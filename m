Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A62CC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAA620661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DddGshbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAA620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYSi-0008AN-J3
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iyYPb-0006VS-JQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iyYPa-000652-8M
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:52:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:58103)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iyYPZ-0005z6-Rs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580723566;
 bh=F/C9eH7AtxuT6CIg9lrIsgN4RZ9y7rOdNuCGyLg2oIg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=DddGshbQYLHHh750JUZehy8wx73ecRo2U9XCyVdFhC7zdOSlLb7n+mCmSz2YmG3B2
 HDMXdLB5xYn0SAbMeWSu5lF0GwHVfYe6PdxyFkxuu5mbmuKtOQ/v1UXQr6yfwdTHAm
 /TiN9PcLexkPcucafbP0PxcdmS1Cy82QoyLCoDSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mg6Zw-1jTltQ1H5i-00hbYv; Mon, 03
 Feb 2020 10:52:46 +0100
Subject: Re: [PATCH v2 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
To: rth@twiddle.net, ehabkost@redhat.com, philmd@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <d6f5efb5-78d9-ea70-4861-db5de23cec84@gmx.com>
Date: Mon, 3 Feb 2020 10:52:02 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128140945.929-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nfSNAspoVwLhPtiKzhPO2FNbFWUeUIe+qauK+ixl/86h/CeNJGH
 00vY/8eJdBoY5eMlfJ/e4rY2Ov8cqKF6PSUX2RAjJXQwkD+87//liymj8PI0tMB1rav8ias
 0Ps++Yxjkfmtt7/8ND27v3qVCkM5hkF2/qi00JGcPwfvjh7LEkKe8JpbJGN3szXXt23GQR6
 m1EqwRB8BSsjcVDUgDk2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QPKnkED42Q=:mC/W+vw8MCJVkll77aJQ39
 qXrKekf7t0i6Q4Ts7HTnKVNbp2VlFkmaXFMygua03bOqWcXnvn90QW3WWDvas5s71Lxxer8tR
 SK99Exc8sjpNF6+4idUMC7Xs9gMQJQoCxHINeNNX68U7LitncSjbCQGbZz9M07pNoADJLYcKq
 T5+8RG4MPDptkH6lKLih/6DQsXjJq4zWfxuIAW3C0uHPOEtvFywuJeiliW9S9SdzY2MZhLWfF
 bdpkKQF860Si3gK7/q/7iree3inEpF2O/mih6a2L69E7xqZ5DGKQGauaDOGuwSZPkRscoWkZb
 4PJ6LKlo7fyckYRNrq3NmqYSzhNqZG8o6V9B/An2BvbYBP4ZnCkUdkXU7sO7BY6oUxljEQV+m
 ZvVYvhADLXrr1+qlz9KAteHggu7rnZTH+GtPHY6tD1axvI2VkGL02yqi8iWSYHY+VqbiT7wtP
 cMDdzJHIadsRA2majkIEF8zJ6TY8/ve5n1XFxpLyDGtGA+MBD0cwP5rjlQ65+Ge+s+Q/PXQ6h
 hv/5xKNfQVMPhJvGzGIEWrUq/7oKycx/0xEDH4jGnNDsbVww3qM5E5AV+JWEeEF6IGoADx7BP
 4KjZQRAwcYLzFPro4+3v2/IykfJbT8jklUrQbTSUesFhwDfVtVpZcen/QXvrlv+jiusabI9cm
 Uu53ki0pdxGXzNDOhhnCFiFtqZ5uNqMAI+997l0y1vovm1MgXlFCw+ezJo3IRDwi+jO+O7936
 YU5wVClCNrcJmQqeTTQMprCniUhEMu2zHlJ/C6doymwl0OsDfEEq7ojor8C/yyFzw5myCB05n
 /gB0PE4UJuc8+Ox1s2vquotroT/QIjP3veFIn2ERAkHBUaURsZzAo8DrGCvr+b9PuWc25UxqS
 M4Hshqt6DIaWjm0lXXNv1RiTxFoAEjmLXMv/nu9SYSTYUe5bLMeYyKEoDuqBUg0OqfLPJ2u9R
 214GJfvrK2zV3lqiHhcWLtYDesNqAO41aQUKm56Sg8ZedjWFBOl5PZdfXGR8seF6jRrq73FXm
 D85Be7STdzegc+o+xpaWZ1EmeGBit/XYTTzpcQ3nICownmz4Jndhi7EQY+RMeaRVl0jc59c58
 xwv+U+pz4guSMqu7eTgAzGk3GZAcsW3FUGnwsIXEiV5ab4AMT2aT5ZiawCW0peZvH/RROIOr1
 FEAZ313O+dZtzgGDpKtbblgI/ovVxSguutL5L0f10mutCrKQ4gfiixZPtcDR2EKotCCMQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

We plan to release NetBSD 9.0 in two weeks and we would love to have
this patchset merged.

"A second (and hopefulle final) release candidate for the upcoming
NetBSD 9.0 release is now available.
Please help testing it!

Tentative final 9.0 release date: February 14, 2020"

http://netbsd.org/

On 28.01.2020 15:09, Kamil Rytarowski wrote:
> Hello QEMU Community!
>
> Over the past year the NetBSD team has been working hard on a new user-m=
ode API
> for our hypervisor that will be released as part of the upcoming NetBSD =
9.0.
> This new API adds user-mode capabilities to create and manage virtual ma=
chines,
> configure memory mappings for guest machines, and create and control exe=
cution
> of virtual processors.
>
> With this new API we are now able to bring our hypervisor to the QEMU
> community! The following patches implement the NetBSD Virtual Machine Mo=
nitor
> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>
> When compiling QEMU for x86_64 passing the --enable-nvmm flag will compi=
le the
> accelerator for use. At runtime using the '-accel nvmm' should see a
> significant performance improvement over emulation, much like when using=
 'hax'
> on NetBSD.
>
> The documentation for this new API is visible at https://man.netbsd.org =
under
> the libnvmm(3) and nvmm(4) pages.
>
> NVMM was designed and implemented by Maxime Villard.
>
> Thank you for your feedback.
>
> Refrences:
> https://m00nbsd.net/4e0798b7f2620c965d0dd9d6a7a2f296.html
>
> Test plan:
>
> 1. Download a NetBSD 9.0 pre-release snapshot:
> http://nycdn.netbsd.org/pub/NetBSD-daily/netbsd-9/latest/images/NetBSD-9=
.0_RC1-amd64.iso
>
> 2. Install it natively on a not too old x86_64 hardware (Intel or AMD).
>
> There is no support for nested virtualization in NVMM.
>
> 3. Setup the system.
>
>  export PKG_PATH=3Dhttp://www.ki.nu/pkgsrc/packages/current/NetBSD-9.0_R=
C1/All
>  pkg_add git gmake python37 glib2 bison pkgconf pixman
>
> Install mozilla-rootcerts and follow post-install instructions.
>
>  pkg_add mozilla-rootcerts
>
> More information: https://wiki.qemu.org/Hosts/BSD#NetBSD
>
> 4. Build qemu
>
>  mkdir build
>  cd build
>  ../configure --python=3Dpython3.7
>  gmake
>  gmake check
>
> 5. Test
>
>  qemu -accel nvmm ...
>
>
> History:
> v1 -> v2:
>  - Included the testing plan as requested by Philippe Mathieu-Daude
>  - Formatting nit fix in qemu-options.hx
>  - Document NVMM in the accel section of qemu-options.hx
>
> Maxime Villard (4):
>   Add the NVMM vcpu API
>   Add the NetBSD Virtual Machine Monitor accelerator.
>   Introduce the NVMM impl
>   Add the NVMM acceleration enlightenments
>
>  accel/stubs/Makefile.objs |    1 +
>  accel/stubs/nvmm-stub.c   |   43 ++
>  configure                 |   36 ++
>  cpus.c                    |   58 ++
>  include/sysemu/hw_accel.h |   14 +
>  include/sysemu/nvmm.h     |   35 ++
>  qemu-options.hx           |   16 +-
>  target/i386/Makefile.objs |    1 +
>  target/i386/helper.c      |    2 +-
>  target/i386/nvmm-all.c    | 1222 +++++++++++++++++++++++++++++++++++++
>  10 files changed, 1419 insertions(+), 9 deletions(-)
>  create mode 100644 accel/stubs/nvmm-stub.c
>  create mode 100644 include/sysemu/nvmm.h
>  create mode 100644 target/i386/nvmm-all.c
>
> --
> 2.24.1
>



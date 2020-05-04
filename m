Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7596DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E0520735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXtZmBGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E0520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWtM-00057t-Ea
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVWsj-0004T5-MJ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:55:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVWsj-0007Em-3L
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588582519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8P3tGI3kiqYUeeflyHBGusrWXC5jLElipyiQHqcMGU=;
 b=NXtZmBGgrQKnJoSOBCq3tQadFfWUf1UofAQDRiXnT9U4y4a04/QkcAmWLWuFOqqfr13JUR
 Pdm3WQYcRvs5NjLJwt0egYu07SZFKO8/709eXq9Z0IqK/8t4Ti+Mql+I95zKgWcan9XIST
 IQ7HmZXppwWJsWUydnGCl0CgAl/OvYw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-MsFiFhuSNIiEKmTzCBy0XQ-1; Mon, 04 May 2020 04:55:14 -0400
X-MC-Unique: MsFiFhuSNIiEKmTzCBy0XQ-1
Received: by mail-wm1-f69.google.com with SMTP id w2so4531942wmc.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZlBmAYZeLeMHKY+ebeItpklGAIY7YH9L3NjRuRuI7vM=;
 b=k01r/tNYIQPBe7lwar0c0KAQkCu4j99dza7xsP/eFBQCQ3NST0fcBIhip1SMsBEcUj
 +KkpsykcdF+m/o0jQN1R+4kAGQFs0TPzAtv6FAUelBf8dhaHn8cTxIT3YwRvda/ZQqhU
 m3c70cPH2DKE3DNtFquRUDaqIJ+LeM4mt1J/fHfpanafNBsmW2EmA3NcHdndbgPHg7ld
 GVWF1Em7JOY7JOPJw3nBEOuP0PW1zqEovH8ebZh2BBgcXF4tmRSggemv1pXWN13gBdHn
 PUn5xbbGN07PqaeFDcR6vxnul6suoxQubJNL07OSeYC8Jts9mmuZ1WazUY+l2T8ZPL5I
 Rh1Q==
X-Gm-Message-State: AGi0PuYBZzmRg2Jnc4WJ8g7JJZcdYR4BslmM/RysXPjDZB8f6+9AN+/6
 5jHGIUydO79VqUmxgzc0rG+UwMxTwT/mRsOuT8p6SZjIloXiDBZQ5NgxazRtngef/2mCYkfRhJi
 6loC2NUBjha/s9y0=
X-Received: by 2002:a1c:ba56:: with SMTP id k83mr13124305wmf.1.1588582512839; 
 Mon, 04 May 2020 01:55:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJYqTN90joqgOWn8X8YJQh01c+IieSQAPCFyq/a896rjv7yEFt06EYmm7WyncXUBDbRKS+Jog==
X-Received: by 2002:a1c:ba56:: with SMTP id k83mr13124290wmf.1.1588582512657; 
 Mon, 04 May 2020 01:55:12 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id b191sm13184709wmd.39.2020.05.04.01.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 01:55:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] misc: Trivial static code analyzer fixes
To: qemu-devel@nongnu.org
References: <20200422133152.16770-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <59cb7a72-9411-48d7-062d-539b46c3221c@redhat.com>
Date: Mon, 4 May 2020 10:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 3:31 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix trivial warnings reported by the Clang static code analyzer.
>=20
> Only patch #2 'blockdev: Remove dead assignment' misses review.

Thanks to Max this series is now fully reviewed, so... ping?

>=20
> The official Clang static code analyzer documentation is on:
> https://clang-analyzer.llvm.org/
>=20
> On Fedora I simply used it as:
>=20
>    $ sudo dnf install clang-analyzer
>    $ ../configure
>    $ scan-build make
>=20
> Since v2:
> - Based on lvivier/trivial-patches-for-5.1
> - Removed dup patches from Kuhn Chenqun
> Since v1:
> - Addressed Markus/Zoltan/Aleksandar review comments
>=20
> Philippe Mathieu-Daud=C3=A9 (9):
>    block: Avoid dead assignment
>    blockdev: Remove dead assignment
>    hw/i2c/pm_smbus: Remove dead assignment
>    hw/input/adb-kbd: Remove dead assignment
>    hw/ide/sii3112: Remove dead assignment
>    hw/isa/i82378: Remove dead assignment
>    hw/gpio/aspeed_gpio: Remove dead assignment
>    hw/timer/stm32f2xx_timer: Remove dead assignment
>    hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning
>=20
>   block.c                    | 2 +-
>   blockdev.c                 | 2 +-
>   hw/gpio/aspeed_gpio.c      | 2 +-
>   hw/i2c/pm_smbus.c          | 1 -
>   hw/ide/sii3112.c           | 5 +++--
>   hw/input/adb-kbd.c         | 6 +-----
>   hw/isa/i82378.c            | 8 ++++----
>   hw/timer/pxa2xx_timer.c    | 1 +
>   hw/timer/stm32f2xx_timer.c | 1 -
>   9 files changed, 12 insertions(+), 16 deletions(-)
>=20



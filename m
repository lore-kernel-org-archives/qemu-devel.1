Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED5CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B544B206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B544B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHm8h-0003Tj-Ud
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iHm73-0002Gm-8y
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iHm70-0001MH-KD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iHm70-0001Jz-Al
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:48:58 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73B9F8831E
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 09:48:55 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id o10so4033943wrm.22
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 02:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BTsyp0rkfpFF+Stz0EkJoZ64+6dsBQF35YVuFlsuWls=;
 b=bUDLkNvBhg9VXBqZ+DpkffLqYcPlUI00gwwP/zcWecH0q8A/zv+3YsvVN5cOIGNxNB
 y5asNzDUd6Flzt/6BdA8TNMHrTvWtXrYmuSYf5f5Ub2Dit0VbKe5j0/m11cgSwGZMoou
 z7Wa4xX76g1ncsdKmN1M9NVKwcWma88Dia47D0p4fre1rUz67bp7/KE2mFQrWeE0vlMw
 lVS1yzfTseV0jqLX44lSPAXJc/9Dey8po1Wc5nnrt2uWYDDgCH00t1O1gZ9gRNo9Ub+1
 VOERJtGCKRlmfsiQ/th/EF67hv0CahlEaKC07HLqwDHilT5gz6lMhl6BAdHF316+pVom
 mGmg==
X-Gm-Message-State: APjAAAWfLqeiDwOZCn6h73EKQRTUoSsweXQU1wTh0bDOamLcJ85/QP8B
 Gma2oKjZ/5erheF/wbIk5oEpRRiD+2eBk/fFOqDOCmP3USUlasdm3UZ8M4w/fh4vZNMuJdYN4Ug
 OXD5h7F9+6tYAfuo=
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr28425778wrg.74.1570528133853; 
 Tue, 08 Oct 2019 02:48:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqweRhpDhxmObUBqarqG14W+X+DsSDrPsDcCY72LLlhER1ZBFfIlhmHuKimLAjlYaH6EgrR1lw==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr28425746wrg.74.1570528133567; 
 Tue, 08 Oct 2019 02:48:53 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id y186sm4825149wmb.41.2019.10.08.02.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 02:48:53 -0700 (PDT)
Date: Tue, 8 Oct 2019 11:48:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] Test netmap on FreeBSD
Message-ID: <CAGxU2F61+TjSy_GJ_2673--VLstVyJjNoqqPdZw+ej22xbzk=Q@mail.gmail.com>
References: <20191008084931.12753-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008084931.12753-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Ed Maste <emaste@freebsd.org>, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Vincenzo Maffione <vmaffione@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On Tue, Oct 8, 2019 at 10:49 AM Thomas Huth <thuth@redhat.com> wrote:
>
> FreeBSD offers a package for "netmap", thus let's install it in our
> FreeBSD tests to get some compile test coverage for net/netmap.c, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .cirrus.yml      | 2 +-
>  tests/vm/freebsd | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 8326a3a4b1..44fea2c29e 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -8,7 +8,7 @@ freebsd_12_task:
>      memory: 8G
>    install_script: pkg install -y
>      bash bison curl cyrus-sasl git glib gmake gnutls gsed
> -    nettle perl5 pixman pkgconf png usbredir
> +    netmap nettle perl5 pixman pkgconf png usbredir

>    script:
>      - mkdir build
>      - cd build
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 2a19461a90..45821702bd 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -54,6 +54,9 @@ class FreeBSDVM(basevm.BaseVM):
>          # libs: opengl
>          "libepoxy",
>          "mesa-libs",
> +
> +        # libs: network
> +        "netmap",

IIRC netmap is shipped with the FreeBSD kernel, so we shouldn't need to
install it.

I tried to understand what is the 'netmap' pkg and I found the following
in my FreeBSD 12 VM:

    # pkg search netmap
    netmap-0.1.3_1         Make a graphical representation of the surrounding network

I don't think we are installing the right 'netmap' (I know, it is a bit
confusing :) )

I'll tried "make vm-build-freebsd" without this patch and I noticed
"netmap support    yes" in the configure output. So I think we're
already compiling the netmap backend in the 'vm-buil-freebsd' target and
maybe also in cirrus.

Maybe Ed and Li-Wen can confirm (or not).

Thanks,
Stefano


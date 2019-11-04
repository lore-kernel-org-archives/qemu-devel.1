Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB6CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE3A21E6F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE3A21E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRc6c-00071k-CK
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 08:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iRc5x-0006Wu-D8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iRc5s-00006I-Iu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:08:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iRc5s-000063-Ce
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:08:28 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62601C04B940
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 13:08:27 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z9so10396063wrq.11
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 05:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Um2Ztr2YBhEJiVusdUoQcbZYOWPFHybSR/VslVGr4y0=;
 b=EoVl2m4rJDaWxsQViNj/5rZtC5/iIe/SElavaaoEGMZYulkp/85EPGfa+99m0j28Vz
 GqO70En6U+MccR9IFKw2tVlJMtLT/pyH/dKOuO98zzuQ/DWoxooO/ZUlUEXwjsASKxnc
 syg9XFA/71JG96F6LyFJ6LPRROqIjT7+J73UfMnKMY6V2nDs5yn5Amn71ox/2/iK0cAJ
 UZWLjNCCMl24FrIIdSI45CB6uITOQiH4NO/wiUJWgKwTLmsHe31oh9U0Lej8MtQRssC8
 sZR+rSP27/Tbqx5H6JqRSoPZ+qPACL9ITkS8RseDNNrHTBDEVsbZeDvVq1NgqPE23vEY
 bhxQ==
X-Gm-Message-State: APjAAAXcvYA74YrwhpGkE5hOHly1Iy02VIVqsK2zB/eBrkGqdiomJ4NF
 rMd5CzD91LLIKhj+0YYHDbnl1tAbnG53UDoRYVSxkNMdiaDWWrP6MB0zuAZh/9dfCazMAOQyyma
 eaVWvXOo0ZLvhAY8=
X-Received: by 2002:adf:9f47:: with SMTP id f7mr3355857wrg.186.1572872906125; 
 Mon, 04 Nov 2019 05:08:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuxswPzrNnGVn+akMaku0rmINia4mAD/xc1OKw7ZRjl8rCAOafu/ksoZ/qdYWKSoBb0aDCLQ==
X-Received: by 2002:adf:9f47:: with SMTP id f7mr3355829wrg.186.1572872905852; 
 Mon, 04 Nov 2019 05:08:25 -0800 (PST)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id v16sm18061325wrc.84.2019.11.04.05.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 05:08:25 -0800 (PST)
References: <20191102114346.6445-1-philmd@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] Makefile: install bios-microvm like other binary blobs
In-reply-to: <20191102114346.6445-1-philmd@redhat.com>
Date: Mon, 04 Nov 2019 14:08:23 +0100
Message-ID: <87tv7jssag.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, Bruce Rogers <brogers@suse.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Bruce Rogers <brogers@suse.com>
>
> Commit 0d5fae3e52e introduced bios-microvm.bin but forgot to add
> it to the list of blobs being installed.
> Add it to the list of BLOBS that get installed.
>
> Fixes: 0d5fae3e52e "roms: add microvm-bios (qboot) as binary"
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> [PMD: Reworded description]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index bd6376d295..755aa6c5f5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -770,7 +770,7 @@ de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr=
 \
>  bepo    cz
>=20=20
>  ifdef INSTALL_BLOBS
> -BLOBS=3Dbios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bi=
n \
> +BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin =
vgabios-cirrus.bin \
>  vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin=
 \
>  vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
>  ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin =
QEMU,cgthree.bin \

Thanks.

Reviewed-by: Sergio Lopez <slp@redhat.com>


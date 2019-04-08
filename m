Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82105C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F58120880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlEblpZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F58120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDcIN-0004nm-Hf
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:59:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcGe-0003wO-JT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcGd-0007ei-DS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:57:28 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>)
	id 1hDcGd-0007Zs-0p; Mon, 08 Apr 2019 17:57:27 -0400
Received: by mail-yb1-xb43.google.com with SMTP id e76so1552643ybc.3;
	Mon, 08 Apr 2019 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
	:cc:references:message-id:user-agent:subject:date;
	bh=8Yi6QVxk9W5jky9l0J8UaUVLboC8PKdBVurccfXsSSY=;
	b=BlEblpZ8Lbm+qIrZrZAnbW5rKie198J3Kq1J8yX5sZMxeffhoAo0rWOSoodGgP7wKu
	5/F5r2mi/ssTsZ93jCOW1udscUa3HRvsTs+gAqoES0k8ynKWxjL5DUpk5zCzf8O56f+Q
	Rxa330WZhy8GORSPeleO7gOU8VcP2ei9+YPzXiWrC681LOavChqfvD+xa9WPHGXZaRZA
	VEODMM6iw8JE+av5Hd+tVPUIbwk9tbY8k9TjRT/yVKVCEx35U9geAZd6TBJrYTknSg/o
	e3HCt8GGvXwALqZddEwDqF/IjOaMGVVeTgMCJlnbaabdiiXYj++DtOfhma5IPJVjuvHF
	QM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
	:from:in-reply-to:cc:references:message-id:user-agent:subject:date;
	bh=8Yi6QVxk9W5jky9l0J8UaUVLboC8PKdBVurccfXsSSY=;
	b=twIsE84SmwnFpGj2h5DpUSklpdCNUqq59mJ3MND6hcrmnBsv1qoWvXirsyu0+8JH5m
	6eF8tVmWDK0Ql+ffphL/iIF1/h07yWVJ7cICVPdCoTEKFe3vRsxsymU4XWeTnTVXWJR0
	CL2v1Tm61RQq9ruwYyriEzDCXi2s5CGdaDRTmIiKbcsU9aUh4FxBci2gP+3GVA034g92
	tk+dTlDgje+gJWqhm8HqgZ8qBZqP1RhkZokNAHowv1tRL6rLOt1Yh9Nh7joElIzQum2w
	RSGdDvoDyfdCz7X/LmlA8Kcb3TIOXc2LjQgvheaxlB/57fLpGJYfrZwHqY4ngSK1uujK
	YxBQ==
X-Gm-Message-State: APjAAAVXtFO9UnCrWvtV/gdRT4WzIqir8Ywv4nzwBBGF38lwL1Qqsx6P
	ZARDFhuK2kaeUnec1wgnAM0=
X-Google-Smtp-Source: APXvYqyJnSry1mt0CziZc4jS6mJSKEiAZqc1SvUkBQ5Sq/J7mwLuLb+gYLN9WXUWdEREjB1eNm2iBw==
X-Received: by 2002:a25:8201:: with SMTP id q1mr4289948ybk.149.1554760645311; 
	Mon, 08 Apr 2019 14:57:25 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
	[76.251.165.188]) by smtp.gmail.com with ESMTPSA id
	w22sm16888463yww.58.2019.04.08.14.57.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 08 Apr 2019 14:57:23 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190404121015.28634-1-pl@kamp.de>
References: <20190404121015.28634-1-pl@kamp.de>
Message-ID: <155476063977.3739.16390356140711847238@sif>
User-Agent: alot/0.7
Date: Mon, 08 Apr 2019 16:57:19 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] megasas: fix mapped frame
 size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, pbonzini@redhat.com, hare@suse.com,
	Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408215719.Tt9IEZ8WIS1PUQDhFyCP57p1FnZo5JrrOp1vva2pfhQ@z>

Quoting Peter Lieven (2019-04-04 07:10:15)
> the current value of 1024 bytes (16 * MFI_FRAME_SIZE) we map is not enoug=
h to hold
> the maximum number of scatter gather elements we advertise. We actually n=
eed a
> maximum of 2048 bytes. This is 128 max sg elements * 16 bytes (sizeof (un=
ion mfi_sgl)).
> =

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

Is there any chance of getting this in for v4.0.0-rc3 tomorrow? Also
hoping to pull it in for v3.0.1.

> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index a56317e026..5ad762de23 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -477,7 +477,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState=
 *s,
>  {
>      PCIDevice *pcid =3D PCI_DEVICE(s);
>      MegasasCmd *cmd =3D NULL;
> -    int frame_size =3D MFI_FRAME_SIZE * 16;
> +    int frame_size =3D MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
>      hwaddr frame_size_p =3D frame_size;
>      unsigned long index;
> =

> -- =

> 2.17.1
> =

> =

>=20


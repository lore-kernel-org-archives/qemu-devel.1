Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A1C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485F720883
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj42gRS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485F720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43501 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVDCf-0002CS-Ks
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:50:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVDBp-0001rY-K9
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVDBo-0004AD-Q3
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:49:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hVDBo-000495-L3
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:49:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so1257746wrm.8
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=zU6Nb7BqwK4f/uem8aTFYxAGYZFvNMwZkEDmmSoIINM=;
	b=gj42gRS8V8+GoINTnwaODjJr1pOoIImLkMddC8OC62dovpX25NcHtNvDLLWoAWckVL
	pHa+QuiDoF96Me2ALRq9tv6zRNHsJ1+s1jgu86FPf98BNwlLIdOSSO7ty41nvptorJtW
	hvCIGZsBAQwkCiiokVx8Wdo6ZAqBIIy9zP2W018q5OFjxBSTtnvFY5zTmaQ0VzPP3XJi
	3KamOSh4JqDary3x7QcBD9ar4OIyUVx9onzMD/qZWS3CL1NTFdvF0wB+MbaQdkFy/Pzu
	ufZyydCSR0NI2oAFURbKQzzToItjqqfFSQ8v0x4AAsBY52LVNurABCVdT+fuVXwS5hsu
	DG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=zU6Nb7BqwK4f/uem8aTFYxAGYZFvNMwZkEDmmSoIINM=;
	b=YEU6pW5gtE8tkh6tUm/iI06q+Hd+upqniGhyYt+cYHw5gdDEMq1u+OFntciYEYpLOG
	nuELZUfQO1hLUU7/efd3CSh8sYqCI3de03MRzdvcGQa+GCm4CN+p82KUulRl33tjZ87X
	IY4OI/K3daVyvklQ/m5v1Kx8NAEJvxcWtDVWHgu1R2Zp3p23rQOp4aQX6E5fS+L67dmh
	++Alt/H6prkNlSuBKWYuR02oUDhl1cgpO+AYEPr21j+b5BViTLXE/3oZKu29KsK/dBSJ
	cxNE8XmPI56gObwyvPYqhVBDg1eN4VQEho8Wi4bfpAEXTw5Gnd7kalIfexs6Rz5awlAi
	YD5g==
X-Gm-Message-State: APjAAAX7llXd9Ei5XvFR/252CbcQdnLSwq/4qtZ0EiDS1AlRMolbetmK
	VWRZlRSNHpeOirUVFd7p20aZ7nUNw3L+FyXGSh4=
X-Google-Smtp-Source: APXvYqxdM563uy2U7jRfzoboIvwUolfeYankuPfTdDNVpL2F940hzAbpiXSAJCSyRNMXM6yZAELcye2wHKiyzcKL+x8=
X-Received: by 2002:a5d:5702:: with SMTP id a2mr4028010wrv.89.1558954151232;
	Mon, 27 May 2019 03:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190527091226.4943-1-kraxel@redhat.com>
In-Reply-To: <20190527091226.4943-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 May 2019 12:49:00 +0200
Message-ID: <CAJ+F1CJs9_PtQn-6jUR9ZS7=nuzR=3Lz_q-NBDPWUi-gm-zCOw@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: add sanity check
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
Cc: tslabinski@slabity.net, QEMU <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 27, 2019 at 11:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Require a minimum 16x16 size for the scanout, to make sure the guest
> can't set either width or height to zero.  This (a) doesn't make sense
> at all and (b) causes problems in some UI code.  When using spice this
> will triggers an assert().
>
> Reported-by: Tyler Slabinski <tslabinski@slabity.net>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 9e37e0ac96b7..372b31ef0af2 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -677,6 +677,8 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>
>      if (ss.r.x > res->width ||
>          ss.r.y > res->height ||
> +        ss.r.width < 16 ||
> +        ss.r.height < 16 ||
>          ss.r.width > res->width ||
>          ss.r.height > res->height ||
>          ss.r.x + ss.r.width > res->width ||
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


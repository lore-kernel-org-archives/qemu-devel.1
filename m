Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF5C04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AC121734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AC121734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVozN-0002xS-2M
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 23:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVoyH-0002I1-7R
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVoyG-0002of-EQ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:09:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVoyE-0002mq-U9
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:09:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id u12so853018qth.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 20:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=z5FM5rXbmBG8myj3o5qdDSziZ+47987kIQs7hZQmoSg=;
	b=CjQ+Bc897EeC/PH7BOFsdcH0j/mePZREv+DLRypZyQTTBrHLHMMN1JSxolrTFpMzeg
	sMFe48dJtxYblWp3fAddofhObGXbFvAN+WT0ihNxobbWHDnhH2f6m+10OifrLqsi7vYG
	83lSaQz6X3KHvdNI3L+55GYNgXqFfeCTOuZ+MUmXqo3SRuO2UOgjHMf6XZwMrHcTDCwP
	oxrTizUsXrbbk5am58WQOtKlcQi0uZthn+iKYTH/LDTaG5/duf+r2mvINyyJdiIR3yLy
	g9Cx8/eYsmJCOP6JZ2lWfe5gNHIUzhcVvAUThEfu6/UxkJtMpuiYbF/AoelaEUhsiNfy
	7fRQ==
X-Gm-Message-State: APjAAAXmRLSv1OxpgOYMHaCzSxWdy8cRlSVL7+WR2/HwiUsO1f4NC5UY
	luuhA82buS3Avu5Iw3tlhqGkBg==
X-Google-Smtp-Source: APXvYqxgZiNADx/JgVr25zD033NJHoQrYQKq+B6kBJnKKwdZWNzWU0M9r7ENl+SB5zY3aP6vMvTosw==
X-Received: by 2002:ac8:2fb0:: with SMTP id l45mr16135545qta.177.1559099381150;
	Tue, 28 May 2019 20:09:41 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	j12sm5401646qtq.59.2019.05.28.20.09.40
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 20:09:40 -0700 (PDT)
Date: Tue, 28 May 2019 23:09:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190528230920-mutt-send-email-mst@kernel.org>
References: <20190527091226.4943-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527091226.4943-1-kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
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
Cc: qemu-devel@nongnu.org, tslabinski@slabity.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 27, 2019 at 11:12:26AM +0200, Gerd Hoffmann wrote:
> Require a minimum 16x16 size for the scanout, to make sure the guest
> can't set either width or height to zero.  This (a) doesn't make sense
> at all and (b) causes problems in some UI code.  When using spice this
> will triggers an assert().
> 
> Reported-by: Tyler Slabinski <tslabinski@slabity.net>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

OK. Worth adding to spec maybe.

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


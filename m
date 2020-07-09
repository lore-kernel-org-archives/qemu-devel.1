Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FC5207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSg8p0BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FC5207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtaeR-0006bN-Th
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtadW-0005ml-LN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:47:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtadT-0008AX-EK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594316822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=//zWWijAJknmHOfC5HQiRMJgHRYliCd/RUQRGWYCg9Q=;
 b=DSg8p0BWeOaxKXG2H15FQ39VXDux8ulovPpNevhWgb9xXdF3wjUdhrXxE6Qi9ozqDIfEYR
 4NTBsK6TQAkciUkeZMTlJvUtRECGp2czJX3cGXkrLxuCvv650w6qWKMPsgTn6LrgIce+MY
 CBkulpPw8k41twa3Pm0e54E4Jy/VhqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-eED8gtxmOaS6_6qpu-6YOQ-1; Thu, 09 Jul 2020 13:47:00 -0400
X-MC-Unique: eED8gtxmOaS6_6qpu-6YOQ-1
Received: by mail-wr1-f71.google.com with SMTP id e11so2639990wrs.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 10:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=//zWWijAJknmHOfC5HQiRMJgHRYliCd/RUQRGWYCg9Q=;
 b=eTV8U0U6yEDgvbj0tX9cEqS9hJBSb3xdE3pPpeVo6ig035QTFXh+Ub0eXUZ3VnDvgH
 AZdWOLTfyrMqTFEZWmN1+y81bzN2ERz/jo5rdo7yhNzCGRohhIbrjFZcF/2T/Vi2cKRJ
 g/83qZ0ngc2IT9Jvd7s/QoUTI2SN16SUuGcePQy7q1a5mzGeDLXobHHDjJKWPqNfVUJt
 uuMy1dyeByhI/nIC3XUXTZavxPpuTFiFDK46JNV+MWuD47XbQjuI9VYfB3V1pM0ulL/Z
 LHlQ9VR6VLXA9G4h5q1Do5qqL3wb9xm4O7V53YCLiCc3X1fy0mTMlkdvr13mZHoe0LOF
 8cHg==
X-Gm-Message-State: AOAM532Vz16h328taeXto0P8RU6FGCvMwsKYwp5DTumQrcPet0gKwTiW
 lyFwqmSAP9kqH0qY079jbyerwrDKP2tUqI7D2X0fMu8RDK832ASenKN9WeKXcj0elONhXGiZzZy
 XdVq1YiMkmwbZuWI=
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr59901521wrs.33.1594316819180; 
 Thu, 09 Jul 2020 10:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEoju3ChS/iavuTvQgbL/6TVXq8M1UZdv8RobjsYPGNcfX1jdkDzOgFWX/G895PQ/b6Yxp+Q==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr59901513wrs.33.1594316818967; 
 Thu, 09 Jul 2020 10:46:58 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z8sm5901956wmg.39.2020.07.09.10.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 10:46:58 -0700 (PDT)
Date: Thu, 9 Jul 2020 13:46:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
Message-ID: <20200709134600-mutt-send-email-mst@kernel.org>
References: <20200704182750.1088103-1-mst@redhat.com>
 <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
 <20200707080049-mutt-send-email-mst@kernel.org>
 <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
 <CAFEAcA_sD0ZPJ7YNk+2bdhwqAFdoKipEPfg-E-xQQh-ukUsiUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_sD0ZPJ7YNk+2bdhwqAFdoKipEPfg-E-xQQh-ukUsiUA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 11:32:05AM +0100, Peter Maydell wrote:
> On Tue, 7 Jul 2020 at 18:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 7 Jul 2020 at 13:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > Precisely. Sorry about missing this.
> > > I made this change and pushed to the same tag - don't want to spam
> > > the list for a small thing like this. Can you pick this up pls?
> > > Commit 849c48004df0e123b53fe9888770cb4f6eb5e8ab now
> >
> > Sure. (You can always just resend a new v2 cover letter without
> > all the patches; that's what most people do for minor respins.)
> >
> > Applied, thanks.
> 
> I've just noticed that the commit that got merged was not the
> one you quote but 1e0a84ea49b68b7cf60e -- can you check whether
> anything was missed or the wrong version ?
> 
> thanks
> -- PMM

Yea not a big deal:

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index fb7de972f3..a3d17fe0f9 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -45,7 +45,7 @@ static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
     msg.type = v->msg_type;
     msg.iotlb.iova = iova;
     msg.iotlb.size = size;
-    msg.iotlb.uaddr = (uintptr_t)vaddr;
+    msg.iotlb.uaddr = (uint64_t)(uintptr_t)vaddr;
     msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
     msg.iotlb.type = VHOST_IOTLB_UPDATE;

I guess I forgot to push or something. Sorry.

-- 
MST



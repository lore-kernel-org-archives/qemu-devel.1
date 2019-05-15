Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2BC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507A62084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uW/2I2ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507A62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34501 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqkp-0004rU-RF
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:03:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hQqjp-0004Wh-5J
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hQqjj-0001tK-Ha
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:02:17 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:39291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hQqjh-0001k0-Tm
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:02:10 -0400
Received: by mail-oi1-x232.google.com with SMTP id v2so1373999oie.6
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=003KoGbnzQZEoTCv6ZTSkFQVXeDrX0qzhdyLi+73oTc=;
	b=uW/2I2ro3If7juwCOfBUih5gueMzfGBtR7T0p9ScSRJJNQi4tXmAyUj2SmvxyWGXnS
	l1NUNCXY5Qwd6z0TLeaG6301SmW9P/3BXh33bxcvAQscSyP1i/gnyQQs8y6D8x8VMBh1
	DN09AljSQ7rDvc0qJlOXhBaoTpKPjbzPIAzl8Aij82POWJ+OOtljM1dqjKGzHEFK/B+e
	9/fSdgeBwoSdgIAmgm2bBb7K6NzSoZ5wqFhxxPfc5GPvhoJ/n/keqVmLtp3XxwVUK9rA
	0rsqf3D4h6zuonbGy3unBp9P3STjnbgHRj3jSl25etRVB14AeqLX6b8+IU7VcqABNQpy
	6L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=003KoGbnzQZEoTCv6ZTSkFQVXeDrX0qzhdyLi+73oTc=;
	b=HAqh73Edn8W9t17xEr7H4vCoDWiNTtRsX2M3Qa1DtJDxQNLZ/CvY5dyO5tL709xakI
	EBONueVP0/Xu1mk990fkq/0xbvw93WYXppA57r0Y7Tl3x3/EbgbOkWk6w/RLw7yzTQw5
	ZkXx1lRLBiRCc+yGADhQnRMNSuIviAzzngCUl+ciZO8gs0rUK2YqxBzGTB+A+cQnX2Jb
	tGKdF8T3itYx1NT8MGUT74qSFWdV4reV3FSQyDFZqJR5aP+Ij+SUz2UG/08X8ztab2U8
	LVVCdCw/WNlzuou65CXy2kdVyTixwb5r/gqZ4/mlebjO65hQoVY+wD1afIiDVpXPqp99
	gyjw==
X-Gm-Message-State: APjAAAW6IZUogvFHByk5yAoRNy9DWn+lDbLZ8lFMffZLAINKJFxzDrJ1
	PPBz9tfmfrainX7D5Kt59KRs9+Wh9D6dEidQsuE=
X-Google-Smtp-Source: APXvYqxN2KwNfyVJ/8DwYFH5HlluEuAN+2jXKtiC6NKNfqW5oboCbz4a2Oe60OsUqj52ZfWlIbCs/V7JaVX3ErbiipY=
X-Received: by 2002:aca:61d7:: with SMTP id v206mr6451249oib.97.1557914517989; 
	Wed, 15 May 2019 03:01:57 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 May 2019 18:01:22 +0800
Message-ID: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com, 
	Qemu Developers <qemu-devel@nongnu.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::232
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Question about the vfio device interrupt
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Paolo, Alex and all,

In vfio_intx_enable_kvm(qemu) I see we associate a resamplefd with the
umask function(vfio_pci_intx_unmask_handler in linux).

    irq_set = g_malloc0(argsz);
    irq_set->argsz = argsz;
    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_UNMASK;
    irq_set->index = VFIO_PCI_INTX_IRQ_INDEX;
    irq_set->start = 0;
    irq_set->count = 1;
    pfd = (int32_t *)&irq_set->data;

    *pfd = irqfd.resamplefd;

    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);

I know this resamplefd is triggered when the interrupt controller receives
an EOI and
then we unmask and re-enabled the VFIO devices' interrupt.

So I think there  there must be a mask process(so we unmask it later), I
mean there must a
call of function vfio_pci_set_intx_mask(in linux).

What I can't understand is when this process(mask VFIO devices' interrupt)
occurs?
I only find a place(vfio_basic_config_write) calls vfio_pci_intx_mask.
I think when the guest process the interrupt it may mask this
interrupt(finally call vfio_pci_set_intx_mask), but I can't find the code
path related with vfio_basic_config_write.


Any hints?

Thanks,
Li Qiang

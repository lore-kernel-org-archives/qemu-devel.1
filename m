Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF0C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AFA2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AFA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJrt-0001Wb-QF
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSJqa-00005M-6i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSJqY-00033Q-Ab
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSJqY-00032v-1j
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:51:34 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D8AF7F415
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 11:51:33 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id l21so7568662qke.21
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CY2IedL+lNc5rwcYVLJS8R40/Ase0LJv1JoWmQMiCVs=;
 b=aA+2dkdzK2TbDGFe3paEzVNdpawsJEG4kq+uTgJA8LUul+T0kJ6ITTJPyQ9rRh14x9
 9h+eM5R/91RioMLe1KyrYYYrprU1KABTB3mFiupu0CtP5IfGIe5y/XO2aC11hIzeCAkX
 CI5ayx5eQWhIpZrT7KEQCNMpZbzHQWOWWqPmdVUaS5XltxLw4Fo9tZhkU8NXEqJRH3Mi
 cjJyuyY8fqrHS8L7PcWdrAmMnGFent9mno6qaAMay35BiYUvIxSizHcEfrwSAki/plyh
 ucu/oTCrERsU9HYa9Og+17Hx3Vs5+JVnOEvXxOzte1g6GeWv11weD1psoF4Gob28heZu
 c+/A==
X-Gm-Message-State: APjAAAX/LIiktDvq7zevOJEBZqArvLWMgqfGDWqPvo9YT7u8Gs7uaM61
 Vhl0PCQ4sw/8Bky4fJxxv4VCedP39g3ZlL1DfnDx10JOb9Mw4J1yQhhUw38eM4G2k3ECIaOj/Rf
 +8esCXWY6qCRJTvg=
X-Received: by 2002:ac8:7085:: with SMTP id y5mr1903467qto.76.1573041092557;
 Wed, 06 Nov 2019 03:51:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxo5+8ys2fcnEB7eZyWS6yXIiGculHPGut7N9fYjy+ldWJrVbMv6+Mo8Cth1OOWAP//r70/YQ==
X-Received: by 2002:ac8:7085:: with SMTP id y5mr1903455qto.76.1573041092277;
 Wed, 06 Nov 2019 03:51:32 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id r80sm5134496qke.121.2019.11.06.03.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:51:31 -0800 (PST)
Date: Wed, 6 Nov 2019 06:51:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Message-ID: <20191106064157-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-2-dplotnikov@virtuozzo.com>
 <20191105155357-mutt-send-email-mst@kernel.org>
 <20191106091812.GF189998@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106091812.GF189998@stefanha-x1.localdomain>
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
Cc: fam@euphon.net, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 10:18:12AM +0100, Stefan Hajnoczi wrote:
> On Tue, Nov 05, 2019 at 03:56:43PM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 05, 2019 at 07:11:02PM +0300, Denis Plotnikov wrote:
> > > @@ -47,6 +48,15 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > >      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
> > >      DeviceState *proxy = DEVICE(vpci_dev);
> > >      char *bus_name;
> > > +    bool modern = virtio_pci_modern(vpci_dev);
> > > +    uint32_t virtqueue_size = vs->conf.virtqueue_size;
> > > +
> > > +    if (!modern && virtqueue_size > 128) {
> > > +        error_setg(errp,
> > > +                   "too big virtqueue size (%u, max: 128) "
> > > +                   "for non-modern virtio device", virtqueue_size);
> > > +        return;
> > > +    }
> > 
> > why? what is illegal about 256 for legacy?
> 
> I think it was mentioned that this limit is specific to SeaBIOS
> src/hw/virtio-pci.c:vp_find_vq():
> 
>   #define MAX_QUEUE_NUM      (128)
>   ...
>   if (num > MAX_QUEUE_NUM) {
>       dprintf(1, "ERROR: queue size %d > %d\n", num, MAX_QUEUE_NUM);
>       goto fail;
>   }

OK I see. It's worth documenting this (with version of seabios
that has the issue).
And yes virtio_pci_modern will not do the right thing.
This checks whether device has the modern interface, but
an old seabios will not use the modern interface even
if it's there.

You want to start with small queues and then check after features have
been negotiated with firmware, and make them bigger.


But even then I am not so sure we should just block
bigger queues by default. kernel can use bigger queues fine,
and not all disks are necessarily used by seabios.


If you want a user friendly option, we can add a flag that tells
qemu to adjust the size to a known safe value.
Then we'd start small and make it bigger if guest is a modern one.




> I'm not sure there is anything we can do in QEMU.  Either you can let
> SeaBIOS fail, or if you want something more user-friendly, then the
> management tool can implement a check based on the SeaBIOS version and
> the -device virtio-blk-pci,queue-size=SIZE property value.
> 
> Stefan




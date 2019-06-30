Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D46C5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 21:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7BC208E3
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7BC208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhhVN-0001Zl-Sp
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 17:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hhhUd-00018c-Hs
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 17:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hhhUb-0006kr-VT
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 17:36:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hhhUa-0006gg-Am
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 17:36:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so12577730qtr.12
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 14:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dikFW63IO+vwOmV2pwZYkUIcukMNTCVmrg2UrND2wUk=;
 b=UZlv8JgQkmOn97qRwALQMv1a3KPL/U+lDWQErZzgHO5r2ilRoX9CccBtAzVt2sCq8a
 WNWrMMz4u0H3DAXieEXVwKccb+zE1rqWNt5F5hIMcVkEnsorI4TuZGl74W+vte3J5Nw6
 v8sqSg5V0FR2lWjQphHiAxamlUHlzPUJGXGtUJxssfKWchWV6anzMByxYTRY2CzfnSt/
 e1M+xks/MmeA2kqrIuQZjyeTHp7iirqP6/Yro6gEA5Wrrmo461jADSaT13Lo/gtAObP4
 4s2YB/71h6SJjKfEaM23Gr7a0gk1fHH8fLFPGkKMZy4vtKY0Hg7MZwBjwqGCTjsLrFAO
 q4ow==
X-Gm-Message-State: APjAAAVuV9k3+wPVZu7mPRuQ9Gwea8thqYOr2fvfK8VcxSlKvMQ1kT+F
 YToXssK8c8RLRhVk5XxPC0bBiw==
X-Google-Smtp-Source: APXvYqw2UNLaxzjND30jmAW1ftVBSgqFvvKzlqCFSrlNJvhKeNK2CLQDHUDDjXhqbWnhHx4pnlVdQg==
X-Received: by 2002:ac8:38cf:: with SMTP id g15mr17680313qtc.268.1561930569397; 
 Sun, 30 Jun 2019 14:36:09 -0700 (PDT)
Received: from redhat.com ([37.26.146.159])
 by smtp.gmail.com with ESMTPSA id j2sm4224075qtb.89.2019.06.30.14.36.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 14:36:08 -0700 (PDT)
Date: Sun, 30 Jun 2019 17:36:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190630173354-mutt-send-email-mst@kernel.org>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-3-slp@redhat.com>
 <20190628100145-mutt-send-email-mst@kernel.org>
 <87r27dwi1k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r27dwi1k.fsf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 10:50:47PM +0200, Sergio Lopez wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Fri, Jun 28, 2019 at 01:53:47PM +0200, Sergio Lopez wrote:
> >> Put QOM and main struct definition in a separate header file, so it
> >> can be accesed from other components.
> >> 
> >> This is needed for the microvm machine type implementation.
> >> 
> >> Signed-off-by: Sergio Lopez <slp@redhat.com>
> >
> > If you are going to productise virtio-mmio, then 1.0 support is a must.
> > I am not sure we want a new machine with 0.X mmio devices.
> > Especially considering that virtio-mmio does not have support for
> > transitional devices.
> 
> What are the practical implications of that?

On the plus side, this means we don't need to maintain a bunch of hacks
for old guests with quirky drivers.

On the minus side, this requires Linux guests 3.19 and up.




> >> ---
> >>  hw/virtio/virtio-mmio.c | 35 +-----------------------
> >>  hw/virtio/virtio-mmio.h | 60 +++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 61 insertions(+), 34 deletions(-)
> >>  create mode 100644 hw/virtio/virtio-mmio.h
> >> 
> >> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> >> index 97b7f35496..87c7fe4d8d 100644
> >> --- a/hw/virtio/virtio-mmio.c
> >> +++ b/hw/virtio/virtio-mmio.c
> >> @@ -26,44 +26,11 @@
> >>  #include "qemu/host-utils.h"
> >>  #include "qemu/module.h"
> >>  #include "sysemu/kvm.h"
> >> -#include "hw/virtio/virtio-bus.h"
> >> +#include "virtio-mmio.h"
> >>  #include "qemu/error-report.h"
> >>  #include "qemu/log.h"
> >>  #include "trace.h"
> >>  
> >> -/* QOM macros */
> >> -/* virtio-mmio-bus */
> >> -#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> >> -#define VIRTIO_MMIO_BUS(obj) \
> >> -        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> >> -#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> >> -        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> >> -#define VIRTIO_MMIO_BUS_CLASS(klass) \
> >> -        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
> >> -
> >> -/* virtio-mmio */
> >> -#define TYPE_VIRTIO_MMIO "virtio-mmio"
> >> -#define VIRTIO_MMIO(obj) \
> >> -        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> >> -
> >> -#define VIRT_MAGIC 0x74726976 /* 'virt' */
> >> -#define VIRT_VERSION 1
> >> -#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> >> -
> >> -typedef struct {
> >> -    /* Generic */
> >> -    SysBusDevice parent_obj;
> >> -    MemoryRegion iomem;
> >> -    qemu_irq irq;
> >> -    /* Guest accessible state needing migration and reset */
> >> -    uint32_t host_features_sel;
> >> -    uint32_t guest_features_sel;
> >> -    uint32_t guest_page_shift;
> >> -    /* virtio-bus */
> >> -    VirtioBusState bus;
> >> -    bool format_transport_address;
> >> -} VirtIOMMIOProxy;
> >> -
> >>  static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
> >>  {
> >>      return kvm_eventfds_enabled();
> >> diff --git a/hw/virtio/virtio-mmio.h b/hw/virtio/virtio-mmio.h
> >> new file mode 100644
> >> index 0000000000..2f3973f8c7
> >> --- /dev/null
> >> +++ b/hw/virtio/virtio-mmio.h
> >> @@ -0,0 +1,60 @@
> >> +/*
> >> + * Virtio MMIO bindings
> >> + *
> >> + * Copyright (c) 2011 Linaro Limited
> >> + *
> >> + * Author:
> >> + *  Peter Maydell <peter.maydell@linaro.org>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License; either version 2
> >> + * of the License, or (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License along
> >> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +#ifndef QEMU_VIRTIO_MMIO_H
> >> +#define QEMU_VIRTIO_MMIO_H
> >> +
> >> +#include "hw/virtio/virtio-bus.h"
> >> +
> >> +/* QOM macros */
> >> +/* virtio-mmio-bus */
> >> +#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
> >> +#define VIRTIO_MMIO_BUS(obj) \
> >> +        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
> >> +#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
> >> +        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
> >> +#define VIRTIO_MMIO_BUS_CLASS(klass) \
> >> +        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
> >> +
> >> +/* virtio-mmio */
> >> +#define TYPE_VIRTIO_MMIO "virtio-mmio"
> >> +#define VIRTIO_MMIO(obj) \
> >> +        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
> >> +
> >> +#define VIRT_MAGIC 0x74726976 /* 'virt' */
> >> +#define VIRT_VERSION 1
> >> +#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
> >> +
> >> +typedef struct {
> >> +    /* Generic */
> >> +    SysBusDevice parent_obj;
> >> +    MemoryRegion iomem;
> >> +    qemu_irq irq;
> >> +    /* Guest accessible state needing migration and reset */
> >> +    uint32_t host_features_sel;
> >> +    uint32_t guest_features_sel;
> >> +    uint32_t guest_page_shift;
> >> +    /* virtio-bus */
> >> +    VirtioBusState bus;
> >> +    bool format_transport_address;
> >> +} VirtIOMMIOProxy;
> >> +
> >> +#endif
> >> -- 
> >> 2.21.0
> 




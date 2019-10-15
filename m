Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03853ECE59D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92EF20663
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92EF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUDZ-0005uR-I8
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iKUCa-0005L8-Pi
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iKUCX-0008Of-K6
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iKUCX-0008OU-Bm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:17:53 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3613E882EF
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 21:17:51 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id x77so21478630qka.11
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 14:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FJMJ2EIXCH2ZVg1K7W5ZdcvKgQLdrcZTpcSLuLGs20M=;
 b=q038qhfJtIzK59H/q64zlBdRzoxNoBWHWAasS7JdqR6bPe7/wZI0uz9F8k5jfO+tES
 fa6wFlQNgegeN+YA5XXCghEvoR4Xxl54uwKLWC49irP3CyZqt/6JNRLybsNoeElv91zs
 cBXdZ1CiQOOgLmL0s/qQ+KE3LKlJtN+f+YUzEuXUSvWHph/Z4RffSxjIpTq8Md2ZScAK
 6xkt29k4CuhnKvBTF7Jzrki1YgGZX/AP8mn2okYWjj2ZwPxRDV9cvHLMJjM4U7kF7EWn
 UqmZXlvweMpBS+iJCP0ty3TlljEtqY/NnN3jDIv5Xc/SBqkTq5mnKRxkfkP0N6C8Fr2M
 T4fw==
X-Gm-Message-State: APjAAAWxQWGEca+df59w4KSwweijgfnjrMXrVCuS1z25Mq7W2pmUT+0v
 vbh5sAH4H7Zq0xyW9rov+AqkKKrAncrNKzpOgMytG19gehyBJP76IryyMCM4o4zoothXAHB8uFi
 Vo+L3nRCtHjoBgQ4=
X-Received: by 2002:a05:620a:1592:: with SMTP id
 d18mr36759540qkk.282.1571174270456; 
 Tue, 15 Oct 2019 14:17:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyf110hwBhuHWCeyANMqG4zn9BeNq89NkuujYk5dIQHHzmnX9z/hpRT/g+wKleWse2YER0V3w==
X-Received: by 2002:a05:620a:1592:: with SMTP id
 d18mr36759514qkk.282.1571174270192; 
 Tue, 15 Oct 2019 14:17:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 u132sm11687366qka.50.2019.10.15.14.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 14:17:49 -0700 (PDT)
Date: Tue, 15 Oct 2019 17:17:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 0/10] add failover feature for assigned network devices
Message-ID: <20191015171052-mutt-send-email-mst@kernel.org>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191015130317.64d68031@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015130317.64d68031@x1.home>
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
Cc: ehabkost@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, laine@redhat.com, Jens Freimann <jfreimann@redhat.com>,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 01:03:17PM -0600, Alex Williamson wrote:
> On Fri, 11 Oct 2019 13:20:05 +0200
> Jens Freimann <jfreimann@redhat.com> wrote:
> 
> > This is implementing the host side of the net_failover concept
> > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > 
> > Changes since v2:
> > * back out of creating failover pair when it is a non-networking
> >   vfio-pci device (Alex W)
> > * handle migration state change from within the migration thread. I do a
> >   timed wait on a semaphore and then check if all unplugs were
> >   succesful. Added a new function to each device that checks the device
> >   if the unplug for it has happened. When all devices report the succesful
> >   unplug *or* the time/retries is up, continue with the migration or
> >   cancel. When not all devices could be unplugged I am cancelling at the
> >   moment. It is likely that we can't plug it back at the destination which
> >   would result in degraded network performance.
> > * fix a few bugs regarding re-plug on migration source and target 
> > * run full set of tests including migration tests
> > * add patch for libqos to tolerate new migration state
> > * squashed patch 1 and 2, added patch 8 
> >  
> > The general idea is that we have a pair of devices, a vfio-pci and a
> > virtio-net device. Before migration the vfio device is unplugged and data
> > flows to the virtio-net device, on the target side another vfio-pci device
> > is plugged in to take over the data-path. In the guest the net_failover
> > module will pair net devices with the same MAC address.
> > 
> > * Patch 1 adds the infrastructure to hide the device for the qbus and qdev APIs
> > 
> > * Patch 2 sets a new flag for PCIDevice 'partially_hotplugged' which we
> >   use to skip the unrealize code path when doing a unplug of the primary
> >   device
> > 
> > * Patch 3 sets the pending_deleted_event before triggering the guest
> >   unplug request
> 
> These only cover pcie hotplug, is this feature somehow dependent on
> pcie?  There's also ACPI-based PCI hotplug, SHPC hotplug, and it looks
> like s390 has it's own version (of course) of PCI hotplug.  IMO, we
> either need to make an attempt to support this universally or the
> option needs to fail if the hotplug controller doesn't support partial
> removal.  Thanks,
> 
> Alex


Alex, could you please comment a bit more on vfio patches?
Besides what you point out here, any other issues?

-- 
MST


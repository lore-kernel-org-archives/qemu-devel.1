Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06342C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D614720679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D614720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8Iy-0000s2-41
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hd8I2-0000QA-SF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hd8I1-0003a1-Pi
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hd8I1-0003ZY-I4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:12:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA6148552A;
 Tue, 18 Jun 2019 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F4E07E8E5;
 Tue, 18 Jun 2019 07:11:58 +0000 (UTC)
Date: Tue, 18 Jun 2019 09:11:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190618071156.GA4296@localhost.localdomain>
References: <20190617181521.29371-1-elena.ufimtseva@oracle.com>
 <20190618062406.m67ytpr3fjpxhlbo@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618062406.m67ytpr3fjpxhlbo@sirius.home.kraxel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 18 Jun 2019 07:12:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/35] multi-process: build system
 for remote device process
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, konrad.wilk@oracle.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, afaerber@suse.de,
 pbonzini@redhat.com, fam@euphon.net, mreitz@redhat.com,
 kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.06.2019 um 08:24 hat Gerd Hoffmann geschrieben:
>   Hi,
> 
> > +#########################################################
> > +# remote-pci-obj-y is common code used by remote devices
> > +
> > +remote-pci-obj-$(CONFIG_MPQEMU) += hw/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += qom/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += backends/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += block/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += migration/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += remote/
> > +
> > +remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
> > +remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
> > +remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
> > +remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
> > +remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
> > +remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
> 
> > +all-remote-pci-obj-y += $(authz-obj-y)
> > +all-remote-pci-obj-y += $(block-obj-y)
> > +all-remote-pci-obj-y += $(crypto-obj-y)
> > +all-remote-pci-obj-y += $(io-obj-y)
> > +all-remote-pci-obj-y += $(chardev-obj-y)
> > +all-remote-pci-obj-y += $(remote-pci-obj-y)
> 
> > +remote-pci-obj-$(CONFIG_MPQEMU) += core/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += block/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += pci/
> > +remote-pci-obj-$(CONFIG_MPQEMU) += nvram/
> 
> Phew.  So you are building half of qemu into the remote process.
> 
> Wouldn't it be more useful to split off much smaller, well-defined
> pieces into separate processes?
> 
> Splitting off the block layer looks like a good candidate to me.  You'll
> have a qemu-remote-block[1] then which should not need much beside
> block/, and a small blockdev-proxy in qemu which talks to
> qemu-remote-block instead of accessing the disk image by itself.  It's
> also a nice improvement from the security point of view, even without
> moving the device emulation too, because the main qemu process doesn't
> need access to the image files any more.

I am already playing with an external storage daemon, which would
probably also cover these use cases. It won't be quite as small as you
suggest (e.g. it will have its own QMP interface), but it will still
separate image file handling from the process actually running the
guest.

The idea is to let it export images via the vhost-user protocol, but I
haven't actually started to implement that part yet (at the moment it's
essentially a qemu-nbd replacement that has a QMP monitor that doesn't
understand any commands).

In any case, if you start splitting off smaller pieces, don't use the
block layer because it would be duplicated work.

Kevin


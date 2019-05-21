Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DBC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752E321773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752E321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5cg-0001yq-Op
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:20:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hT5bQ-0001C4-25
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hT5bP-0006MV-2y
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:18:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hT5bO-0006Ip-Ns
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:18:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63A4C99D2E
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 14:18:46 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 57C9A79441;
	Tue, 21 May 2019 14:18:20 +0000 (UTC)
Date: Tue, 21 May 2019 08:18:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521081820.0d81a309@x1.home>
In-Reply-To: <20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 21 May 2019 14:18:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
	laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 09:21:57 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
> >On Fri, 17 May 2019 14:58:16 +0200
> >Jens Freimann <jfreimann@redhat.com> wrote:  
> >> Command line example:
> >>
> >> qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> >>         -machine q35,kernel-irqchip=split -cpu host   \
> >>         -k fr   \
> >>         -serial stdio   \
> >>         -net none \
> >>         -qmp unix:/tmp/qmp.socket,server,nowait \
> >>         -monitor telnet:127.0.0.1:5555,server,nowait \
> >>         -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> >>         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> >>         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> >>         -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> >>         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on \
> >>         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> >>
> >> Then the primary device can be hotplugged via
> >>  (qemu) device_add vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1  
> >
> >Is this standby= option only valid for Network/Ethernet class code
> >devices?  If so, perhaps vfio-pci code should reject the option on any
> >non-ethernet devices.  The option is also non-intuitive for users, only
> >through examples like above can we see it relates to the id of the
> >secondary device.  Could we instead name it something like
> >"standby_net_failover_pair_id="?  
> 
> It is only for ethernet (VFs), I will add code to reject non-ethernet VF devices.
> I agree the name is not descriptive and the one you suggest seems good to
> me. 
> >
> >Also, this feature requires matching MAC addresses per the description,
> >where is that done?  Is it the user's responsibility to set the MAC on
> >the host device prior to the device_add?  If so, is this actually not
> >only specific to ethernet devices, but ethernet VFs?  
> 
> Yes, it's the users responsibility and the MACs are then matched by
> the net_failover driver in the guest. It makes sense for ethernet VFs only,
> I'll add a check for that.

FWIW, I'd probably stop at Ethernet class devices, vfio doesn't really
expose whether a device is a VF, so we'd likely need to resort to
getting that info through sysfs.  It also seems like there might be
some limited-use cases of copying the MAC from a PF to the virtio nic
or use of utilities on the host for modifiying a PF MAC, perhaps via
eeprom.  So while we expect the typical use case to be a VF, it's
probably ugly and unnecessarily restrictive to enforce it.  Thanks,

Alex


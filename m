Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED56BC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 11:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C392A2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 11:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C392A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlAOj-0008Av-RB
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 07:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55636)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlANV-0007X1-CW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlANU-0004lw-5r
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlANQ-0004SV-8P; Wed, 10 Jul 2019 07:03:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E20A82F8BF0;
 Wed, 10 Jul 2019 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-179.ams2.redhat.com
 [10.36.117.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4BE892D5F;
 Wed, 10 Jul 2019 11:02:43 +0000 (UTC)
Date: Wed, 10 Jul 2019 13:02:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190710110241.GB6501@localhost.localdomain>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
 <f790cb77-fa6a-c304-bc7f-62bbede78751@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f790cb77-fa6a-c304-bc7f-62bbede78751@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 10 Jul 2019 11:02:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio: handle zoned backing devices
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
Cc: fam@euphon.net, qemu-block@nongnu.org, mst@redhat.com,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.07.2019 um 12:09 hat Paolo Bonzini geschrieben:
> On 09/07/19 22:38, Dmitry Fomichev wrote:
> > Currently, attaching zoned block devices (i.e. storage devices
> > compliant to ZAC/ZBC standards) using several virtio methods doesn't
> > work - the zoned devices appear as regular block devices at the guest.
> > This may cause unexpected i/o errors and, potentially, some data
> > corruption.
> > 
> > To be more precise, attaching a zoned device via virtio-pci-blk,
> > virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
> > above behavior. A simple fix is needed to make
> > virtio-scsi-pci/scsi-block work and this is covered by a different
> > patch. The virtio-scsi-pci/scsi-generic method appears to handle zoned
> > devices without problems.
> 
> The problem with this approach is that other devices (e.g. ide-hd or sd
> card) also break with zoned devices and the only way to fix it would be
> to add code denying zoned block devices to all of them.
> 
> The question then becomes how to define a whitelist.  One possiblity is
> to add a QOM interface (for example TYPE_ZONED_BLOCK_SUPPORT) to
> scsi-block and scsi-generic.  In do_parse_drive you can query the
> BlockBackend with bdrv_get_zoned_info, and return an error if the
> backend is a zoned block device and the device does not implement
> TYPE_ZONED_BLOCK_SUPPORT.  (Commit 6b1566c is an example of adding a new
> QOM interface; in your case, it would be simpler as the interface would
> not have any method).  Kevin, what do you think?

What about non-device users such as block jobs or (NBD) exports? Won't
they have to special-case such devices, too? In fact, what about image
format drivers or even filters?

I feel that this needs to be managed at the BDS level somehow. Not sure
which mechanism to use, though. Permissions would be suitable for a
blacklist approach, but I agree with you that we need a whitelist
instead.

Hm... Actually, file-posix implements .bdrv_check_perm and could just
refuse attaching a parent there if it doesn't request a specific
permission like BLK_PERM_SUPPORT_ZONED. That should give us the
whitelist semantics through existing infrastructure.

Kevin


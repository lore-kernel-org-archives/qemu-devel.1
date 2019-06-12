Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7490DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA6120874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA6120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb30L-0000q5-Ej
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 09:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60215)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hb2ya-0007tu-FP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hb2yZ-00015Q-D9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hb2yP-0000iL-6B; Wed, 12 Jun 2019 09:07:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3AF959473;
 Wed, 12 Jun 2019 13:06:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 435D51001B0A;
 Wed, 12 Jun 2019 13:06:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1243C16E08; Wed, 12 Jun 2019 15:06:50 +0200 (CEST)
Date: Wed, 12 Jun 2019 15:06:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jun 2019 13:06:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 0/8] Add Qemu to SeaBIOS LCHS
 interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 02:59:31PM +0300, Sam Eiderman wrote:
> v1:
> 
> Non-standard logical geometries break under QEMU.
> 
> A virtual disk which contains an operating system which depends on
> logical geometries (consistent values being reported from BIOS INT13
> AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
> logical geometries - for example 56 SPT (sectors per track).
> No matter what QEMU will guess - SeaBIOS, for large enough disks - will
> use LBA translation, which will report 63 SPT instead.

--verbose please.

As far I know seabios switches to LBA mode when the disk is simply too
big for LCHS addressing.  So I fail to see which problem is solved by
this.  If your guest needs LCHS, why do you assign a disk which can't
be fully accessed using LCHS addressing?

> In addition we can not enforce SeaBIOS to rely on phyiscal geometries at
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
> report more than 16 physical heads when moved to an IDE controller, the
> ATA spec allows a maximum of 16 heads - this is an artifact of
> virtualization.

Well, not really.  Moving disks from one controller to another when the
OS depends on LHCS addressing never is a good idea.  That already caused
problems in the 90-ies, when moving scsi disks from one scsi host
adapter to another type, *way* before virtualization became a thing.

BTW:  One possible way to figure which LCHS layout a disk uses is to
check the MBR partition table.  With that we (a) don't need a new
interface between qemu and seabios and (b) it is not needed to manually
specify the geometry.

cheers,
  Gerd



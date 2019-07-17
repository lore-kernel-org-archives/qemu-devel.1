Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ABDC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2358F21851
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 19:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2358F21851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnpsz-0004yF-EQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 15:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnpso-0004VE-CH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnpsn-0005fI-BW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 15:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnpsl-0005dl-4d; Wed, 17 Jul 2019 15:46:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D0C081F2F;
 Wed, 17 Jul 2019 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-47.ams2.redhat.com
 [10.36.117.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCB9B5C257;
 Wed, 17 Jul 2019 19:46:24 +0000 (UTC)
Date: Wed, 17 Jul 2019 21:46:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190717194623.GF6471@localhost.localdomain>
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
 <424BE97C-7EAF-4B28-B580-AC2B5261197C@oracle.com>
 <EB5E5E3C-CCA1-4138-9623-89ECA7335F88@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB5E5E3C-CCA1-4138-9623-89ECA7335F88@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 17 Jul 2019 19:46:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 0/8] Add Qemu to SeaBIOS LCHS
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
Cc: qemu-block@nongnu.org, Arbel Moshe <arbel.moshe@oracle.com>,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kevin O'Connor <kevin@koconnor.net>,
 Liran Alon <liran.alon@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.07.2019 um 21:03 hat Sam Eiderman geschrieben:
> Gentle ping.

Through which tree is this supposed to go? I feel this is more firmware
interface related than block layer stuff.

Kevin

> > On 8 Jul 2019, at 20:30, Sam Eiderman <shmuel.eiderman@oracle.com> wrote:
> > 
> > Thanks Gerd,
> > 
> > Gentle ping on this.
> > 
> > Sam
> > 
> >> On 1 Jul 2019, at 10:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> 
> >> On Wed, Jun 26, 2019 at 03:39:40PM +0300, Sam Eiderman wrote:
> >>> v1:
> >>> 
> >>> Non-standard logical geometries break under QEMU.
> >>> 
> >>> A virtual disk which contains an operating system which depends on
> >>> logical geometries (consistent values being reported from BIOS INT13
> >>> AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
> >>> logical geometries - for example 56 SPT (sectors per track).
> >>> No matter what QEMU will guess - SeaBIOS, for large enough disks - will
> >>> use LBA translation, which will report 63 SPT instead.
> >>> 
> >>> In addition we can not enforce SeaBIOS to rely on phyiscal geometries at
> >>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
> >>> report more than 16 physical heads when moved to an IDE controller, the
> >>> ATA spec allows a maximum of 16 heads - this is an artifact of
> >>> virtualization.
> >>> 
> >>> By supplying the logical geometies directly we are able to support such
> >>> "exotic" disks.
> >>> 
> >>> We will use fw_cfg to do just that.
> >>> 
> >>> v2:
> >>> 
> >>> Fix missing parenthesis check in
> >>>   "hd-geo-test: Add tests for lchs override"
> >>> 
> >>> v3:
> >>> 
> >>> * Rename fw_cfg key to "bios-geometry".
> >>> * Remove "extendible" interface.
> >>> * Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
> >>> * Fix last qtest commit - automatic docker tester for some reason does not have qemu-img set
> >>> 
> >>> v4:
> >>> 
> >>> * Change fw_cfg interface from mixed textual/binary to textual only
> >>> 
> >>> v5:
> >>> 
> >>> * Fix line > 80 chars in tests/hd-geo-test.c
> >> 
> >> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> >> 
> >> cheers,
> >> Gerd
> >> 
> > 
> 


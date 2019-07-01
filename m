Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904DC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1883208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1883208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhqyn-000632-Tx
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 03:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55529)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hhqwq-0005By-PO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hhqwp-0003b8-RY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hhqwn-0003KD-LL; Mon, 01 Jul 2019 03:41:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7356811D8;
 Mon,  1 Jul 2019 07:41:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74A7B7DF5F;
 Mon,  1 Jul 2019 07:41:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 995EB11AA3; Mon,  1 Jul 2019 09:41:17 +0200 (CEST)
Date: Mon, 1 Jul 2019 09:41:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 01 Jul 2019 07:41:29 +0000 (UTC)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 03:39:40PM +0300, Sam Eiderman wrote:
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
> 
> In addition we can not enforce SeaBIOS to rely on phyiscal geometries at
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
> report more than 16 physical heads when moved to an IDE controller, the
> ATA spec allows a maximum of 16 heads - this is an artifact of
> virtualization.
> 
> By supplying the logical geometies directly we are able to support such
> "exotic" disks.
> 
> We will use fw_cfg to do just that.
> 
> v2:
> 
> Fix missing parenthesis check in
>     "hd-geo-test: Add tests for lchs override"
> 
> v3:
> 
> * Rename fw_cfg key to "bios-geometry".
> * Remove "extendible" interface.
> * Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
> * Fix last qtest commit - automatic docker tester for some reason does not have qemu-img set
> 
> v4:
> 
> * Change fw_cfg interface from mixed textual/binary to textual only
> 
> v5:
> 
> * Fix line > 80 chars in tests/hd-geo-test.c

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd



Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8018BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B8A22DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B8A22DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03Gk-0003Nh-Cv
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i03FV-0002CI-67
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i03FU-0001BI-5m
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i03FU-0001AO-0Z
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD1AC3082131;
 Tue, 20 Aug 2019 12:28:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE93871E9;
 Tue, 20 Aug 2019 12:28:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3AF2E11AAF; Tue, 20 Aug 2019 14:28:25 +0200 (CEST)
Date: Tue, 20 Aug 2019 14:28:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190820122825.ok2jfngulypcyvah@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.9999.1908190208150.57965@zero.eik.bme.hu>
 <20190819061545.7qeiyonvvqe3s6up@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908200126020.56805@zero.eik.bme.hu>
 <20190820062552.ivu7o4rcroppkjje@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908201235270.15352@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1908201235270.15352@zero.eik.bme.hu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 20 Aug 2019 12:28:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Machine specific option ROMs
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Plus I don't know if other firmwares such as sam460ex U-Boot can handle such
> multiplatform ROMs, especially because it can use x86 ROM

Yes, how the guest treats those roms is another issue.  bios/efi combo
roms on x86 are not that uncommon.  But I'm not sure how widespread
bios/openfirmare combo roms are used (have been used) in practice.  If
guests can't deal with it (and try to run a x86 emulator on the bios
image instead) it might not be the best plan to go that route.

> just not the QEMU
> vgabios due to not emulating i386 specific opcodes that gcc puts in real
> mode code

What does sam460ex use?  Some x86emu fork?  If so upgrading might help.
Xorg uses x86emu too and older versions have problems with the
gcc-generated real mode code too.

cheers,
  Gerd



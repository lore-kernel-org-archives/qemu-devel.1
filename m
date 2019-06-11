Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5784FC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3111420896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3111420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haaZ5-0003WN-7S
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 02:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54504)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1haaWL-0002TY-BM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1haaJF-00081C-25
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1haaJ5-0007do-0T; Tue, 11 Jun 2019 02:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A31D356F6;
 Tue, 11 Jun 2019 06:30:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F83951409;
 Tue, 11 Jun 2019 06:30:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 475B616E18; Tue, 11 Jun 2019 08:30:19 +0200 (CEST)
Date: Tue, 11 Jun 2019 08:30:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190611063019.2uiatioxh73lrgqz@sirius.home.kraxel.org>
References: <CAKmqyKMs4nt0eddFkXHG9vOdxnj=yB8jx8s9NivNiwvVg8TObA@mail.gmail.com>
 <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 11 Jun 2019 06:30:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] RISC-V: Include ROM in QEMU
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, onathan@fintelia.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 05:03:42PM -0700, Palmer Dabbelt wrote:
> On Thu, 06 Jun 2019 16:22:47 PDT (-0700), alistair23@gmail.com wrote:
> > Hello,
> > 
> > As a test of the waters, how would the QEMU community feel about
> > including the RISC-V OpenSBI project as a ROM submodule?
> > 
> > The idea would be to have OpenSBI (similar to ATF for ARM and a BIOS
> > for x86) included by default to simplify the QEMU RISC-V boot process
> > for users. This would remove the requirement for users/developers to
> > build a RISC-V firmware. The goal here is to allow people to just
> > download and run their kernel as easily as they currently do for x86.
> > 
> > We would make sure that it can be disabled! That is users/developers
> > can use their own (or none) if they want to. The idea here is just to
> > simplify the boot process, not lock anyone out.
> 
> I like it.  My only question is about the mechanics of doing so: are we just
> going to assume there's a cross compiler in PATH?  I guess that's less of a
> usability headache than needing a complier and a firmware.

Usual way to add firmware:

  (1) Add a submodule below roms/
  (2) Add rules to build the firmware to roms/Makefile.  Firmware
      maintainers can use them, and they also document the build process.
      A normal qemu build will not automatically build the firmware
      though.
  (3) Place a pre-built binary in pc-bios/

There is some cross compiler detection logic in roms/Makefile which you
can use.

cheers,
  Gerd



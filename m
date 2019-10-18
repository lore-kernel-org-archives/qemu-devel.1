Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EE1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E8320820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="XuRbfh2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E8320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWsD-0003tA-KL
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iLW3L-0007LM-Fc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iLW3H-0002CB-Qm
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:28:39 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:35544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iLW3H-0002B2-KO; Fri, 18 Oct 2019 13:28:35 -0400
Date: Fri, 18 Oct 2019 12:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571419713;
 bh=2ccc2hl/g/jdVFKlQHgt++kl1Utj1PoCbAIAY6sojWg=;
 h=Date:From:To:Cc:Subject:From;
 b=XuRbfh2AYtrAu9rB3i3FtiRmYCZtXBtHl2DCQUrhMHxilns0eMrGmeOiVtcG3N6RH
 DmvD+H6S7Mq+ebs6cgak7Gf2mUd9ycix3wq3zrEy3iD0MDUgENg2wOgh3Tp09aHXci
 SXu0uycBjDsnTxdl22jChviY+4OJ7WaCgU+G1AYDR0vNxmlq0H/KYE2dQPMR/FP3IV
 cuvXVlwc5/rf3nbibxzY83lWLHNLfjcX5NChwv2eJlL4enhlUMzbzPQglYGojYnDWD
 IjaiuD1pxFow8LNz2gkUz97XVDhf5ZwWfo9PIjA3iANoZMGA9QSZoo9/CSiY3BpQYu
 EG48YnzKhtJFQ==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: qemu/powernv: coreboot support?
Message-ID: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.155
X-Mailman-Approved-At: Fri, 18 Oct 2019 14:17:51 -0400
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

First off, thank you for the work you've done on the ppc64 support, it
has been very useful. I'm currently working on a coreboot port for the
talos ii line of systems (which means more ppc64 support, support
specifically for the power9 sforza chip, and specific mainboard support.
My plate is very full lol) and have been using qemu to debug the
bootblock.

It has been very useful for that, but I'm now at the point where I need
to jump to romstage, and that's where it gets tricky. qemu parses the rom
image and looks for a ffs header, locates skiboot on it, and jumps straight
to that. Not exactly ideal for debugging something not produced from op-build.

Do you think it would be within your wheelhouse to provide a generic, non-ffs
pnor interface for loading arbitary rom images? It would be of great help if
you could. (This would still hopefully have the bmc support code as
well, as I'm still needing to support a system using one).

Regards,
Marty


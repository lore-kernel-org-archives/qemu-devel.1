Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 06:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3934020866
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 06:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="n3HfZj4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3934020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbJ1t-0002c5-FR
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 02:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33641)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbJ08-0000i3-2s
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 02:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbIts-0000lv-W7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 02:07:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36609 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hbItp-0000Vj-BO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 02:07:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45PYDg3ZBCz9sBp; Thu, 13 Jun 2019 16:07:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560406051;
 bh=ouXnPZSMxus7wyrIDJPMADgA7moITH35ceoZAMTJz6c=;
 h=From:To:Cc:Subject:Date:From;
 b=n3HfZj4Oz/bhuDnOtHNIcka2NMSZAz1QKtA8NjCRu2FUvPQpov9viw7ERz396nFsd
 pwyhhw3iVNHlCW0TAUl82CiSljW6X/v16yreYuAnB0vASlt/Du4GO3C18/jLi0h3EU
 9zFyx76YTajs73kcmxFXgll4AmGb39t7Ni/Gk1yc=
From: David Gibson <david@gibson.dropbear.id.au>
To: crosa@redhat.com, qemu-devel@nongnu.org, arikalo@wavecomp.com,
 aurelien@aurel32.net, ehabkost@redhat.com
Date: Thu, 13 Jun 2019 16:07:25 +1000
Message-Id: <20190613060728.26955-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH 0/3] Some fixes for make check-acceptance on a
 POWER host
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are several patches which address failures I see when attempting
to run "make check-acceptance" on a POWER host machine.

David Gibson (3):
  tests/acceptance: Specify arch for QueryCPUModelExpansion
  tests/acceptance: Handle ppc64le host arch correctly
  tests/acceptance: Increase timeout for LinuxSSH test

 tests/acceptance/avocado_qemu/__init__.py | 2 ++
 tests/acceptance/cpu_queries.py           | 3 +++
 tests/acceptance/linux_ssh_mips_malta.py  | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

--=20
2.21.0



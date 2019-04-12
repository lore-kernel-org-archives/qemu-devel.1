Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5254AC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB4F20674
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l7eewguW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB4F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34515 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEuGr-0000Id-98
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:23:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEuEx-0007gW-NA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEuEs-0001IU-G0
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:21:00 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hEuEr-0001Ak-0J; Fri, 12 Apr 2019 07:20:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44gb6l44CQz9sBp; Fri, 12 Apr 2019 21:20:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555068047;
	bh=7OZZJTnz7NNaFnZuQScRhbRUmvkDH3WbxDZLt7pIQSI=;
	h=From:To:Cc:Subject:Date:From;
	b=l7eewguWSICdk/UKSfWAA4uFvCAognNxjjoBacKfSEZGaiKOv0KlBbiIDw7Hrce+2
	1FAwDz6lY0ohB+UmHpHCdSrGgIwchpx5cWFAIXzrHD77Gzd8N7GQ+fo2gr9UBpFQG+
	81lZGknk1uEqoczfVMwT7DUFVaYRUdwfEEnb65oY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 21:20:43 +1000
Message-Id: <20190412112044.15361-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 0/1] ppc-for-4.0 queue 20190412
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
Cc: lvivier@redhat.com, mst@redhat.com, clg@redhat.com, qemu-devel@nongnu.org,
	groug@kaod.org, alex.williamson@redhat.com, spopovyc@redhat.com,
	qemu-ppc@nongnu.org, marcel@redhat.com,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412112043.t21jr07Q0tCRpSjJt5JfPKd3f6GpZn7euHVTIZrgkJE@z>

The following changes since commit 532cc6da74ec25b5ba6893b5757c977d545829=
49:

  Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190412

for you to fetch changes up to 4560116e42a21989a4b6cf9551ce2f90b16c7238:

  spapr_pci: Fix broken naming of PCI bus (2019-04-12 12:23:02 +1000)

----------------------------------------------------------------
ppc patch queue for 2018-04-12

Here's a last minute pull request for 4.0.  Turns out my last pull
request, to fix a regression in extended config space access for the
pseries machine didn't fix things hard enough.  This PR has a single
patch which improves the fix to work in more cases.

It's a ghastly, ghastly hack, but it's simple and localized.  I
already have patches almost ready to go in 4.1 that provides a simpler
and cleaner solution to all this.

----------------------------------------------------------------
Greg Kurz (1):
      spapr_pci: Fix broken naming of PCI bus

 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


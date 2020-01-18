Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F487C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3840C24683
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHXOKlfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3840C24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isjuE-0001DI-Bs
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 03:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isjt7-0000EA-3o
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isjt4-0004Mj-GS
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:55:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isjt4-0004M0-DF
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579337721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6ndBVXUXq4bVFwB7NxD99RDj4Gmf/83NkA1b9g+NEWU=;
 b=PHXOKlfAW3QDqXRDEyNsfxh3a5OSC0T1QWqgThcCETHIQ4dl/k73NF49ekhsVp2UZzhenc
 ICFtLzBDeOdQc2hQzlm541OZf64iWZKT0EotjyH4Rl6FBgJrGSO2LhJvdstm8KiQqmENkw
 g8J6d8VdQlhYu9Peq3zyGpj6GF8UV60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-geYg4HDhMMiogkhFqDyGlA-1; Sat, 18 Jan 2020 03:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F2A1184C71F;
 Sat, 18 Jan 2020 08:55:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C227F5C1B2;
 Sat, 18 Jan 2020 08:55:12 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] MAINTAINERS: ARM & SD fixes
Date: Sat, 18 Jan 2020 09:55:07 +0100
Message-Id: <20200118085509.30182-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: geYg4HDhMMiogkhFqDyGlA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few fixes after looking at Vladimir's commit-per-subsystem.py script:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg651545.html

Since v1 [*]:
- Rebased (dropping patch 1 merged as 1232ed1f27 via qemu-trivial)
- Add qemu-arm@nongnu.org to STM32F405 and Netduino Plus 2
- Added Alistair R-b tag

[*]  https://www.mail-archive.com/qemu-devel@nongnu.org/msg651746.html
Supersedes: <20191012065426.10772-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  MAINTAINERS: Cc the qemu-arm@nongnu.org for the ARM machines
  MAINTAINERS: Move the OMAP section inside the ARM Machines one

 MAINTAINERS | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--=20
2.21.1



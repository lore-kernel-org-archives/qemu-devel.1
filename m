Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BDC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EBC22527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtJ8aMUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EBC22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcIU-0007RS-09
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itcH1-00066l-DS
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itcH0-0004pK-AA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:59:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itcH0-0004p4-71
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579546781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FyT6X3cvGudDEoArP9RMSmHzFqcNVVsTlP/NRJe7+5c=;
 b=RtJ8aMUZfULcZAtc4NhnzPmQVkJwTAgeGUasvSxbZUW+trIWa6hqSupFX2LZstV60Lx+wZ
 HPWqGGixD2O25w49WfXh5MJrS62tZP62w7SFWyJz8Aafo9BUo2gh1DLPixPROOjo8i1LB5
 QKnxyWGcG5az8Azw9TRyXQdro8FW+NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-n8UHzYvbPhKR4e8PYMSZng-1; Mon, 20 Jan 2020 13:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3DA818FE888;
 Mon, 20 Jan 2020 18:59:36 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-38.brq.redhat.com [10.40.205.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BCD95C1BB;
 Mon, 20 Jan 2020 18:59:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] MAINTAINERS: ARM fixes
Date: Mon, 20 Jan 2020 19:59:26 +0100
Message-Id: <20200120185928.25115-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: n8UHzYvbPhKR4e8PYMSZng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few fixes after looking at Vladimir's commit-per-subsystem.py script:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg651545.html

Since v2 [2]:
- Do not move 'OMAP devices' section, but add 'SX1' new one (pm215)

Since v1 [1]:
- Rebased (dropping patch 1 merged as 1232ed1f27 via qemu-trivial)
- Add qemu-arm@nongnu.org to STM32F405 and Netduino Plus 2
- Added Alistair R-b tag

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg651746.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg671653.html
Supersedes: <20200118085509.30182-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  MAINTAINERS: Cc the qemu-arm@nongnu.org for the ARM machines
  MAINTAINERS: Add an entry for the Siemens SX1 (OMAP310) machines

 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--=20
2.21.1



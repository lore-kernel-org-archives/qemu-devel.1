Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAAFC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58085206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMVkP0j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58085206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dyI-0002DE-Hz
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6dxG-0000vq-I8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6dxF-0007nn-Dq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6dxF-0007mL-A8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582651508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TS9KyKrlERvOO59j3lBIH68dy8WcIUr+GR/9yXzAzLc=;
 b=ZMVkP0j/jqbEMOb3flGCsOkQ2AN3o06RVJ+4W2prl59jZ/VlJ3Ep3YU52NEhCP3DhGmUZo
 ep012oB8lpm5vpvCENz++ITdWzazsPtL2mIvIaf76wZ7Nyi22tTf04CSW2x9nZnix9usCW
 pp0h1t2uU1Iz/mTiKo95CAOGjLi5qtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-lhZ6rkQFNaeeJfeOOGn9FQ-1; Tue, 25 Feb 2020 12:25:06 -0500
X-MC-Unique: lhZ6rkQFNaeeJfeOOGn9FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94838800D53;
 Tue, 25 Feb 2020 17:25:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFC2060C18;
 Tue, 25 Feb 2020 17:25:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] tests/acceptance: nSeries and integrator/CP tests
Date: Tue, 25 Feb 2020 18:24:57 +0100
Message-Id: <20200225172501.29609-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series collects patches adding tests for arm machines.
All patches are reviewed.

Philippe Mathieu-Daud=C3=A9 (2):
  tests/acceptance: Extract boot_integratorcp() from test_integratorcp()
  tests/acceptance/integratorcp: Verify Tux is displayed on framebuffer

Thomas Huth (2):
  tests/acceptance: Add a test for the N800 and N810 arm machines
  tests/acceptance: Add a test for the integratorcp arm machine

 MAINTAINERS                                  |  2 +
 tests/acceptance/machine_arm_integratorcp.py | 99 ++++++++++++++++++++
 tests/acceptance/machine_arm_n8x0.py         | 49 ++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_integratorcp.py
 create mode 100644 tests/acceptance/machine_arm_n8x0.py

--=20
2.21.1



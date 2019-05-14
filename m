Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0172C20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0172C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUGd-0007uL-LU
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:02:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQUEj-0006Vg-7i
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQUEi-0003q7-AD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hQUEY-0003EK-4j; Tue, 14 May 2019 06:00:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51CCB308A963;
	Tue, 14 May 2019 10:00:27 +0000 (UTC)
Received: from thuth.com (ovpn-116-85.ams2.redhat.com [10.36.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDBB85C207;
	Tue, 14 May 2019 10:00:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:00:15 +0200
Message-Id: <20190514100019.13263-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 14 May 2019 10:00:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] Kconfig switches for core / misc devices
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
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are some more Kconfig patches that introduce proper config
switches for some devices in the hw/core and hw/misc directories.

Thomas Huth (4):
  hw/core: Add a config switch for the "register" device
  hw/core: Add a config switch for the "or-irq" device
  hw/core: Add a config switch for the "split-irq" device
  hw/misc: Add a config switch for the "unimplemented" device

 hw/arm/Kconfig        | 12 ++++++++++++
 hw/core/Kconfig       |  9 +++++++++
 hw/core/Makefile.objs |  6 +++---
 hw/dma/Kconfig        |  1 +
 hw/microblaze/Kconfig |  1 +
 hw/misc/Kconfig       |  3 +++
 hw/misc/Makefile.objs |  2 +-
 hw/pci-host/Kconfig   |  3 ++-
 hw/sparc64/Kconfig    |  1 +
 hw/timer/Kconfig      |  1 +
 10 files changed, 34 insertions(+), 5 deletions(-)

--=20
2.21.0



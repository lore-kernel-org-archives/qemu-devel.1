Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA4C4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79F32084F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79F32084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jDK-0005KL-EY
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i8jBc-0003Tl-NR
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i8jBb-0005sy-OB
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i8jBY-0005q9-RK; Fri, 13 Sep 2019 06:52:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28CFE9ACE;
 Fri, 13 Sep 2019 10:52:16 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79B63600D1;
 Fri, 13 Sep 2019 10:52:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 12:52:03 +0200
Message-Id: <20190913105205.7581-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 13 Sep 2019 10:52:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] trace: Forbid trailing newline in event
 format
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

I'v been confused by trailing newline in trace reports,
so this series aims to fix this, by cleaning current
formats and add a check to catch new one introduced.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  trace: Remove trailing newline in events
  trace: Forbid event format ending with newline character

 docs/devel/tracing.txt        |  2 ++
 hw/misc/trace-events          | 10 +++++-----
 hw/scsi/trace-events          |  2 +-
 hw/sd/trace-events            |  2 +-
 nbd/trace-events              |  4 ++--
 net/trace-events              |  6 +++---
 scripts/tracetool/__init__.py |  3 +++
 7 files changed, 17 insertions(+), 12 deletions(-)

--=20
2.20.1



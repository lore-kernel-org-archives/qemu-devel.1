Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC0EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CE82083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c09jlg0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CE82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHXK-0003eu-Oe
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHW7-0001xH-8V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHW6-0000TM-6k
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHW6-0000S5-2K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PM4McVHOdqOGvyrnKChRIPtBPDROFP1aHk/Bwxmac9A=;
 b=c09jlg0icKiUrfrPkfdrURiB3F/rX1QbTQWDVyvw6KrJpqxAJtZokEWPoPi3X7bRFeFDUv
 gxSblBedeZAueTv2zgpFLg22Ce12yQlEDyTN3TAsex4laL3ZvppsqLPpWdAP2CdaO3ZKWM
 dxulk7TxPJ/aFi9HEsNwAMLeN494h+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-afvL6G8tPmu3jDUzntbn8w-1; Thu, 30 Jan 2020 16:38:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDB3899470;
 Thu, 30 Jan 2020 21:38:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97F4784BCE;
 Thu, 30 Jan 2020 21:38:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Tracing patches
Date: Thu, 30 Jan 2020 21:38:09 +0000
Message-Id: <20200130213814.334195-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: afvL6G8tPmu3jDUzntbn8w-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f57d=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
130' into staging (2020-01-30 16:19:04 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to e144a605a614d22165000c69e8e1dc6986d45cd8:

  qemu_set_log_filename: filename argument may be NULL (2020-01-30 21:33:50=
 +0000)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Peter Maydell (3):
  docs/devel/tracing.txt: Recommend only
    trace_event_get_state_backends()
  memory.c: Use trace_event_get_state_backends()
  hw/display/qxl.c: Use trace_event_get_state_backends()

Philippe Mathieu-Daud=C3=A9 (1):
  Makefile: Keep trace-events-subdirs ordered

Salvador Fandino (1):
  qemu_set_log_filename: filename argument may be NULL

 Makefile.objs          |  4 ++--
 docs/devel/tracing.txt | 12 +++++-------
 hw/display/qxl.c       |  2 +-
 memory.c               |  8 ++++----
 trace/control.c        |  4 +---
 util/log.c             | 28 ++++++++++++++++------------
 vl.c                   |  5 +----
 7 files changed, 30 insertions(+), 33 deletions(-)

--=20
2.24.1



Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1418222D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSEetEcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1418222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX45X-0006Fx-Jc
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX43w-0004ux-Lz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX43r-00019l-KD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:01:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX43r-00019N-Dw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574172054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JYVVVT4zHwb4lFVQhhUGq9/FBXqruRn/Kt2ktDIPh4w=;
 b=NSEetEczNZH5g5pgtCMX1mcHzX7wWXUzGjl1uMmybToptlxMeOK+6TfKIQYZG3Zoky6FkP
 +fUfGB52R0K6Lpf2kNeVLmUZALQEF2vkbfMtSQUXHW0CC5gSjM4sj5OTvEvEyZfxM7/lw6
 mlSi7s+E1qYmLG8ust50B1qEy3FgvG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-cmpauROsO7iWCm1EbZJzZg-1; Tue, 19 Nov 2019 09:00:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7193D107ACC9;
 Tue, 19 Nov 2019 14:00:51 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7EA15037E;
 Tue, 19 Nov 2019 14:00:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] mips-next patches for 4.2-rc2
Date: Tue, 19 Nov 2019 15:00:41 +0100
Message-Id: <20191119140043.28539-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cmpauROsO7iWCm1EbZJzZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull fixes a regression with the SystemTap trace backend,
see https://bugs.launchpad.net/qemu/+bug/1844817

The following changes since commit 385e43e6638464009e09cfaec254012e531f6342=
:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-11-19' int=
o staging (2019-11-19 09:17:24 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/mips-next-20191119

for you to fetch changes up to abc7cf36559f953777faf27d2e0dfb561ac533a5:

  hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-11-19=
 14:46:01 +0100)

----------------------------------------------------------------
The DTrace via SystemTap backend can not support the dynamic '*' width
format. We failed at noticing it for the 4.1 release, and LP#1844817
was opened to track it. Fix this regression for the next release.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (2):
  hw/block/pflash: Remove dynamic field width from trace events
  hw/mips/gt64xxx: Remove dynamic field width from trace events

 hw/block/pflash_cfi01.c |  8 ++++----
 hw/block/pflash_cfi02.c |  8 ++++----
 hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
 hw/block/trace-events   |  8 ++++----
 hw/mips/trace-events    |  4 ++--
 5 files changed, 22 insertions(+), 22 deletions(-)

--=20
2.21.0



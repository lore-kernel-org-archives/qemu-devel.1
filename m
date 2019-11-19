Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2367DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66CE2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJulga5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66CE2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXAPN-0008CI-Tt
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iXANy-0007CZ-Ac
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iXANv-0001fi-Lr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:46:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iXANv-0001f7-Fi
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574196362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PPECDqwQTHAi8qK9ZSECyrOjMMcGbUMcQDM54JQkhNg=;
 b=SJulga5oolQd7H7XD4DdCzU66UmcImT70ouaC6r3S57ThZlzGGBVzJCWLxMy176XCnAH0O
 IeGp6mSo6Lf7x7hobgjiLwXyjU/EowvPef7w/cxgz6TwXIOMHVmj+nKsgtYGA+G08rXoZF
 0ZGjpAF7lPLwhCM4VDvhmJqYJItzQP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-sLuE1U6qPTGbESf2ZYOSrw-1; Tue, 19 Nov 2019 15:46:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51EEC1005500;
 Tue, 19 Nov 2019 20:45:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11CB74A;
 Tue, 19 Nov 2019 20:45:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-4.2-rc2 0/2] Tracing patches
Date: Tue, 19 Nov 2019 20:45:49 +0000
Message-Id: <20191119204551.240792-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sLuE1U6qPTGbESf2ZYOSrw-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f086f22d6c068ba151b0f6e81e75a64f130df712=
:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-fixes-20191118.0=
' into staging (2019-11-18 21:35:48 +0000)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 6b904f1a528a6d8c21f7fbdeab13b9603d1b6df7:

  hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-11-19=
 16:17:05 +0000)

----------------------------------------------------------------
Pull request

Tracing fixes for MIPS.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (2):
  hw/block/pflash: Remove dynamic field width from trace events
  hw/mips/gt64xxx: Remove dynamic field width from trace events

 hw/block/pflash_cfi01.c |  8 ++++----
 hw/block/pflash_cfi02.c |  8 ++++----
 hw/block/trace-events   |  8 ++++----
 hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
 hw/mips/trace-events    |  4 ++--
 5 files changed, 22 insertions(+), 22 deletions(-)

--=20
2.23.0



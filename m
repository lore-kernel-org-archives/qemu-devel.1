Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3918CC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042492068E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLgvsAaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042492068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izr14-0002kC-27
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1izr0N-000206-VO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1izr0N-00083V-3v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:56:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1izr0N-00082Z-0F
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581033378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gKJjbnykLCD2gA/yz6eUjpYPw+K5C0ffnU99w3N6IQ=;
 b=PLgvsAaNjRPSpIBKxYev+T+WXdCzKLGcIi9np+K6Ad4w0O/C+LrDpeoAxaerO32G1+PGr9
 ZIFPwrTTxSnEhWyr4s2VbXWiDrLnFLvfkO+oFYBmErznURang9QlwWfGRvD7hYTlmm66V1
 MxZ0q2YVAaAy963PV/nIFCqTWxiYw5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-6oop2advMySG3Zsk3XHjvA-1; Thu, 06 Feb 2020 18:56:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85408DB2C
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 23:56:14 +0000 (UTC)
Received: from gimli.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 438DB8E9EA;
 Thu,  6 Feb 2020 23:56:09 +0000 (UTC)
Subject: [PULL 0/1] VFIO update 2020-02-06
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 06 Feb 2020 16:56:09 -0700
Message-ID: <158103327286.16446.1485987593254343093.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6oop2advMySG3Zsk3XHjvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2021b7c9716cd579e20b4993ed75842f4e0deb34:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2020-02-06 12:57:54 +0000)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20200206.0

for you to fetch changes up to 29d62771c81d8fd244a67c14a1d968c268d3fb19:

  hw/vfio: Move the IGD quirk code to a separate file (2020-02-06 11:55:42 -0700)

----------------------------------------------------------------
VFIO update 2020-02-06

 - Split IGD to separate file and config option (Thomas Huth)

----------------------------------------------------------------
Thomas Huth (1):
      hw/vfio: Move the IGD quirk code to a separate file

 hw/vfio/Kconfig       |   5 +
 hw/vfio/Makefile.objs |   1 +
 hw/vfio/igd.c         | 616 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c  | 614 +------------------------------------------------
 hw/vfio/pci.h         |  17 ++
 5 files changed, 642 insertions(+), 611 deletions(-)
 create mode 100644 hw/vfio/igd.c



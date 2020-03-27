Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4754C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710A52072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NubVjn9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710A52072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqne-0000FH-K4
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHqmF-0006kx-0X
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHqmD-0004jq-4h
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHqmD-0004gP-1C
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585322404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D8RDhRnBFGlb09u9fqcsWEE8n93UnONfdrEHYGrHS9s=;
 b=NubVjn9yNZs1NKosuXybdxXDvljicI2VFf9S1ufnx7VkHObtT7+0eRzqmP0JVufsnKgfjg
 SBKl3PXwaydC5ocB2o0RpUdTpFLWH8PTR/A4V8Lzx5tHhj0c0MdNQMKSQMpeWIBprr/lmH
 l9UcyBqbFjOTsQP/n+RvfD1vupaIL28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-6b8y-6IWOrGqFPGczTP2-g-1; Fri, 27 Mar 2020 11:20:02 -0400
X-MC-Unique: 6b8y-6IWOrGqFPGczTP2-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383C21005513;
 Fri, 27 Mar 2020 15:20:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA055F700;
 Fri, 27 Mar 2020 15:19:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/6] Block layer patches
Date: Fri, 27 Mar 2020 16:19:44 +0100
Message-Id: <20200327151950.11820-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d=
:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pul=
l-request' into staging (2020-03-26 20:55:54 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to df74b1d3dff80983e7a30db1346a4a05847d65fa:

  qcow2: Remove unused fields from BDRVQcow2State (2020-03-27 14:47:23 +010=
0)

----------------------------------------------------------------
Block layer patches:

- Fix another case of mirror block job deadlocks
- Minor fixes

----------------------------------------------------------------
Chen Qun (1):
      block/iscsi:use the flags in iscsi_open() prevent Clang warning

Kevin Wolf (3):
      Revert "mirror: Don't let an operation wait for itself"
      mirror: Wait only for in-flight operations
      qcow2: Remove unused fields from BDRVQcow2State

Minwoo Im (1):
      nvme: Print 'cqid' for nvme_del_cq

Vladimir Sementsov-Ogievskiy (1):
      block: fix bdrv_root_attach_child forget to unref child_bs

 block/qcow2.h         |  3 ---
 block.c               |  1 +
 block/iscsi.c         |  2 +-
 block/mirror.c        | 30 +++++++++++++++++-------------
 hw/block/trace-events |  2 +-
 5 files changed, 20 insertions(+), 18 deletions(-)



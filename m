Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD3C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D495B2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvHvN22W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D495B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Cu5-0002PE-Fg
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1CsG-0001T2-F1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1CsE-0000ee-Mq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:29:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1CsC-0000br-T4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581355767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m1F1IZ6Uuw2yhpWnzlDO8eszKvPHqg3SUNPRc3ebT3A=;
 b=bvHvN22WKpcW8nIvYA5TO/9mZiP2JCDQiU44IGk5M7XhBQbitPxAg/OalwuURin7emOFbA
 HLnq+pHWyTnrTQBewzZkTeXzd06mc0CULgpqUAwxQbCLuFrkur3mOu56/VefvH379R2FaL
 NDRG6cjM1LJRRRhMbfgJhnD5WJ0p2x0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Zy_eCsxfPV6vsBlJ555UQA-1; Mon, 10 Feb 2020 12:29:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78E8B107ACCC
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 17:29:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-112.ams2.redhat.com
 [10.36.117.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6368E89F24;
 Mon, 10 Feb 2020 17:29:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 0/5] virtiofs queue
Date: Mon, 10 Feb 2020 17:29:13 +0000
Message-Id: <20200210172918.95874-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Zy_eCsxfPV6vsBlJ555UQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 2b8a51cdb3e8d15a5c35de7a2e76a813ae7358f0=
:

  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-02-08' into=
 staging (2020-02-10 16:07:29 +0000)

are available in the Git repository at:

  https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200210

for you to fetch changes up to 6a7e2bbee5fa5f167959f05319550d2a49a6b8bb:

  docs: add virtiofsd(1) man page (2020-02-10 17:25:52 +0000)

----------------------------------------------------------------
virtiofsd pull 2020-02-10

Coverity fixes and a reworked man page.

----------------------------------------------------------------
Dr. David Alan Gilbert (4):
      virtiofsd: Remove fuse_req_getgroups
      virtiofsd: fv_create_listen_socket error path socket leak
      virtiofsd: load_capng missing unlock
      virtiofsd: do_read missing NULL check

Stefan Hajnoczi (1):
      docs: add virtiofsd(1) man page

 MAINTAINERS                      |   1 +
 Makefile                         |   9 ++-
 docs/interop/conf.py             |   5 +-
 docs/interop/index.rst           |   1 +
 docs/interop/virtiofsd.rst       | 120 +++++++++++++++++++++++++++++++++++=
++++
 tools/virtiofsd/fuse.h           |  20 -------
 tools/virtiofsd/fuse_lowlevel.c  |  81 ++------------------------
 tools/virtiofsd/fuse_lowlevel.h  |  21 -------
 tools/virtiofsd/fuse_virtio.c    |   2 +
 tools/virtiofsd/passthrough_ll.c |   1 +
 10 files changed, 141 insertions(+), 120 deletions(-)
 create mode 100644 docs/interop/virtiofsd.rst



Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E9F214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXjZsgCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E9F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgra-0007wB-VZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izge7-00052W-EJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izge6-00046I-0Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izge5-00040u-Sp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3iZ6uNHy99aDKzSMgsLjlz2GTDKETQveN+oHkEqusHA=;
 b=hXjZsgCyueGfgIlUiQ7/NVoy6cu21vKlWjSVTSzZhBop+wg3NAxK/++1NVzTqWKHBOMBT8
 rqmRLrPGsIblri0zFhfaxSBhZ4t71Z+/pvtM34SCCbHPFN97R33rjKUb7dQArvc7LSInzU
 Nj0vL3KWfV8XnQkGNsa1+8YP1isUN9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-7RxWXbvvPMy5UrXfKhoujg-1; Thu, 06 Feb 2020 07:52:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1DBD10054E3
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 12:52:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D79C5DA7C
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 12:52:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] NBD patches through 2020-02-06
Date: Thu,  6 Feb 2020 06:52:21 -0600
Message-Id: <20200206125224.3819972-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7RxWXbvvPMy5UrXfKhoujg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158=
:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-=
02-04' into staging (2020-02-04 16:12:31 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-02-06

for you to fetch changes up to 0bc16997f5404134637227e53b637d0825d46b5a:

  qemu-nbd: Removed deprecated --partition option (2020-02-05 17:29:49 -060=
0)

----------------------------------------------------------------
nbd patches for 2020-02-06

- Allow setting NBD description from QMP for parity with qemu-nbd
- Remove deprecated 'qemu-nbd --partition'

----------------------------------------------------------------
Eric Blake (3):
      nbd: Allow description when creating NBD blockdev
      docs: Fix typo in qemu-nbd -P replacement
      qemu-nbd: Removed deprecated --partition option

 docs/interop/qemu-nbd.rst  |  15 ++---
 qemu-deprecated.texi       |  49 ++++++-----------
 qapi/block.json            |   9 ++-
 blockdev-nbd.c             |   9 ++-
 monitor/hmp-cmds.c         |   4 +-
 qemu-nbd.c                 | 133 +----------------------------------------=
----
 tests/qemu-iotests/223     |   2 +-
 tests/qemu-iotests/223.out |   6 +-
 8 files changed, 45 insertions(+), 182 deletions(-)

--=20
2.24.1



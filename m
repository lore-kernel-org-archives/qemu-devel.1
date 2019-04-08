Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34314C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0675720863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0675720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZZW-0002is-4g
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:04:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXa-0001dO-Pe
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXU-0007DD-0T
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hDZXT-0007BQ-NT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A73803082E3F
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 19:02:35 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6873760C70
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 19:02:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:02:29 -0500
Message-Id: <20190408190233.10321-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 08 Apr 2019 19:02:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] NBD patches for 4.0-rc3
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408190229.1y8gR8l-Gr4KCBhq4NPkjTpIXq6zQiknU3hdzD7comw@z>

The following changes since commit 2c573106279495795449b0d0373464b597dfe3=
16:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-04-08' into staging (2019-04-08 15:21:11 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-04-08

for you to fetch changes up to e53f88df77e70350b0eda92a2e5e39f67792008f:

  nbd/client: Fix error message for server with unusable sizing (2019-04-=
08 13:51:25 -0500)

----------------------------------------------------------------
nbd patches for 2019-04-08

- Fix minor issues in recent alignment patches

----------------------------------------------------------------
Eric Blake (4):
      nbd/server: Fix blockstatus trace
      nbd/server: Trace client noncompliance on unaligned requests
      nbd/server: Don't fail NBD_OPT_INFO for byte-aligned sources
      nbd/client: Fix error message for server with unusable sizing

 nbd/client.c     |  2 +-
 nbd/server.c     | 39 +++++++++++++++++++++++++++------------
 nbd/trace-events |  1 +
 3 files changed, 29 insertions(+), 13 deletions(-)

--=20
2.20.1



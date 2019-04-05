Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_HK_NAME_DR autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D6C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965D321855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965D321855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCR7s-0004k9-Sy
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:51:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6H-0003mE-Dy
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6F-0004Dh-DJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCR6A-00045R-Qj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B203780B2C;
	Fri,  5 Apr 2019 15:49:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-242.ams2.redhat.com
	[10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38E7C5D704;
	Fri,  5 Apr 2019 15:49:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, quintela@redhat.com,
	peterx@redhat.com
Date: Fri,  5 Apr 2019 16:49:32 +0100
Message-Id: <20190405154934.18664-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 05 Apr 2019 15:49:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/2] migration queue
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
Message-ID: <20190405154932.c3dccwnltghSBBvRc8e2t4ESdyUTcOTeT-4qbXteZjE@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 10546e09e174e0bb185b66a4c397aa845efcd3=
6e:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.0-=
rc3-v2' into staging (2019-04-05 04:50:30 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190405a

for you to fetch changes up to d013283a46e1f197594e76ed320f867067ab80b3:

  migration: Fix migrate_set_parameter (2019-04-05 15:32:13 +0100)

----------------------------------------------------------------
Migration fixes pull for 4.0

A couple of fixes for crashes in colo and
migration parameters.

----------------------------------------------------------------
Juan Quintela (1):
      migration: Fix migrate_set_parameter

Zhang Chen (1):
      migration/ram.c: Fix codes conflict about bitmap_mutex

 hmp.c           | 6 ++++--
 migration/ram.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)


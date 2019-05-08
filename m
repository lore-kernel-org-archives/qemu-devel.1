Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A7C04AAB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBC121479
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBC121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34055 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOJDh-0005bv-2I
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:50:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOJCF-0004hn-Gq
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOJCE-00009q-3D
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:49:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hOJCD-000099-RD; Wed, 08 May 2019 05:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1084C04B2C0;
	Wed,  8 May 2019 09:49:03 +0000 (UTC)
Received: from thuth.com (ovpn-116-100.ams2.redhat.com [10.36.116.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 119815D9C8;
	Wed,  8 May 2019 09:49:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Wed,  8 May 2019 11:48:54 +0200
Message-Id: <20190508094857.21145-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 08 May 2019 09:49:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 0/3] s390-ccw-bios: Skip bootmap
 signature entries
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org,
	armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull request is not for master.


 Hi Cornelia,

the following changes since commit a6f6d24757a73f7176989134b97284a1a7df11=
e5:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190507-pull-req=
uest' into staging (2019-05-07 21:39:28 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2019-05-08

for you to fetch changes up to f7a339a5ba48a8a5c5bf4f1fdb1463bf8ac5f5bb:

  pc-bios/s390: Update firmware image with "Skip bootmap signature entrie=
s" fix (2019-05-08 11:26:01 +0200)

----------------------------------------------------------------
Skip unsupported bootmap signature entries instead of aborting the boot p=
rocess
----------------------------------------------------------------

Jason J. Herne (1):
      s390-bios: Skip bootmap signature entries

Markus Armbruster (1):
      pc-bios/s390-ccw: Clean up harmless misuse of isdigit()

Thomas Huth (1):
      pc-bios/s390: Update firmware image with "Skip bootmap signature en=
tries" fix

 pc-bios/s390-ccw.img       | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/bootmap.c |  19 +++++++++++++++++--
 pc-bios/s390-ccw/bootmap.h |  10 ++++++----
 pc-bios/s390-ccw/libc.c    |   2 +-
 pc-bios/s390-ccw/menu.c    |   2 +-
 5 files changed, 25 insertions(+), 8 deletions(-)


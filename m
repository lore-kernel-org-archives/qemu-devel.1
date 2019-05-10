Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB66C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C017221479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C017221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5CV-0005GJ-UA
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:04:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Aq-0004Hw-5T
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Ap-0003zm-3y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5Am-0003tE-PL; Fri, 10 May 2019 09:02:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 356FA9D439;
	Fri, 10 May 2019 13:02:47 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6595C1001E82;
	Fri, 10 May 2019 13:02:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:35 +0100
Message-Id: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 10 May 2019 13:02:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] Block patches
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 812b835fb4d23dd108b2f9802158472d50b735=
79:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-05-=
07' into staging (2019-05-09 16:31:12 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to e84125761f78919fe63616d9888ea45e72dc956f:

  docs: add Security chapter to the documentation (2019-05-10 10:53:52 +0=
100)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Andrey Shinkevich (1):
  block/io.c: fix for the allocation failure

Jules Irenge (3):
  util/readline: add a space to fix errors by checkpatch tool
  util: readline: replace tab indent by four spaces to fix checkpatch
    errors
  util/readline: Add braces to fix checkpatch errors

Nikita Alekseev (1):
  block: Add coroutine_fn to bdrv_check_co_entry

Paolo Bonzini (1):
  aio-posix: ensure poll mode is left when aio_notify is called

Stefan Hajnoczi (2):
  docs: add Secure Coding Practices to developer docs
  docs: add Security chapter to the documentation

 Makefile                               |   2 +-
 block.c                                |   2 +-
 block/io.c                             |   2 +-
 util/aio-posix.c                       |  12 +-
 util/readline.c                        | 174 ++++++++++++++-----------
 docs/devel/index.rst                   |   1 +
 docs/devel/secure-coding-practices.rst | 106 +++++++++++++++
 docs/security.texi                     | 131 +++++++++++++++++++
 qemu-doc.texi                          |   3 +
 9 files changed, 347 insertions(+), 86 deletions(-)
 create mode 100644 docs/devel/secure-coding-practices.rst
 create mode 100644 docs/security.texi

--=20
2.21.0



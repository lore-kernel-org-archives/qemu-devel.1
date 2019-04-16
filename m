Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F06FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61257205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61257205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGP5a-0000kT-JI
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 10:29:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGP4H-0008Ss-Rt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hGP4G-00034L-Vu
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hGP4E-00032E-SS; Tue, 16 Apr 2019 10:28:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC90B307EA82;
	Tue, 16 Apr 2019 14:28:08 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-89.ams2.redhat.com [10.36.117.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CDBAA1001DE0;
	Tue, 16 Apr 2019 14:28:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 16 Apr 2019 16:28:01 +0200
Message-Id: <20190416142802.11990-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 16 Apr 2019 14:28:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/1] qcow2: Fix potential corruption with
 external data file
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416142801.bCDzEWlTA8Nlc6qsAXXL_aOPIdoOha6wHxPs5t4a3H4@z>

The following changes since commit a9b305ba291fb74f7ff732b3d7b8f4c812431d=
df:

  socket: allow wait=3Dfalse for client socket (2019-04-16 10:40:43 +0100=
)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 93e32b3e2012a668e4da1c2566d2935c24060435:

  qcow2: Fix preallocation bdrv_pwrite to wrong file (2019-04-16 16:23:24=
 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2: Fix potential corruption for preallocated resize with external d=
ata file

----------------------------------------------------------------
Kevin Wolf (1):
      qcow2: Fix preallocation bdrv_pwrite to wrong file

 block/qcow2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


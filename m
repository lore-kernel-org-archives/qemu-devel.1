Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BC3C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0A920880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0A920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnO5k-0001ps-9n
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hnO5Z-0001PG-Ei
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hnO5Y-0000Cd-Fg
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hnO5Y-0000CF-A8; Tue, 16 Jul 2019 10:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 824093092674;
 Tue, 16 Jul 2019 14:05:51 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F1EF19C68;
 Tue, 16 Jul 2019 14:05:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 16:05:43 +0200
Message-Id: <20190716140546.6661-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 16 Jul 2019 14:05:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 0/3] s390x cpumodel fixes
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5ea8ec2fcf57cb9af24ad2cf17b4d64adb03af=
df:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-07-=
15' into staging (2019-07-15 16:11:47 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190716

for you to fetch changes up to 5d8866c89817998a3d9c3055d5dc2b5a8e78658a:

  s390x/cpumodel: change internal name of vxpdeh to match description (20=
19-07-16 11:29:38 +0200)

----------------------------------------------------------------
straighten out some things in the gen15 cpu model

----------------------------------------------------------------

Christian Borntraeger (3):
  s390x/cpumodel: remove esort from the default model
  s390x/cpumodel: also change name of vxbeh
  s390x/cpumodel: change internal name of vxpdeh to match description

 target/s390x/cpu_features_def.inc.h | 2 +-
 target/s390x/gen-features.c         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

--=20
2.20.1



Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F4C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF92206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsRAbqAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF92206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChc1-00016z-4P
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jChac-0008Jv-IL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jChaa-0005on-LQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jChaZ-0005ki-Oz
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584095446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ksrK5FD46lPp6E9uEekmclXVDvgQBJks61Lb5cJzfI=;
 b=RsRAbqAVVCR8RzrhTj4OvgujsO1zdQ238pni8ZIKBYhojzC//VgPWwHjnpMuwVFdhCe+EN
 Jozh0NZ2QeVExMlaDDOdbhs7y2ob7bhdEVC7nsCXW48Dvd2/LaZkRGaey8X+N6Njw2c6Au
 M86PJ7xxuiROH64OT9vJNZ4tbdi2lXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-lvpP9NkYMS2-i4Gj7yW47w-1; Fri, 13 Mar 2020 06:30:44 -0400
X-MC-Unique: lvpP9NkYMS2-i4Gj7yW47w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43563800D5A;
 Fri, 13 Mar 2020 10:30:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 401AC8FBF2;
 Fri, 13 Mar 2020 10:30:41 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com,
 zhukeqian1@huawei.com, quintela@redhat.com
Subject: [PULL 0/5] migration queue
Date: Fri, 13 Mar 2020 10:30:34 +0000
Message-Id: <20200313103039.150133-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

The following changes since commit d4f7d56759f7c75270c13d5f3f5f736a9558929c=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
312' into staging (2020-03-12 17:34:34 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200313a

for you to fetch changes up to 19dd408a479cae3027ae9ff9ef3f509ad3e681e5:

  migration: recognize COLO as part of activating process (2020-03-13 09:36=
:30 +0000)

----------------------------------------------------------------
Migration pull 2020-03-13

zstd build fix
A new auto-converge parameter
Some COLO improvements

----------------------------------------------------------------
Hailiang Zhang (3):
      COLO: Optimize memory back-up process
      ram/colo: only record bitmap of dirty pages in COLO stage
      migration: recognize COLO as part of activating process

Juan Quintela (1):
      configure: Improve zstd test

Keqian Zhu (1):
      migration/throttle: Add throttle-trig-thres migration parameter

 configure             |   3 +-
 migration/colo.c      |   3 ++
 migration/migration.c |  25 ++++++++++
 migration/ram.c       | 123 +++++++++++++++++++++++++++++++++-------------=
----
 migration/ram.h       |   1 +
 monitor/hmp-cmds.c    |   7 +++
 qapi/migration.json   |  16 ++++++-
 7 files changed, 135 insertions(+), 43 deletions(-)



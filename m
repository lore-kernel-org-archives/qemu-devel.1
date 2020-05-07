Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12516C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF13A207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8u40OHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF13A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjwV-0005og-Fb
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjum-0004aA-T4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38624
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjul-0001ZV-84
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=huJWCduFdXan6/tK/E6AOnPZJFaHON21BiOBOz5Fre4=;
 b=R8u40OHi+W48JGwRapDvRJtmUn2MjB+4vpK9jcbsnLgd3gTJpK3VpYgntKUz54e63PnW+v
 aZHX7bVO00fZ/5iVhU6j6gay7TVZiW6xAjpd0BLx6oqnjd+QQNmFQIWrbGbLvHYQjJ+pQX
 3LLIOiKKAwyua9Rx6gpu7Rb1m42NlKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-e17whfAdNGO0QI_J4wy7ng-1; Thu, 07 May 2020 13:02:23 -0400
X-MC-Unique: e17whfAdNGO0QI_J4wy7ng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3E9E800687;
 Thu,  7 May 2020 17:02:21 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB3510027AB;
 Thu,  7 May 2020 17:02:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 00/12] migration queue
Date: Thu,  7 May 2020 18:01:59 +0100
Message-Id: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

The following changes since commit 3c7adbc67d9a5c3e992a4dd13b8704464daaad5b=
:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-req=
uest' into staging (2020-05-07 14:30:12 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20200507a

for you to fetch changes up to 13f2cb21e5fb33e9f8d7db8eee48edc1c67b812f:

  migration/multifd: Do error_free after migrate_set_error to avoid memleak=
s (2020-05-07 17:40:24 +0100)

----------------------------------------------------------------
Migration pull 2020-05-07

Mostly tidy-ups, but two new features:
  cpu-throttle-tailslow for making a gentler throttle
  xbzrle encoding rate measurement for getting a feal for xbzrle
performance.

----------------------------------------------------------------
David Hildenbrand (1):
      migration/ram: Consolidate variable reset after placement in ram_load=
_postcopy()

Keqian Zhu (1):
      migration/throttle: Add cpu-throttle-tailslow migration parameter

Mao Zhongyi (4):
      migration: fix bad indentation in error_report()
      migration/migration: improve error reporting for migrate parameters
      monitor/hmp-cmds: add hmp_handle_error() for hmp_migrate_set_speed()
      migration: move the units of migrate parameters from milliseconds to =
ms

Marc-Andr=C3=A9 Lureau (1):
      docs/devel/migration: start a debugging section

Pan Nengyuan (3):
      migration/rdma: fix a memleak on error path in rdma_start_incoming_mi=
gration
      migration/multifd: fix memleaks in multifd_new_send_channel_async
      migration/multifd: Do error_free after migrate_set_error to avoid mem=
leaks

Philippe Mathieu-Daud=C3=A9 (1):
      migration/colo: Add missing error-propagation code

Wei Wang (1):
      migration/xbzrle: add encoding rate

 docs/devel/migration.rst | 20 +++++++++++++
 migration/colo.c         |  3 ++
 migration/migration.c    | 44 +++++++++++++++++++---------
 migration/multifd.c      |  5 ++++
 migration/ram.c          | 74 ++++++++++++++++++++++++++++++++++++++++----=
----
 migration/rdma.c         |  1 +
 monitor/hmp-cmds.c       | 23 +++++++++++----
 qapi/migration.json      | 53 +++++++++++++++++++++++++++++++++-
 8 files changed, 192 insertions(+), 31 deletions(-)



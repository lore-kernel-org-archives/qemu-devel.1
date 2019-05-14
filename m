Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_HK_NAME_DR autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05600C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33AE20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33AE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcIH-0007y1-Po
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:36:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcGT-0006OQ-08
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcGS-0000Oh-2V
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQcGR-0000NJ-TI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B5703082E5A;
	Tue, 14 May 2019 18:34:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
	[10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A6780608A6;
	Tue, 14 May 2019 18:34:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
	ehabkost@redhat.com, richardw.yang@linux.intel.com,
	yury-kotov@yandex-team.ru, chen.zhang@intel.com
Date: Tue, 14 May 2019 19:34:38 +0100
Message-Id: <20190514183454.12758-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 14 May 2019 18:34:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/16] migration queue
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit e329ad2ab72c43b56df88b34954c2c7d839bb3=
73:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190513' into =
staging (2019-05-14 10:08:47 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190514b

for you to fetch changes up to 9d3250d5ba8c4c5389530b861686e22e77fddcc7:

  monitor: Call mon_get_cpu() only once at hmp_gva2gpa() (2019-05-14 19:0=
0:04 +0100)

----------------------------------------------------------------
Migration pull 2019-05-14

Small fixes/cleanups
One HMP/monitor fix

----------------------------------------------------------------
Cole Robinson (1):
      migration: savevm: fix error code with migration blockers

Eduardo Habkost (1):
      monitor: Call mon_get_cpu() only once at hmp_gva2gpa()

Peter Xu (1):
      migration: comment VMSTATE_UNUSED*() properly

Wei Yang (8):
      migration: not necessary to check ops again
      migration: remove not used field xfer_limit
      vmstate: check subsection_found is enough
      migration/ram.c: start of migration_bitmap_sync_range is always 0
      migration/savevm: remove duplicate check of migration_is_blocked
      migration/savevm: load_header before load_setup
      migration/savevm: wrap into qemu_loadvm_state_header()
      migration/ram.c: fix typos in comments

Yi Wang (1):
      migration: update comments of migration bitmap

Yury Kotov (1):
      migration: Fix use-after-free during process exit

Zhang Chen (3):
      migration/colo.c: Remove redundant input parameter
      migration/colo.h: Remove obsolete codes
      qemu-option.hx: Update missed parameter for colo-compare

 include/migration/colo.h    |  4 +-
 include/migration/vmstate.h | 14 +++++++
 migration/colo-failover.c   |  2 +-
 migration/colo.c            |  2 +-
 migration/migration.c       | 26 ++++++++++---
 migration/migration.h       |  1 -
 migration/ram.c             | 22 +++++------
 migration/savevm.c          | 89 ++++++++++++++++++++++++---------------=
------
 migration/vmstate.c         |  8 ++--
 monitor.c                   |  3 +-
 qemu-options.hx             |  9 +++--
 11 files changed, 105 insertions(+), 75 deletions(-)


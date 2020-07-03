Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EFB20826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehw0tnxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EFB20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHzo-0000CT-7p
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtN-0002iG-T8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:21:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtM-0000x4-7t
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593768115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0v+efBXvG4neeNQh6xjq4PNeyTvbDjVJQF6XXTzwxZs=;
 b=Ehw0tnxakYKNu8lLB2jWms22R8kTf+d9+hn/6Q8v5KRY3ynADi66WG/EgQAmf3K4mPW/1m
 U7Vf2a+zw6JUcFmLGlF5cQnzJfzqLt4IkIjQb24ZElsFel3wG1tLN7WtD8RzrF+mls8v6Z
 xb2qPna3vjJIiQLJlLQtoeRml19jauA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-mrjS3A-_OgqVP1iPEjw5LA-1; Fri, 03 Jul 2020 05:21:52 -0400
X-MC-Unique: mrjS3A-_OgqVP1iPEjw5LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCCAA0BD9;
 Fri,  3 Jul 2020 09:21:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7791F7AC63;
 Fri,  3 Jul 2020 09:21:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/7] Block layer patches
Date: Fri,  3 Jul 2020 11:21:36 +0200
Message-Id: <20200703092143.165594-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 64f0ad8ad8e13257e7c912df470d46784b55c3fd:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-02' into staging (2020-07-02 15:54:09 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4f071a9460886667fde061c05b79dc786cc22e3c:

  iotests: Fix 051 output after qdev_init_nofail() removal (2020-07-03 10:06:29 +0200)

----------------------------------------------------------------
Block layer patches:

- qemu-img convert: Don't pre-zero images (removes nowadays
  counterproductive optimisation)
- qemu-storage-daemon: Fix object-del, cleaner shutdown
- vvfat: Check that the guest doesn't escape the given host directory
  with read-write vvfat drives
- vvfat: Fix crash by out-of-bounds array writes for read-write drives
- iotests fixes

----------------------------------------------------------------
Kevin Wolf (3):
      qemu-img convert: Don't pre-zero images
      vvfat: Check that updated filenames are valid
      vvfat: Fix array_remove_slice()

Max Reitz (1):
      iotests.py: Do not wait() before communicate()

Philippe Mathieu-Daudé (1):
      iotests: Fix 051 output after qdev_init_nofail() removal

Stefan Hajnoczi (2):
      qemu-storage-daemon: remember to add qemu_object_opts
      qemu-storage-daemon: add missing cleanup calls

 block/vvfat.c                 | 67 +++++++++++++++++++------------------------
 qemu-img.c                    |  9 ------
 qemu-storage-daemon.c         |  5 ++++
 tests/qemu-iotests/iotests.py | 34 +++++++++++-----------
 tests/qemu-iotests/051.pc.out |  4 +--
 5 files changed, 53 insertions(+), 66 deletions(-)



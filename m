Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE5C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF8E22404
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPMlMw/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF8E22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV4v1-000886-1p
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 23:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4s6-0004Jm-Uq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4s5-0001aI-0X
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603251183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y0MJyI0tYPA7XZfPllyC6u9liiJpVrG/KgGG6tyljCg=;
 b=HPMlMw/6p2L3uCnkSHwm45ttGtUSY2BEkenAocVH9O7GD0DxsRoTIiBDy/HIthLt9ZSFVm
 l0JbOyzsKHifYEyD1liT3+R5rXKdZwF+g8SzITevqXrEYyGHm5JeqB0ZuAXP+T9sKJPUFL
 9nsCpVvIgfEPSCbEIinB+hCDE4Ikx7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-PX87CY0kOs6o0R1KS2vHcA-1; Tue, 20 Oct 2020 23:33:00 -0400
X-MC-Unique: PX87CY0kOs6o0R1KS2vHcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A443186DD20;
 Wed, 21 Oct 2020 03:32:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE76B5C1C2;
 Wed, 21 Oct 2020 03:32:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73EDC1132A08; Wed, 21 Oct 2020 05:32:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] QAPI patches patches for 2020-10-21
Date: Wed, 21 Oct 2020 05:32:52 +0200
Message-Id: <20201021033257.2126624-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:

  Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-10-21

for you to fetch changes up to 28af9ba260634daa0bb50039a6103f31b91b1603:

  qapi: Restrict Xen migration commands to migration.json (2020-10-21 05:00:44 +0200)

----------------------------------------------------------------
QAPI patches patches for 2020-10-21

----------------------------------------------------------------
Philippe Mathieu-Daudé (5):
      qapi: Restrict 'inject-nmi' command to machine code
      qapi: Restrict 'system wakeup/reset/powerdown' commands to machine.json
      qapi: Restrict '(p)memsave' command to machine code
      qapi: Restrict 'query-kvm' command to machine code
      qapi: Restrict Xen migration commands to migration.json

 qapi/machine.json      | 168 +++++++++++++++++++++++++++++++++++++++
 qapi/migration.json    |  41 ++++++++++
 qapi/misc.json         | 209 -------------------------------------------------
 accel/stubs/xen-stub.c |   2 +-
 hw/i386/xen/xen-hvm.c  |   2 +-
 migration/savevm.c     |   1 -
 softmmu/cpus.c         |   1 +
 ui/gtk.c               |   1 +
 ui/cocoa.m             |   1 +
 9 files changed, 214 insertions(+), 212 deletions(-)

-- 
2.26.2



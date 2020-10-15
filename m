Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E37C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8521B22251
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbhFsiPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8521B22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2mP-000733-6o
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT2lH-0005R5-Vk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kT2lE-0002dC-H7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602766415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zgFxqY6VFAnAgFEKMDlFr3dnERXthrivFHtyUweEDJU=;
 b=DbhFsiPLf5YZhGsefmcDiP7ddnfqcnTJFt2wf4/VmANmkDdBQ3n8WfiaC616LyJ/MEd5OC
 471HKynFo5ZTfSvZFNuq+VpVk8r5lSMKVc3efHm7tj6HyW96NPLwwPdM8oH04sQPI2hTbe
 Sx4E+CQQvEhU7Z3RgIPPmAyaorHOXvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-Ex5v9kN4P2GFxq6jtWeQDQ-1; Thu, 15 Oct 2020 08:53:32 -0400
X-MC-Unique: Ex5v9kN4P2GFxq6jtWeQDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E797718A823F
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:53:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8308055798;
 Thu, 15 Oct 2020 12:53:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9736D16E18; Thu, 15 Oct 2020 14:53:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Modules 20201015 patches
Date: Thu, 15 Oct 2020 14:53:14 +0200
Message-Id: <20201015125322.23648-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-reques=
t' into staging (2020-10-14 13:56:06 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/modules-20201015-pull-request=0D
=0D
for you to fetch changes up to 23ebeaae4eb09a0d92dc7f22b41e5dd08485c390:=0D
=0D
  chardev/spice: build spice chardevs as module (2020-10-15 11:14:40 +0200)=
=0D
=0D
----------------------------------------------------------------=0D
modules: misc fixes & tweaks.=0D
modules: build spice chardevs as module.=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (8):=0D
  module: silence errors for module_load_qom_all().=0D
  modules: update qom object module comment=0D
  ui/spice-app: don't use qemu_chr_open_spice_port directly=0D
  chardev/spice: make qemu_chr_open_spice_port static=0D
  chardev/spice: simplify chardev setup=0D
  meson: add spice_headers dependency.=0D
  meson: add spice dependency to core spice source files.=0D
  chardev/spice: build spice chardevs as module=0D
=0D
 include/chardev/spice.h |  4 ----=0D
 include/qemu/module.h   |  8 ++++----=0D
 include/ui/qemu-spice.h |  1 -=0D
 chardev/spice.c         | 37 ++++++++++---------------------------=0D
 softmmu/qtest.c         |  2 +-=0D
 softmmu/vl.c            |  9 +++++----=0D
 ui/spice-app.c          | 34 ++++++++++++++++++++++------------=0D
 ui/spice-core.c         |  2 --=0D
 util/module.c           | 26 +++++++++++++++-----------=0D
 audio/meson.build       |  2 +-=0D
 chardev/meson.build     |  7 ++++++-=0D
 meson.build             |  2 ++=0D
 monitor/meson.build     |  2 +-=0D
 ui/meson.build          |  2 +-=0D
 14 files changed, 68 insertions(+), 70 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D



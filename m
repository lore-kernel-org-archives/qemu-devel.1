Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8592C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3AB20866
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oh9sgMJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3AB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Ns-0006Ec-P0
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kD85m-0004rL-Hk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:21:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kD85i-0006fM-Pw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598973657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3yergm6UiMsGDZZ2WL9UqGL3SYwlh/osV8DKNRQXg2U=;
 b=Oh9sgMJdFU9cnPdKQ1v6ONQnYZYYsHeGOpRUZGrmxVRuVhk3cVtzjN4EU8th8bCqQRYFRP
 ajUl9tb1duwb9Csxau5d8RW6EZF/rY/D5b2q+6nrzURWKITehMjG98tD4jE/ynZXSfH/oB
 RIRHYsCXC7FQX99x80Tvtp0Xdzwsods=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-KBLbEJqOMDirqI5MWPT6dQ-1; Tue, 01 Sep 2020 11:20:55 -0400
X-MC-Unique: KBLbEJqOMDirqI5MWPT6dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF373425DC;
 Tue,  1 Sep 2020 15:20:54 +0000 (UTC)
Received: from thuth.com (ovpn-112-188.ams2.redhat.com [10.36.112.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D51C5D9CC;
 Tue,  1 Sep 2020 15:20:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/8] Cirrus-CI improvements, and other CI-related fixes, m68k
Date: Tue,  1 Sep 2020 17:20:42 +0200
Message-Id: <20200901152050.255165-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,
 
the following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-01

for you to fetch changes up to df496fb0532758cffb5ad4075b4e60a43c723492:

  hw/m68k: QOMify the mcf5206 system integration module (2020-09-01 17:09:17 +0200)

----------------------------------------------------------------
- Cirrus-CI improvements and fixes (compile with -Werror & fix for 1h problem)
- Two build system fixes to fix some failures the CI
- One m68k QOMification patch
----------------------------------------------------------------

Gerd Hoffmann (1):
      meson: fix keymaps without qemu-keymap

Thomas Huth (7):
      configure: Fix atomic64 test for --enable-werror on macOS
      cirrus.yml: Compile FreeBSD with -Werror
      cirrus.yml: Compile macOS with -Werror
      cirrus.yml: Update the macOS jobs to Catalina
      cirrus.yml: Split FreeBSD job into two parts
      configure: Add system = 'linux' for meson when cross-compiling
      hw/m68k: QOMify the mcf5206 system integration module

 .cirrus.yml                 | 43 +++++++++++++++++++++++++++++++++----------
 configure                   | 13 ++++++++-----
 hw/m68k/an5206.c            | 14 ++++++++++++--
 hw/m68k/mcf5206.c           | 44 +++++++++++++++++++++++++++++++++++---------
 include/hw/m68k/mcf.h       |  3 +--
 pc-bios/keymaps/meson.build | 28 +++++++++++++++++++---------
 6 files changed, 108 insertions(+), 37 deletions(-)



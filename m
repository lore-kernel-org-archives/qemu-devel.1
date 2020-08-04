Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1EEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1586A2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="L9k1eWw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1586A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tED-0005fL-3d
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k2tDQ-0004qo-KM
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:26:37 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:16319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k2tDL-0000CY-Qa
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1596533191;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BGtV4buQLSV4kVsmhw15UWdyjLxZS1wmHPQnT8rh4jE=;
 b=L9k1eWw6zNvMJQh+TF0r5ZQwzsL/avFvCL7k2NSLVa76x4vzhdjj52+u
 3hv1dfAXJGC8zeBjVt1EJkjy+TrYTTxccAKPweJyFUluAUJYHz4zayVyA
 tKRhmWYWLeeVSmLRgexqzu1j7wDF375vd+IAMbpzTz39DrK/FAehW2Yaq Q=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 186U1PMTFN/6mFC++GOTqG77LsGWlYBb5SaonSm0/OhiP55JNb3TbJV9WIGWBcsA2EzDXE7EcR
 ZKeELt/7IBjcwB48D0IjIvy36wydjXxWJ8gmdCvuvT4fVCoPp5hu8e8YQgle6nIdF33xB9aiVQ
 g6t2T5HRpE8QYtyX/Xjo7oVrXl8aEoC/5BIYIQOdsatvvlVU9QsNo4+3UaLQhA3GerGUMlI0iz
 QVd/rm+VE6TwOGp2eoHUD8km/jI2Ed8Lz77C4ri2Rbrv8cFG3zrZjA44Pt8vQTHO420qV5AJzr
 se4=
X-SBRS: 3.7
X-MesageID: 23979476
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,433,1589256000"; d="scan'208";a="23979476"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 0/1] xen queue 2020-08-04
Date: Tue, 4 Aug 2020 10:26:23 +0100
Message-ID: <20200804092624.1126013-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=anthony.perard@citrix.com; helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 05:20:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20200804

for you to fetch changes up to 8e0ef068942e4152f0d23e76ca1f5e35dc4456f7:

  accel/xen: Fix xen_enabled() behavior on target-agnostic objects (2020-08-04 10:21:35 +0100)

----------------------------------------------------------------
xen patch

Bug fix.

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      accel/xen: Fix xen_enabled() behavior on target-agnostic objects

 accel/stubs/xen-stub.c |  2 ++
 accel/xen/xen-all.c    |  7 +------
 include/sysemu/xen.h   | 18 ++++++++++++++----
 3 files changed, 17 insertions(+), 10 deletions(-)


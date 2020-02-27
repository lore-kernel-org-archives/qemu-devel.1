Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2DC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BE124699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YD0owbmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BE124699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I7E-0008Cd-Ic
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6D-00072P-FA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6B-0001A2-Lb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:05 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:12376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1j7I6B-00014j-0Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1582805823;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DoHYWIF/aM2J/lXeslpKwVf4KNhLXaBsJHgw0AfGDDU=;
 b=YD0owbmDpv6wEe7ZycC5lhTumCetjrn3cSzIQ5L/Zcawe+p/0n4ViJPG
 swn4P+b5omFqURe5HptbvJn5OCU+7lixhQ8AF6EL8aTHH1uILM1U23+Ap
 gFqEwKcIqlDAPEI8zgGJnHjlacAgNIRmf3ro5W/6WXIKBFOm/xxU7b1tb c=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: sRQEoyydPWijGWuMmiJiXvK3c+mqU8iMp3dGC0Sz3+oNkb4GRpy4DZ1FUwYnbBdI+/dGy8B+bf
 if799pTHGmQEn3uOf3dExChhvnKLYAg7XFMwFVFr9FcVPt5kIkxy9XteeEl0sKbZViSKaDh9E0
 Q/UEy5cIH/Y6XD+OkzPAwl6k+Teic0wJtpGlPlbVzkndbtnmDGfdeppG1KW/Xmk5SuuczprPjX
 60GJODWNne0dgW3cQkVRRa/jHFu1NsEn8785s4fhnsppbppfBydKvtO7I2w0XmcmrRxsb330U+
 wS0=
X-SBRS: 2.7
X-MesageID: 13103979
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,492,1574139600"; d="scan'208";a="13103979"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 0/3] Xen queue 2020-02-27
Date: Thu, 27 Feb 2020 12:16:42 +0000
Message-ID: <20200227121645.2601280-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-02-25 13:31:16 +0000)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20200227

for you to fetch changes up to 5d4c954931ba62661c6a1bc16ce604a012a10007:

  Memory: Only call ramblock_ptr when needed in qemu_ram_writeback (2020-02-27 11:50:30 +0000)

----------------------------------------------------------------
Xen queue 2020-02-27

* fix for xen-block
* fix in exec.c for migration of xen guest
* one cleanup patch

----------------------------------------------------------------
Anthony PERARD (1):
      Memory: Only call ramblock_ptr when needed in qemu_ram_writeback

Paul Durrant (1):
      xen-bus/block: explicitly assign event channels to an AioContext

Philippe Mathieu-Daudé (1):
      hw/xen/xen_pt_load_rom: Remove unused includes

 exec.c                         |  4 ++--
 hw/block/dataplane/xen-block.c | 20 ++++++++++++++++++--
 hw/xen/xen-bus.c               | 27 +++++++++++++++++++++++----
 hw/xen/xen_pt_load_rom.c       |  4 ----
 include/hw/xen/xen-bus.h       |  5 ++++-
 5 files changed, 47 insertions(+), 13 deletions(-)


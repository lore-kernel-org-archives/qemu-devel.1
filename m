Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46842089D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hqndVGjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46842089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je0uV-0005Kc-2n
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 14:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1je0tP-0004Da-2W
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:35:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1je0tJ-0005PU-UM
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590604502; x=1622140502;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X7yzdi9Cg8UDmfutqkM1fOKTOmRI8ETsZbmtdMwq74w=;
 b=hqndVGjPfOqs/Sz8RCvPjts1ymPWK+sBamld3TY+LI1Cw7Ekg9mjg/02
 JTYFv99y9eqQmQfFrkSkou/kCaupdQ3umIaUWl6klr061QuSOIMYW8Rx7
 hUVejzAvottJxpvdi1LIxbQmPmKI5gsAJh8uJetdx0abpsK5DNIhcgX+D
 48WEflZq7kbejd1nyO38Yg60F9p99KM4cRgd7gild4SX0BLo8BoHNGtn+
 4DAdiq7FjkmMTqM7pf8IDSg3ai+QKqMNamtA84z1bw6UipXnxf1iziIUS
 oGQzQ7tpPtUvGGzH/fodvhkgnjdj0iObeZPXkU23wvmzTXQVbWnBmXF4w A==;
IronPort-SDR: IPYBQEvWOhQqJC3Q1xDtoktZqIub9wSnCfKd6URmEcAznUu2d+a9fBnXSCGo6SWntUCX2ipb0p
 2Y8WeDeUc83oGt5c+1gQUL8P5Q8A2698UG+ZuezTsaRmARJBRhOGWkKkmqPszar+ftJB7U23qn
 7w6yvLr3oJ9nMBNOZqiKuG0itYbHT7LiMerun3HnvZPfUVE4sfM/i3f3m+oWyCD03uSSx2UURF
 Js6CEAJISgyT0fOzlhGTyyU5iu8GQu/2x9i8ndq9IRSUJO8kt4szQtt8plp/UV53Qsroou18Vx
 FXw=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="140069851"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:34:59 +0800
IronPort-SDR: oZDST/sb2E5Ho2/NenWoIzd2L8Dt3AuLtv0sXzBsEukxFp849f5BPXB6XIFZaZbQK5Vc3mKv4y
 tXt5ewumqwa2tg+ZDobzrV8rJWT7IXfog=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 11:24:49 -0700
IronPort-SDR: ih+CfP58xoBexgi3lktHoSyy5aI8TielA/xxzHWm3gXRtloq6EZ57pfZPtgm2gfuLYCaspnHTs
 BXyhZ//Y4vqg==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 May 2020 11:34:58 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/1] register-api queue
Date: Wed, 27 May 2020 11:26:16 -0700
Message-Id: <20200527182617.1979018-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-register-api-20200527

for you to fetch changes up to 5932a46c8a419db4a6402ac8ae42953b4d4fef1e:

  hw/registerfields: Prefix local variables with underscore in macros (2020-05-27 11:23:07 -0700)

----------------------------------------------------------------
A single patch to avoid clashes with the regiser field macros.

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      hw/registerfields: Prefix local variables with underscore in macros

 include/hw/registerfields.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)


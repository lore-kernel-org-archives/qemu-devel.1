Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C3C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FEE20730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="M9LDICol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FEE20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM5w3-0006U1-DD
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 04:19:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1jM5vA-0005kO-N5
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1jM5tP-0005JO-Iq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:18:52 -0400
Received: from mail-eopbgr1280100.outbound.protection.outlook.com
 ([40.107.128.100]:27879 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>) id 1jM5tP-0005HF-58
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:17:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYCOCwPeIZ+iGcvBp8+W2KFk8lHfhXxOlBK+ZrQNOA97YRWHRY58hOfWJmW0jsCZUJ1d3c6nOnKhXZ3pFbKPIXddvq5jSMLXLnD37z/biThDJgjtx4h5dl5aTJRu9tku9zCxet8xlkqOgOZG2E4NZDBDwwLmdTJGEylD0PJ0z9V+L3F2b8Fj0kw+drh014C53I0LtLbiJOyn9p25mcdZQXgCh3N7f6+xbwmklwLgpbKPzrTVqz69KbKIsCqFQkt3zeOOzUhxaIIyx6hOG6jy/H5/dCj2PdC/yTGTJajVvtwjwD84O5wrWlB3r46w7vhCw3ChLnMvZtMdt5FZNaasPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU7EaFYtnXi82IpAfqaGDkY5VZgsJpOcxVzIx3c8raY=;
 b=n4PSyg4UzP4geJek5HoVR/0hPNNT6i8l0v6ADY4gdxWBsGstPf/VKpMATF2ax1Sj9YhHIZtGC7nDnNmdxIlRuHwhkGDQwyiUTc0MdVDMusGbIslIa4R/p7fsX1RVnOk2vdjxCnMKGjIx4pYrV8t8NWk0FGKqwtiVtwmIHt2Jwsy+JEO4+cp6YPmfRCAUQsMdMW5M8SvgTZ4EnhfEbi2/qziMKkixcj4F5XcaXPPTNnSiiSstZ0soD+f7BPD7jiX0i450949o0/kRrBwRlOz0ToU0AbRNQZJCkacKtlxCy1fv+G9ZOVbF1Fh3kvDJOnOGyznSOUX+4rzGjCRI5qbtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU7EaFYtnXi82IpAfqaGDkY5VZgsJpOcxVzIx3c8raY=;
 b=M9LDICol44BBWBnJZZjDMmJ2fxBu1beCuQ5T0HozxAo3oc3ceSmvVK9AH8faI+KiNFQ4hk+qzwxLiaTncAvvu1g7S0G2EC1MuHG02JjwKy68mTRJlzl0sx/Y/smHFGz/f8lIf8i9x6bGgWM9MCRmH0XGKC/Rq59cjai5Ibdd7JI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXSPR00MB220.KORP216.PROD.OUTLOOK.COM (10.174.40.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Wed, 8 Apr 2020 08:16:57 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::1144:68ba:9c5c:e]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::1144:68ba:9c5c:e%10]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 08:16:57 +0000
From: Stephanos Ioannidis <root@stephanos.io>
To: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH] configure: Add nios2-softmmu to the libfdt-required list
Date: Wed,  8 Apr 2020 17:16:07 +0900
Message-Id: <20200408081607.96114-1-root@stephanos.io>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Wed, 8 Apr 2020 08:16:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [1.214.196.86]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f9c4fe-b66b-41f6-c840-08d7db95345b
X-MS-TrafficTypeDiagnostic: SLXSPR00MB220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SLXSPR00MB2202870391475FB1DCF080BBDC00@SLXSPR00MB220.KORP216.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39830400003)(316002)(66476007)(2616005)(66946007)(2906002)(956004)(6486002)(186003)(16526019)(4326008)(81166007)(6512007)(26005)(6666004)(8936002)(8676002)(52116002)(81156014)(66556008)(86362001)(4744005)(110136005)(36756003)(5660300002)(6506007)(508600001)(1076003)(36456003)(42976004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kCDD35dHz4LhrMy+x5up788AEdMCwKf9VvhG4yaubIRLKfb+mNSzJbH8tmP8JqaHa2rhqgc4VrqPKYA8ZS6fH2NAYkppbCVpFsgpKKWjO5Gbo+4l+auGzjWwDcv5Ok/OsqsHh9M03Qt8mVXeLudgpgySbtpokazR4ZmLWRyIFxTfHd+Sji01BiQYSVU8m1/TvdisisQntL1rri1bE4su+dBFlvEGhr/rfsuxtOYRvFhSmbVV3Sh4uSr++3lAwvllqNg5ySulJ0LTxkC3JY1e47CoXnh8Xg6eJZBXy6KfSoUMPrXvGo/jh21ZQqiC4pOkxoLaqgB+Rdc6DigquDeRn8v9t+1cU2IR4KPpxl1da7fAqMMcbYM9h09GgKezpO411bOirrjMH2aa8XyAgAIOvaKdtC5u4/OJpYU1KcsX7xmalPnF8S1dlVFceNE1XerrjxSq3Pkc+ABwDJLGlMjUsA6Nm0jKf4m7ulm/OwQrshgEWVsLcNrzOYLxGeedlPeBFLOlt69hfMnX1gaeLIMJg==
X-MS-Exchange-AntiSpam-MessageData: QxDXM0fHzz13VlU/3+RcsRwshPRgNS/I5Cy4HgDz773HPlkLDn9cyuD8UF3qWNRr43bpWbLaeVzDqUEY4j1LiKQo1Hy3pYGbRfxgtPAQb5sMiFNeo8ZGaGJwfcE1SBUe61rfv+Ih45qjXC2FtydURw==
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f9c4fe-b66b-41f6-c840-08d7db95345b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 08:16:57.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX2Oj/iGM842ph7uZux8fmEu9V38h6aVhreiCE1uAHGcWOu5EaWIguDEKt/lVlaeZToVwS+Khb7/4V09Z9v1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXSPR00MB220
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.100
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
Cc: Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nios2-softmmu target requires libfdt to function properly (see
hw/nios2/boot.c).

Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 233c671aaa..029adcf795 100755
--- a/configure
+++ b/configure
@@ -4236,7 +4236,7 @@ fi
 fdt_required=no
 for target in $target_list; do
   case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv*-softmmu|rx-softmmu)
+    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|nios2-softmmu|riscv*-softmmu|rx-softmmu)
       fdt_required=yes
     ;;
   esac
-- 
2.17.1



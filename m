Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B8C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267272074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tM11EG+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267272074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8cY-0006hc-45
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bJ-0004Jw-Ee
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU8bI-0005l9-L3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:47:37 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:53184 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU8bF-0005iG-3s; Thu, 30 Apr 2020 08:47:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhB3xoUU7k50Q3TpvslAuwScg5SEEqS4K8gIoS5m3kNlQm6W4sbNuZUt0gq1RiIPJAL+qmRfeHTGQncoum5XvduxGSZlF7Xp0hhenBi3RGShBnYiU041wr+eNATVIToP690X0q81VIMNpIc1Pfj3weXa/1j0roOlZZLOnLzDeVYiYCqHYEad1tbrchBjF6EkRjntT3GuQQBrTdld0jaWJd3L/1FY3Cu1ovBP5CAZ35MxbHkbrWhHaIOy8vGtp+JMtMUTp6wAKJSm/wu/xKcMSPN7D8NNdeOowrEXa3H0G/iIo5vtjBR2cOcujIn/LDen2SVeTFZeVc7QsWuinUyq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq5k6KF9RNWSU/z7aHKA2s7PK26HUt/ITdRWWjDLyFw=;
 b=k4rmgqlNg/FZc8WUfAaTU69GnhCJ5VrvNV/zqjlV/ebpOkgUNKQBC+77j0VwxEiq2KspEkO18DXnMt9Whyg1TxBn8Vf4j05r1/X7EO5T6N0640tzTq1ohMD1PEAikCW65TxisCzFJcz/tR1bdLG1UskObgBV9fd2oBn4A5/mBTs9y2ls4iBvymkzhvO40v7zHJcBwcWqiRwaQPNyztrYniB5jSVHFCVYAPnYE31fTqH+dgKY+eJOAR1Ka4uJ6lpVjuKeB4IZoIf8Aug2kSy89PYUPDbzKI0peWyKWq5prsGGWYrBMknM1oSrEV0Ct4kpTBbbXHQ2IPRRMAKlGLwSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq5k6KF9RNWSU/z7aHKA2s7PK26HUt/ITdRWWjDLyFw=;
 b=tM11EG+Sp9IMUnowm8eJHYz+NwpSi+fgti0EF86/FQyKel4KJ4iiLPASjb+5cgM6te8Dregp9rvinGFK08+3vc4w7dlrxsCpKG8mnlHT/yt1pUzFM3bX/F1NkBJ8fPMgL01OQQTlFaXkKE8gGxUik2p0JsUHlk76/gQwDqj0+kU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 12:47:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 12:47:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/8] iotests: handle tmpfs
Date: Thu, 30 Apr 2020 15:47:06 +0300
Message-Id: <20200430124713.3067-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430124713.3067-1-vsementsov@virtuozzo.com>
References: <20200430124713.3067-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 12:47:29 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9385cdef-6473-4df4-4053-08d7ed04a4f2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54786624C38D3177C97AA1BBC1AA0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PtvTuljorru6impBByT3JWka1UNxWpG8c0z/lPQLPUx1nqH1/FnkwZXsBpz5px0u1e2EzhTUpaA9Z6jpCzOdfXTRcOgM4YOwIi5IkqHuUMpoR/jrgWZSmRkqeDkgngMXWWUNQUxmQiZZB34ooDBEF6WrTFm/viMfhWUiggGfXnpklHLf+VbtjQfihklXjiX3/aZJ1Dd3OzR3ovlKFnRs/BYsnU7TCXUliHKFJOcH/A7RaIgZuPyFGC3R4U/xyTlvkbPGTDHkMlS7ijpmk7V+Y7Q/KnRv1UQDQV31XaiHHK6JazXxdgn+2oGAlqj3LuLo4o68muRw2Qvoyt/cxTrcImH3sSXUNRGgQiitdNlaWJkDOE2yvc/YHENgZT9kTpOTGYllJSCBEHrVzhPEZIJA9hMhCyDLU4foYXfyRDNklIXHP4ji/CF7BiONtCHXhpHSQf5RvlMFHzo9gDi1PYSoD3sfHAnVZ7aBPUgui20PGH0+/g75FHa42wWHzIt3O0q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(316002)(2616005)(6666004)(956004)(2906002)(478600001)(107886003)(4326008)(6486002)(66476007)(66556008)(66946007)(86362001)(36756003)(6512007)(16526019)(186003)(26005)(8936002)(52116002)(8676002)(6506007)(1076003)(6916009)(5660300002)(17423001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xCdVKJ50kIbrqY9QQ1bw7bzeFit2kIpiOjc+QjEY8CwqZRqixvBrYo15hnJPBVNobs/+lNp0ANjsnYk/1nxEDd3CGKrIT1F6+2XwVP3GbZYKk0iDi5t7/FHrhSLYI33nuO2HZ9pWPxzJvTGPNFhIjYomaJbp12Np4z/YmxEJTtIRnonkgWyjGH22QLPqwajquCA5VE34jdC52G6baVpSFRf8blajn9fAfR7jwKn3ae+hyEQw7R4YkzR3L7unc9U9RCDQ+srriQy5m2KDEP+SlK8QvEJWyqEpnKOgGz3yVSBBlaFjsGuJ9C46joIfwitKi1OViiHzJXh2qbuUIcxbFNY064FCbqW5cpT4GZfT/ddD3A+61jNwKkWnX83rCCx/VpT27riXcbpItphAXAURPgzN2O6DujaC2SgP6I0GE3mmd/P83ZF/zrF2u+dQJL6PT8n8QQ/P4O2Y/9csIkX7c0p3wlyM9WMgaQOdt6AarqwEQ5JY7M1akCTENDiD/v1dv0ey7UNvjJ0h6n7ccYqzYxmRqbHv5Gdr4ykBK45TIFkYg3bMImo4+2iXcqJYJFrWmRZix4+Mhh9iuSOnbMdzeWK1UnNxTt1pCsGbysffBufdFqpsyHV0702oaHM3EH5pdz9Lh2VzoNH5UuUFjATP5Hp0yqhBpsbWp2xr/2uc3Ks+ZIP6QAfeHs3oikTibIzpMPHpn3E6fwmtSv95aUqKUym46Ly1Hv/JXuZXJui6Ahy28bS7eQ/ByIWPELshCuAnznhXax0jL47qkx+6KN9zxZo+vqvW3xsIDCopaAUNWOU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9385cdef-6473-4df4-4053-08d7ed04a4f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 12:47:30.1297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYgj7LaVXOVigp9FUnbbfGyGeyzur97/IoEcTTm43s7kT3vjSDNiR17feGHC7MLwqixpXG+SWkkBGVeyVT3sBZNtyv4/yNjfU4Owc0Y5RgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 08:47:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.137
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some tests requires O_DIRECT, or want it by default. Introduce smarter
O_DIRECT handling:

- Check O_DIRECT in common.rc, if it is requested by selected
cache-mode.

- Support second fall-through argument in _default_cache_mode

Inspired-by: Max's 23e1d054112cec1e
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/091       |  2 +-
 tests/qemu-iotests/common.rc | 37 ++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index d2a2aca347..68fbfd777b 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -46,8 +46,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-_default_cache_mode none
 _supported_cache_modes writethrough none writeback
+_default_cache_mode none writeback
 
 size=1G
 
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index bf3b9fdea0..ba912555ca 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -673,11 +673,44 @@ _supported_cache_modes()
     _notrun "not suitable for cache mode: $CACHEMODE"
 }
 
+# Check whether the filesystem supports O_DIRECT
+_check_o_direct()
+{
+    $QEMU_IMG create -f raw "$TEST_IMG".test_o_direct 1M > /dev/null
+    out=$($QEMU_IO -f raw -t none -c quit "$TEST_IMG".test_o_direct 2>&1)
+    rm -f "$TEST_IMG".test_o_direct
+
+    [[ "$out" != *"O_DIRECT"* ]]
+}
+
+_require_o_direct()
+{
+    if ! _check_o_direct; then
+        _notrun "file system on $TEST_DIR does not support O_DIRECT"
+    fi
+}
+
+_check_cache_mode()
+{
+    if [ $CACHEMODE == "none" ] || [ $CACHEMODE == "directsync" ]; then
+        _require_o_direct
+    fi
+}
+
+_check_cache_mode
+
+# $1 - cache mode to use by default
+# $2 - (optional) cache mode to use by default if O_DIRECT is not supported
 _default_cache_mode()
 {
     if $CACHEMODE_IS_DEFAULT; then
-        CACHEMODE="$1"
-        QEMU_IO="$QEMU_IO --cache $1"
+        if [ -z "$2" ] || _check_o_direct; then
+            CACHEMODE="$1"
+        else
+            CACHEMODE="$2"
+        fi
+        QEMU_IO="$QEMU_IO --cache $CACHEMODE"
+        _check_cache_mode
         return
     fi
 }
-- 
2.21.0



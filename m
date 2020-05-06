Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF2C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF1C2073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XeFYZ+I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF1C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGPs-0000Gn-3j
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJY-00084I-By; Wed, 06 May 2020 05:26:04 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJX-0006M8-FW; Wed, 06 May 2020 05:26:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT6WRngp3eneJ6gGGPwJGOBzwXorQG5TpHibf4qAGLZ1v2CmJgZDvmD4MgCXPAEOAErxsaSofIi6ENOdiRZw/45/bsHdgAWBNNa5+gwdwIIGsR6Y5SOn0d51rvoYTWiVU3PNzRXNqIXfJrXZ+sIvaCTMocHaue83BERQD2M8d5eMjGX9S+FE2g2OX5k2e2+koltYiLKlvU4XWkmg+q0ftxPruhZKLbXlEH2YHI5d990ObFqYbfo8fu1jyU8eks5CzJOPVAE5qwx4sXUN/TPUCf0VchprC8w1V3Mu3BDVuWEtWLCwFWEbVy11CRn2/0C3DRNCQM7+VEvRCCWAwJ2bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tYIj7mrdIsX4tg3tsG17MNhFv9OGlRKqf7KQyYDUo=;
 b=JDFtQFbxMtzWebWTpa8ziJEUE3PupLWo0vX1gI5+L6iyzK2DU0MEloPDRPJC9eC46eE+f1POk0DoZrlsJk3z5veUmTNpHhemOcJLyjSZakMhs8J9BsqinO0ottC2hjQerE/SnQcZZlWAD+SwrKQAmFkxQ44JihYU0mKnPYLFJ0ThcJ0YA01IiyMNEpJO4gW7mHePXgUZOMe56U5fuujTR/6TW7Bm4SR41YkB+9+J5BxIdr3DiW9UTJ45xGw8xszIHhkLJ1rhbwTdJCibyCP44kqjOX1IDHjQXykkjKvJFBf1kZCs4Ae3oC2HoqEGeOF7lz14WzZyQb771ucnAGw4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tYIj7mrdIsX4tg3tsG17MNhFv9OGlRKqf7KQyYDUo=;
 b=XeFYZ+I7bcYSpf27/cHDtq9IGNmM61U9yAs9EVqhwXqypGf841JmaaVaaxYrkmZX5JOfYAlkEIXn+Bei7ieJb7lUROrneg8i05JfD21zzC0i4a1oHrMX51fqjj8SL+3ropmCuWRfVAGf+rzwr44PXinuaEo7QdAKm7XZmD1RWMs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 7/8] qemu-img: convert: don't use unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:12 +0300
Message-Id: <20200506092513.20904-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506092513.20904-1-vsementsov@virtuozzo.com>
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ccb276-d45b-4dc8-208c-08d7f19f79dd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382287B3A9A4E8BE04F351DC1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTczkqlTnRO/3aFehiYkkHg1oc8zx+sZ5OhwcxJ5bXJpvwbSMj+HP33jXzuiKopAaEhwKVQM/NzPHk8DM0zfKH9/2eOV8E7EqHb6SUmiIG/frMLznDrrNHQmwhcdeqgsbveiYogjvQM7AzCv74JFlhtvgp7AO2H2R5qg/6VR7nRTy3t5/sKn8GMPD7M0acxyb1Z9DcvS/kLRl4behIoTSvCQG0EqRI4KTuOxJXW8GEarAY1qfp/aqHj6RR7EE9MIyh0mSM3XFfj9QQMV84Vrztr/BbAYdJeocruScR782w+ll68knpCrkOjWtuKtU6dk3zQ+2w/O+kW00GMg9LtwaizpqdUOztUzQVYamX1C7GMV/Nox/BXTLEWnhlVy95AF/ufOtfjYCd0xTjRz0bX9f65Q3Qds8VpoCcqw69RE6cxG3pC+bUYZE+E+USXHvpufKWIoZWyyI5W7xvFFAu7CFk8PS+zNVUWmZcvfm/xNh4gCm+RRofb6aL4qFS7Dle4qrEKD3NqDU/2zkw9Lkp/f/BrOhD1jDV6WqPw+0QUWxDZRF2ljK5a5mrh6sWlaATWE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CLzkhb8/W01Atsp5/gsS8hnXRvvDGa5kHCYO/jYkRIvTCapJn+2qxZRcby4yo+a0k2ysZrZZxvDR+QC+eYu0RljHpO6UII0us9rU87G6NEmf/T2vGCIGaYHnhNjxqD/6bOMITo4XRQutp3OaVT2ovRfGS+kJyIrwzC8ssXLybbJHtCzHhTLT1BaAHmUQ5TWyAGX8Qay61rHrrK+vG9nsDSyHzvAYUsQ1K/O2TnTAku/DDb+WHHjWb2oO06Xy9wNa2qB0zne1xcAzdXLFMV5cI8NIWu2993TIPZaBz7sXVPy3j7GqXtf+IGZYOYhtE8jQrln2sibd2ta7g8doqzjtpFH82hcR+R69vynb4UvTyL+fSiEqWMyC8mgxHRyJxAbYwv/qzwl5o/LUp0tcH0AnvXduFE5jkdTXPMt1GNyTRDAiRiDuIHLK01nP4vL8s87VrWZ5Z8CDcA2P7rU9Up55pL20oG3f0OR+mtEa26+gEnZvKDLzhauIGoXYQhLcO5oPi12HNGYU4B72mntM5h/nFslHCilb4Yk/h8kjN1AL8Y/aXZ54ZSqsLP0ZZ5SD3rTjg9sbfVTb31PfsRXM/3P2h5PuuzGLOzhU+vWK/FyZaVb+QXnjeKFt7ItLeo+MzJuwA5YtnLRNvMaGrK1NfkXfWOMRJ8RT+4nQ9/rP+fg1rYHH9IhKgvWZ0sOkJAnmkplkqfr/XYmKvnEVcCPueudxbbtu4xRJF15K/Wlz9G2WCGas7GO0bJzkh4Zn/VY5G/uybziKmjgk8UJwmW8J9OWtYVXw21wUfw7II9JMA8p8V1I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ccb276-d45b-4dc8-208c-08d7f19f79dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:54.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYqVYoTQCH+1YRr9kkvmzs5cJqM0zo0O/ku8mj9cS34NpnOLvTb2yf24nbQQdswAya9sbwdNrEfdZoN1LdsL7CN1/x8Bsa25ZRzy1CBnK9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:25:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-img convert wants to distinguish ZERO which comes from short
backing files. unallocated_blocks_are_zero field of bdi is unrelated:
space after EOF is always considered to be zero anyway. So, just make
post_backing_zero true in case of short backing file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba..4fe751878b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1632,7 +1632,6 @@ typedef struct ImgConvertState {
     BlockBackend *target;
     bool has_zero_init;
     bool compressed;
-    bool unallocated_blocks_are_zero;
     bool target_is_new;
     bool target_has_backing;
     int64_t target_backing_sectors; /* negative if unknown */
@@ -1677,7 +1676,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
     if (s->target_backing_sectors >= 0) {
         if (sector_num >= s->target_backing_sectors) {
-            post_backing_zero = s->unallocated_blocks_are_zero;
+            post_backing_zero = true;
         } else if (sector_num + n > s->target_backing_sectors) {
             /* Split requests around target_backing_sectors (because
              * starting from there, zeros are handled differently) */
@@ -2580,7 +2579,6 @@ static int img_convert(int argc, char **argv)
     } else {
         s.compressed = s.compressed || bdi.needs_compressed_writes;
         s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
-        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
     }
 
     ret = convert_do_copy(&s);
-- 
2.21.0



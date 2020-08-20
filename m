Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5062087D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a3jsXGrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5062087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pfa-0007Tq-9a
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUL-00018y-8Y; Thu, 20 Aug 2020 14:40:37 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:1630 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUI-0003CQ-0t; Thu, 20 Aug 2020 14:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7nchhQnwCJd8Sg0hF9NkV1z1uFxM8vxbFz2y7gDWHFjklr83fCDQl1H9sreJ8h9zcUQ+U5S8Zti4/orIyhKvj5cnNto9lCqFxMCvm4Mj7sv14y71Le9r4Qz2T2eclsxpd/e4YscfCu2IvSDQHPnUlnlI+tUUnEbElSAAahC773TfDWl/NG50C9h5OlyAFo8OGFCDw93uIv/nMT72Nv+suJlne3wWXRfArTEOh37P1bWYSk3oJXB9uhI4W2MAx2z2or1uLDNymHh0D7x6urgvoGn8c54rLv0vesWpszy3FiuN8IAKj/GBnYE9Lum2NG9o7YCgneFwo6BRNJ5YMmhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1hZ5wjEyfzVH8D25IXioGcJE35tviOlYq6iYGJ+Suc=;
 b=fuy8foXbUc1GnTSoctE5MMVM78vKzJHEHNnDiaHoyXVaHjn4wbwC0MX26YEI2eT+6Txw4VyFUMjwpQYYMZ/hKQuQK3guK6qSpjdueVo5aJs/xjiKDAwcESStmjhlukce76Wr4LlL4sIxnDvjrH0DXpmewI/PgIDvSdiWzONYwAHimMBFRALzO9Qc5rivs0k6U4oXu+9Q4v6zD/QWvUiL1DsZ0xC7m0OEBBrq/6Itt0m19l1QkXfSth8KIeLxAZuog80OPf3UCB7xrIZgzQIAG7bIQIFvN1ndbUTfDzpoRHn47ytx46gTZmDuq3iD+VlvK/AF9JLsminJAssGxiUC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1hZ5wjEyfzVH8D25IXioGcJE35tviOlYq6iYGJ+Suc=;
 b=a3jsXGrvd2Wxo4VH6IIIq4F51BksiwADVFW5WCAFNq0ilYEG7Fk3VFt/ackSQ7V1FRW90ym4QOiCo2MPuyNQCSusotUsq7AIdJ5ey6Gv6y/gH7aBs2pR/1Fg+U9XwS1fFIKUsg/mA8a/YCHR8CLasi056WM9/t4HPt2ZuQYj+hg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 09/10] iotests.py: add filter_img_check
Date: Thu, 20 Aug 2020 21:39:49 +0300
Message-Id: <20200820183950.13109-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:11 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b34768db-766d-4f3a-6e3f-08d8453878ad
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032A72860ACA0291DA8C0ADC15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vXt3vco1pmk6R2jVp3rOWUkFj/NAyA+FRK3kkXx4eZxXm1BBunoAjhzB3tUes5fK5TfQZjb+ZNqotH5kG0INONh0+RAHfZgw9Dcf7d698Ej8DDFv4YxGM4WWVE5rNaahQtEmOIvNjC+irmfXjmObRFs976eSc+L2B/a8M6MMkEcSdda8oVqgEr2O7+3s6LMNkFSMPJ3tDNnsmqPznH/vvYk8wnqmjtzR7zlQM7P1L1lMkMMq+hh1077Xt4NN+Zn0qpfaOmCmIVQfC34z9q4EfzjaJqseFTvAuzqu4ipha6KcWPync6+yZv2pFoEonZAagyg5c6AYyHtR6DKaewsoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(36756003)(86362001)(2906002)(478600001)(6916009)(4744005)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZNhrpE/g10yXCvwERZROHDnxpM5auiIn/D7Ato0QZV2Ume9vB+K9CdDDKV8LyiyoluOwa645/pkC96wEv+m+fPvoaDqA848eWb0WJrFIJHUwb4P4SQH+qyiTkZjsRgkrqxyA/tDgn3FoDctZZOJhwyzJ4fwhikYD0Wy9DJIm537xMTjiK6RC72ciO5TSMWMfOqdhPYMGTH22q07gYCFVXN9SP/91+0t0Nq/iZ476rrgIX+HnWhTQUxvbxlrXGvhIhCVYKHPKNlUO87eHoRpeg0WPf3RMJb+0dD//EAR6j9r11K6+v7B2A46iROdsI2lr7lxzazD4g547IUapHkYA5SQNt+8c7aoiWKLaCw5XQlxl7CdhvoRlu+xj6F5jni2P66LeO89IcdMpvNhE1m874Y2fhmrxCuwQOvXS2zf+H6iYHBsvYQD18fmf46pMwVSBNttMmVxzKKeFh/ybdkQWU/JqQjvNxR4hSBYm6Kylk8KOv8eDuJYNnOeFX4ybqaXZlva5f2APYeiZMNHiEVDugVFEMf5JpxjcjA8W7RwyIaWFrQvlkl3ZGZ3MaqCUFIEe45DhjkxqE99UFMYqN4sivN1f9PdiurmuYOgkZb44E5XqYuxmKwHpV5968CXEeYbN66ODOcks8b2uV8lw324HWQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34768db-766d-4f3a-6e3f-08d8453878ad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:12.0361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9ltQVQ7vDpK5APSmJiDgWWEUUA6PPXejNrhHM1Ce6ZEuDXhMW7pT1O1Nc5Pd1RCgMOmtYN2ArkdTd7TdfOX/sihmSv7rEkNExEyflZ9J6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add analog of bash _filter_qemu_img_check to python framework.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 369e9918b4..ef3da4ee61 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -402,6 +402,10 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
+def filter_img_check(msg):
+    msg = re.sub(r'.*allocated.*fragmented.*compressed clusters', '', msg)
+    return re.sub(r'Image end offset: [0-9]+', '', msg).strip()
+
 def filter_imgfmt(msg):
     return msg.replace(imgfmt, 'IMGFMT')
 
-- 
2.21.3



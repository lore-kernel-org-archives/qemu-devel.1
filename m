Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F0222265
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UKzd7t0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F0222265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6dN-00030l-4B
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX695-0007ty-4g; Mon, 26 Oct 2020 13:18:59 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX693-0008NC-Da; Mon, 26 Oct 2020 13:18:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4sdZuekWta/lIUUuRoEvcvuAnCcfMeTiAKYEnJfbdk0wTy+F2jbvL4ZQDP2S2BLOAzJsiIsuKnDn0lYosxNj9UDwuHiNfJYXzRlaxWuaGgahZ7VQjWORRK9RjRl/RS+WN/oSeOw4EguI4gLRgbV61RUET8dl+PwR/kZisfZjB5ut1p4mbER+CVTprL3bvgWPobT2iamww+uvASTYTqzvwos9qF00R7KLhIhaaShqE8PhW7i5hRcEI2+6c4Kklr46jIH6FmkoFYAEUcAkCqGGu+5q6IQO5d0WsoHOaxR3TkM3Ad3NZqUQRCpZfY99WM9LjnbIlZfbCKHRBikMxPOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRTUWwh5iv3XC+ROEm0xJHcdtTc/PceILJOmjAS2b9g=;
 b=i+NbQqXtZ9tfGjWd24JTGlM7G31Mj5GCfzqDEwDcJwewIrWLU9Yw31xtmRxhrsncAbU5LaOoRGr+3NDxkLJeMXrp/sE6drRg081BmtV7u3aJqUIGNoSFHExRVD6DJaDF0zjNb5fdBDPy+05onwUsqZcmQNGd7W8+d4j+eYP6KMqOUqDb73dHljygPjQlP9+G2CGNxyt5QDZZIkcBeKQbo7ks1UmLi4+vsGimHsqV4lUkpY5s1jVymXBTIyOPoGULRXfLlLY0UN17oUnj6SklyRg97uH6shvIULJbQ8e/lM6+7zTeKJ6HfQ88r74gy1NgjxSxH4bJWqkPhhtO+kjTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRTUWwh5iv3XC+ROEm0xJHcdtTc/PceILJOmjAS2b9g=;
 b=UKzd7t0taK3yEuSO9Ewk+rnZEMqB/jrkth3DPoITsRMuNoQh0FV5T04KkramJ6pMhj4DQZpArz7jUuvSZuLhwL5TNWNwaqOOwBzguY6Bt25tvA2/W2+b8DlxbH+9e2NU3XCl7ThMOHG9JfIDs053FU5K740VqK3jlXtsvz6mu6k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 17/25] block/block-copy: make progress_bytes_callback
 optional
Date: Mon, 26 Oct 2020 20:18:07 +0300
Message-Id: <20201026171815.13233-18-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e363c8-0dcb-490b-d624-08d879d3318d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30329B2E41117C8F5A6CDB42C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:89;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65MDH1gHEeNxSTXVrnMVmYXt/HG2XWM3T1MhGe5/sK0kfAQsx57cT7pNkzrx1+9nFqB8Bu4RF/etHUBrJEEu9+clopC6yzbQTQewTUAyiEzAOX/W0rkytNxFepdVXjd41ju9gPiFAdxrxVD11fGr/O93mZY4puMS6qq1i9HuxAxRbLmKhYlZOzS59TS85da5N7LlUadN4Y3AaA5vlGtnyzKz6qSRysam5cSEHoPGhSYeAN2PUtoDEjcW8mFoEOdMBhjQ+pvfYxVrY1qpDFwq6bsVBP6fb8hXWWHeOnhKFgvaAQjYjT5qzGBW7A3PSelkymy9Ur210rc0J4wIFjCMRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hzlGO+69xcr4uWzqb6wi34+7BjtBHrO9jPWOeNC0JvPzgFttFZQk59deCPMB34hUjVCQ3IBjllUIAAqfdIqsxhhrTV868hjjVBYg0CXwbKEw7G84tuG9pouWDuAoEiP/6XVlF0eQcxtsJe3NQ+ifIgBP43Dc2bYSMtiX7v89OafkACymhoTsCUL7qC75XHN8RjC076kJFZ3YXvnCUnimUUZkEZK860cubkNr61QIZt5e5/OyVou6U0UMiamKdzutKroPD1hjXzRGjbvE6VvZ4dDgGtV6l221i9LjMl26DF6xWf4+2O6WTpECSjLjy873BszBZOMHMfo6tCw0AYzYgNrJZoUE+Rfob2QapWGMAyQe5BxyiwVQvk9h5UKNc5YqaroEAvcxYZUmvo1Q6IUTTD6o2vyBZ/VkE2UyJnzdbyIybHBIpS57ylHJBmhsPbPlB2ZdoQ2HVvYbD9K2VOPpBFWtOiJURS72PbWbeylS4MAigDNy7cGgkW7WVBHiRAdIswhEEtvE/xeagf7e8LSpr0vYcnKaKyHAFxxmCoVpfnDjYgveEsegy4/cjmx0+wOnpMmaXOtV5p3BE67ya3x/ia74h0AQ7Qz7ulC+UO5CuqcfapHxrHUvUcjxAAPDm6I7iWaatn/Q/ow6mAjltRYE6g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e363c8-0dcb-490b-d624-08d879d3318d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:45.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDAQLUvUCmSpxfl/durnvKuO/IpLpo4LwzXvQ6YHGNLIhXNM92GwjDHZwTpPezpMML2++7wm78VaZUE7axys1Y9B9PW0FORmIaDqKo8z+qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to stop use of this callback in the following commit.
Still the callback handling code will be dropped in a separate commit.
So, for now let's make it optional.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 82cf945693..61d82d9a1c 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -454,7 +454,9 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
         t->call_state->error_is_read = error_is_read;
     } else {
         progress_work_done(t->s->progress, t->bytes);
-        t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+        if (t->s->progress_bytes_callback) {
+            t->s->progress_bytes_callback(t->bytes, t->s->progress_opaque);
+        }
     }
     co_put_to_shres(t->s->mem, t->bytes);
     block_copy_task_end(t, ret);
-- 
2.21.3



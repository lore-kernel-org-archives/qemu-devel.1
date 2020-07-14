Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18984223AB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DJ1OUPZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18984223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNkb-0005p1-AW
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNhn-0000Pi-8o; Tue, 14 Jul 2020 12:22:55 -0400
Received: from mail-db8eur05on2116.outbound.protection.outlook.com
 ([40.107.20.116]:22897 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvNhl-0002R9-4E; Tue, 14 Jul 2020 12:22:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfSYb7HzzEZzo2UxLr/dl5N5iac+mS8CCL5Gt9KQvcenkEOj+db1X+ARe7WqUhtuIFbD2zxnyMHijdejBS79Iagx7t34TQ5m6gZbEJGc8qkLk2NuplW3oH9LfoaLA0VTjNNa3UZp/vTVqQ65j4Xv6+Ds9LEXLIq2AovI3i1BTFDdxq/jxAIya4Ngyzk86w/oMf5FClXfFhQzKT2nNQOwFr45QQt31wvlA7v1d8RYDCQrFue6JZEAnUVGeho4phlNAqyRyCnqXTyl8Nlsk/dAZbEuCPpPVk1xcU4oY3Ev+fkX//Trf+cAjcBnPteYZzLDh5DPqUKJpyCb5Gb6LnMqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB89ZtR6zLX+6CEa+d7FQHhB0EflJGod8Oh1atQHoKQ=;
 b=LFAB0kO3tvN8gR06ifzfCT1pscaDPZ+DJIreIAhQlRa1JqEpwn0pgETX0VbtZaGKTBR7nXKSVvg2AKTO0yTpCOBSIMQwH7Qz4UVdfot2n8SwbonejRepW+fUDpFer0x+79C2x7M2wLTedriraOHDi7pL4YcxzX10imdWxyyDPHBGnoutplFW46z0Aa604WJwy5ODgPGFVtTFCc0/lXQuRd5+0IivHGuxMMIYl0o9E+KwPz8ESu+xygvTthpphnDpfvohPwhla7PZuXuw0O0gTqWtTSBh+MjFCw0sy3izTaeW65daHu8GN2nJyTtpbVKM2U2v3zZUkud9vAY+da1Kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB89ZtR6zLX+6CEa+d7FQHhB0EflJGod8Oh1atQHoKQ=;
 b=DJ1OUPZqnV/h3n8Smyk6v+VhmdGgsZV+hWJbBhIu3ZFhoNSC6bchp1L1pbY5UnT2iBwks2Q1vNl+2H2qHQ/EwWCxA8hEnIk1ISrQoQuyCeUDs+NLw8moR6BeONPVq4C3pKbU5jkvPg6+oPMYP6f+qz3qZ60NlL90zgrLxt28L9g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2982.eurprd08.prod.outlook.com (2603:10a6:209:43::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 16:22:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 16:22:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/2] nbd: make nbd_export_close_all() synchronous
Date: Tue, 14 Jul 2020 19:22:33 +0300
Message-Id: <20200714162234.13113-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200714162234.13113-1-vsementsov@virtuozzo.com>
References: <20200714162234.13113-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.164) by
 AM4PR0101CA0075.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Tue, 14 Jul 2020 16:22:46 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19599f24-e721-4989-5912-08d82812250d
X-MS-TrafficTypeDiagnostic: AM6PR08MB2982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2982AAC6CDB21CCB52165A75C1610@AM6PR08MB2982.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z47pkKYGTZk0CUiNIPgbSc3RaSepl6B+z8jGY5w/4pkLlY0J0P6DaUcNLeQYGZJWqV9zVWTd4JKj1jOmQ0MuG9bje5zoqYSRm3w1JX/uEOJrqLP1IidtyQtGXfW2/hT9WMquXbEHE2Hyk2YxKKu2uNljlce0JmlJz0IzJuv5e+FzEjUO87rOsRZTWCNE3p80209fquD+GjoC3w//0jsUL7dZ4aeFR1az1rlSMPHYTuZoV5nHLNn9Gzh7E/xf858eYc+otGc9gPscGEben7CsVEu0lsinu7orBzzx/2Vx2MzbW6NBt2lUfmj4LbtnZMvj9MCan8N8nNDeJNE3np6shw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39840400004)(396003)(136003)(86362001)(6512007)(8676002)(6916009)(6486002)(5660300002)(66946007)(107886003)(8936002)(2906002)(6506007)(66476007)(36756003)(66556008)(26005)(956004)(186003)(52116002)(16526019)(478600001)(1076003)(6666004)(316002)(2616005)(4326008)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y98NMZtm/K3ijumVRHP9jx9j8enX7/Ed80TbJceaX5dplwkK2NmzhF50mj94gJVgMC4q1JEIIbLhgPA25Qd3odleUl3TWsFDU3z90YE9Z6Rv47V8EzybF3zzokF1kNtplVoLhPYRLesFc8zCQFpIUwOLA7zfe7okGLWJu0HHKYzS04MkDSIYxXC67nv7Ds4F0xuzino1PEP58ZeL+BXvLeaO+68Q6TG5sFYHc11BhXmsI2l+PWinQ9o4wnLaRMqIxZ0wzrcvhKchSH+AroaqO/NiaEm6sLWM9Aedh5PdKObpiafpsrS/g4Gc5OkBhQp4uibCRNXNY8ZJINMEpbbGQmVaa/+g/mO108tNMwIo7S+cTxWTIN+mebj/IhW2XY6ymrj6XBLN1Ct1BF+TvCwoKEPAUzoRscryEm/HbPhsNNMPo9K/fn4OU09YDIVAQGgFEhnNTJVVe/UbuiBM0J/Gv49PVBQ5ctCeV9WT7OhOM1RO7PFjYm0a0XRsluGdRt1c
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19599f24-e721-4989-5912-08d82812250d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 16:22:47.0692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r59tPlDv1oxWz3MWAHvJg8I8RFpmy33/GcToqQOXUcs3MuMd3rcHsDFaklq4cZHty0ajEL6L3lonNUKpumQiLobzUq/QxEzLw5r0TPaTfME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2982
Received-SPF: pass client-ip=40.107.20.116;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:22:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Consider nbd_export_close_all(). The call-stack looks like this:
 nbd_export_close_all() -> nbd_export_close -> call client_close() for
each client.

client_close() doesn't guarantee that client is closed: nbd_trip()
keeps reference to it. So, nbd_export_close_all() just reduce
reference counter on export and removes it from the list, but doesn't
guarantee that nbd_trip() finished neither export actually removed.

Let's wait for all exports actually removed.

Without this fix, the following crash is possible:

- export bitmap through internal Qemu NBD server
- connect a client
- shutdown Qemu

On shutdown nbd_export_close_all is called, but it actually don't wait
for nbd_trip() to finish and to release its references. So, export is
not release, and exported bitmap remains busy, and on try to remove the
bitmap (which is part of bdrv_close()) the assertion fails:

bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 5357f588f0..4752a6c8bc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -102,6 +102,8 @@ struct NBDExport {
 };
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
+static QTAILQ_HEAD(, NBDExport) closed_exports =
+        QTAILQ_HEAD_INITIALIZER(closed_exports);
 
 /* NBDExportMetaContexts represents a list of contexts to be exported,
  * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
@@ -1659,6 +1661,7 @@ void nbd_export_close(NBDExport *exp)
         g_free(exp->name);
         exp->name = NULL;
         QTAILQ_REMOVE(&exports, exp, next);
+        QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
     g_free(exp->description);
     exp->description = NULL;
@@ -1722,7 +1725,9 @@ void nbd_export_put(NBDExport *exp)
             g_free(exp->export_bitmap_context);
         }
 
+        QTAILQ_REMOVE(&closed_exports, exp, next);
         g_free(exp);
+        aio_wait_kick();
     }
 }
 
@@ -1742,6 +1747,9 @@ void nbd_export_close_all(void)
         nbd_export_close(exp);
         aio_context_release(aio_context);
     }
+
+    AIO_WAIT_WHILE(NULL, !(QTAILQ_EMPTY(&exports) &&
+                           QTAILQ_EMPTY(&closed_exports)));
 }
 
 static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
-- 
2.21.0



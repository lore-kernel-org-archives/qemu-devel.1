Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F48C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3AA222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NVo6yn1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3AA222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrPb-0002Z5-Le
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrJ3-0001qX-Mt; Tue, 20 Oct 2020 09:04:06 -0400
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com
 ([40.107.21.136]:23328 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrJ1-0005aC-Uy; Tue, 20 Oct 2020 09:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYk4/9WLpxOTuC1ASwKSl00DZGkv/QeNuQilgbOJKWroc2ndHyKZ8LAcYKE72KfwsSZi58PprzPP2GuHdyszqkmsDYI8ymGbYIYuuhBAznON8ep2k3uxEPBXaqXsz73Tt4XUVibpL0swYb574naJ2IuJYTlevgSqBeloR9jLjLoOkf164Dg6XrF1apmOa9rKS8BU0YUQG0KSSY2PGQFlGnjc1c/mEy4QOTBuO3kO5Gt+uV/fg88VcIG1yQF9NN5yuYafbwrFTLfcQH1UEKLvVo+XxjBGgtnF09EZcNw2iW7Oq9EhHc4VMcMvGAI44EPFSDJMVjuoWluVPWFPAZyv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdSEjVO42JVpf9UH1OgVnfG5T7fEq3ynxQc7TRf+7bQ=;
 b=fDRBJah4Xb2bbVYRJ4U08Fo1FUyR+iY3hLYnHE5fDoa/k1AA4Gxl2whHrsn0zonnfFhVW4CpbNFpLuKcHMZLnShM7PWMEZcrEJUiTR9xcHsbYDWaDKsx9eg5AY8FGfCUw/XzYwYrXvDkKGZupPCr4dlWscMuBsz0sKJYvf/u/JwH/UxPpV/jKFqmHHhynH2K0qwOhY3Pmtx5lFAPs9B0FE1DHZSLcjM7hCmSqRKnEqr93TvSer/uoDa3SCbypyMUgX2z+QBUPYmY2O2TcpnmwLN8K4H8U2hl9uB3ixK5rMJWvJDehV+egDMXszh1TXHq2FuioaNbZm/b/LeY7tCpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdSEjVO42JVpf9UH1OgVnfG5T7fEq3ynxQc7TRf+7bQ=;
 b=NVo6yn1++gbIBu1XK+KqrGRbGWAWCaD1MfY+C4iP5mNI9TgIUnZQzMkN+6Pg6sDyoS/3TWt4XETfCfZ8GspfOixSE/kClw6i4+apKQwIYrFFGYsSuUmVcLcLro8izki9izL4k2TURNSuvl1R2l7aapAEKrCtcRFKOMZidZbutkM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v4 14/14] block/qcow2: refactor qcow2_update_options_prepare
 error paths
Date: Tue, 20 Oct 2020 16:03:11 +0300
Message-Id: <20201020130311.14311-15-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cef80a42-09ef-4158-911c-08d874f89111
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61682B103598A8D14F7DB0AAC11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:92;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIo66cMuxBzSRvF83x/4zyYB95mh4ga1yZgx9DOnRMig4YXM7Qg4nBUl9nLnpoi1OrM6q1ZcF4FuoRy9o86MGyiMcnKgFMk36/EKynM9Fcl/pd3cAB8QlvAwe9GNe5tEDZm456OO12jB62g9uzAR5u/MyF1g9BGt+lFedI6NiC8zsgwwGiU6qfwrpxUiE5xK4sRxomTgyKZHKt02EX/HZ+qPXNE7Lyz4u9pz5DaJ9YQi9zP9P3A4rxG/vCD8GZfho0Dwu8wLo3uo3DD9sY3oamMwrxidPHaZXgUTyeLUbBuhTU501XXpaVeQpUn7WSvrr2+hYMt2Q3EKFR3z7Kg9yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cX5IxYdDWiJdoRYlkfs3r/zins0J9RNXEyPJeGuO6AEYHocKfHwEkIq0y7oxOxC8xxNYnKKcjVx7JF5smUmjbWIn2kDSO1xnKjT3rXJMp0sx8wbW3JmliZcWGhnEKuY7+4spjfxqVMMyr3x8nG+jOIqQACUE16VVwxN+kGJSJhEqI4WKm8VpIrRv2T9lSD2MWucY/K/VEEx7dVzCrc8eY+gbkcRld1auxqbhV6TxCRGKqW6Bi3xapCIRmnx4Thiw/FSDt/CuHsKrN4Il3xtEtBL2PaEcGXGE1vK/raW5UDs8bQwoPjkwGcci+CMVqHsZqH2fZ/YS9bJEU4VF4hsJPNoRCdgKHiNMs84Jx3j4tK4PEk0itTJMZsUwVRKWyDfayMrdALLCKT/VYbn1wZrBU80dqOhzKUJFGDD/xao8CEFBDol8EPU9G4U3xYKxZ7A7kY9E+yDi1Rq4WOdELB3FNRZsj77oa2s3JH2ek6xqF/+9tMNjOJyKG/eIaf4KN3sy2LLYCKZ8955KXvO9HZlsvmxFjGRtc46yGA+ANw8kdBhVOXLn6+YsTpr4pv2oyxqPiJvxyXPRai++0wja47Sins3FrM6Tx2jImB9yjuht9u9h0ZeQZR1B+x4QQkNudWhxG5zY1WS/buiR5dG53BwAdA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef80a42-09ef-4158-911c-08d874f89111
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:40.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlEM9MFGmNzkpj3a2Q8C0P1B1B6yqKopAuIJRVRF06tlt8FSe7LYsxZEgMALdt9wJTA5tPlaiUC+Ay4b60rHCcHGzgJ7ithdCVkodBE3ZkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.21.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:34
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

Keep setting ret close to setting errp and don't merge different error
paths into one. This way it's more obvious that we don't return
error without setting errp.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index cd5f48d3fb..c77be32aa2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1159,6 +1159,10 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
         qdict_put_str(encryptopts, "format", "qcow");
         r->crypto_opts = block_crypto_open_opts_init(encryptopts, errp);
+        if (!r->crypto_opts) {
+            ret = -EINVAL;
+            goto fail;
+        }
         break;
 
     case QCOW_CRYPT_LUKS:
@@ -1171,14 +1175,15 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
         }
         qdict_put_str(encryptopts, "format", "luks");
         r->crypto_opts = block_crypto_open_opts_init(encryptopts, errp);
+        if (!r->crypto_opts) {
+            ret = -EINVAL;
+            goto fail;
+        }
         break;
 
     default:
         error_setg(errp, "Unsupported encryption method %d",
                    s->crypt_method_header);
-        break;
-    }
-    if (s->crypt_method_header != QCOW_CRYPT_NONE && !r->crypto_opts) {
         ret = -EINVAL;
         goto fail;
     }
-- 
2.21.3



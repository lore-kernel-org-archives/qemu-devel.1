Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168CCC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CF020747
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hPV5okVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CF020747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcHz-0002QD-W3
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDJ-00025C-Mz; Thu, 07 May 2020 04:49:05 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:13902 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDI-0006Er-Ry; Thu, 07 May 2020 04:49:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOw1nevti1faf+gPfVzg4abrZoKlbFoqbNoCoWSarNflsPaDKkTTHJoC68Dl9R8l8t023gU8fpj+zrnQO7r4ne81Pc0ScMkEITIu68GDYU/9uCEBjgnHWbjmmc+02CC+2HRmw/5vD/IGaXj4Y/wyG9rUzXvsWoSl6R2K1pZfS/kzxNSVzk5yonBkj5LE9ApFYTlob36HWMDaS8nUhTU54i6KXsCgycr6G6+cMA1ziMy0OhGVbNGR2NLoaguSlHr3RQNzF4/5pHxmJVhBIIfdJeMM0yuc1pIOlaiB5MUfnR4p8LgefCp2tL406BN3o5LdvccZYyv2mYCmPTiZMfDO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAXFO4PGkoECMrka3NeTmIHeGqfaW7zgtjVmbJiOv+M=;
 b=ZNFULcJ56D0zVaYiGndLzgV6op59SHdsg+vJe+iue7tVeJeQjlVa+/b6Nvu4IGQUTiSCy7g4SMbDNc/DD+odbYl48PQec0kQZv2dby2xx+5DYbRjtup72AYm/MKxKf81s+2B+zkJM1pgUGleOMkEGneV1PUH86YxhxY2AO/s8Z2OogfgUqgG4iiEWiHPJr0o8hoa08kfJ7COvKqyvDoSrB30T9YZEJ8n2+rpvPqGnDUYYKB0wASMdoeUgY2T25DVffz5rzbdsXXujdhjXoDpv+jBI7xW+miguEH1tE5L9sG6SIWlCt5FnF17iU34RCTF6/hX3UY71HUOcdINQcjhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAXFO4PGkoECMrka3NeTmIHeGqfaW7zgtjVmbJiOv+M=;
 b=hPV5okVmTHGIUy2OdPkL2He5PtcWmR9z4lT65DM2TiC3Rakj4E4UXrkLjvOINrjLjuc1VogqGwi3bkAwVbkkQE37G4AYebVT/2gBnJowHdl7+Bq3EZ7dRhn2cw2Ftm+s2XDTOrrMFvh4VZa3lFsvco8pc1afMmpF4jWQjYWQ8M4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 8/9] block/vhdx: drop unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:47:59 +0300
Message-Id: <20200507084800.20596-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf06539-5b44-4c7a-0d0c-08d7f263728b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495DB1A10B291C10A59619CC1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNSQnvM8vhVbIJAZWlcAPHTV7FfWP8m/UmHuNkKiz/n0Gjok28gcTJvwBvEWkqfbaP64oMiMJ+PbPiFT+K+XM6hLg1PsfP/JisGuc14XVXmHdfkIzHnsXWjjnxIUxkVm/aeyk4qzZBk9Yidrg++DhsoZR734HFlKqtDIo6E+AqSi1MDLYQ+pJNiwR/xbqc8cnkrtVPD96Fk2jzSi0JXKmEIjXj/envtbcfoGaK8KNB7dAZr/PUdvi2ppsbZh58Ks5V/ihMkfCW5sZOjZ86tDNv/llYOzNrLRvKcz6cZp4nENtmVbvllF0k9WCRpshram8ljBihX9FuxNGI7M1Z+DpgSIA+lzZeLoWxqlli6UCcLOONHQzi9xYYn+Ouzv71qPP1r4mDWz+n1R+hFCTd2OSWIQKsstOIpTZIrItJ2ET85lLNGB832hCyS3ccNjRGx0dWeuW8l0sSyH7X5m8COMHdoqPVlSe8W+x+4g7bu9Y9V3lvp7DCPBR4BmVhPhZ/S1CGtJJOT+eP/XbBQ1l5UL6QLZcxnLUZjmMr56USauIsyAFu39ggOMnIfBKi9G1KuN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(66476007)(66946007)(66556008)(4744005)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6udyDmxfb4i7U5a0sQA4Jzw8zokegShFaMGWAp4ZfsL5CeE6tPUkGKUw9lulWxKm4wHv9nKf5ZBEimLpIvemGW7HphYgWPXb24HzJUO2MZYt6ZXgDUS6yvnfv2xKYlsFFYwHSKDKKFW+01JvG9yeYAcmBWYCBl4esUXMtLcfsw+CoTIn/3Bys4SX9LVeswq6MgJrioVMRjaByyC0PqH8NmN8TBJRuvxXd+2D4FVfxe0B0CgVZGjKmKpKXf3EjUp2IMTuEnvG84DC61Y221adecq/q2AMthstPhcnzwhLOp3iZ9+MhlhwCFbBjJ95DgAHcptWWzSGJBYP+zau9B8GPV1YSj6dJqicB9bTnug3QAEY0hjsj0yBwp5p/ZyUYTbXLg1cK2YwfEmzbDUbLy33d7tO6AfegEFSQhc6a2pnKDwMC6fCCFjh/J643t6FFqfZcTTj+DRDyjuoS2Uh52P/+ed2MILNK/cz+R2Hr3OfjRoupwH86hxfyQ+Zbg4I3gevaa2MfUQCeRtqNdFCJx+jXLxMNNprMW1HGPrVo+Cl4doPecDLJZsGhIGFgnr60sgDzXl4OJRypnIPkXqI6B7GeVwhBag48Snmj1h5TwnGi1M54IJiJ0r2irgv01Fn/8Clnm2gXv8PrIVnETORabjp6mlgGSz6gQe/FSBL2VDbI8/rOQ88TyDdKRK+T1mnj5gtw06emOo/S4dzFuM9wEQUAvwm4nHHMdz5OovkQe0Yj1bpz/n25dDQ/kWcbS1YQu4eqghrZy7qknxxIxxBnrANBAGmW01UYzDCMNnugJd6K8U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf06539-5b44-4c7a-0d0c-08d7f263728b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:43.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13MYRqRET1EJUut9JH3SL7OsNo+jD1Dmy85BP+BpRh91lIVbSYDyhC5bdYe100KDqqyMhhhbvB4c+wBQVBEVOvA3z6OJ0NLU9hlFCjfDygM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:43
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

vhdx doesn't have .bdrv_co_block_status handler, so DATA|ALLOCATED is
always assumed for it in bdrv_co_block_status().
unallocated_blocks_are_zero is useless (it doesn't affect the only user
of the field: bdrv_co_block_status()), drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/vhdx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index aedd782604..45963a3166 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1164,9 +1164,6 @@ static int vhdx_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 
     bdi->cluster_size = s->block_size;
 
-    bdi->unallocated_blocks_are_zero =
-        (s->params.data_bits & VHDX_PARAMS_HAS_PARENT) == 0;
-
     return 0;
 }
 
-- 
2.21.0



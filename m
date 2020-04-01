Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8896206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y3mjdVls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8896206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJetW-0008Qz-Tr
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes2-0006MI-Ss
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes1-0004Ci-Hr
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:34 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com
 ([40.107.1.93]:29790 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJery-000494-Nv; Wed, 01 Apr 2020 11:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuW8+ng/Gv1Y48MGlm7bnUv+yjS9FS39senbg7AnqtKFl1H5G3GIyyHAkDZrnUiyknTuiH5PPo+Oakw2JrTjVvG1JNrxiNCHuxM4NMd2kBKzvUaWE47aENQ09YmWd742gZkmeRlL76y17i7nZ4Ha3CvADs0wDwLrh2ip/JhSH/nG/87auXdPYjbP++Cgczee3WdVhRj1qmKPNvsnNpY1yewSbzY91JXNOF5yjosETrSomNAFIWWi58J8EZm2hALDzzStl9mZFghbFCQ6fKcX1X/KnpQh88Ea0AkrIaLOQeiKOmlr86Z1LoDIUllbiakohPHRzIC88dYYhNpjvUcorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xrQeysTFjb+GCyru1t/kK/l7QxTARdCZVDvohnjes=;
 b=IFTWHeXWdm8rP1BZBqxpmCIFIcrtfHn+QW+f4P/WjAZWHbAWJSebOWONxURn+oVcYwuuTh12NB6hO0SRE3xiZ4iN6g6NA+gBSfoxFhfYBQ13k8kkFNfeB7UbxZm2Qi13/rrfeZtdC8Bqw7igo28Io9oPI+3EyiB640Qt8ef8YiiztRR//t2KpQANCkaL/RYtrsvGr28HXoiRLxIzq6BT+ps+c2g/43+t9SLE8nFiF8UsyU7SYY/VghBYcZ5+hxX+RDlys2F2ocqLLp2H295eaauV9XGXXte4sEpXl8OnlEVrl9qxpWuypXBao5BCe6/nZzryezeJ816p6LnoXQIDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xrQeysTFjb+GCyru1t/kK/l7QxTARdCZVDvohnjes=;
 b=Y3mjdVlsw7mLoFddnw+0Cwb7mb3IggHKYXs5xi6gVvxWDrCkEz6zhO8DEpnuHvzukNFxxxRdYePRkCvU9CQMkoCoVnfGSmzFfCMAxtrYFXVX9lxe2o19TVJh4RPqqpa/NSqduDkdV5Za81AqwfoKqxtaoMIyjq6DyhFfeoKK1sU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 1 Apr 2020 15:01:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:01:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/6] block/nbd: define new max_write_zero_fast limit
Date: Wed,  1 Apr 2020 18:01:10 +0300
Message-ID: <20200401150112.9557-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200401150112.9557-1-vsementsov@virtuozzo.com>
References: <20200401150112.9557-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.23) by
 AM4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 15:01:28 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bddc4564-0071-4096-0fd9-08d7d64d8ea5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494AB133310B44302294983C1C90@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(39840400004)(366004)(66946007)(66556008)(52116002)(6486002)(86362001)(186003)(107886003)(478600001)(6506007)(4326008)(2906002)(6916009)(16526019)(26005)(5660300002)(6666004)(316002)(66476007)(1076003)(81166006)(36756003)(4744005)(2616005)(81156014)(8676002)(8936002)(956004)(6512007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkpQqhxqehoUuFyXWhX57k+MfQ3gMgVqywnmeyZmbi231jGSRv4slJ2lpdmkcpG231up9SswujaD9wURzVN4Vgojnm2qkJBT5Jh70zcwJKzsXLcLc7X70qLNeD0IYb1tEu9yEj3Ql2JUrg0wnTmzYKPUHD2ueZSQo7UNi5UQf782S4qN4xJj7Y8VuSQt4R0wf8pHzO5vwc03iXN9kVPthYWq4SyOhChfTLPRpL/oakAyrbuK7PYaYRoSq1WJqifoFLdiAAdG1x/bbqYDb21b2ssz1Eo08nd7foDZnV5JhcHZRebIlzZi1d5foz0dQFYA195+a7RiWYoTXVpK8XH5x5PaI0TSqBcp45C69EbH3eqqOWsQUUNrFFAteJUMgGrZzwYJgNyfmRwzSf/DX7jvfu3m51njk4nEtA24z6YXJyQXbO5t1QkhrQ8KTjoZuV33
X-MS-Exchange-AntiSpam-MessageData: N1Yqaq7ZOGKxvx8QpAS5trW14cmN7bS0fcrTWBakn+6cMl2fA1kEA+LdjgoCasDeyb/Ezhw0pKiqFZqcdeT6qZPFVllf5INIT+ZD2P7Fkh6e5z53upWrVFAQIejeXT6k7CMxS1VZeEvBu+kNIagFZg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddc4564-0071-4096-0fd9-08d7d64d8ea5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:01:29.2213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F52dtSPNthMWW+Ph3DLuPiIb8ckZAdjTAjpeMyPx8GLSL8RZyRhTDmq573gYMZezgnCnW+bYkCM6P+P0zEzDBBeoRjcllPTniO0W6l5isyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.93
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD spec was recently updated to clarify that max_block doesn't
relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
mirrors Qemu flag BDRV_REQ_NO_FALLBACK).

bs->bl.max_write_zero_fast is zero by default which means using
max_pwrite_zeroes. Update nbd driver to allow larger requests with
BDRV_REQ_NO_FALLBACK.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 4ac23c8f62..b0584cf68d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1956,6 +1956,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, =
Error **errp)
=20
     bs->bl.request_alignment =3D min;
     bs->bl.max_pdiscard =3D QEMU_ALIGN_DOWN(INT_MAX, min);
+    bs->bl.max_pwrite_zeroes_fast =3D bs->bl.max_pdiscard;
     bs->bl.max_pwrite_zeroes =3D max;
     bs->bl.max_transfer =3D max;
=20
--=20
2.21.0



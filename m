Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB4BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52788204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eC6iFSfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52788204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZTU-0002BR-LJ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO4-0001Hd-08; Fri, 14 Aug 2020 09:04:48 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:54037 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZO1-0006by-KU; Fri, 14 Aug 2020 09:04:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UA9WR1QN50Sl3bYmMUSfIHxlPOEcJnosQ94JH2nshJp/qwpGT44jaEGxMSwMFHuD231OS6i517kP2JfTSyA7UIU2umZ42GV9eQqt9/RXyEiYE+rQZxz5z0KgrLrycP2Abla1JiD0Cuiq52K2CEL+0hqmiln5Y9UNXFm1KRaAeTDJsgi6IHVVUgBy+NF6STYrlqXj4w2oakjAWovktQr7G0pOImOlgcNX6jaJgA9mYOjsohfH+YdymK1uLLOMqB5/1Y4WswbpS+7pFeKSgZRKDp9UbLmNV/tLlEhV02q+3FscNiD2DBs2XGnEwwUf2e8F3WNTuHuhZDBkaw3dFSKwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgJ43neXWXddYK6r0bzKLeoupwTJydQ6HKTEK0ovulk=;
 b=E5Fxt4S4CejHFy8E+DQaSCPqbB16SohjQ9psL31O7+TEDusU29xwG3ANL8Wa8j6xO+rXMqXLEUjoMZ+y6P/eo5j3KuR9xqm+Ziby/9Xf+TXEx4H6EP6WtMJPEhZBgPFLSmUEX7DtpX3XULSx6w/8sXWujNNI9bz6H4U+9mcVgnEWkpiyBq0m6HRIpDmcmoP9RnKpFZhBCKPPTdQbFhxVjDWxyrCqUSwxs5MIoI6/r89uXkgfLEcW31PjyY9ciR8k7HghLzBdyMx8vfEZf6ZfF7sHGy2kP9T8PNGGmg9kt2oTwcaNDCWuC469GjDRbi+rZW6RQ9xOmmAey4iX08HM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgJ43neXWXddYK6r0bzKLeoupwTJydQ6HKTEK0ovulk=;
 b=eC6iFSfFoHiGtzvHJXrf6se5KMrv+H7LJWXoJOVQZaXfRT0jqHQYPhQhY8QeZdmXCvZ3KFVuCDbgwMpb4MrgXINTGDSJve9GPfsm23Ym2hdtFUiBlP87GrJkVmQ9YQiGNRJhxBV+qphsKS0sDAG0jvr+1OlBM/8sAT9oxy5pzys=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 8/9] iotests.py: add verify_o_direct helper
Date: Fri, 14 Aug 2020 16:03:47 +0300
Message-Id: <20200814130348.20625-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:26 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59abedf8-cd55-4b3e-7311-08d840529331
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29816607803BB4471F3FF412C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zoXyMBlXuR4tKThUKRfwOiqv30AaRISkaPFQR1rh6bHju6KDj5mY3335EMaLiSkqKzzddlUG9m/4f6Zb06Ol0koqUmnm5Pok6MlZcu1ZSOCqEtKqTv9QD9zXIf0ZYPIOiXCLmP/AxsX+HAsVspXg1FwJqVCkC1phyZy34p5Nc7q+031g0zilaZz5xOYgC/wR+53QnoE0XqNleTXnSG6Ka1o10S4NXLDXQcgPwDJ5zgJwSbVAy9JRENaioQx5ZG3qQxbASsj/XeT4QCEr3FV5UM9eQa9ZTPf5wy269CeWlgsilQy0rSgFeGDsofvU2H7CX9FW8qw3keUNJ2AO967iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(15650500001)(36756003)(83380400001)(5660300002)(4744005)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hSXsEcJ20wNQdwtdaoqXG/Xv4UIZpR8MKIFgiEnT1AjSeXvYmrD+fD+87DOPKmgCtlSRtnx52w4HlNw/foY1/SPshWTqLDAe2sYqry9L5a1sMjIAXfylmMcxCkj+jJvQnKMs7NSM4My/aBI2F3Ef8OrE1y6BZL36t/w1IkXMIYXUbX5yEo338Bj3sApwLOsRtLmUVa3PpQo2yLEZX7fbyW+5iT5GncVpA8wSFN86V5X+YeNWC0YR2UaPG1bwYZvitAao/zPOC9GSshWfCorScJo3IG1Uj13MlR6zeSwHbEXISrPGHU4i7RZ1tIpY168ORAIPLgOHjQcBxuqHDVg4Z9+XKUzwifz2zxynrWPkFRzI+yQc58+KZy5xugtg0lZhK+ab0fPH5MU8a4+edIjnkNWQGTqQSrI3jYJE0ghnHmlswKuDdNngnhmtDegrqYKAyG9OWhBjIOIawxG2fdlPjIoqlqG21QCzdvy+9dR9+dohZravfft+fHvqZXGxECV4/rTFYZdH152HlSoOIc1M1VJANo1nQ9jC6mxPdNdy7fAh3d788T99ufwTMNPTAVI+R1ES192/5C7nWx/2GRvdRKkvlkRiTPgKlpwQAbfCr19nH5pORYK2cRkUYNJnx3qCIahufEWBnRasYvoTRW5fTg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59abedf8-cd55-4b3e-7311-08d840529331
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:27.7307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP1kk5v6x/OfwB+6gnrLFDuVQyWz8MROu+2pXgTGJyfd548/NmMqWKBiu22PfUHmFrLPcoCTEg903e5lOn+bdBYAoSj8oLcPSZkemqCKl1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:04:28
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add python notrun-helper similar to _check_o_direct for bash tests.
To be used in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 717b5b652c..369e9918b4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1083,6 +1083,12 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
 
+def verify_o_direct() -> None:
+    with FilePath('test_o_direct') as f:
+        qemu_img_create('-f', 'raw', f, '1M')
+        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit', f):
+            notrun(f'file system at {test_dir} does not support O_DIRECT')
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
-- 
2.21.3



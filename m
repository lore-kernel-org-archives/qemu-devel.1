Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB26C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1692177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hq7racAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1692177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFvl-0007sj-Cs
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaY-0006Yo-Ei; Wed, 21 Oct 2020 10:59:42 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaW-00085a-HE; Wed, 21 Oct 2020 10:59:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxsBBCeRXfS30NeorSoP/IOKK+EGVYsxI4QOiiiY3cgumNzEbQ4BWY7Fl+WgmFMKfeXTgQied4S+Q3xaAtL2VtCPZg4zFMjCpjmTEF9jllr3RSjupZFIrYhGRycDeQM5VqQCygrF6zoExEq3+mihyWUvUHPbIoVDy9p8Rqzgv+bRp4Ot7/b5hjU0E/poZz/g7aQhIgBcMMMkdRcS/h2NL9JaCBoGkSnNgwex9eXwXaGgBxxv3E8NwG+FDYOiCtDK28a8hW3AItWp1n4RLIZDmxeRUBVaxVvxdaq6XtIeZH0QV9y/woEDD4hT4Hahz6VMYcOThnit2UKIsWJMBVMmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgZ2U1mgiZ6DIP+4CzJ28CfUEIpSuR2wCE8qztkFr2Q=;
 b=IwnhwKZ6KEVUtqO+rR44zRi+T8Gtf8Pl1gKilJouTOE5O3RF06wsYTkQsYZ/tUU0MUMcHLEX9qlqHYp7OXVS1Gep44rX9g6nQlZTiEXCJqbi0x/yZLKaV+4zrt1OZcjSIU6AYg/mHIrJ8VzPcx2jQ83LAyaprJOjKSsHTyRkWm8DU6CxdRUo5wPeWFjrTfMZzanfk8mh6Kftkp7CQQp2hHZbnwAlQVebFXaAGAybimxWl+4RrrGf7kv7LOyU/D4dMTBB9J+/maZvc3qEMQMjlzTMdUTT03XC93QPS0akkmHPjDilW9VjnYjkwqOJ8goVp1zzPewEuAN9n5OzqZSc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgZ2U1mgiZ6DIP+4CzJ28CfUEIpSuR2wCE8qztkFr2Q=;
 b=hq7racAnEg/mgW00ObyeQOdQ73YVw3tTuiYcE+RrOrGS1ivkELcVteSEM6L3yKsUNKvriuuVGq8qZXosFnh+cNDyN0p7absbakoC71oe1Rf+bm5t0pXxbNKQtvHMty1rVFkfPDDmuIwl1zxIRI+4B3WvfEXJGXopmzDnAGVTMD4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 18/21] simplebench/results_to_text: improve view of the
 table
Date: Wed, 21 Oct 2020 17:58:56 +0300
Message-Id: <20201021145859.11201-19-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0479edec-1645-4fb2-7f93-08d875d1e867
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472158934DF75767D96FB1BC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXKedcfl1O0ERwWc/SBR5HnM7DAguLJTGzx6CzRept/E3gIgNoPwNL9pj0At7RWZr9K3VIgWpl5rw8V+lwQw00su9fupNBOOM80l51/UBjaJhyZgMVT4WB2rJcfCUSlN1O3W5+8+6dWzpTNjc5ItZ1dDJ9NMWy6jGPj2QRv/twN/lJ055Svl52cRfbP91P7HKZln8yGVAoRDPZA35Mhp94lM0xMMAhpOu/qpITFbiaDwormJm/JSG3mr+inKPJnJFlXsc6N0vTwJ7UX9shOj0KewlOW9xOnAd/MKSrxgfh9eUSKkW3+LhvJgvEEG+VewD/moJbfFhct9jCx4FPojJiVaalGk8yPYVGaooVnUf2ETozLs4A/t1Cfxcr7KLR4+UTPPVcMaASsDRimtI9d7Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39850400004)(346002)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UE0JgLfnDaK1uLPYQJg9Tdey7CnSr9nEwKY8MzUUBsi1U3zxASctqLkLnf81X2+0VVZtpcUnmSvl40d7Q6+NSV7woVL7BtEcKKFUw4KycWtI4sxCugihE5IjhYFRKrg0zLvJuzMpzhbJdOyXmgRwIfU7DLP9eVyChuL++JG6uRu3p7xN96P+us1QB5MXtehUdi0z7W6vPeVs+BK/F/TQBud9ReiDoBFaPsQApZuFz2zha3E269V3rhDsQuFaTC6NcBCyc491uxJap6t3vaPJMrtodWKphKwpIOo1hrLjJVWnb3WYgyUaoEDMI0XVx3mTTFymiCs/EkcgIaCgDpLGmAZ1UXdpwDfFcpDu5s67KjcxvGEuxI1yEQ5OX3KaiWv5A0F+NPvMizeJvmv+b+BMyh8G1MLlRQKhZB5nlsAJU0bn/Rmcu51n7P3vFOEHlK0xj+P4EZZcnj4ET8HphKe2qCoc5O9ixgEafDnReObIRJx8SlRL4ZiatuHlBEed49IuaoH9wNO/qYAd4WyiU7+Th0wCoeEaUd4pAfujKRMz4LEgWrauLquivzBWOKaKRT4eeshBSm9F0joDzeQ0NJxMMfP+MpCs/zyTiPDYbZDW9uXeB9HjsQE3Y41j5OhlSQGMOgQoGJWhLqIozq6NmvhBdA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0479edec-1645-4fb2-7f93-08d875d1e867
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:28.1881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7WgiUZmGlxxmGBKrAUNrfh7cweDPFom67ly8K7N5NeHb6TtQoPQPuwWtivg/2OoanLu1D1GLNimimsOkHGQVX8Yvtz7Wslbg+ScEYHwauQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move to generic format for floats and percentage for error.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/results_to_text.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/simplebench/results_to_text.py b/scripts/simplebench/results_to_text.py
index 58d909ffd9..479f7ac1d4 100644
--- a/scripts/simplebench/results_to_text.py
+++ b/scripts/simplebench/results_to_text.py
@@ -16,11 +16,22 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+import math
+
+
+def format_value(x, stdev):
+    stdev_pr = stdev / x * 100
+    if stdev_pr < 1.5:
+        # don't care too much
+        return f'{x:.2g}'
+    else:
+        return f'{x:.2g} ± {math.ceil(stdev_pr)}%'
+
 
 def result_to_text(result):
     """Return text representation of bench_one() returned dict."""
     if 'average' in result:
-        s = '{:.2f} +- {:.2f}'.format(result['average'], result['stdev'])
+        s = format_value(result['average'], result['stdev'])
         if 'n-failed' in result:
             s += '\n({} failed)'.format(result['n-failed'])
         return s
-- 
2.21.3



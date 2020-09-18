Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC614C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6357521D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="huGqeE3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6357521D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL6y-0005dW-Eb
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL0D-0007aq-PL; Fri, 18 Sep 2020 14:20:59 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:32391 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL06-0004dZ-FN; Fri, 18 Sep 2020 14:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLtjpndc1c47oE3jEOTiH/o/nMUfhSJZGUevrNvcvn2aZGKP7OiGKa5Md8Wvehy5HvfM2Z/VYb9Jny3jZ0PcLHDwdMP2DHkQxOQmzIGHrQpXhFc5VXJxp/IODvkIHBteQiCqVKzAX+mw5MCkvSAGdUf6EqJu6jyN0QJyoxz0M+fbz8Vur8vc5mXO6sZDFjC3wfLXNhV5DLdOPn1WoKwTruwf+GJlMuc4eCwdPbYE/Wp1azdsikxkJ30+c+HtJUteq85oRxPLvNF8429VKAGvfn2let5sx5gXPUCJgAid23C+yXe+e40Yx5EKygXMdB3f6O/9kJ9E2BQwQW2IT2Zldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/8tAEMFLkgUCLY2eVBGIwxG2EjF7nIftCv188u6gqc=;
 b=oUlRnyy9xZssLjv1MLqnucZYrLH5QsWGLYunwx5cIMjX7BvC7aYT46Xi7r5f7U5NT6USE8kiNYK9XwWLGLrgfFyC9RMhrOjCVS3YWerlObsf1cWBGphxkj3WdbBrR4ESDBICXP7IKtewoEfiRsVwrAexKUbq89OFe4RMI90blNVJIXolWdugH/HnABlTFFI6ucefn7hWUE4Ewo1n9NXhNcXjm3WumsWcU8c8zHBCz+CkUsxGM+tDrsFKeEVIfsn/l9C/8o6U7M6EKL2B641rNj2N6Ej9GM0RNl6k8wwPFthzIYC2lzuXYGcHHwyavQsK1o1LN29Ej6MEgIioiwsqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/8tAEMFLkgUCLY2eVBGIwxG2EjF7nIftCv188u6gqc=;
 b=huGqeE3ur3YuCUnnJVG6pvG/Whfo33hy6q3SuFgk1NCPryzejMTDWs4Tc2bqXrDFM6SnhgGNuEvEKnGrb0/WsDV7/roxj7i1iypX79Qjk74i2RXI9h/kGcXrhH4QQVSpW21Pn7YA8oLs+6P+VbT8fmaHGHeSRVPdvr31J0CYtoU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 10/15] iotests: qemu_io_silent: support --image-opts
Date: Fri, 18 Sep 2020 21:19:46 +0300
Message-Id: <20200918181951.21752-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:14 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e126972b-802d-4442-60af-08d85bff7d1f
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905E895C67572F3669E593FC13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkPBOfdCOa+7/gKcvRcLpWgqTEVWhqPMcTo1c4v6XmC/PC12dP5LXB6GyuIYqnk22RI8ax5SYirufjd7avGi+8VQVDeTEz/ps8nAFNk7Pe9ley/Zhogt7pUaxnGxpFm8tx4Q+a5jrjn9eaBzyA0wvLoGp8OJTmUNFeJsrxsIneCEaL2t/fhcJ4MfDsBw19ndeJbRXjbxo8UaZ6hbA1pO3PThaZAFZrfP60bbeJPGSjSLNwc+0q9MAJvSRyhqPWFZY4+/te9xoac3vDpogLzFQcpQajc0EUuHcnQClzkbwQnpdHeQYJbmi8TFClJ8QYSyFByvpjJdBThcuqYIW4HK9dv/GMDutxxym6FvmyiSl6c24BXOwQZCuv6VEm4d3XPj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(4744005)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0EV0D6mN36cy6uqD/JwL3gJEIjmL19z7YGoHBqgILB03qr6aeYcEJLcNIBuAcxKJU+neRIasSp54xtw/Hd+S8UsJvedjQesnAuoi6RPaXkl7a0v8O+86oEfMOnpVL9ieDgf27A/oK0oBClvXN1fvyh6g7j+fNiks6w/p30BU1GJoqwNgrFLO2l2U12HhozCV73EA4AGZE3YUOECehax+btph4qZ6riIm+DthEkTrJ/PWc/wRbqo3tGKgaxFU07ChKsavQSd+wPUAhOm0U8eJkSaedvjgNDqSPxgNTThGHYbgi8Y+LIsEU+oMj5eLXWwG5Hz8Hyf08/QiyVTKr4SBdVe+Z9+Y8puqtojf6aLXk6GerYYwO1HsA6G496lwq8RGJjPhwFuIbtZ49h0Z5zhyxWFkLLWDfcPPslJG8nIliaCbpymrHpM2AmVJnO2dCzhADmIRjAJWIZhiyMZNHBJRC4cG+sPDgIwxcaPu71MFck8zGMLu+4aOuMEpct165iW6nm+vej+5TgBqdTWhMQDJzWQxtQUpRuA9dvWvWBhj9rxzZPbHlip2JK+wBzeZVHpAMwOlqrizG7wW4c1UrDGYIKAoVselX4M9R9W5l+MZGr2uw5WxrKd/C6Dv3wX3iGyBb9inXpeGDExpoqhEzPmIYg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e126972b-802d-4442-60af-08d85bff7d1f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:14.9131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwJcOZixP+U+fJJLRPyST1WZ6pkojpIto+ocPoSG1SpSKH8jA/1IbzoKVbwSQn1VOTLKIGw+Tx1S0Og4CrLO7LgjoCRHnY85fu4AkLFjPVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:14
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 91e4a57126..3d48108f3a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -197,7 +197,12 @@ def qemu_io_log(*args):
 
 def qemu_io_silent(*args):
     '''Run qemu-io and return the exit code, suppressing stdout'''
-    args = qemu_io_args + list(args)
+    if '-f' in args or '--image-opts' in args:
+        default_args = qemu_io_args_no_fmt
+    else:
+        default_args = qemu_io_args
+
+    args = default_args + list(args)
     exitcode = subprocess.call(args, stdout=open('/dev/null', 'w'))
     if exitcode < 0:
         sys.stderr.write('qemu-io received signal %i: %s\n' %
-- 
2.21.3



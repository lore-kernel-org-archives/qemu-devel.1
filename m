Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A712C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7863221D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HqfPUjvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7863221D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6DU-0005DP-GG
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68j-0007DW-7K; Mon, 26 Oct 2020 13:18:37 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:26030 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68h-0008Ma-Dq; Mon, 26 Oct 2020 13:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+t0YbXFNkGyOc9Bpq1niazOIqjaMe3eu7IWGaeU3q5CqITR+jhMQGGTV+e5vmVar3MaXCzxHh8U55y1mpTOac4qPIn9qqZsSoxQAGZbw8gMEegF9fF0lYfoySiSlaaueERPXCBJQ1/ubvFow3B0RPSLjBCcvCeSekp198RLU6c4keDGSZ8Ff0wH+PKQxKRf0vE0xyG5hHWAT650RLKRdK9r9Kdztsebx8ILMK7yNPILCwCSXbja1KTheOotZdm8T6Ackb3YJ95IKZG001sgx130CQof04JU9DV4jGkU20L1fn5jOyeXGOsy7qCPqvrbHy429MSd1JIsxLN6+HH6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOb94VaA9Pn4FFbyTdswlT6VUkkC0BKaz0skqXSRiyQ=;
 b=DubAbtzARQBU+P8nOUvdNM8pRHr5gLxlPGWRSptInDzMaX++zgaTuQHqJLRTlupBsuP3KcKq6TcwjIHHY1AtRFu7HUZiNyl/Uhifm5dlJM05xzjNuEgs0vfdtOvb1p/Wc5CsvbHYljCpPP8XAjAW+lSnc++gVCzMR9NR3m9n/eVoIIGun6gy8dpfUJ/KEsFg5NvlWrRbk3VSLfM5M9/pg4n5/x8MwL/N5WWWlKkz4ZUMpZ1PsE+Jq7Mdnj8hMLtIujMXhHRdAtQE/B/9qfz241uc4IosKwmcfHOiKxkIcsrnV4JebRlcqQhuJDtrvhnku2o36u5j6c/RKEAkKMjltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOb94VaA9Pn4FFbyTdswlT6VUkkC0BKaz0skqXSRiyQ=;
 b=HqfPUjvHYds1Y9JxD1aQ8SSEYcOJlPi833O3cR7TK6GDZKcTgi6DPlElgwnUlL/BA6AxlzDC2V1N2djgm/W/kTAbZaL4eGSuaEic+1v7G0L06AsBlGpR3NXu80XHhsemNori3jP209zG+5z9KGBDUJO1OrmKj+FB2avlE/yfdmM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 01/25] iotests: 129 don't check backup "busy"
Date: Mon, 26 Oct 2020 20:17:51 +0300
Message-Id: <20201026171815.13233-2-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1363cf4d-074c-4700-8e02-08d879d328e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50318B4FB1BCD5A1E7899BFDC1190@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYa+UVdfs+dTpX7254ngY9Gbo7hN/3hhzTfdIIbfUFjLIK1NXtpaHPWT/w6ZMlcijrHB63A/eQE3UIfUhtgQqshQKr1bK4cZUuzVzmSoDjtdm6QProPz6mfdbPBZp0qeWMNbU7euih9DvVwkQdwUteH4HCIOtZtreexG+wmKklYBQqwMT9+PxuvPQRFYom2MscKkCNdPuzdUV0iFFOdLEgqU5dmoRqCxZJsLjNL39pge4USFJyAn2EJzqZABGproApcz95ggNAtdpELQ0U3h7epqrXeDJHhcDwWP3Y3U3SVB5bkhXjYkN3f1tskJbQgj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(83380400001)(5660300002)(1076003)(316002)(2616005)(478600001)(6506007)(4326008)(6666004)(66946007)(26005)(66556008)(956004)(36756003)(6486002)(6512007)(186003)(66476007)(8936002)(52116002)(2906002)(16526019)(107886003)(8676002)(6916009)(86362001)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vbr9NHLZYuVuXblFyytb1cnJ8tSskGYFEpzzBJ+GR7Mp1PJreyFlMGuevu6QiA9NX9UAdBBnCMpcfRtrSYc15+sEkz+KR/NyJ7jmh7KT22E/9YEdEs/pK/j5sew0/qiUBOlR2o8lSv/2xkX+RT2L8vJ/jDrx/YT6hQ/PBzZAiPdlkFVB5YaO+lPMP5u2umkVRe8dgsKP8bRI8bLoS5eYWdl8wg6GeqZbx0Vv/5MpCJ5P3BTitI/p1zrUrP0Vhu16eziTlWbvTORjGzGCYDVTHO69DFDINcW4YyUbhkBRO4uzTwQAGFQL5UkO6XEDXkE8T3sf/alQ5exyv7mpWN2bLn9sD8acp/zJlAvHhnHpXKAaUMW09NDNCQw0cumJmaH6J99WNNTc2v1/OR1o4wQ+Axyd8pbaDatlQ5HUmMQ9fON3/95P59tA9eK5ry8MFjjodnPv9sCZqZExAmueV6LOdlhGaYuzOrA8iQHqXqTf6xBmv0ul8dv3DvAy+qSkNtJpwrX8/vaEzJDPilKlZlTPlnR4HsfEViuZrpOcihMcdFecrjlpinyjVt8R1tMxer1jIyNyJcUs4JK6NAltrh+Fs0olik5S5ARYoI2XjEma26xcnvHL417aGfstAGoJfOHP3rfMec7/uw8y1w8JAE4aOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1363cf4d-074c-4700-8e02-08d879d328e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:30.5863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nk5pl85ujhPTiLV5do8tV0+LRlXzbN8sIhIoEQtrDkHIbq6C8xhWE1OQ6pidWPIiBy54s6N1VVVnEK1ZdLJ6d9fbnOv+8zydpmH8ZB4jK4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=40.107.6.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:30
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

Busy is racy, job has it's "pause-points" when it's not busy. Drop this
check.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/129 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 0e13244d85..3c22f6448c 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -67,7 +67,6 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         result = self.vm.qmp("stop")
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp("query-block-jobs")
-        self.assert_qmp(result, 'return[0]/busy', True)
         self.assert_qmp(result, 'return[0]/ready', False)
 
     def test_drive_mirror(self):
-- 
2.21.3



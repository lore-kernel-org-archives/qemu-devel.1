Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E157AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86D9206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pKfqYFn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86D9206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqe75-0007m2-VO
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqe6T-0007Lf-Ow
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:52:49 -0400
Received: from mail-mw2nam10on2128.outbound.protection.outlook.com
 ([40.107.94.128]:7556 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqe6R-0006zH-7o
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2XPeUtWyO54nCPeYZtAx3f/xY/Up54gDJ/xywlzmDXy/bzZtRsw9sLWJDF/hQqg+RXZu8YRmE5WHEki6A2YEqSe2UmsNNhQ/cAmkBDR6Zgxjwth1lDlfw18vb3CVHrf/34zPaFikWFKylYKkWP6oGLTmintTTro5FWow48orroIeXOL5fm0abzFpE+IXLOWm371VWjDFxbSjkcsS8/L5VkS2CC4QqV2opuWa6uJspsOaYTn68HqSEzM2olLdMuZuZaOtoPzEKfdsYJRMCHZDR8wbxk/YsaWCLzZkUogma7StvOHJc3AvFZJtDEylAG5KpwKSvoVRJSRtdjy3e53cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhNz4iOJlx52hzJovyvIwiJTEodzXOkfE764S7kXNl0=;
 b=kh+4bUle8UQ8D2trf8UuLUXKZISAnhwxHigHsbC1bZWCIsISAWXR9ttaWk3REII6RN3vQ9EBwOfjLpVjBHJ8CyFLgHqxXS8LFNv8eJq/RpO8EZghm6KauUt9tUihaXaIp+7Y+6xg1HF1Vht5lIBhcOU7v1wmtVUr0EH5hcz4EZF76YDvBCc/lgZ6n8zkMlhoW8I/GBcI5pFBoZQspMxGMrQue9p8vOOy96dckuoMpYGRpHu+ETNlppAKjMRExCMQgjbkN7lPPUt8K1mERVMxMDBUBqXT8LP4yn0jSQO6S7qg3QkzsBCbc4gQILjf9leWWXA34hKXjBnQXXJgIuqhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhNz4iOJlx52hzJovyvIwiJTEodzXOkfE764S7kXNl0=;
 b=pKfqYFn7k7BMthkmuUJfZ0eRF7gT+robxrORXBs2mMmx2gGjxqQhOlvpdThob9JC6TtvTwihIOdimW1Y8AtUQXmGN5sltZNP8LWywbKgDqk6n3KAawECf2k6Pk3gfcmm/8g3PbXWc1gOLTGo2LswAts7kipzd6kbyPecGFOBqW0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2381.namprd03.prod.outlook.com (2603:10b6:804:10::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 1 Jul
 2020 14:52:43 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.023; Wed, 1 Jul 2020
 14:52:43 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] pc: fix leak in pc_system_flash_cleanup_unused
Date: Wed,  1 Jul 2020 10:52:31 -0400
Message-Id: <20200701145231.19531-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:208:238::9) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 14:52:42 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e249e1a6-3a88-4501-e8b6-08d81dce68a6
X-MS-TrafficTypeDiagnostic: SN2PR03MB2381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB23816A3AFC1E0CB88EFBD1C9BA6C0@SN2PR03MB2381.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:247;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMciGAoLL6RPK9xoz6ZjpMizNl+5KoBQfQ57jGAkXSSztbRqeAYJoWMadEOYnYtVTDYfblvrJTn6kzWlZJjaI/Faznp1/cI6CCL1gXrb4lfTULyFmfzN8/jc9drKnT5UjxsRLd/cjKuoTPLBkKVE2otVWX2XqUHYpaENzIgAuwNMNEXO4iJiBXf2XYO2q3/uRxol6tZ9rYe90xAH1XSTq/T13AtMjv+KczW8mnEnsmnRF3b2xQHcOcxY10hcPhVpmkn3sIEFgcPnti0VP8JjtwPcI0AgQysD2ukBspmVwIKj6vOpzBtueekTdmumD0iF3moc396hDNopyu+/wmX6iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(16526019)(186003)(75432002)(83380400001)(86362001)(8676002)(8936002)(54906003)(478600001)(786003)(316002)(66946007)(7696005)(52116002)(6916009)(2906002)(1076003)(26005)(4326008)(36756003)(6486002)(6666004)(2616005)(956004)(5660300002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gIwmVnb/37KuaacJ9rlxH0xwamNLXvXi12OIpg/eVMzetv2t4J2oh+mA9tGvYQVYJiPRwK565vL81PvInnr3BEW5m7OBfHT079JbOjIRKfXXgUkDiMIfAnwwv7/geUxg4VOF8W72TSQOSMJR4cgcuunW6pG4UCNkkzbe39WBU4EUs7tfW/meAgfKd0OqUeh2z9V55KK2kYSnGGh0y2G+x7TzYj2utOVg5/SaqHqyAyqZKTLFjliJG0DFgtojdpDOQlYbr0uQ9vPv+z/+27GsxiXvgFf5rRsxFdb+MmLf0K1wv1OMrN+E773NohrqzchZrUjbslBGYv5Tc7aHQjOXsBt6xwSvsJ7OzUs6f5rpbv2QlJqrG55HCrywW3dK10drriNw/GIrneqnLJRh/Uk+qaDAM2Av8aeHw1V/JQW/M4gCBhhly9Yf4VJjGoXgBG2MB+brlXXyX8WUO2w6awmTqLsCKZ3CKG+arpa4y7SgSxc=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e249e1a6-3a88-4501-e8b6-08d81dce68a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 14:52:43.1251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jscBRXWkY1NWAmMkma5SAq3CA3of8Odp37CwMVfobRFTHbg50XrXjl+PIhMtYIkB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2381
Received-SPF: pass client-ip=40.107.94.128; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 10:52:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tries to fix a leak detected when building with --enable-sanitizers:
./i386-softmmu/qemu-system-i386
Upon exit:
==13576==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 1216 byte(s) in 1 object(s) allocated from:
    #0 0x7f9d2ed5c628 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5)
    #1 0x7f9d2e963500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.)
    #2 0x55fa646d25cc in object_new_with_type /tmp/qemu/qom/object.c:686
    #3 0x55fa63dbaa88 in qdev_new /tmp/qemu/hw/core/qdev.c:140
    #4 0x55fa638a533f in pc_pflash_create /tmp/qemu/hw/i386/pc_sysfw.c:88
    #5 0x55fa638a54c4 in pc_system_flash_create /tmp/qemu/hw/i386/pc_sysfw.c:106
    #6 0x55fa646caa1d in object_init_with_type /tmp/qemu/qom/object.c:369
    #7 0x55fa646d20b5 in object_initialize_with_type /tmp/qemu/qom/object.c:511
    #8 0x55fa646d2606 in object_new_with_type /tmp/qemu/qom/object.c:687
    #9 0x55fa639431e9 in qemu_init /tmp/qemu/softmmu/vl.c:3878
    #10 0x55fa6335c1b8 in main /tmp/qemu/softmmu/main.c:48
    #11 0x7f9d2cf06e0a in __libc_start_main ../csu/libc-start.c:308
    #12 0x55fa6335f8e9 in _start (/tmp/qemu/build/i386-softmmu/qemu-system-i386)

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
v2: move unref to pc_pflash_create, per Paolo's suggestion

 hw/i386/pc_sysfw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ec2a3b3e7e..60a83c53ab 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -93,6 +93,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(pcms), alias_prop_name,
                               OBJECT(dev), "drive");
+    object_unref(OBJECT(dev));
     return PFLASH_CFI01(dev);
 }
 
-- 
2.26.2



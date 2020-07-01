Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBA3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 02:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B16A20780
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 02:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="2TOwBnD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B16A20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqSHG-0004ea-KC
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 22:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqSGb-0003tH-Bc
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 22:14:29 -0400
Received: from mail-bn7nam10on2112.outbound.protection.outlook.com
 ([40.107.92.112]:25793 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqSGZ-0004fI-4Q
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 22:14:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4OW4uw2vpC8DXQqFikZ9gLrIJ8VwI60hp6bCKvaI1z25l6YereWpHEjOShG1HGcl0CuEnd4w//S3ckHkDlPeqXCGEaj4PxkGeeUFwDJ0D78jjUGDmUxMK3YR60U96YzqaeSdu9E1IVHlNqF+/ym5gxETMaqiaUlUPmvmDndUDbKcxmUkPB107PEqFnbd7roi7Khy+ORsc9aVZ80nTMtdj/zgikOeZ6z4SINWPXfjZ/rIZs1GJ++IIFBEbXSPOp58vUtAqXTus/g44CpfMF7ksQnEQmEv+8Q7C1LN17tHRKrozZSbZ+YtHvVcUN3bGkMwVLkLP+pkTOSzzSAvmvUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktDzJbhgamf3q44kqq7G7Gvgqs49Umon1ZjD1WpOzbg=;
 b=ZtZGsDo2BwKktH0K0JZZ2cXjfnqNRfZ7t5rU3zVw9jXAijLJ6Vu3DG2qMANNfW46OEu6vNJyiGOg0L8HZXIaS8qCy/alvA+AR6M5zop7v/bEeAburWwM48+S/eprwVVVNFGRa7btukbtfVW278+RGgUWVjr+x+1Ewne+NAI6TL7x67qWxvLsVq1Q7q1gnreL+dqnYa3RYDyOIuFmD5oYdbjQLttq4bQ+bfhGLG4b8SRgewm23DiaS0EX5yK0ieoNy92YqZMX5pcY+kG+wyOIOPUSzxT+6EdhOcBl6kWWf/5ZuEh2OrQNNjDbW3uHsvskqB1ddAtMU0ikZ3dBtryvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktDzJbhgamf3q44kqq7G7Gvgqs49Umon1ZjD1WpOzbg=;
 b=2TOwBnD6NJVxMVWNJlxJCrPgmPMdvi9uZQx+45P6eoYUNBVFu2+pDC4xQj7v+Nx5QBLCJHw6iDVxRaUAzq57sMwh+jw+YDDXD4EzMc3TLLUwKGQ2vsSonf7SaTn4Qiqq+/SvJNijMTQOPLhLUhT+wLJ/v7vh+TV//SyHew07gNk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3679.namprd03.prod.outlook.com (2603:10b6:805:42::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 01:59:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::8ce:29a6:77be:c35b%7]) with mapi id 15.20.3153.020; Wed, 1 Jul 2020
 01:59:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH] pc: fix leak in pc_system_flash_cleanup_unused
Date: Tue, 30 Jun 2020 21:58:59 -0400
Message-Id: <20200701015859.29820-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR1501CA0014.namprd15.prod.outlook.com (2603:10b6:207:17::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Wed, 1 Jul 2020 01:59:18 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e95fe39-eba9-4155-c548-08d81d625de3
X-MS-TrafficTypeDiagnostic: SN6PR03MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3679878038B1DC8FC1780710BA6C0@SN6PR03MB3679.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GccZzBW1xzycaDXJlNBaLSjmSEmdaHLDUS+N6s1LDWBCc6QolcmB+SHaROvqB9jXW2J7MOkRonNjj0ubvJ7W/gO7L85JnZDhZoTWpuYzS59y2xS4pl9iz+LIPzv98y0TCmlseKCQNqb/lRo3jFav9+dl+A9XKm7C5dTOjHgotwXtgWyOcQjFld5b/+EBX5AQWVbwd4I0eFd1Ddve4usohxbySpu6m+KiOdPJnjqezfnKm4+BqC61CUHvQDMq36LQ0z4REHpQ1OEXK2WHWJNGMoBGiyIsMV5PUeHxX65mjVhPtRWH2P9f6FMi1qXvD09zHzVFQkc2moYkMHo2CdJtVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(4326008)(54906003)(316002)(786003)(36756003)(7696005)(8676002)(52116002)(8936002)(478600001)(66476007)(66556008)(83380400001)(66946007)(956004)(6666004)(2906002)(2616005)(86362001)(1076003)(5660300002)(16526019)(26005)(6486002)(186003)(75432002)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kErMEN8/80WMKHQ4jvsndqYoYr2VCS+lIYE1RvANC8uBAnhDUBKiBj5fNMXr7smDQGXFbqKeMV8hmKvfJZEP0ZLTtgrlI9J0/8b12HI2a2kMBMO3dIxrecbAezghdx0QLHPyeSEHHyFw4sKep0wnQAQxFv1CFIvUaxI6aglYKWCPVcYomeY3wFhl65fJvIh1vukdiOPfZ7UTjgStPcOga/ZgtNMzOsCxIkW0CYKEzAQVtjd/1r2sXL/GiGRZhmA49czW1IUyrU7lRkFexWM1AYSqHt/OgECk42r70haEadOkZ/U9flvg1BgQz/LGsZ5NipXexKb0WqHafwhHxflsmCvoIU2CXB1GzV/ISDLPc7Wo3tPP1Ry5IELQfXMRV/T8/llMLjMKua6fIh7CHgiEHZtEvvU5MNDaOb7iW98c/sC++5yhBbsao3v/wTwNx3FlucZQdVQXdezZZhTOJKvCZN/tYKf/zn7iMitu2gScEv8=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e95fe39-eba9-4155-c548-08d81d625de3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 01:59:19.4252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/UXECyiIn1ZR7HCxoIOR9E1H8ifCsC/FHOQhCf58vmGfuzK0OAUTUXlR8wun8rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3679
Received-SPF: pass client-ip=40.107.92.112; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:14:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

fix a leak detected when building with --enable-sanitizers:
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

I am not very familiar with the QOM, so maybe this isn't the right way
of going about this. With the call to object_property_add_child in
pc_sysfw.c:pc_pflash_create, object_ref is called on the pflash device.
In the pc_system_flash_cleanup_unused function, there are calls to
object_propery_del and object_unparent, but it seems neither of these
calls object_unref. So do we need to manually decrement the refcount?

 hw/i386/pc_sysfw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ec2a3b3e7e..f69a93671a 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -123,6 +123,7 @@ static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
             object_property_del(OBJECT(pcms), prop_name);
             g_free(prop_name);
             object_unparent(dev_obj);
+            object_unref(dev_obj);
             pcms->flash[i] = NULL;
         }
     }
-- 
2.26.2



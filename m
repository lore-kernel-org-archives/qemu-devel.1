Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACAC47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A65A20757
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="zynkbV7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A65A20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLC0-0008Ra-Gw
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLB9-0007Mu-Qo
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:01:59 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com
 ([40.107.244.98]:45797 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLB9-0007mk-1C
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTmdHuStA2vDiXplufcRTsY68QkGZ/hyMQkQr7YfQ3RLtLgPQzNVz0bho1viO6aabwWgOKJZKFCuBMzGR4hGlqWS8Y6DPxRvZUFLOR1DikYqn/dt79Hp4htyPWzioCfdnayANv0NGyHf07VpYAYF0IYaZRy6R8hMENFOaDHIv42A7aeyPuiAyqfB+LHUOk1LJYb7baVBiWY/+hechPV2HYwHGVRDbk7UNIWp5F6GrQ58DhMOE/8OTs+Z+Uhysb2zXYL46mtj/uSOT6sttQVdSpi2ybPkj1EQgbZESrMAF1G0KbRZHfHEQHmHP3I7lYrVpjWACb2fnTCqYVpmITMCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7FY7X0Tf82uRydOo0ch4U/UHz2NVLHI5HNmP56ejEc=;
 b=ZdBnwHq5CLkyUSuUxAvoCk7mojcIrTDklJiiNNLKOIMW9QiTYwcvec/yHo4iRdRqooAPpqitet1En1c22caJPlh186s/IYGr0KOAw1qlHXMXFP10jd0bBqP+rE/qSCC1ORad+FVcFrPBykyWDrZ83VZpFbzqgs+bD5eY6ZM+6F3romxFRjOSHasRfZajsokYrP187GwPY2igUGmYp0wmPSzJOCljdTbxmII+XExlAzkJjOVMtkVEikI3yhO0wBDpydYd5Y7I9cRhEUEvGIhyQst93TYw3VSUvKfYWcUm9HH3HNLgUWQSGFomKuNN9/Py3Xg7aIgehGrEtWutB9GbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7FY7X0Tf82uRydOo0ch4U/UHz2NVLHI5HNmP56ejEc=;
 b=zynkbV7GB3rXQ6OUXJlLpUPE1qo5/VvdocK1j4zQIcuVZ/5sajMVZImfMnCL69GY9Mri1LTeU7hgY6OI9aIvVCxFNlaAtyoujDDsW6FytapU8WmoWSnlSDlQSqeDqTPwImdFFdP6ZiC3LBDdMKNY+0MQWUXraBhJKaWelxD3Y/s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3887.namprd03.prod.outlook.com (2603:10b6:805:70::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Tue, 12 May
 2020 03:01:50 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:01:50 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] fuzz: run the main-loop in fork-server process
Date: Mon, 11 May 2020 23:01:33 -0400
Message-Id: <20200512030133.29896-5-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512030133.29896-1-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Tue, 12 May 2020 03:01:48 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c8d06da-fb1e-4b03-0013-08d7f620d083
X-MS-TrafficTypeDiagnostic: SN6PR03MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38879B58F65CD7A3A24A0CBCBABE0@SN6PR03MB3887.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1M+bAmMjbIiIjv6s45/c7LmiOrc+N+j+8YUYRvf97Q/u8btQ2hl/0jHvDlaOEYWapRi2yGECbpWT9Dgt7QJfimfWAsX0ZZ0G+ooUJdycddN4MXQF4n28y0z6hoe8ANSPVvsa6z2TFz5Yh10U3IXjh3o8ZNFxG2TA8vD9RFAsJzQ0JuSEJgoZrsxYyLFIpc3vhOO/9b0OhRDg795qRWM/8VvHn3OhIUmj/xyX3+qGvXfL0CuQPHMe7QMYGKtgVW41DT5hdGQko8ohlPmctVrOxArtNBV+5JY7JpXa8R1XOw4sWPb5t0cMqy2C3NsSnVbzxrWDX5gvsJKMHsfjLhU/uRLGJOTURK13k9cd4astSLP2VdXgUxrm+WQcUI94rEdXuSKbTSbK2Mr+egiAShCufUH5FmJHlC1m9HPuFUjFzEl2/V0dQCgCgoJPZkUztiX7nEnJICGSVlQSEdQAvc+x+bQN+KGKR8wuN3bA3EIoa5BA9Llw3GBg9qKsRgNAP1bNTSuvbRQ5JKZvWKZzvmnIBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(33430700001)(52116002)(66556008)(66476007)(66946007)(5660300002)(7696005)(8936002)(33440700001)(2616005)(8676002)(36756003)(956004)(6486002)(75432002)(2906002)(86362001)(54906003)(4326008)(186003)(316002)(16526019)(786003)(6666004)(6916009)(478600001)(1076003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /cY2/dzM1JmB7whmvt93HKps9yj/LHW4WtCH9ZgXyUAvChl+9pKLEzslU1AzHH5a5Nn62LruN3d+x7PNNlptLiAD8re29OtFMLdhpIHuT5BVzF8Phtr3v1efMbA7nV/zJSrJtvaqnozQ5PlKmoLtYtWVEmcwPpnRVAuySF6hU+vXgMBSPl3491SHuO86ZeKfllxd34vkNilbgw0bAQD3o0c0tpqrPuiz7FBHJ4n3DF/mFKcPeV7j86LdlICGaPtBB9rf1fAbvlZTc+f3KappNoQhiTYLm//w87jTZKuKlahxgl5AcmEtWN02vBWGH+mJROAsmMgzl96/JnaMJwcsyiqMAzDqx4LIW234wBmFK7qlhL+ITY24vUw1z7ci+0eqZGdCjcGMtuMfaRXH+BhOvzqnGnx9LrE09NK8Ca/7NghEqmBAOb2akFCMoO2MHKuGrYsbOXDexIl2t3NYBijb/ncomVKTRZZfmv+ovvR0GZ8=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d06da-fb1e-4b03-0013-08d7f620d083
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:01:49.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBsnHDoRgx9q2bUlurEWF4izZODeKRnXYeYttD7Wta3MzEQwIOOwAb/tDpDLRjLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3887
Received-SPF: pass client-ip=40.107.244.98; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:01:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this, the time since the last main-loop keeps increasing, as the
fuzzer runs. The forked children need to handle all the "past-due"
timers, slowing them down, over time. With this change, the
parent/fork-server process runs the main-loop, while waiting on the
child, ensuring that the timer events do not pile up, over time.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/i440fx_fuzz.c      | 1 +
 tests/qtest/fuzz/virtio_net_fuzz.c  | 2 ++
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 2 ++
 3 files changed, 5 insertions(+)

I'm working on another series to abstract away the details of resetting
qemu state between runs from the individual targets. That should relieve
us from needing to add this for each new fuzzing target.

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index 90e75ffaea..8449f81687 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -138,6 +138,7 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
         i440fx_fuzz_qos(s, Data, Size);
         _Exit(0);
     } else {
+        flush_events(s);
         wait(NULL);
     }
 }
diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index d08a47e278..a33bd73067 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -122,6 +122,7 @@ static void virtio_net_fork_fuzz(QTestState *s,
         flush_events(s);
         _Exit(0);
     } else {
+        flush_events(s);
         wait(NULL);
     }
 }
@@ -134,6 +135,7 @@ static void virtio_net_fork_fuzz_check_used(QTestState *s,
         flush_events(s);
         _Exit(0);
     } else {
+        flush_events(s);
         wait(NULL);
     }
 }
diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
index 3b95247f12..51dce491ab 100644
--- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -145,6 +145,7 @@ static void virtio_scsi_fork_fuzz(QTestState *s,
         flush_events(s);
         _Exit(0);
     } else {
+        flush_events(s);
         wait(NULL);
     }
 }
@@ -164,6 +165,7 @@ static void virtio_scsi_with_flag_fuzz(QTestState *s,
         }
         _Exit(0);
     } else {
+        flush_events(s);
         wait(NULL);
     }
 }
-- 
2.26.2



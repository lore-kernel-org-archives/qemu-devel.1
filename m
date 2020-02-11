Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B28C3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7DF20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="bkFaXLPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7DF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cNd-0001qw-UL
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG2-0006cW-Ir
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cG0-00005F-FQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:43233 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFz-0008My-4J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcICo4+IvoD98AyNUvcW9O8YchD73QLadfuwo7RIwa6flN7eQ1YNy5boeY2z8a6/PCUU1jotUVnlt7ZM7f/PExSG5RtYfaC8cGIBhxPkf6Edp95jq0+By3FOW5Uv34soHlPvyLsF6IOfPmV9eYvd8L8xLpGWtjPzTAs/u99fE6fAvYGjmQcuXfPWCTO7wp0ftywM27nbTQP0yYZX5/Kf2btdXkHK1raprraJjjv0UClqC2Wt/crf5mYgwW2FOjjmOVR844Hrl1CgpEVh9O2JxVSFvlGQ+ZIJ+qSsfI+4kd5QHhz2kUgNOGcqmrsbzp1bfkJx/pfI03fssPEiu3cNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc6c2BTDxT9LbR4aQZ5C0ASd4u6iUF/RXCiqnZY1tzE=;
 b=f5xx654CyjWf8WotWCLdU+xkwAx87i7ezZVDy5Wy+TWh8WbCXMiP6CyNDXYfLFKEqj13WVphWgOeKx+wsNSmhIH9e0fhNmrZUyEX2e3HIXbfHSd2CCeHnmp5OMfMESuyNVig+TtjLYYFWxsKX6oMTnhBpd+P4u/5mlkJmiUIMsgCWpcEoYmZndF4kFQIqr5KxDhJtXDdI88b8XEJLtaiCFZIOdKPstKkC2Fin3TpdDxkryzNDaCgwOjQ8u99Wuu/zF24DgvA334Hfy1aZTPU1QcWn+MVZc8+9UwTG2PQhL6/4WzNq2FwBZ8/nE1R/krrc+qB5NYkqVRdLUMaAsXBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc6c2BTDxT9LbR4aQZ5C0ASd4u6iUF/RXCiqnZY1tzE=;
 b=bkFaXLPO6UfThWCGVCf6PjvKnATu8vj5cDsl62FjBJ+mASeWUbqoQSs8X+TWRBG8zhQ75krbKTfCCbxU/0ELAQpRrI4kq1uTonygqNnF1Z8uFvOoMHUf6lAPW0FcXFo+oF7riuShAcApLxEzaoJNZgSZ6aD4FMwBTJOHy0VWFSY=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:38 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:38 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 18/23] fuzz: add target/fuzz makefile rules
Date: Tue, 11 Feb 2020 15:35:05 -0500
Message-ID: <20200211203510.3534-19-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:37 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 363e6caf-a965-4563-c3fb-08d7af31f40f
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336A748C43A2BE522A558F3BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHNZMvUNZU0hDqFoGA59F5DMCwkh9lr0mG2l2mJ1GVN0VednMbFiQOIbQ39IlgtbBtU1r9WhwFVVCKA3C3VzLIS/gu79CCU5v2yw4EIwuiCiViR1LsoA0al3rdzDk18lJ4MeECFfrxy3F6cxkGIN9JhhMI0JmVwItOgVvEslwhauDYTB2woEu+oIloCh3sepWrR3sTnsLYId8pDnhPN23HBts9lz6vSnbeBMCyutJJSX2MjSto/uaAbx0jgNl4433ybK1dnRILw3/hG6gZK3bqxgAr6jOkhLzGXaX50rMfy++3bmD4gdsjW1Aa+i/r2hcF8rZI2g5WofjgRte69VgzhdzI7Mo5IDytKZjew7szrNqqO8W6yrWeoFYGWMTPklxtSbiXvXGMD+OywxWX8sTKyqBpJkyc+VzDhlnBRIm1NbS5U6dCxbjAeKBJJfuWiB
X-MS-Exchange-AntiSpam-MessageData: CPOMyA2/HzSQyz/7eEBQ54108UhYFRFIJNk15h7wD4MgePN9GJwSiKoomNpo1GB3XUXKF61hxhb35kUwj9R5fHABge6AeXc3Ye9SFwYr7Q4Dd3p3p0j0dkYdcRg5P6EC6vkNUO9gCv5d1/GmctnJzg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 363e6caf-a965-4563-c3fb-08d7af31f40f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:38.1385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLMiVjWdeZmExandjFITxXuSjpqz0TLBclLFHD5/twNBiC27/PefOcZdIIwFfOnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.69.106
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile        | 15 ++++++++++++++-
 Makefile.target | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f0e1a2fc1d..36ca26f0f5 100644
--- a/Makefile
+++ b/Makefile
@@ -477,7 +477,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@=
")
=20
-TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t), =
$(TARGET_DIRS)))
+TARGET_DIRS_RULES :=3D $(foreach t, all fuzz clean install, $(addsuffix /$=
(t), $(TARGET_DIRS)))
=20
 SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
@@ -490,6 +490,15 @@ ifdef DECOMPRESS_EDK2_BLOBS
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 endif
=20
+SOFTMMU_FUZZ_RULES=3D$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
+$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
+$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
+$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
+
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
 # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
@@ -540,6 +549,9 @@ subdir-slirp: slirp/all
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y)
=20
+$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
+	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -549,6 +561,7 @@ $(ROM_DIRS_RULES):
=20
 .PHONY: recurse-all recurse-clean recurse-install
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-fuzz: $(addsuffix /fuzz, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
diff --git a/Makefile.target b/Makefile.target
index 6f4dd72022..2d43dc586a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -228,6 +228,22 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
=20
+ifdef CONFIG_FUZZ
+include $(SRC_PATH)/tests/qtest/fuzz/Makefile.include
+include $(SRC_PATH)/tests/qtest/Makefile.include
+
+fuzz: fuzz-vars
+fuzz-vars: QEMU_CFLAGS :=3D $(FUZZ_CFLAGS) $(QEMU_CFLAGS)
+fuzz-vars: QEMU_LDFLAGS :=3D $(FUZZ_LDFLAGS) $(QEMU_LDFLAGS)
+fuzz-vars: $(QEMU_PROG_FUZZ)
+dummy :=3D $(call unnest-vars,, fuzz-obj-y)
+
+
+$(QEMU_PROG_FUZZ): config-devices.mak $(all-obj-y) $(COMMON_LDADDS) $(fuzz=
-obj-y)
+	$(call LINK, $(filter-out %.mak, $^))
+
+endif
+
 install: all
 ifneq ($(PROGS),)
 	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
--=20
2.25.0



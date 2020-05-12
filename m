Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02ABC47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C4D2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="WiJYxc01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C4D2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLQc-0008Ku-3h
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLPZ-0006Py-Oo
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:16:53 -0400
Received: from mail-eopbgr760127.outbound.protection.outlook.com
 ([40.107.76.127]:31527 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLPY-0004LG-Ld
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr1UwOqxSOtAI0tRLtsAUS/uxh4pCsImTKtv3Tq2kLEgm+JXh373boOK1S/FO/J176itDfsFsw1bf9639o8d8O513JjFLzajkqn/EB2yw6IluIIPXYkFjpJIsvp8Q3wUN9GQ6jSdGTDa8Z3V+Nhn0x/iPjUcXltwFD9+eGzVVZ36JqEFAH+h+98XPc6OTwzAYQ9d7U5JQ9WxK+0LfaxNukjjBApLe80xkXf2yKgdf8Ww1eGuuKyU1WVo7dcjIVksy6SYA4+c7z2ze+d9qxEs/jQWHr5CjaYa/vz/eMBzoiL69QuAxVfrhC+T08NHathADMBOQADSePaplcklATtXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGaSeRQUISb5Uwe8EOB96n3Pdqu//yfXGtekUZPMv6o=;
 b=RX224669EljXTEvRg2aMX+oo10ZAhFQ8+QO4p5o+5KlKb6gDov6kWJ1zolW8HSghvDgGkd0od/7DahIW2sn/mM+LCejykX/7XlzrwI+v7fWFG11JNbLMt2uDCObAlJbj1/SpfcrGSxfZuc+4rN070i07c//jc2tz0MqM5o8tFOdqv1NJGxEfnFNWHetaDWDSaXHWWKBjN/CCEyZ/CP0JmKZcdVMbNJIRtdRwCuvVjrzMklK4XBxgMNjkZWGkU/yWW5Kq+VIpNuAj/oiYC52YtdKGSPOtoDRY15qAWZg+Eeck2n77uVIeEetg+BAJ4JpvoscxdsvFUM6qeDPmt2rYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGaSeRQUISb5Uwe8EOB96n3Pdqu//yfXGtekUZPMv6o=;
 b=WiJYxc01SdFDyL+NWTpJ9rAE1GAP3SpQTieqmQgOqleZxYv9NChbqZTYWuhMCpQRH83KoQn4EGT0Y5mzqbGbIVh7iGfGT1zul5vI3D6UolwiKZlECVnJoLzeooZcN5YQ5GuYa1xmPdSZRceGGNs0DqpYHgNbtFpaLjDtC3KtdXQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4176.namprd03.prod.outlook.com (2603:10b6:805:c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 03:01:45 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:01:45 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] fuzz: misc changes for oss-fuzz compatability
Date: Mon, 11 May 2020 23:01:29 -0400
Message-Id: <20200512030133.29896-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
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
 15.20.2979.26 via Frontend Transport; Tue, 12 May 2020 03:01:44 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28679fce-fdd7-4c83-4c02-08d7f620cdf6
X-MS-TrafficTypeDiagnostic: SN6PR03MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB41760EB01E318332B59006EFBABE0@SN6PR03MB4176.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74HS4UtTrHswb817hwds6pTfJWBLyloSxDq/0StN5GZPSO1sgbKQdSRC1uMWdIx+4yM+1Pi4WCXSL2HmAEXRQbpFyV7rU8oYdo5NFXzDuvpQYxugrIIE2A0x5wblOfHg6jkV5TqFAHSUh6KUSL14xnPPTeocxStDD1jLWCAT6xICbrfcGMMDMaAT5f/U3Kkr7yr4yOaFvmbBjRMPT/WAqRa4q/zmv4XP/RIhDwaswY54U+Xif5anUOtgXcGzT8clHQZB1Lk3h9iGfURQK8dCPxmjIg7wDP3AiECyBZJVlA6w8H6EAxJ9b+9BWLeZse+9uBx1Go6kk4JwSeNhmgqyjy+pCiVbNhZm/pCSFz5j5heoTF8Dzn6c0c1cUu69oBtHDtvQWvAOHIVl2hi1gpmSjGD3lBHPVwFJvsfQFOfPk9zynfN7iV74WHtU9GuAueARagnU/vYZyV6ReVanBVkfwaqbbYWAlYAMLE8ucdIr1ZMdArvxAyauqitCB9W1TpVQ0BmK4Qtypx8S4H0So/dagQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(33430700001)(66556008)(66946007)(36756003)(956004)(1076003)(33440700001)(66476007)(16526019)(186003)(8936002)(6916009)(4326008)(6666004)(86362001)(5660300002)(26005)(2906002)(478600001)(786003)(316002)(8676002)(6486002)(52116002)(2616005)(7696005)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 626/l68SlLFm4IUloye0iILurbpYRWpO7Ft4UmTQLIfU/F6Cjs0ppH9wT1zsBTfHYuFjTuEMCWVBztgCuLUYQCfEYuTsJljMotV0qSeaA6BR3WDhqLxgio9wSp7S8ZaNaPzUv0GFk5gUuVSrRAFZ3B+Lc2bQvHH/L+GLQQB4UY1X3X0DejhHBciX9gBCmo5Jl0XlB8mT/CgPwMc7ZuFe9wydt4hYnM5DZ/GuibFGs1et3FCT3moIBgYPZlmndf1f7dnHYVswtkuLQKEIzmvZAvj9D3T+loi+4pWNfYNokQLM8q4x+xTupd9l3Lxc8YvvKQM3W2kbR1hLQJWOkbpBxUtverZUFF5wBl2RlF1TnEIH0SoQePeiZWNRz3h0/s3sNeXDvHt6Nbad3g/J2q9E+BnwPAOO0Z2zz6Y0+o9opaVV3nmYCr9lw/5PgbAagD3AVee5QEIIj1Zt6AjYFiYhf09SvIforpZqFNtIw9epmYw=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28679fce-fdd7-4c83-4c02-08d7f620cdf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:01:45.4489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byhs0yfKy8nQHVKqmJNuGFwiUD7YDsqpF3kKUIzDWjA1mbD2I7ri2qSo/G6Ufqe+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4176
Received-SPF: pass client-ip=40.107.76.127; envelope-from=alxndr@bu.edu;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:16:51
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
With these patches, the fuzzer passes the oss-fuzz build checks.
There are also some miscelanous improvement to the fuzzer, in general:
 * If building for oss-fuzz, check executable_dir/pc-bios for
   the bios images
 * Fix a typo in the i440fx-qtest-reboot argument which resulted in an
   invalid argument to qemu_main
 * Add an alternate name to resolve libfuzzer's internal fuzzer::TPC
   object at link-time
 * For all fork-based fuzzers, run the main-loop in the parent, to
   prevent the clock from running far-ahead of the previous main-loop.
-Alex

Alexander Bulekov (4):
  fuzz: add datadir for oss-fuzz compatability
  fuzz: fix typo in i440fx-qtest-reboot arguments
  fuzz: add mangled object name to linker script
  fuzz: run the main-loop in fork-server process

 include/sysemu/sysemu.h             |  2 ++
 softmmu/vl.c                        |  2 +-
 tests/qtest/fuzz/fork_fuzz.ld       |  5 +++++
 tests/qtest/fuzz/fuzz.c             | 15 +++++++++++++++
 tests/qtest/fuzz/i440fx_fuzz.c      |  3 ++-
 tests/qtest/fuzz/virtio_net_fuzz.c  |  2 ++
 tests/qtest/fuzz/virtio_scsi_fuzz.c |  2 ++
 7 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.26.2



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0DFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 22:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC7422403
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 22:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PExQ8t5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC7422403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka4k6-0007Ye-MU
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 17:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ka4jH-00076C-AB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 17:24:39 -0500
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com
 ([40.107.94.84]:13920 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ka4jC-0005pp-2r
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 17:24:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+HalQbOgdS38xQKDcha8Q/OPq0LyoEuRHwXWQbaqD6f3C17l07bKSWGVpShoZgY3+gd3X8/gzteBcwJaQ2R/rDCUE/Y0CYQiD4BRWVG2r0dchFM01PlE8MfuDz3Mxvat0viGXTJXxaxS9Re+y1MpzomlI5eHwRHrkERXEMeGHSN3PaAT3F/H10uFaNxw2nOVQ6ytRB+G1b5wiPDx+atuKTMnW6NrQjI9C6vtrrGFrY8Par2OBp68in0Z/3qrjX2FSxlYAMytoRf0n5Mqq3V5QvplCq4WIdINyNlyLnAAz23W/lmwJT5FOxdCYyFWv33pdCOHcSE6h+mnCL3k/7gAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXd9ko+taY0pzRt0ondzb6odNnr/WA0l61MovVaSkec=;
 b=B4WtcvoqA2cU/IdPFGzxLSR6HR+2GPP4Bukyaim6f9Y5qvufPmSBatZITncrxSj/tWVWTprcBP0+UODf7i4I0d/NVTzBIjjluC3JqmS5yB1VFtQb4p9bU4FzZL/aOmJFPjrl95EaiPQ7Hs1TWiKlzMWjpGaHUY3b1/1ZM5iLVyCcm7awpxTwrhLYoFG8PC/FxlpdY6B3TM2qoCyvjWRA8I/KKOA0kGZL+2n8L/taaesNS3ciyHPUHh10yJa5iIUmb5m+J61YqpUvxNO6DmvU9mZWAc15wqDuRHQ8JDGbmsyWi9A5UIuh4E/zbYVW7wCalelHK6+Tyr+Mg9VClAwRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXd9ko+taY0pzRt0ondzb6odNnr/WA0l61MovVaSkec=;
 b=PExQ8t5oCw8SZJcq1raXC4TG7oZX6M6u5xWULhV0dz0eohRh4+Z1+TDXoW476pG/kdLdChnm72HNdb6Itq0+M4GFkfMGEsMVi2AE8EVqhd4chn5xrcGHrcChdt3HLLsaI0TynOAf7Wu72Qc8GqeHsR7rfGwGkAsHJ3wDDMjFQkU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4646.namprd12.prod.outlook.com (2603:10b6:610:11::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 22:24:29 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 22:24:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 5.2.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Date: Tue, 03 Nov 2020 16:24:17 -0600
Message-ID: <160444225713.930780.6451462811566209171@vm0>
User-Agent: alot/0.9
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM3PR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:0:56::22) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM3PR12CA0054.namprd12.prod.outlook.com (2603:10b6:0:56::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 22:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f712cd5-e332-445a-f6e8-08d880473ae2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4646:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4646963B65A30F583EF0E7FF95110@CH2PR12MB4646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeRFTFzEVgHOzUW7CGxDQUb6xbSy6PYE4qQrYJo8InVoclRqXeYhF7ZluK/Enpa5HHffLyC3ITE/G5XEFTjtN2Ls2QoNdGKVJ0IesYNAc0agdqraZDuxcKUHmXA7JUNHRVA3Md/TSkEXnwzdLvJjl26gxirwO9XQNVigD9kza/4QbaW1rd59VnWnW2hwUCc5lk3VWlm/3hjiaZbX6pZy6t5zw1ZfjZC2yWwbfO3H6F0a+rtGGBjHE0kLZoeqSnJaseEUzqVjUiESXV2nNXEqsJXtXocGZ4mUoRq+INwZclcI0pLrX4zzjIqqQ1aFFTbYbF92gDVB+33cFQNV4sfBjjNerrH4sTZO582nD7bspFa6N6pj7cfJ003RmeOEKDxelJuO6IEUTf4Ji2bLAISzGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(9686003)(316002)(8676002)(6666004)(52116002)(956004)(8936002)(6486002)(966005)(66476007)(16526019)(478600001)(66556008)(5660300002)(6916009)(83380400001)(4744005)(2906002)(33716001)(4326008)(44832011)(186003)(26005)(6496006)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4dxJHZdHi5lw2LmTruX6lMulhcf9GWJFtgKAd5mWCaxLofWQThsKrqWEStUwcp0ig5wJ+gSw6C8SzxAkzbOnWUEO3xBAjAJU4wjyhA8jRAsyZMsHokaoPwQFc5z++6r8oEWWsEKZ5LfbzHaAlGPLU+y2Kn7eaI6GAuHDqyPiHaTfwCLEWDvwVATAtCVJux3uHFMF+NH9T5FAZAVsBQXu/7ZFclOYMueDFCi9xoQPgCW9ieRKZA376JA2Th5C+21sUlXXcMiuh3UFzj+1vdTfGF2PP+gH70oRM8hSNy+0OviQFLjgjqMW5OP0fQ5jdWjdlXJYXsksJaeRgofEtZGQN8TUpPVjW/AY5nVzk0CWKUm/0sVlM91a/8OjndHe7Iz+5Pr4IZ1VPDX02KQQlZlWsbZBKQBjs+4QcC9LU39SSK0YE9BSkqMo0SoKSQtc2ePy6KlYYNfsGCL+RpZFAF1Iq/3KWLsm7ibP/KuvcmV6JuxlvxjzSNz7Ne10JONf3shCZzWFS3krk4svildoPv8ouQITn5q5JPMUi3RsYh+WKb8lPsw0T15Kz5SNRSMaRl+q8a8Q0ygBdf1cMDy+XQfHSlE8BiCa4DrSndhPUmtE9qthkVU6nsUoSWIXvPbLuoSQgBxWDC20zpLDx+Fj4eibVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f712cd5-e332-445a-f6e8-08d880473ae2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 22:24:29.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6J6jICBWURyTnAeW9b/wctcyTDHiAz8DxZRlJXJSVO2sNMX8Aqzm8KDOsXQXN4tmBPLrMRVNeoBkdaeF+NylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4646
Received-SPF: none client-ip=40.107.94.84; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 17:24:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 5.2 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.2.0-rc0.tar.xz
  http://download.qemu-project.org/qemu-5.2.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 5.2 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.2

Please add entries to the ChangeLog for the 5.2 release below:

  http://wiki.qemu.org/ChangeLog/5.2

Thank you to everyone involved!


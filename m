Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF2C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC6E206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Yz7qXNaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC6E206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLvP-0005Jr-V5
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLtp-0002rd-Ui
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:48:09 -0400
Received: from mail-eopbgr750134.outbound.protection.outlook.com
 ([40.107.75.134]:42296 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLtn-00087Y-SH
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzzHbGdej2oJlSzCUpqGwayKB935rwsy8HhCCOA9d7eVBP40olk3VqzUQkrTKwnhiIXvJrUTdJNoT6lkLlpXopfqlLwySGxSVdforQGfzEaCXr+vuYDdSX9LFDUZhrEgHG5bQSj3IWaVpF753QuQOgeU0+n4ZyTBfPcfoAVwGPeQXpFatEeho/JCfRRF1IGBie2MVWOoCmKB++1LB9JBeAFobTlgI9jzhTULhVbuwxAe/d+9RK1C1Y6ZGmfVah9K5GwNBchwMFLjb/rP0R/GGdkW1vITUcJs7YCFGCdGFPBXX64r1hW4C8oMya6qH7bQG2ut/gji4kDW2VzmL2g3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIwMKLwEtszbkbukGhkTwut0u3c8pjf3tS1vbdngRKw=;
 b=XkMYb5kWSdH9+2ymvdHs1fEPbj+CWEMI1jPzx2ZltbB4XCCiuOAHatXW4mcPkBkV6mzOC3DO79qRsGkxJHMNxWmrzZ4WuKhVl0R+U8Rj4zW9GM7HYeCsYfs1agGPmy9xBjq6bONYZeDvZUuZEKScCehXPuDr3Aoq7VC/R7y6xN3BvZ4KjIpjysb8QX5eY8vBRaomWmRhz0CQJ8c6zHTItH+rhsYtR+D8rCtHXi1flBfnlJehQOYpUO5Gjx/bxuTXkmOB4lgx9EpbITUCkLYBtrkEaTc5YaUWbKSrcmt+MJzlF16g4cDOpY0G/+AKi2JYHYRC1bFirFsZFPsMf8QsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIwMKLwEtszbkbukGhkTwut0u3c8pjf3tS1vbdngRKw=;
 b=Yz7qXNaNGQOUQ28IwRdN4tj0MsDWUFzVIZ84/3GdP3Iunh8H10iEJL9YsTjFVqlsvPkrVWCB93YdkMMSyi/pybmQwuKJpoODaG7Z3LbzfhFxKwFZXu2wodpNCKASnaNgyixn+DvVWqPO+fwM9WwqQeuefG8N5o35SQvzUwEilfY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4368.namprd03.prod.outlook.com (2603:10b6:805:f4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 03:48:02 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:48:02 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Add pathin option to -chardev file
Date: Mon, 11 May 2020 23:47:48 -0400
Message-Id: <20200512034750.5773-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:208:1b4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Tue, 12 May 2020 03:48:01 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbb81ca2-ccaa-460e-71fb-08d7f6274504
X-MS-TrafficTypeDiagnostic: SN6PR03MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB436893214D3286079D147E26BABE0@SN6PR03MB4368.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSezWlP6HusxGSxb5dXq9E9Dx3D0CGGJscQGSPXnDMHtQxKkZvFaBeHngFq5H8261+BbcDBgLEHQtkIK25OOxScd14YE9Df8H/rAFysz+AUH3Ie7g2L9GMVe8cgbiEE5Gv1Rmt97kSoeL1R7JFDkFSmvSfgJ+M6vj09eVTHTN+7BQTvoW2Btfu7tN2MbuZiqAGyhcttaraiOTNkU67BckJdGwGFZv8RioW/j1jN62TbgUks8fBESr7COpTKxQx1+xGjvqB/xh5KQWrECesnSN8vZXUMPJ8HVs12skPyVbqzbBQTPjFcHFsZ6/ky/pqj9bRNl+Z3wwprfKZWE7z1GdVKCt5C8ATKx/By/mc9PqMkC7GSqQuku9Zhr274ckhoCOeDIGbaFH0OhjLwFogqAHjKlj7PofrkB3QVVadeJ6g3leNErpb6UPTY7yp+4KPHivN0lXjYnY3HsZlB+U8iel1TUYBO6JbiBdrf7MyQVdQP0nlVr1PevoOA4Ma/qNtj6sZOXPtX3d2w1yVNII6nIzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(33430700001)(6916009)(316002)(5660300002)(786003)(75432002)(16526019)(8676002)(26005)(4744005)(66556008)(8936002)(186003)(66946007)(6486002)(66476007)(86362001)(6666004)(7696005)(2616005)(2906002)(52116002)(33440700001)(1076003)(36756003)(478600001)(4326008)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +43S2bTMvzvHIAct+yYZ3sZS/FfVwm+V2OPkoCgLgPi8u6+AEgG7XszB6CT6z/ibCNEhQd7nQy6gHl7fFakRJx3TFIe+GNocJ6oV6RN28wxTNe9UIoB/DSyBgh7FgF04ObWEuVJzEhGOWdTvgosKdw2glbI/zldier9n6/lAfTPL2dsSceH/Zvr+0WFRCFV+IAuxhalCMGV8FI5HV1X985cUIqh1fH6ZAuZYxyml7/LgA0alMwbeSE1AljWuR0qxZEzFVrENO6oSkBH1c0BKSXn5ahppXnqsbdLcbJp1xa1P63JDGYQTKVbCPvOwmUmanUooVJXd67RpFnKYfw18nvy5G7BH8+YihVrzLYcLYDM8BARwasu2z6QB+mueFpCDWhOxt9GmKCuZk67a+vt5YrKzCpYKLWORXpYPDxqjJH60DSGZQwkl9Nx/qjkaWbo1Su7uiJ0Hk2Tu2MwwcyG797IBL1Wpbs+gvdp/WgKi2Y4=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb81ca2-ccaa-460e-71fb-08d7f6274504
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:48:02.0809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaWlSw+uq/9DBd+obqZ1BHvS4qGXsQwOSGP9h4JMJ0i+mhWjqiur4iOYGzgVQbod
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4368
Received-SPF: pass client-ip=40.107.75.134; envelope-from=alxndr@bu.edu;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:48:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: berrange@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 darren.kenny@oracle.com, bsd@redhat.com, marcandre.lureau@gmail.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a pathin= option to -chardev file, which allows specifying
distinct input and output paths for the chardev. This functionaliy was
already available through QMP.

v3:
  * char-test: add a stat()-based check to ensure that the pathin=
    file is not modified during the execution of the test.


Alexander Bulekov (2):
  chardev: enable distinct input for -chardev file
  char-file: add test for distinct path= and pathin=

 chardev/char-file.c |  5 +++
 chardev/char.c      |  3 ++
 qemu-options.hx     |  7 +++-
 tests/test-char.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.26.2



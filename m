Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37ADC56201
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8CD20738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gvITQCIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8CD20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJiK-0001lm-V7
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvc-00076i-9K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:52 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHva-000447-OV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0eybSBvtm6aS2QghkwOOLNRxq7YudSiE8t6yw/A/tbpFOM/uE0y7nZXd4RBIPOVkeojdoitCgwADGIn/Iouu4B1SHdLGg3Knp/mSVGI7awm/FvPc03XzSjs1jznIwbjOWsyk/kXBiiA+tjHxJDj7olO29oj6bY/YQjldw9rLtBtCA7fIJ29QQVMQ2XYVyg8jgYzwGbYz44Q0XKI1IRY2cuNpZ+4YHN72zZqfR+hep0Qwh/k0vmZu9APU7TC2d23Ec4qI0bZ8H9BvNEp0E8pS18hMzGGZW32YNVaM575vYASZQlzQ1R9TAnNPklSo7YG0FNmaO41nUVT5rp22JuAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkavu4ED6Wfu13p+JPvQN1u+LQUI77K5Oi985yQNcME=;
 b=aPSYoRXzQrgRAuyc8LzMaDnAUQRtYRS9zjH/HAFgX04xtAVh6+9xBZ1FKu0AS34yPoSwNdoUwbfkUExaN8ERWOClcthuMV8Zm5Rz8yZ3d9Dyxl68Zppw36kqpx5yxtYoVLS950IIqXlyIiZZPZ9rdlnVYGTDWHDNFzApiSdz8ZDuj05q/TedbACGxICGH6nA1od92Y9bWR1PFq+g1iXHyCIUpCIcJnxHDqnYvRiQzmaN5rxFzzWs/Ufg/faOFujlC6nGEaUj/IZKrsM/sgJKXWlm+7HNBkASJFuxNam4PHVLQFFhUZ+oV6abqS567CeLLSYVGXFNddd5/RIcaUVlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkavu4ED6Wfu13p+JPvQN1u+LQUI77K5Oi985yQNcME=;
 b=gvITQCIVu5Q6Dm4cOrBMUUzyw8gQQa583QX1omtO+FIB15W5FTLUHG6nQ83WnM+UEItoylWqRepa0azFNlXeoH4MvwgXlYR/B4Pe5vIqU8o4EZFz8ReWFz2Ctn1Qy3I4On45qidEhBWXs44CqThRpNtkcsEucYT3baBr4/MirzE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:39 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:38 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] qemu-ga patch queue for soft-freeze
Date: Tue, 27 Oct 2020 00:53:05 -0500
Message-Id: <20201027055317.351868-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN4PR0501CA0028.namprd05.prod.outlook.com (2603:10b6:803:40::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend
 Transport; Tue, 27 Oct 2020 05:53:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f617e6a3-7eaa-4096-14c2-08d87a3ca6c5
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5004F0CA2C5EBF9ECEAFF6C995160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NO/lRA7sWPzeX3AwRf21We7W8lDeLKfuFI8cIrusbUPbErVCz9R79oxpY2BvN5zh9ivAc5/xggue9fxA6lLsI/iiGmrQsP1cYlRSPKrwKxmSNM1HVHvCf0mI9vvR8I8Eemq0Chr5GJV/8v/taC8retFAp7c/cZ5Ihm8H70KHNvfxA7MrJ05gUNRom9K6o6ozDjHCSgDsO+dw2a5I/x5INWA/1GzfqNLh3RZFyGPQfRBkBTsMiDnMPYGzeyvf0lGvPskZniuHZ70jttIbhFE5/r2Ko9u+ikSJz1SQMIivLW29rsxjszYQFN7qtxyVTTIUmKbtkfMjsiJjDHAHJ+Ajaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(4001150100001)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VL8SMZEV6Uts+COGiL3M5Mh0o3GLLMD3YYsplqLS3/v5Oey3SHXLuonKFhC9jk3HYmW1ueEWSDjJkS7xu6cqA53x/rbaAXWpyrGiigSqn3tmd64uYBrtulZ/PFNm+NrCF67lG7Fb7s8tuCJ8tQxqDYQkvKBaKNw+xUJhm4BUq/6BEStItB1/eaKuN97WRuALQuIbQTZBnWtfyIWmfT234bNZnPc9LJHG/+3UhIjOlARKuzMqVCXncv5S+P6JisJBt04Qtxvf86l5RtA2yhgwPwxQ97I3YL246bNjH9mXf8ZKb+0UGN/Iknu0UgcrQpDlnLul1exzdtZVJP1+trkQJsobujcS6Y8xnorN+IxRnZ3gX2L4W89rOeMI0eJTLKuddtW4N9Grw+wDvZZWJCKd3hp8XK7leR8JM+BoDHzxitgp4pZyNw8WilpI00sM485f2oFOAKS/o74bvlqAPG/tZRz2X1aTIeKk0lmwih2ghhn2pE9Q1A6Q2X9bDibmSvbBkOPlDBZ3KtgkBnuQE4mJ7CGnAcMg4+9anjtnbjJS6mId9KfZxpVNOZGeXJAYpeZNF2hREZV2DfXKY7lUFhR/rQ5tRCqRuTmPkYDZLOaxka8ZMBfUeGvrC84e8gJkQuRrvh2ekmo7pw1ojxdgSHO1zA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f617e6a3-7eaa-4096-14c2-08d87a3ca6c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:38.9237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tztF6od4MNLGcQZXsq6xBVTDq6+TfDU7klqB23X1p98Pt50tlx9kB62VpWqtSzDR2PERqATIVlJaUHrP8xVJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.92.50; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:53:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:21 -0400
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

The following changes since commit a46e72710566eea0f90f9c673a0f02da0064acce:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201026' into staging (2020-10-26 14:50:03 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-10-27-tag

for you to fetch changes up to 568979ea819d945e8af6c14658793b58bcd4485c:

  qga: add ssh-get-authorized-keys (2020-10-27 00:22:30 -0500)

----------------------------------------------------------------
qemu-ga patch queue for soft-freeze

* add guest-get-disks for w32/linux
* add guest-{add,remove,get}-authorized-keys
* fix API violations and schema documentation inconsistencies with
  recently-added guest-get-devices

----------------------------------------------------------------
Marc-André Lureau (5):
      glib-compat: add g_unix_get_passwd_entry_qemu()
      qga: add ssh-{add,remove}-authorized-keys
      qga: add *reset argument to ssh-add-authorized-keys
      meson: minor simplification
      qga: add ssh-get-authorized-keys

Markus Armbruster (4):
      qga: Rename guest-get-devices return member 'address' to 'id'
      qga: Use common time encoding for guest-get-devices 'driver-date'
      qga-win: Fix guest-get-devices error API violations
      qga: Flatten simple union GuestDeviceId

Tomáš Golembiovský (3):
      qga: add command guest-get-disks
      qga: add implementation of guest-get-disks for Linux
      qga: add implementation of guest-get-disks for Windows

 include/glib-compat.h    |  26 +++
 qga/commands-posix-ssh.c | 516 +++++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c     | 290 +++++++++++++++++++++++++-
 qga/commands-win32.c     | 140 +++++++++++--
 qga/meson.build          |  34 +++-
 qga/qapi-schema.json     | 127 +++++++++++-
 6 files changed, 1092 insertions(+), 41 deletions(-)
 create mode 100644 qga/commands-posix-ssh.c




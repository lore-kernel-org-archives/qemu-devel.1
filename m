Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BDC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713F922243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PORmHTUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F922243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZkxK-0000Zp-DN
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksK-0006PH-7Z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:40 -0500
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com
 ([40.107.94.58]:64832 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksH-0005WU-4U
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:12:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCC+LGg/1X40rRsnIggDw+4slFTjSoHs7WgLbLFWl2VYQjNc0H+772L8zNfpoF8wXJL8IVIidk7f/A3HukQHxeAx1ovbacbuYRoOXjamG8qsx65hsYHxOCx54U57I4LL+AmjhbHl14uohc8y/sfP0YlPvQLxHfX1ruqj768zynsoPsLHrNDBO0cuS+EdiC1rwwZ+eZgl9jZb7xzcBuN+s2UpcOyzdKqALJkTZNGUKqt7VeOiJgV+t2Ju9iqW5MIRs6VWKLV2oKwJGpjQ9q+SHDF6bpH9GP2pjiBesLeRraf1Zxc+C94TqethHhhmyFgRmqzSY9D1bNA5lGs+zTps1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt+1p9pHu0cTvazHPIfQaDfV5VTVQ82LxfjzB+yc+As=;
 b=XJvaFEy+uEXKU99/KQ2wlBX8X8YouRJbf8wIcDPcTGeQjbLeS1mGDtsYOua2iMAZ0sRwqZruERE8GRYbdbm+9CnmzPmW9eOaAf/QF5c4lk9LFCtRPsbZpIZJeQrfTMWA8OVIgctLXB9kALRvzpPqxWfyIxD1WsmECP4CeF4tI+XfoBASYjOtQzG4Wpc+YiJJiiWSoT4Zo6Ht85FOl2OaK92LRbuT/pcWtY1CGAoy54Eye5fd05+pvQmXFHpI23LwW9Io8+nF7ZOLejNU5Ww5nWa6oUr9r64wUllSSDG+NtX2Ixqhwv6G+OGje85s+kv1hEo+IyGqqKdZF4ZP3VTV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt+1p9pHu0cTvazHPIfQaDfV5VTVQ82LxfjzB+yc+As=;
 b=PORmHTUI18kjbjCM9momXQnOn+uY5OkARUj+jfKPrukBHAkSfdqvN4uQlrJgDmDiT1/ZElYIcobPWzs9qaefkrIVDQGcLahouCB5oNxiLHGpoubuxr7z/5OTRIjBSfeOxNVA6ihGcFjB2aLxQBvhBWfQ5bLdHiyqRr8D/epaqRQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:11 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:11 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/12] qemu-ga patch queue for soft-freeze
Date: Mon,  2 Nov 2020 19:11:22 -0600
Message-Id: <20201103011134.887744-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN2PR01CA0001.prod.exchangelabs.com (2603:10b6:804:2::11)
 To CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN2PR01CA0001.prod.exchangelabs.com (2603:10b6:804:2::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 01:12:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ae3e8d0-05d3-4b6d-b9a5-08d87f957ddf
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50018E290A0895D37658379795110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvLV99+u1ljnbO/rBcmJaFhQ/1FGJSyPVpYKftevrN6XHsbPpJdeuFD5xqyzmNuFFlEDe/OJk9UtRGLtW2AnexP53dz5ygaH+mpVT0IaiRUHkqD2AMv3nIYx3vbQRI2wymERoj1dk55pNgs3nzl7ZVKTD9wUQMcCYOtuffrdNFMfk70DaQEI/TtdyHTAirRWRolzLzjjecWx3rbD7ClijsGgzPDNi931dI2WY875aE8cC5G7MYMQpmM6NMH5tDTGrwBzKSqu0CcDGptCCeyvBMZgeRzL0UQ/J0UcwLAbT//D+KthMoq3w1Bix2UN12+OKiAWz9KgPqa/I1MSv/iE8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(36756003)(4001150100001)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2ccfMqPpDSF0z8J2uJkx3aZLg5oQC2mKDz2jY0zC+pdbp2gj8Y35k9r2pMjAxPn9p0UPmUJyIUht5Ccw705aDKMT+8tjAqW/0R1BpLqnSy85MfocW6qnzBfhJ20m1jL/3Fi8ZXXlRcP1htsKUQLL4JryY0VrQ0u4Yi5JhSp83dwZdz4lE4nWHxTmWYccXKSEkz4C8RoDokj7SzGmEXR2rRz11/0jvc0dkYoNuThw/dWsPziHv87JFA0Sennr/m56d1fqkYxE936y18dpP5LD+DElyW5swMtmsUwuavOAAPQ5UTDR3+2SJob+s1GCk94Qya7p8XhkV4itxASVvziqiUjoph7NZFr4rtddlYkMxev5kX3m90ZTOqAyfXAV5rz5Lhs2tKtbOGDNGR3koBpcgg028DTB8z4em04zdVNuYR2fvRZAPQRN0nSzY71LcuH+QA0MDzaMk+Zawy6WSJ3tSh5rsO0dyQVE074dKFOR0VDG/6UVBvYpSDQzOPx7pXuHH2sX+y4AO0wWiKK+eWfI4tciW9OhnNHPZD113K1Gn7/VMyizX9CJTxuQe1hxTKsDMQYpwASaksoWXblqa9Z+DxeC/Ou9NQ0iglTFMvoT0SurNIYvpcvu8H0WwAuHU/J0dmagarigyd8xD10nKFJ/dw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae3e8d0-05d3-4b6d-b9a5-08d87f957ddf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:11.3127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25zbu+SgFyiMEjlyGJivgFWMvG5r88M92ExxVrxTGLUFMVYzXLSvlxY4KE9OU38IT8+0Y3V0zCgclYsUjd+4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.58; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:23
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

Hi Peter,

Sorry to get these out so late, for some inexplicable reason my email
client decided to flag all responses v1 as spam and I didn't notice
until I double-checked the archives this morning.

I've fixed the gcc-on-BSD and clang-on-linux issues you pointed out 
(PATCH 6) and added proper test coverage for both.

Also, the qga-ssh-test unit test introduced in this series triggers a
failure in Gitlab CI build-oss-fuzz test. This seems to be due to a
memory leak in GLib itself when G_TEST_OPTION_ISOLATE_DIRS option is
passed to g_test_init(). I verified the unit test doesn't introduce any
leaks when run without g_test* harness. Since G_TEST_OPTION_ISOLATE_DIRS
is currently needed to safely run the qga-ssh-test, I've disabled it for
now (PATCH 9 and 12) until we figure out solution.

Thanks,

Mike

The following changes since commit 2c6605389c1f76973d92b69b85d40d94b8f1092c:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20201101.0' into staging (2020-11-02 09:54:00 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-10-27-v2-tag

for you to fetch changes up to b457991dfb801bf9227e8823534de5dbb3c276c1:

  qga: add ssh-get-authorized-keys (2020-11-02 18:30:42 -0600)

----------------------------------------------------------------
qemu-ga patch queue for soft-freeze

* add guest-get-disks for w32/linux
* add guest-{add,remove,get}-authorized-keys
* fix API violations and schema documentation inconsistencies with
  recently-added guest-get-devices

v2:
- fix BSD build error due to missing stub for guest_get_disks
- fix clang build error on linux due to unused variable
- disable qga-ssh-test for now due to a memory leak within GLib when
  G_TEST_OPTION_ISOLATE_DIRS is passed to g_test_init() since it
  break Gitlab CI build-oss-fuzz test
- rebased and re-tested on master

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
 qga/commands-posix.c     | 297 ++++++++++++++++++++++++++-
 qga/commands-win32.c     | 140 +++++++++++--
 qga/meson.build          |  39 +++-
 qga/qapi-schema.json     | 127 +++++++++++-
 6 files changed, 1104 insertions(+), 41 deletions(-)
 create mode 100644 qga/commands-posix-ssh.c




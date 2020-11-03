Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4311BC55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E1B2227F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1BeV3cL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E1B2227F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmRD-00075d-Ic
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJU-0000hp-1i
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:44:48 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJS-0007gm-7p
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:44:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0o7JMbmjIm9yfV5ZgX/mEi+5E4Ew92pjYByBwTzr9TkWccdkF9MZ3b+s1m0YzffzdcX7zbHTTa4OH7NdTrwuK1gFtk8awwUGjlcYmoFy1c8AdCTU6NLkcJYMUkEXaA5dJ1sLZoJMFn9ULvisniKHU8E8IU/OW0hMnW89AJcmJbJRNi1wThGCHCOxfujRDtfFmBybTvihJLvdiZE2xP10FtVEw/kilGxfR+1AXQKJaQq8VRf0004rlkBY9fH04COxrHRY7k8tcBIwhFe88Ki9boA+8HdFxyaAHgrM6xoObDMxlszB1njxoxoBXPToy9o3jDvOb4K4qotuH6mT6H0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zTwqa28Izclx3PjHmVA0u+zhlBGCBTj0npDz+49DMI=;
 b=bIV5cYwL18lZf2GJ87oGTXmaJ/fHTQkeFfbkUUUiSzvUMvC3EPi15/xSCtFLfZJ7vB0Z1awgaCh3PEdG5x2OZfoVFvKPvF/ipM42Gs0PyLJTWDu4WuF/8v7f5htzZNTkeMi7MtOaQ5LJdXITfVl0Qsg2Qr5s6MLtHfPHC9CZhIHFcg0Cb3lSCN7qjy+mhD+3V+Z4eNsrGlh0gXSqFA5W5oJsWfwqfCP3kSeRbXLcyISy+QX41X53UMurD20xwDMooEV+uwY+Bgjmt5zcHnaQrEOsc2Wwg95xkWcKkRfztJGybxSPJMTMymenhkFOiQrg3KLoU90qQJwLeV53hYWN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zTwqa28Izclx3PjHmVA0u+zhlBGCBTj0npDz+49DMI=;
 b=1BeV3cL5TJNOzw5ZoNzO5MEmt7DntKhY4VBEi9k6iNMBKfSMmKWHiI8PzjIfBAC/FlkrRrn8VHsxRwgFZt0ln205UUuwy5QOiOMYSbDgzdYoZ2VNCPyBcXaKw5g0jXtEaocdZ267FwoR7BBFP+4KzJex7+XNdK2yL8+8qCbgtkE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:44:36 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:44:36 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/12] qemu-ga patch queue for soft-freeze
Date: Mon,  2 Nov 2020 20:43:32 -0600
Message-Id: <20201103024343.894221-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM6PR02CA0116.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::18) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:44:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a65110f9-1f5d-4ca5-0095-08d87fa26720
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB431160B27B967352B53F062395110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v2iTWBKLsTUpIQwBrvWFkOIiKnuCNd6sKZWp25uj+Tslp9l+sQ7FPJLdrXbsls6RydQnaKJpkC7z6cdJd4f4Tek157Aci0uV3XRopxFSPNPPWX8MarzojcLue3kVt8DxbkH7mh7I3kciqSAhQDQhintvNXftbl/mtbbGKcvak/x3IndnezPohn1o+5ydMNIonXJYfe4fLfioim245UfnncraoFc7n2lBGurLRpDI1CGQk48bJECJHQR415xl0tRWE4hlyQINAcn0UXcYeFSQc74LQL+UfGZRsL+9ypDba/s3L1rCGRJj9Cww8rqs5FnY8hLAPOWQBNeUoP8MlxX1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(44832011)(316002)(4001150100001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Nv13ntt5j/KkdwEBpngG8bzCBOTArOvPfeKGznoHCaSWcOhMuIYEZ22sixH8dpvBwD0wGXHqgUEbdMhA+omX6A+YRMRn7nWNz9314zmyyz2GFRqNkVAtQwwdcXKNWCUyLeKElID+1rMgQVqmdSza/G6Dl2+IP2+uzWzjZXB2VVBdWrzNpsnlo0GG8gNkY15wytj9erPI8wO6tdUO8fXS34v7lqEL/VJYapjlE1xQpAA6r4/G9c/6yoxvp7N1jwry9SZKT35YdyjqaQAu2QBJ+E64BlPQOA2/FJZ8cg041ERaweaVBHuzWGs0EJVQ6+YvLY9FNV0ipVfR6EaNT7K0Ezucxly25jZx9QGAgv8Fu+vQZYni6NM65gUTVwUCHNMNK5/MdgXIJxB2JUZ2fXnr7+Pe5DB2OhWGpjfkPzp3rcGaUkWA5jeunGrnzNfm1PM2kWhjP38o2fJ4MVbT4GzY7p3gip7RkwkBLRou5tC3OFLwSDlThc+XGpUJR8cwIqDngkjp3V9NrN7Wbc1efky1AuD6or+WMtryql3nStCu4d0ElFJ7akxvupLAz/Gpxc52yP3horaarTUFseStvgFLtd3ZHgdTO6k9YGfDU6IDynBv/fcQFswd5yOeak2VwqmNxhLcgY29K3QZMdmyDorbBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65110f9-1f5d-4ca5-0095-08d87fa26720
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:44:36.6406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYy122zpNQiz48CkJ888gVDj1pDj6iWSdHkPT/fS1yb3n7ysYf0Vc57jJKXjy7EWkL9DT1uquW53+Q2cGOVcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: none client-ip=40.107.244.72; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:44:34
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

And finally (hopefully), I addressed the checkpatch warning regarding
disallowed use of various g_assert_* macros. I previously thought they
were just noise until Markus pointed out commit 6e9389563e.

Sorry for all the noise,

Mike

The following changes since commit 2c6605389c1f76973d92b69b85d40d94b8f1092c:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20201101.0' into staging (2020-11-02 09:54:00 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-10-27-v3-tag

for you to fetch changes up to cad97c08a1c17830d77a46780088bc0199df89d1:

  qga: add ssh-get-authorized-keys (2020-11-02 20:04:13 -0600)

----------------------------------------------------------------
qemu-ga patch queue for soft-freeze

* add guest-get-disks for w32/linux
* add guest-{add,remove,get}-authorized-keys
* fix API violations and schema documentation inconsistencies with
  recently-added guest-get-devices

v3:
- fix checkpatch errors regarding disallowed usages of g_assert*
  macros and other warnings

v2:
- fix BSD build error due to missing stub for guest_get_disks
- fix clang build error on linux due to unused variable
- disable qga-ssh-test for now due to a memory leak within GLib when
  G_TEST_OPTION_ISOLATE_DIRS is passed to g_test_init() since it
  break Gitlab CI build-oss-fuzz test
- rebased and re-tested on master

----------------------------------------------------------------
Marc-André Lureau (4):
      glib-compat: add g_unix_get_passwd_entry_qemu()
      qga: add ssh-{add,remove}-authorized-keys
      meson: minor simplification
      qga: add ssh-get-authorized-keys

Markus Armbruster (4):
      qga: Rename guest-get-devices return member 'address' to 'id'
      qga: Use common time encoding for guest-get-devices 'driver-date'
      qga-win: Fix guest-get-devices error API violations
      qga: Flatten simple union GuestDeviceId

Michael Roth (1):
      qga: add *reset argument to ssh-add-authorized-keys

Tomáš Golembiovský (3):
      qga: add command guest-get-disks
      qga: add implementation of guest-get-disks for Linux
      qga: add implementation of guest-get-disks for Windows

 include/glib-compat.h    |  28 +++
 qga/commands-posix-ssh.c | 516 +++++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c     | 297 ++++++++++++++++++++++++++-
 qga/commands-win32.c     | 140 +++++++++++--
 qga/meson.build          |  39 +++-
 qga/qapi-schema.json     | 127 +++++++++++-
 6 files changed, 1106 insertions(+), 41 deletions(-)
 create mode 100644 qga/commands-posix-ssh.c




Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E00EC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1D222226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0WuZCe9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1D222226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmEz-0008HG-Um
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmCN-0007A7-HT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:37:27 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com
 ([40.107.236.74]:32464 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmCL-0006xA-GK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:37:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJdMnFdaAiPM9HpcFJSgc2BuC3HG/GlJBMNPul/4GIthch/6IUcwA67+2FHed9jsjrvWPQBtVq2nIlWT1Ndsi3ENrDjDHpBjNMXDN8kDSdF4fl6SM+eaxQEt/HdgnrVpykD21AChL0MGtJdYAIP7AYTftASSyMDzDEJfV076zrXElseZe54DRIxJolmx7dSRGiMeMgvpsVIpjTTtgZk3B7YNfjCG1tWkYBKXSvsZ0whDczo5Bsa0n6g5j3+PZM8i4XPAkJqn2loEum1cFu9IubFGzG/uORGo/vo1w+9BJNtTGkr9RN9+vCUXeWnIHMyc7ip5zWsUEWSemO6+Wcimzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJThjI1wv+QDQKhd+2KnZrvrEmOhSMLBtdK7bkJP6pQ=;
 b=aSvwkfe7AIDJT+CaZjqzRqfSOEgmw9lBESHhsjudm+XK6aYu/2EnrdRMQ5L+1G/vBDO/Y1sGmRW+4avvCrO4DBV5uCpCmbRB9U6Nd1ciVUeGwGLbwBEiY9sJtvuOzU1foyMo99+KJE6HPulLdeP5BfGwVBN9oRoA+eRSq5CHI26R+HwQnX20N50N1RXJnOyzVMY3PqxR+HfAgzqCYZJDFYHezmYHSh7mhGbmUsrfxnGIMPGf2QKFzCXHLauR/7IWEXGb2DI27xvtBapPzCyLt34aP7d/RYSwnQX7UU34kkWDrbgdsl3b2uc0G1+UZk4xLdA7fj5PHhVrcDg/FqDEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJThjI1wv+QDQKhd+2KnZrvrEmOhSMLBtdK7bkJP6pQ=;
 b=0WuZCe9mHgR7hiFbpqFNK0s0SVxbffLuqR1kStvUPDVDsezSASS4YxJoJnNYeqeuddpKzzKII2+s/En8Yeu0P+TtW8i7DRqGuXRsvaSYNy3TJma3RgsXBuXGZEn6YnATfXyH9IH5FT4Bp7GkCccm6bCBDQ7qlBh42qghpkfv8O4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3765.namprd12.prod.outlook.com (2603:10b6:610:25::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 02:37:20 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:37:20 +0000
Date: Mon, 2 Nov 2020 20:37:07 -0600
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/12] qemu-ga patch queue for soft-freeze
Message-ID: <20201103023707.kzx2gz7typtfdxzr@vm0>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN2PR01CA0076.prod.exchangelabs.com (2603:10b6:800::44) To
 CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN2PR01CA0076.prod.exchangelabs.com (2603:10b6:800::44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 02:37:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba684af8-6b28-4f04-39a2-08d87fa162fc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3765:
X-Microsoft-Antispam-PRVS: <CH2PR12MB376529D8107E7193D5F61DD495110@CH2PR12MB3765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+EUeSBYl3Gqp2H/NyfTcHIZ4csRH4R4rhlERDHu6lDaa+M2moDjR/T+9QEpL/OknzYCRuRPUIGJTfToEHw6GQyxpZYohtrZPkcLlc/6+nTodvbqMz0EXcth2FVFAzoMWTMSLOt8BIjmMA58CWC8IYz9selhxKsAawZalDGFSAJLdDJdxXBp8Lm9memRXCrAXHie7rrb8YTNcOhjdsdQh7gZubIsxzsr0n7dQH1oOsbkF5ZDHYWnIr9f8MfXjY9dDQ3Xi1bjMFzeRuemhwWfvFGPsmRpyYrvdUdG62rCVmAN0uU/QRe7X+HInG0yoEKDE3L70p2ycNC7gmz/rCuoMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(4326008)(8676002)(8936002)(66946007)(86362001)(66556008)(66476007)(316002)(956004)(4001150100001)(1076003)(6486002)(2906002)(44832011)(478600001)(9686003)(33716001)(26005)(6916009)(52116002)(6496006)(6666004)(5660300002)(186003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Xnj7WGuPc6gz2gYg2aw/FBeD/xGPIcuiVn8POTJpS0d9SJJCAepGejkqd2Jt5p7wKeop4TZ/E6chdbMSPA732Zdwo8nXVE/Ll18vURWivnesTqMJj4TRSTMxXzRUmHjcFKPgfJie6Y4xnVbgVNXrS9M/0jvRarzkI0CNwxrzAgvJ+0OBguidVOT787kGyQKfmOvKQrYRN8DRtCIFXMpJ2ge/WXT68ThxpNKUNTq/2W9IU/EHwf0X1+jVC1rRemorV2AKrqwrpDh22CiDUp6/BKAiZPgGaWSPEQl15ol25zUWi/+400696pZVl6zRKJ4RH1XyvVMJV4CDc/EFA5y+ixo/Mq0d9+rRczG3FqBWkDk9kn23csBuXgPoV6MWcKKLP+PsW8j/X7DN7ZUxbazyMfeGxwBRVs4VLC4/md+zc92/TXKDTIeXkIS7yMgpWXPTM+znyyCUyXtRdjZ7NIF/Uu/iy/FCTlYOmVy5zRefycnyhmtUrKekAPdolt6QzpQ1HjGW3+jT4mHginViW7lzAyhZclvrtQmTi8JehbM+/K8hv8yzUCl1X77m95YXaYKueFzMg4WgXSaLlklwRq6FIyoPQhfeMPTjrMEAfW0Vaz/G2NVK2+QXY3iyNYzU15udamaRsjLP2bIA84n11eiqdg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba684af8-6b28-4f04-39a2-08d87fa162fc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:37:20.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpSq4qArcCRMBK+eJrMhivO8964BdSRa8/gDfjQgllg/RDp2uwTzrn2uxPqx7S9BdDBDpBHuDFxoJ9Z1fR/24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3765
Received-SPF: none client-ip=40.107.236.74; envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:37:22
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

On Mon, Nov 02, 2020 at 07:11:22PM -0600, Michael Roth wrote:
> Hi Peter,
> 
> Sorry to get these out so late, for some inexplicable reason my email
> client decided to flag all responses v1 as spam and I didn't notice
> until I double-checked the archives this morning.
> 
> I've fixed the gcc-on-BSD and clang-on-linux issues you pointed out 
> (PATCH 6) and added proper test coverage for both.
> 
> Also, the qga-ssh-test unit test introduced in this series triggers a
> failure in Gitlab CI build-oss-fuzz test. This seems to be due to a
> memory leak in GLib itself when G_TEST_OPTION_ISOLATE_DIRS option is
> passed to g_test_init(). I verified the unit test doesn't introduce any
> leaks when run without g_test* harness. Since G_TEST_OPTION_ISOLATE_DIRS
> is currently needed to safely run the qga-ssh-test, I've disabled it for
> now (PATCH 9 and 12) until we figure out solution.
> 
> Thanks,
> 
> Mike

...And I just noticed Markus email noting that checkpatch complaints about
g_assert_* aren't just noise. Re-spinning a v3 to address.

> 
> The following changes since commit 2c6605389c1f76973d92b69b85d40d94b8f1092c:
> 
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20201101.0' into staging (2020-11-02 09:54:00 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-10-27-v2-tag
> 
> for you to fetch changes up to b457991dfb801bf9227e8823534de5dbb3c276c1:
> 
>   qga: add ssh-get-authorized-keys (2020-11-02 18:30:42 -0600)
> 
> ----------------------------------------------------------------
> qemu-ga patch queue for soft-freeze
> 
> * add guest-get-disks for w32/linux
> * add guest-{add,remove,get}-authorized-keys
> * fix API violations and schema documentation inconsistencies with
>   recently-added guest-get-devices
> 
> v2:
> - fix BSD build error due to missing stub for guest_get_disks
> - fix clang build error on linux due to unused variable
> - disable qga-ssh-test for now due to a memory leak within GLib when
>   G_TEST_OPTION_ISOLATE_DIRS is passed to g_test_init() since it
>   break Gitlab CI build-oss-fuzz test
> - rebased and re-tested on master
> 
> ----------------------------------------------------------------
> Marc-André Lureau (5):
>       glib-compat: add g_unix_get_passwd_entry_qemu()
>       qga: add ssh-{add,remove}-authorized-keys
>       qga: add *reset argument to ssh-add-authorized-keys
>       meson: minor simplification
>       qga: add ssh-get-authorized-keys
> 
> Markus Armbruster (4):
>       qga: Rename guest-get-devices return member 'address' to 'id'
>       qga: Use common time encoding for guest-get-devices 'driver-date'
>       qga-win: Fix guest-get-devices error API violations
>       qga: Flatten simple union GuestDeviceId
> 
> Tomáš Golembiovský (3):
>       qga: add command guest-get-disks
>       qga: add implementation of guest-get-disks for Linux
>       qga: add implementation of guest-get-disks for Windows
> 
>  include/glib-compat.h    |  26 +++
>  qga/commands-posix-ssh.c | 516 +++++++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-posix.c     | 297 ++++++++++++++++++++++++++-
>  qga/commands-win32.c     | 140 +++++++++++--
>  qga/meson.build          |  39 +++-
>  qga/qapi-schema.json     | 127 +++++++++++-
>  6 files changed, 1104 insertions(+), 41 deletions(-)
>  create mode 100644 qga/commands-posix-ssh.c
> 
> 


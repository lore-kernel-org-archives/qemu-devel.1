Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4512C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110A920754
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iIQFH3Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110A920754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOqT-0007Rf-14
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXOog-0006Th-Ss
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:15:10 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com
 ([40.107.94.41]:19264 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXOod-00053g-B6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPCHgvRb9pZY/aG3x9rFPCP2qay0y4Cc2clKx8FYf6bLY6LBb80ESDCadvirMvr4GxonIQzbGPhQtROMfLnVZxtbPsxQOzNYBf8kV/RcNrh6tIZy/53ks4rIdpR8hhltRx0BqJVtbKyTrWUPAKh7F3jcj1Lb+9htTcUMLi0vpPzzlyvarwFwdC1NGrKLaMgKrE2OfBL9JtlYo9zvhDNo0yRcVTXmBg4ud9QwVEC3czTlIJ10VOFPwHiKFbrrYGmyPCtA8wkUpF548pPYW0w8qu/e6jIxooVvkMDpHGwWGG0904M+wEBg3M0qSa17HaohYQGlBIixGCVIreZlYXDA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/UucigNY/t1Rylf2cjSfhSEaSR63zJHd790KLj4UH0=;
 b=ATCOSonpy8ilLCs3VluU4mZBmhFzGEBxKEyhyOniFKtEmWGbSKTFppf9gyO4btdP4evyH9XmhGsr8SKfHi5tnDiBYJnLu4644LZi9puGUH4deDmYpy9zOqleuj9NqZSpukD4F+Tz4qYCxT2+gl4GaEbX7rlpbBlLs9fccxuS/An1nl7jyCw/YJHufyTMn+LbLJJ88QXMBB69PebB9oUI2K38LSTvrGFbk4qbaRi16lIYsiwKTjMLp4VQpu+NJdm5Id7XW+gSHGw+O2ZDu9wCpQGOEKNrGjtnvHr3zhxFYEw42kxMkCB3YBfQz7MdKWSYgGYLpsm0Y/JnuWiETRkaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/UucigNY/t1Rylf2cjSfhSEaSR63zJHd790KLj4UH0=;
 b=iIQFH3CyiaEn1hY0RUuKHRY2H1AwLz8kmGeTTviFilpooBg+AmhcqzZ2nA9FU3syTvGS6gR7sdI8omRaoFqWqWsmeK9cnby8ZSt3VtLjq8LviqBJpBlrKae3SiVCafwlldgAnLuNgfzRso+cnV3U4M0TAOHwIfIJm92W/N+4jQE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3959.namprd12.prod.outlook.com (2603:10b6:610:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 13:15:03 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 13:15:03 +0000
Date: Tue, 27 Oct 2020 08:14:52 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201027131452.6q4tqvp6a75zj7kk@vm0>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN6PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:805:106::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3 via Frontend
 Transport; Tue, 27 Oct 2020 13:15:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25448e19-69f7-481a-2eac-08d87a7a504c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3959:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3959CA468E38E98001C7776295160@CH2PR12MB3959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXYTLISywSIp4KCO63L0Mz3jrmlYGtqNWsk+UVhBlQBx7QySD0ZHNMbVa35vfpYxDuk4jYtP+CD6s1YuHcyjRrk73vrOTS/r+BDL5t4HCAfvBklfnn5wFZyd/9CQmlzwYuaVEqZreTJZxOwHiGQtpGxOqHPMwIgXejQaVcySJ02rkHCiAXcNkHfCZ3E7DaJxoOi8vQJUy9EVlzj38gtiklXdE+fEqOZvqaePJpLKDfDh4xG7fsqqAx4Kl3nfnUwjycJEP5QN1kmqC2j+OEc1yLtnP8Jkzh81cNCkx8nu4VTlEVfdXXKi0tSWyGcznOvegjyI20mJAapMCLnxzK++EGzAkxBP25DDAHYUL7W+cOG/cj0DJV82a22xN+sP1Vegwhlb+6s6m+uvZIwxPaC8eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(478600001)(33716001)(66556008)(52116002)(6496006)(956004)(8936002)(316002)(54906003)(6916009)(5660300002)(1076003)(86362001)(9686003)(8676002)(44832011)(966005)(66476007)(2906002)(6666004)(4326008)(26005)(16526019)(83380400001)(66946007)(7416002)(186003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nJl5Fsl16Q9exqXQegGWeoZPJhmW5iDOWeBLjQ4dT8Ip/ZKupMpr95qL6BllbgWBWY8ay+LvjYW6j4EtU+4Jx0rbjh+PbMQd8R8aQJ+5+R8RJucDYen1dKTipNGUllhB9/9fCbmxvBer374iH00A2s8PrSaYWEDVm18dbw+XurykjvhKZxf76SY9/1MiCxuMyxLGdN1kN//KlP4lfMTIUa8y7xCLvuyGlmuYMvQmZTFxnJ4WS/fXX/mJSXi4rrw1G0NTbONdN7hUPh1LOjpy4uzIrLG5e0fsU7/WLdG9/Swotmd8A4v07RRdBoZo70IZSA/0nmbqvY/8dx48TstPogHiPu5AJybTlQhnbb2To027PvZgLePrSoSE0hp/pGW61IhAu9kZj5RycU26qLG9XdBneJY+jnPAXxcCPdwjCZPphjSyQHJY+vl4f0nUtC2pBqVflLecJkiMCG+h0cb6wUni8HZWUKGM46t+9+Kn6LfOTBq1jS9UJCUDdf8IWx614VyrfM67eAUJf/e0iyGTQQw2nXjd2KiJ0OwnosnNZsOH00O1E0V9/i4ZlJxk9ZS8UcNEqKcQLHAfnYkDs8/zpzodtqwBDa685EjJZanBVgfC9w/CIgDAaaRiF74uemwbVOjOJRkNMJ/GuEtGsWGfxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25448e19-69f7-481a-2eac-08d87a7a504c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 13:15:03.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOqEt6JztrB7QPTc1bch4S/867QQgaTZ6nRMjTrC/RmY4AoIpL7bT2tTrEmVB6Q7JzzyaIV6qQMHL5OUuAKN3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3959
Received-SPF: none client-ip=40.107.94.41; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 09:15:05
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
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 11:04:06AM +0000, Peter Maydell wrote:
> On Thu, 22 Oct 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > now that Gitlab is the primary CI infrastructure for QEMU, and that all
> > QEMU git repositories (including mirrors) are available on Gitlab, I
> > would like to propose that committers use Gitlab when merging commits to
> > QEMU repositories.
> 
> > Nothing would change for developers, who would still have access to all
> > three sets of repositories (git.qemu.org, gitlab.com and github.com).
> > Committers however would need to have an account on the
> > https://gitlab.com/qemu-project organization with access to the
> > repositories they care about.  They would also lose write access to
> > /srv/git on qemu.org.
> 
> Yes, this makes sense. Who in practice does it actually affect?
> For the main qemu.git repo, my guess is just me, Michael Roth
> for the stable branches, plus Richard H and Stefan H who both
> volunteered to do a turn on the merge-handling rota once we
> eventually get it set up to not depend on my ad-hoc CI setup.
> 
> I have a gitlab account so I'm set for this. Michael, do you
> have an account there and are you OK with switching to doing
> git pushes to the repo on gitlab rather than direct to qemu.org ?

That's fine by me. My gitlab account is @mdroth, and I've requested
access to qemu.git and qemu-web.git subgroups.

My only concern would be what the lag time might be between updates to
qemu-web.git and the actual website update if the mirroring doesn't
right away. Probably not a huge deal but might be good to know what the
upper bound is if we want to verify the update process went okay.

> 
> thanks
> -- PMM


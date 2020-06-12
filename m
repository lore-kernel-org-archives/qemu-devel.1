Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E971EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED9C20801
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="mRtCx0Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED9C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmyL-00080z-0J
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjmxh-0007XL-IG
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:55:25 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:40421 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjmxf-000233-9W
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:55:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyblTCyQrA9dxJojmezpOpidJgG+S3YJgpdHnU3edvYyivmoar23DZv6awxuP/RuaSoCBLxtrri364R7Ar1VHQYBx7/IyblxPk+4pMRjDPJuq1QR+1c7ypBr3UlmIID6IHEjnQCCpwcoMnOk2EKUTrzL1pBEQwx87eiAuP06heMZ1V3OYfq3qgEULVCRudc8q8aEenDBgQWKV3avCIl6U9ULq1i/lBPEFk6iw3o4fbdMM8Emt2ory6Xpdfp7AU6Pem4FACJilxb/ihwayq/oce7u0fldA2YPEXi8jWwVtjp5jEaqaLA1560iNo51f/cdrn+G0XcV4W4uahPToWj2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbfC3BkN1KWSMpaxGR9TmWS3Y9sUyZJXbIadp9uYdFQ=;
 b=IBjJ7PpfYfqRlKU703PDfOosSEhgyJbgZWzanoARfFAmzG/2o2LbZBXQEskiDJ1/mGE1aICdwzQ/BjKf9K5bGnM5i4ln68T9MufZV4Q3tg0BDHhJYh41EVaHmnWd4SSVoQVV3+1yu53K4ASTbhlUf2bkVTu/IAwPrYyWptLkq6VMoEHzr9gTD5Z3nqgLYbW+bYcGxAKDvtB5cd29kQwzzqO82iVxplAOSf3UtZzPXN7IzT2MGa4Ud0zab0DYvEeth5eE8r27+fxQGxMHtPZnecsIiVcG+90dlfBYOP/PBl16RBqHYI67ewftbRJlFas0EhR6ECyyH10LRCEsQbKtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbfC3BkN1KWSMpaxGR9TmWS3Y9sUyZJXbIadp9uYdFQ=;
 b=mRtCx0NmeH0237DJtlLBhXs9DKCXvPAf76977AJ211NFPCfTkHJOfmJ83TgYL5J9LqtlU52QEoqcqTvfNyhWOwzyORLHXL11AbCPO+p+L3FKHkRrjJy0C0meABxVMy2pTm7cXYyH1YH9xiR0Yec4oySeJ/OUGi6jwnWYRcT6h5Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4072.eurprd03.prod.outlook.com (2603:10a6:20b:24::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Fri, 12 Jun
 2020 16:40:16 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 16:40:16 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Add strace support for printing arguments for ioctls
Date: Fri, 12 Jun 2020 18:39:59 +0200
Message-Id: <20200612164001.27405-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::24) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 LO2P265CA0444.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Fri, 12 Jun 2020 16:40:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2de6f8aa-a7b3-495a-8dbf-08d80eef4908
X-MS-TrafficTypeDiagnostic: AM6PR03MB4072:
X-Microsoft-Antispam-PRVS: <AM6PR03MB4072F7DB92FC7F4FCFA8874AEB810@AM6PR03MB4072.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLWNUTbAENfoHEclNiXXM7eK40wVJueskt8aiFsdniJxz8pUc16OLAeZ8zG0+RYgbOS597v71yaEa9F4z3truBtQf7zyTgy8F0ir2bvfwavbxHzrql+M7ItMq58A9YrMIx43j/oZgJOJg7KXaFosfBrNBU09iF7RwUQyVTEs2+/a/SPXi55soLtSSHqWeMQDr6QOT9rhySuoSX2IYVA8pUx1XGSvRBSb5I7VdOfoBoZkxMU9a9K99zyGgyaSbdgBZSuGqmWDbCvB7kjH0oW8p5uq31dFg4YZkaRPn3DfbYAQR1Ulx2GdiumpUg6rT9eG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39830400003)(376002)(396003)(366004)(8936002)(66476007)(86362001)(2616005)(52116002)(66556008)(956004)(66946007)(36756003)(26005)(6666004)(83380400001)(508600001)(44832011)(186003)(16526019)(7696005)(316002)(4326008)(5660300002)(8676002)(2906002)(6916009)(6486002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oTGGR2+SgT5oAM7osNNMgkExe079QDcEKRHX/BBvTgR9cbuSdvkkr+nJs0WZJZr6yX1HIMKXmbkIiHefgxTtnNv6hl/0pwPuVhOyyrCZg6Vl6e3MlMiJLZl/e/8j68q5oP7SBAbSNj/x511QDoi6ICWTKnceA6akdZO2YmvsxZ00I/1KPoyWSoWJN7DEprFxxlKckJdfZgTq+kJey0RKu4RxT2uUIqdqjB56Bb5Jev73vjOWn0gYKml2MLuJYyaTctxFdbNB2OoJbCzeNlEU+zn5CrrtzAtWyvKSmntQyF80eGitTlT6kGAfGmgnL5065B2Jky5l13KROjEG9J2O2PGtHGzmOp1aWIveL+am+Fd+kyFAfAHNZt8+kxKWJ4EUuxaHtCzsG622m1LnRz8ZNYSRyw0fetZh6R/30zQRsQyqIBx64o5doIwCqq0p6nMpeYmbDz/+gCUOZLI3hi5krbIsIM8WYYMN2nlMHQyj2LI=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de6f8aa-a7b3-495a-8dbf-08d80eef4908
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 16:40:15.9634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysW3DpZbSBzP2PQHHdrofOi81eDWSmSUbCxJ2zLN2hAxXAxDjR8PCvCX2MWOzG7Q+ORDSXXluEJBDD8vkoA3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4072
Received-SPF: pass client-ip=40.107.8.101;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 12:55:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This series introduces the functionality in strace to print arguments for
ioctls. This is gonna be a useful adittion as it indroduces a good debugging
and diagnostic mechanism for user programs cross compiled for different
architectures.

The first patch in the series introduces missing thunk argument types for ioctls
SIOCGSTAMP and SIOCGSTAMPNS needed for strace argument printing. The second patch
introduces the argument printing functionality. The implementation details are
described in the patch commit messages.

Testing method:

    Mini test programs were written that run ioctls that are implemented in qemu.
    These programs covered different varieties of ioctls. Some covered rtc ioctls
    with both basic argument types (like RTC_IRQP_SET and RTC_IRQP_READ) and
    structure types (like RTC_RD_TIME and RTC_SET_TIME). Some covered loop ioctls
    LOOP_SET_STATUS and LOOP_GET_STATUS that use "struct loop_info" which contain
    special types olddev_t (in qemu presented as OLDDEV_T). Some covered alsa timer
    ioctls like SNDRV_TIMER_IOCTL_GSTATUS, SDNRV_TIMER_IOCTL_STATUS which contain
    complex third argument types (structures that contain other structures and strings
    as fields).

    Programs were compiled (sometimes using cross-compilers) for the following
    architectures:

        * Intel 64-bit (little endian) (gcc)
        * Power pc 32-bit (big endian) (powerpc-linux-gnu-gcc)
        * Power pc 64-bit (big endian) (powerpc64-linux-gnu-gcc)
        * Mips 32-bit (little endian) (mipsel-linux-gnu-gcc)
        * Mips 64-bit (little endian) (mips64el-linux-gnuabi64-gcc)

    All applicable compiled programs were in turn executed with "-strace"
    through QEMU and the strace printing results obtained were the same
    ones gotten for native execution.

Implementation limitation:

    The field names of the structure argument types cannot be
    printed as there is not enough information in thunk data
    (inside StructEntry) to do that.

Filip Bozuta (2):
  linux-user: Add thunk argument types for SIOCGSTAMP and SIOCGSTAMPNS
  linux-user: Add strace support for printing arguments of ioctl()

 include/exec/user/thunk.h  |   1 +
 linux-user/ioctls.h        |  12 ++-
 linux-user/qemu.h          |  20 +++++
 linux-user/strace.c        | 120 +++++++++++++++++++++++++++++
 linux-user/strace.list     |   3 +-
 linux-user/syscall.c       |  20 +----
 linux-user/syscall_types.h |  12 +++
 thunk.c                    | 154 +++++++++++++++++++++++++++++++++++++
 8 files changed, 318 insertions(+), 24 deletions(-)

-- 
2.17.1



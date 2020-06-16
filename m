Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC2C20739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="FWQOCCAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC2C20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl9DS-0001qV-IX
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl9CH-0000au-5Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:52:05 -0400
Received: from mail-db8eur05on2129.outbound.protection.outlook.com
 ([40.107.20.129]:5441 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl9CE-0004s0-PW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kexg42EhTCXbgIESu/9779YKSC2CdlCvgVALK1qT91MJCgwzim3aohuuFl46SuBQqU6H750gfxEhqNwsV9JFoO0jan7/npju8n6XkZVr1b8AmaxBsbD4oXljOctOwAtcWOeaZWQkkwuBva5JwjeT5PQTaqUOYSnoSy2sbO3idjX+4rPZoFjuBgHftXTwMENc9OC5WIbrsrFbyOl2MiJ4lRt9PTi4kn4LmRev9I0yoz3fy1CPbkJh80iPImgXiQZMEPsd4UGwQF9v9Ty1Z85okedc/1XR1fqpDLCw42IcK+4REfddLbiPl7ksnIuE4WxnswgxZ8PEXF+HWBzv64p9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esnqpx9ORxJfwJANrLueiYV30eyotdBVI0lyTJ4Um/I=;
 b=hY3GDzTMq4Sgg0PxxTahWLoeoFZYroy3yonMG0Oy5FVUEI0vDpV9TGbdEdfS8Mbaa3aNBu+gXhWOuXSZ9/01g6wDXNceF3L6uk06eq0YJXOVQQMFZUEMeK3YuE6+0LfEGTcjBFZj4zEJaB91vd8Gt0tqlNXe3chENy3AlAQnFTpY8LTg15JlOpHXwLW3Xzvj31gvP/V1nWL38isDeHX/4o9463SgtDsGI+FJDEZ69oXDovr6NSYdKScnIriX2Hi5rxC1aM5UA3FfBYbvvZQ7R0tcsCbk1BkSRMB7Jjen/Rqvbd2T71x7iN9oxa8GvVgEfagjknU8Dgw23kwxHIZ//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esnqpx9ORxJfwJANrLueiYV30eyotdBVI0lyTJ4Um/I=;
 b=FWQOCCAlZVm+UVjsbO1vsfy8tj6u2u2m9oNDPHglkACbSL2e2Sf+JTne7e7kXQb3YPqypQduEH3Y0uxAiNDyr/6C/JaQLqjlOZ+PCT1SWBoD75vxYkF0aLE4bZjj7kBGI3RwBZlt508M1HhehX5+bRKPJRuqmJKikxP8lQqIlNk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5014.eurprd03.prod.outlook.com (2603:10a6:20b:87::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 10:52:00 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:52:00 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Add strace support for printing arguments for ioctls
Date: Tue, 16 Jun 2020 12:51:45 +0200
Message-Id: <20200616105147.21736-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 10:51:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ea63193-723f-4177-db61-08d811e34bdc
X-MS-TrafficTypeDiagnostic: AM6PR03MB5014:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5014A50B6A35112BB7787A9EEB9D0@AM6PR03MB5014.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLtH/MeNmHRN2Yq8ms+PFV5vE/M9fK2PAAmfO9hwBSjf83jyNBP+12fZne7ETfItR3Zpd+zlLa9uTeOF8XTcz1UmUt9w+H3Y5Q+E7oIX28V+pJkMlm9yG3Be/C7ijj5GG/lhK9bX/cxomKDS22Z/gHBZwqdHpNHXrtGHNXLDNmqnWyce5WFT3OMFDA+xn8JsaLhXEqXd2nmLHp8SCycu2LSLbCCFh5qMUsRPdIhqqHZVcbaKIDALsxCG83AtUJf0aQEq//0Y3Qf4ZFMSs3/IF0yi0R9LDNquMnxzcoq/AcL6BqA1ldvq9KvXd5l1NCKI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(366004)(39840400004)(376002)(346002)(8676002)(8936002)(2906002)(6486002)(5660300002)(508600001)(4326008)(44832011)(2616005)(956004)(6916009)(66946007)(186003)(66556008)(26005)(16526019)(83380400001)(6666004)(66476007)(7696005)(86362001)(316002)(52116002)(36756003)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TDESdO8hkOMLLT2srD/W4v9MOXC59nlG1aO2SLQ0jJ1p9NLa9IqnU8OvP5xGvplAig7PyIG1fgCZZkHWnmDwUhkF+zKTcGkarje34/RKd+wyHdGo58MGdGaWwQh/HhNAkew+XOjF/88aEdmjTRFhNnOQ74o/Ft69cwTjCle/On4feA/VAxBamRV92+OL3iQIchb2SH6oAZhLy2fkBhqWJ+D6hRJ2HZgT/1mmSQYXSHCYdChHPCmp6wcLW9k2HgOuzLRmQgZ125M7wEQBmdW0VrMWHXms0JJeea7Pmo/isEugzla80tvZUp2ScK8V6xx/Zqy7oRudosJKG7CXjJy6F4lldcPwYSBIvXZWeTJKcYOADygslS8E4UFM/B3IsvwbAaaFT5NJsYVdyr7egGJCnr0A8gx3GOGt/z/LWn5brKywf7BADdGqL11ytfF3BIY3mfJDmiQL0o2mHFsarfRYomIcamlTSCmwApB+a5oqMxo=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea63193-723f-4177-db61-08d811e34bdc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:52:00.2018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9Gs13xLl+ReTFfzbBnUv/YGibqeqsEacMNMMR7lv19Vp1thaMatnZgHR1OOU2epM8XOO3wXDUSvzH2+C6aGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5014
Received-SPF: pass client-ip=40.107.20.129;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:52:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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

v2:
    * Removed case TYPE_LONGLONG, TYPE_ULONGLONG from print_ioctl()
    * Changed error printing in print_syscall_ret_ioctl() to use
      error printing function from another series
    * Added and #ifdef directive in "syscall.types.h" to manage the
      case when the "u_sec" filed in timeval structure is of type int

Filip Bozuta (2):
  linux-user: Add thunk argument types for SIOCGSTAMP and SIOCGSTAMPNS
  linux-user: Add strace support for printing arguments of ioctl()

 include/exec/user/thunk.h  |   1 +
 linux-user/ioctls.h        |  12 ++-
 linux-user/qemu.h          |  20 +++++
 linux-user/strace.c        | 107 ++++++++++++++++++++++++++
 linux-user/strace.list     |   3 +-
 linux-user/syscall.c       |  20 +----
 linux-user/syscall_types.h |  22 ++++++
 thunk.c                    | 154 +++++++++++++++++++++++++++++++++++++
 8 files changed, 315 insertions(+), 24 deletions(-)

-- 
2.17.1



Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB31C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9912207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="IBArGC3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9912207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGSM-00008o-Va
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGQr-00078y-VK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:47:46 -0400
Received: from mail-eopbgr130117.outbound.protection.outlook.com
 ([40.107.13.117]:41591 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGQp-0006QN-N7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCt1RdHWBVpviA2bZZPh2V0RktuI4Q5h+bZShJVnwyOkeNhiCHFrrMZOaJU030tZla/i132NssO051hYkOoUn2aMzkDP1z5lbtbooyADJwgMVs2Bm016tpC3XrgRzc3xYQXNetUlyd3UlUnlMAuu7UdOWHCMnjhKLJCp6asmeWrlTUHKG3wQRgNB9/G4epmvB9aQ7l0/6hOrgbmI94A1cTii3JZMqAVxHNeSyysjBtGjGobgxxNN57sE/Iyqvet7o8AYjEz6Xr24lQcrG7KAk9RK/Gy/hiZGnaWx5mn0j0EVGHRt6tjaOMAiprsXdrMMaTW1W4z5YTJXJaVepkST3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsbpSPiOeIjsy0VsRD0c9NhCYNlUyjaI5Ur4GPnTR8s=;
 b=OxCHY5VT8GysvhpzFgiWF3l2df5uCP/6Uemdg+NQuIb1DV39VckRMJs7FSgKKk4aQ3HC4AfJMFujJ+jGXgYTlKz4CVUFyxt4WLYho+PBj4jr3dzg17iO2syy6Dih4PX6nPFXRIREX8mhPTVeyTwTgc6F0dfRe4FEM5QRxnNlv3Th9+GXcbSYJwSnHpVbHaJxaD8ZNmEF8RokORfgk95yRbzzcrT2UdGXkEdx8Zc3fTz/ZpYSF5TWfw18FeN17n73z581Mj6x7Q4SRdSF0lAfr4qfshyqDT5pDaDkOP3XaQ+5X5HmTXlfneSfFC2QWroMnRbYjuwInAZEbFWNkxEUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsbpSPiOeIjsy0VsRD0c9NhCYNlUyjaI5Ur4GPnTR8s=;
 b=IBArGC3cEUAnCFZGDYCVVq0lBBJ7x7makuktisCQB/hrcKTIakKNDrITHiVkUDWV/EncrMgbUYmTTh0/HFsVSZYDEHcDpsIQ1KhWLl+AHKA9PuV11xCf17XteJm4oLJk+wN/gCsVk4rc4IlqkT4WksHmzl1QlRqj2uZ8h7EZhUs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5094.eurprd03.prod.outlook.com (2603:10a6:20b:80::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:47:40 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:47:40 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Add strace support for printing arguments for ioctls
Date: Fri, 19 Jun 2020 14:47:25 +0200
Message-Id: <20200619124727.18080-1-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::28) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 12:47:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de228eef-1c6e-4ed3-08fa-08d8144ef3fd
X-MS-TrafficTypeDiagnostic: AM6PR03MB5094:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5094EB366153865E0F93B82EEB980@AM6PR03MB5094.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H36mbPenKeq2rqTluGKFOXeu75mx/t+REoc/0GawL2m15YOkeYl0+vkjcE4xWRzh6MW+PryP6dYr5VCTRzldQsKB0gYI67KdN6DHM5WbQIdoNjutt45j899CcrwUjITVb73wnGumAFvZQYz0Y/dUQtnO/suM9K6rcI8wy4aSyEmWQsY5ksxQFWatiAileqAh+hzwMadtYEGGYzOfRHd/v6oTC/eRKgz4JKjdsKB9WufYpLdpYXAx2QpK57OMVlazadYekcA/k5oRyemq1/3iRZdvq8MpLpVk/AAmbcWqhs3H8ZQv2sfGKslKGXAJZ2Nj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(136003)(366004)(396003)(39830400003)(8676002)(36756003)(8936002)(5660300002)(83380400001)(186003)(16526019)(1076003)(86362001)(66556008)(6916009)(44832011)(2906002)(4326008)(6666004)(316002)(956004)(508600001)(6486002)(52116002)(66946007)(7696005)(26005)(2616005)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DVcVJNi7MWxL9GCse9RqTyWtSMdjJRwfOJkr4OuLmLSgs82Ri+TbqumeipNjojwU3e5yBG4wxp75tcqlD0qEfjiIesEXQuZCj1OXD2hkcChnEjVWVdtbdykK6ZWf3m7klsafNtEudFvBbO5L46D/qMluJVjCkjM7zzC6trHJRxzDxTTIGTlxLg+GbjeYOCtV36QqD2HPh5K1M83ko1RtsymbHb4bUhT9a5BHewZx0uOzSzGpRzNd8mq82xzw96pVcSIq0cFw4Cvp8cp9C/bqM5uiDLuo8+qogBbJ2LXRfv5lsLR0esF7Zn4hZZc4xqWKcnqkG/ZU9sJsH7ahcaqzR+28jCb+q0n0okFIsBSwcTfLBPEtUxL5UUXxYkIJlC6z7bigdcM3pd04c6slz2XOFnU7NXwcqA7XDhIFehhPB8+MLgvVF0yJVY2MKsjJ5/cR9CTf1zZR8CoBbXd1s1ohy/gGhAox30+S1mrv/gjVYnU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de228eef-1c6e-4ed3-08fa-08d8144ef3fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:47:40.7865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9dtsZYs9q0qfCqtfn4+X7LgAkwiuJPVvJ/X1rf1U15NaSf+Ma9CG2ywDuGBbQ9e+ewjggo8HecrClQqva++gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5094
Received-SPF: pass client-ip=40.107.13.117;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:47:41
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
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

v3:
    * Moved "Based-on" tag to cover letter

Based-on: <20200619123331.17387-1-filip.bozuta@syrmia.com>

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



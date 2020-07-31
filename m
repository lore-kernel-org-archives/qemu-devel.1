Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2EDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B922074B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Yx7FnH4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B922074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Rlw-0003j0-IG
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1RlE-0003DB-80
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:55:32 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com
 ([40.107.8.97]:61601 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1RlA-0006bM-GQ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0vaSEprC2P2JR7njQ/ttU2VAiw/Z84ANuWBKUqXVVLeP9IHjFGkTWc5zda/EZ9RUDdO8lF8Kd+sBa6pQx4Pxs0iMggfTLuHK4Y4JPmh7xW28LRvaGUh7Ti2t8YQCXOaEiSMJ1s3L9D2H7jaMLToiHgs5Dc0cG9n1+FsHrI+xqL//RTIdfoxm3nBPpsVtztBt1zQYotLBHe05TezQ1Pti+RmRk161sDGNR+ybUXH7pXeb0wpCk1cowwp6HzNFbgZm3n8wt1W/MLG2XHKEV2pfBeLZIGeFaod7ose96vYKv8JcoCQngfw1M/05/ZBpReQY5Ir+xLbc1FAZTxHhIx+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mELUfr7ysXJ4+7Az/fUS2kzA3Zc8nVd8DlmG99EvYw8=;
 b=lvCRGC+q4GjotWQSl6HcfcFPvH/+oeIR9qyownDxxLQ6Y2/HLwyAo8MuYavxM0QLTOl8s4X7kQ2Wh+6xvUc0/zjfIp00rCt7li+GTBvaav0pun3Z/xkPHnU3ZRqyljGiB+g6uPnAsWDb8N06wNjiatn3anPDrXO1WBT0huOjSaPWKzMO0IuYRan1IMa6m0CNHJ6ay+SPBGO9aNjS4LFmj2214era7Hjk/FW+MLzoivoQLfV7nT7fkD+0GHDvyhnwfLDszlx49XgpDtnAaHOK3DCTja3ksCYXjAKJwPd/pKz1AD+GRXsujtDGcUpuHUUdJvSwLJtkE9PBom++tcvwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mELUfr7ysXJ4+7Az/fUS2kzA3Zc8nVd8DlmG99EvYw8=;
 b=Yx7FnH4ha4zGcZJp1McTYVWHzWBhAbdwnAEGhbISWz8WSFKp7t3xWdmW6MBkyJejozVbglXLNNdSMoPqH6qywaTVVtVyDJIXqgsR4Z2o4+lXFM9QrEZarO74lB17CrSA/WTjQCEx8Se1uS/MmK5borMzMGO545w5CxnI1/81rLI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4143.eurprd03.prod.outlook.com (2603:10a6:803:73::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Fri, 31 Jul
 2020 09:40:22 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 09:40:22 +0000
Subject: Re: [PATCH 0/1] linux-user: Add support for SG_IO and
 SG_GET_VERSION_NUM raw SCSI ioctls
To: Leif N Huhn <leif.n.huhn@gmail.com>, qemu-devel@nongnu.org
References: <20200730025548.237905-1-leif.n.huhn@gmail.com>
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-ID: <6f40ca09-40e4-6180-2a96-656ca1833d92@syrmia.com>
Date: Fri, 31 Jul 2020 11:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200730025548.237905-1-leif.n.huhn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (147.91.217.237) by
 ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 09:40:21 +0000
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee81fb92-041b-4a8c-7f8e-08d83535be8d
X-MS-TrafficTypeDiagnostic: VI1PR03MB4143:
X-Microsoft-Antispam-PRVS: <VI1PR03MB4143E1EB782573573FCF04F3EB4E0@VI1PR03MB4143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBCoPfOUi42Myui3uIOG7u5uaJQe64kUc1cpWm8aueofIngG4q0eavXGNw7pq3kRLqQd/7s6KNRbSz4WhFysLS86aB0IWJm39kBiPQWdpluWHd6NTGAEcVTyD+Lq+2KZuCymCn4zNx2QJLEhODlSh0R5H6CFFWgaGpNZYk+1ALvg2OoeJqbk7V2KRS//V/HIwNtRduwZ2vi8uDzQ4b6pIlivzxT30ahmmE8ACgy6HxaG2zyTMfLLkM95AK1BMGG26NzsJ8HZdup5Gc3Hs/Nrb+kmcLiaUX1Wqly1omWAhmhG4BYeJxb3Ai2lIrzbbXJxcojAdV1TrLLQapa2CBXIb95pQ9CAoRoM3qPC1NBxVU15MXrVjBlne4tX+knTar+eZErrpiITNNZUkLFahd50T2/640GQKoibbGI0j00TevW8xBtIcmiaA5xEeyJthMcu6KqECaTmlU05n+JH1AzVqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39830400003)(376002)(396003)(366004)(52116002)(316002)(5660300002)(31696002)(8936002)(16576012)(86362001)(8676002)(6486002)(26005)(956004)(2616005)(31686004)(508600001)(66556008)(66476007)(36756003)(83380400001)(2906002)(186003)(16526019)(966005)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v0fUNhFRo00fQXHeunkI9AC5Kz4yXfcmu/Dqw8FnDOBQNW50C7QD1eWGmq+ft+LjCZTsPXgMFmR5X1bzDC8iebhb13CHaJHU53YMswGE7slqF4WuA5rVi9ZXwd/8wmTYWCw1MpZldj97lNjw2BuX5hJ8kH3ZyEMsTCHOtIodpv45o7GuBehHbRabY3x2/Vc4NlpZHjww2haf4lVha4bwxbxRB33vMbuWeaGlolLS4bIgjC5kskcxmNx0ZxXC4aYnwrEA+8OLdfcqxJR2B0Nbb4AzZqH7hdhoAODvOphtTLo5BpDUfIioDPrRwzM+jV8WvoT+5QLtOgEAudGbh2/7ou1T9IQghkPgR3NBhuo9wV4leMkDPTrqUsXbMBerhJovjvsIGgnS86nrUvMJbm4zgg5nYnhFFCNdH3IFfCd8nb973Lmifb7WhhaMFAOQyPoP5G38q1Z8GK5N17siLWUBxqWrAcst8mfq2QaczeXYB18=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee81fb92-041b-4a8c-7f8e-08d83535be8d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 09:40:22.1616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrwb4lj18tnJt2U4PA8+5yW9wslkX0fQWYL3YUz+a3QI2zmnPCYSNuB5kmvKf/8zIKYW/HSPwkpAbE1jyIQn4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4143
Received-SPF: pass client-ip=40.107.8.97; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:55:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Leif,

On 30.7.20. 04:55, Leif N Huhn wrote:
> Hi. This is my first time trying to contribute to qemu. This patch
> works correctly for architectures with the same bit-width, for example
> 32bit arm host and i386 user binary. Here is an example with the sg_simple2
> executable from https://github.com/hreinecke/sg3_utils
>
> 32-bit ARM native:
>
>    strace -e trace=ioctl ./sg_simple2 /dev/sg0
>    ioctl(3, SG_GET_VERSION_NUM, [30536])   = 0
>    ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_FROM_DEV, cmd_len=6, cmdp="\x12\x00\x00\x00\x60\x00", mx_sb_len=32, iovec_count=0, dxfer_len=96, timeout=20000, flags=0, dxferp="\x05\x80\x00\x32\x5b\x00\x00\x00\x48\x4c\x2d\x44\x54\x2d\x53\x54\x42\x44\x2d\x52\x45\x20\x20\x57\x48\x31\x36\x4e\x53\x34\x30\x20"..., status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=3, info=0}) = 0
>    Some of the INQUIRY command's results:
>        HL-DT-ST  BD-RE  WH16NS40   1.05  [wide=0 sync=0 cmdque=0 sftre=0]
>    ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_NONE, cmd_len=6, cmdp="\x00\x00\x00\x00\x00\x00", mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=20000, flags=0, status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=4, info=0}) = 0
>    Test Unit Ready successful so unit is ready!
>    +++ exited with 0 +++
>
> i386 binary on 32-bit arm host:
>
>    strace -f -e trace=ioctl qemu/build/i386-linux-user/qemu-i386 sg3_utils/examples/sg_simple2 /dev/sg0
>    strace: Process 690 attached
>    [pid   689] ioctl(3, SG_GET_VERSION_NUM, [30536]) = 0
>    [pid   689] ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_FROM_DEV, cmd_len=6, cmdp="\x12\x00\x00\x00\x60\x00", mx_sb_len=32, iovec_count=0, dxfer_len=96, timeout=20000, flags=0, dxferp="\x05\x80\x00\x32\x5b\x00\x00\x00\x48\x4c\x2d\x44\x54\x2d\x53\x54\x42\x44\x2d\x52\x45\x20\x20\x57\x48\x31\x36\x4e\x53\x34\x30\x20"..., status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=3, info=0}) = 0
>    Some of the INQUIRY command's results:
>        HL-DT-ST  BD-RE  WH16NS40   1.05  [wide=0 sync=0 cmdque=0 sftre=0]
>    [pid   689] ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_NONE, cmd_len=6, cmdp="\x00\x00\x00\x00\x00\x00", mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=20000, flags=0, status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=3, info=0}) = 0
>    Test Unit Ready successful so unit is ready!
>    [pid   690] +++ exited with 0 +++
>    +++ exited with 0 +++
>
> However when I try i386 guest on x86_64 host, the cmdp bytes in the
> first SG_IO call are zero, incorrectly. I assume that is because I need
> to write a special ioctl handler. Is that correct? Should I be calling
> lock_user(VERIFY_WRITE...) to copy the buffers over?

Yes I think you need a special ioctl handler for SG_IO. I also tried 
your patch by printing the

cmdp as pointer in hex format and noticed that it doesn't change after 
each cross execution

through QEMU as it should (which is the case for native execution) so 
there is definitely a problem there.

Check out IOCTL_SPECIAL() in file 'ioctls.h'. It enables defining a 
special ioctl handling

function which is called specifically for that ioctl in cross execution.

>
> Also, is the current patch acceptable as is, or does it need to be
> reworked until the ioctl works with different architecture bit-widths?

No, patches are usually not accepted until they work for all targets. 
There is also a little

issue with SG_GET_VERSION_NUM. I will write you a review in your patch 
so you can

see.


By the way, I like the form of your patch description.


Best regards,

Filip

>
> Thanks!
>
> Leif N Huhn (1):
>    linux-user: Add support for SG_IO and SG_GET_VERSION_NUM raw SCSI
>      ioctls
>
>   linux-user/ioctls.h        |  2 ++
>   linux-user/syscall.c       |  1 +
>   linux-user/syscall_defs.h  | 33 +++++++++++++++++++++++++++++++++
>   linux-user/syscall_types.h |  5 +++++
>   4 files changed, 41 insertions(+)
>


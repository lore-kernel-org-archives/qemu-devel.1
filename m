Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4148920829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="DIXVu8BV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4148920829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1SD4-0002RG-H2
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1SCK-0001Rc-5I
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:23:32 -0400
Received: from mail-eopbgr140131.outbound.protection.outlook.com
 ([40.107.14.131]:21077 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1SCI-0001iR-1T
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 06:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY+R/illmWp1K9OiZaAmqeB4UhqsrDHv2KN/RhmF/5WDzEbteURcsvOFvBPCk58dexfegMbBazb3JKMt/iYytcPIG7uOrDws7ICMJq9jgG6qoYZiqRzadS8+sd3MVXBt7+JO3TpZZAdRmBVA4wbntdF2nl/52VPiruaCQ83LAgEoCWMKHCvcbH09GvhLptOOy7PSE9PK0/9dh5Ea0JfrfcA9IPOUqiGbcCkTHGlSHE9Q64C/ZC9oIH/U+u9U9to9dxBsNA1xe9s+BYNx2y7vkh8bLjHnocU2b+25lNB7R36iDYG2LgqSiQDy5t3eryaMqM/egLi1Juw2EYlgWq69fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNoOUAEr9XegD6sas3Jdcle8BTq+t/xGC21O0LwsaUI=;
 b=I1+aEYE8M6snJ0/UcdM+BW6eQXId2TVHxQOHZ0TJn+ujG2yBs2KHrz/gtf3idoJt73s9nUX1HuFaayhINZ347U7+oDSuJQ9+9zvZdxvCnXGFLyPI82C1F7jnm9w1OBgSSPGaXN9Xpq7GbdMK86/TXwft4/WECBNokBeSeGkOKpI451JB/D9s/Uaxeo11rH64KXZXOIL8SewGT0s5l87TzvUtVPtBFrEKrSbCwfSBRmX6Zt2nOWYTo/mbZ03QPs47dwKWFAAPfvozNsscDcTdmuqrz/8cBt03YxIFPe+Tidrv5LA+ZojEJrwDfGSSAaRA48uauYa3C+z2zwsFzfcKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNoOUAEr9XegD6sas3Jdcle8BTq+t/xGC21O0LwsaUI=;
 b=DIXVu8BVad7x4eYUhz7pNtf5J8AARByEWif9nCxw5pUbM75ukkyfealJlK+zRt3MUt80E2KPHTUosUr4qm4sNFplcEsljZ7y2/utYTuiDnMTaYEGFo53WDxWL9FJJFtpwPABCZyQtMThir+Ues/JwBtJy8F16ev2l+UC0il0rVs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4576.eurprd03.prod.outlook.com (2603:10a6:803:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 31 Jul
 2020 10:23:26 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 10:23:26 +0000
Subject: Re: [PATCH 1/1] linux-user: Add support for SG_IO and
 SG_GET_VERSION_NUM raw SCSI ioctls
To: Leif N Huhn <leif.n.huhn@gmail.com>, qemu-devel@nongnu.org
References: <20200730025548.237905-1-leif.n.huhn@gmail.com>
 <20200730025548.237905-2-leif.n.huhn@gmail.com>
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-ID: <2b0db8d3-cd3a-4f62-1f90-8554c6195686@syrmia.com>
Date: Fri, 31 Jul 2020 12:23:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200730025548.237905-2-leif.n.huhn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (147.91.217.238) by
 LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 10:23:26 +0000
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7014b631-eb66-4d67-b416-08d8353bc321
X-MS-TrafficTypeDiagnostic: VI1PR03MB4576:
X-Microsoft-Antispam-PRVS: <VI1PR03MB45761F7FB6D683EADDA82F2EEB4E0@VI1PR03MB4576.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QYIIYhPnccEPrYRtiZ3yLp5Cc2Rj2p7u/oiZRs/mQlfxwBJ/0xNwnCPtNlwgv5xE3FX6Ns4hdx4MuiQ1ELCseAX4i1YZ97SWYGxEvRolMWr/+BieTWCjSw1kAOzAv222qU37LpL6xt3UcRaNFZDmleTZ96z1S5E8GjVSNfZe47sacUuPgMdpw5EuocXxqVYTNhm6af08XK2yxCzojysZofdWyxRXi3+JHLMGSSDGqx97/msB/DqFKXELTv/SKP4n/k7JfM2Hdxz14JN9Xmi54H6X9Wfe9s9fXg2qQSoFkdKIZrWijPU9THZ/dg2h9D9GGCeZy2pz+86RcZFwOc76T8maW5+9lqdRzgbxyztVffXl/ScXbRImeDVn1fcobPY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39830400003)(396003)(376002)(366004)(86362001)(66556008)(31686004)(36756003)(186003)(2906002)(26005)(66946007)(16526019)(66476007)(31696002)(5660300002)(6486002)(8676002)(8936002)(508600001)(16576012)(2616005)(52116002)(956004)(316002)(6666004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PaBukmaDHQdajPODoMueX0RjlLLzyFzhSOGtZDVjA+7KXA83CCBOsykJqivwI/HI+WovPc2+4Lyp06VpAOlH8fYQQy3exEgURNAoLBz5YSZ0TqLT1JL1ZJuBxnr8ToAN/Map+2WGuLTUDzItzLPp92FpDQJHvnenG/Kajv76BL+I45sh/4B3x2+UDMG3dG6d5cpi6yPvcYtrATwdDXhp7NzLJGDEzT4ny1KQnadfpmd1apFUccc+yq1drLUVFoZ6Oqme12ZvY9ffcmOtuMLVSzbu8915Zu90adY4EvEuORwD7lml41y9bW1ILVitBegTQCsbRvL8p2OTPL5gyanW1aZZL4/C5S2wbognrGxJHDEwyMGTau9ixlD/lNYnr4t28jaFAEoNM8cMa7rrUIKKmHr19fDtFe8NnLtSyiEbuDwV9UZSB2o3i4VE1hZKagEB3z141SXo4aBCPFjs8X4slT8DbbzjbtEObb9/O+s0BCU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7014b631-eb66-4d67-b416-08d8353bc321
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 10:23:26.7902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnEZqrCt//CWrSYRbq9sv2WXcxTcH+TqF6KTaXyAFDELAieCoSdQiZ4eCR6E6oNdL0XO/Qs2oFdxkvzYnX/JFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4576
Received-SPF: pass client-ip=40.107.14.131;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 06:23:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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


On 30.7.20. 04:55, Leif N Huhn wrote:
> This patch implements functionalities of following ioctls:
>
> SG_GET_VERSION_NUM - Returns SG driver version number
>
>      The sg version numbers are of the form "x.y.z" and the single number given
>      by the SG_GET_VERSION_NUM ioctl() is calculated by
>      (x * 10000 + y * 100 + z).
>
> SG_IO - Permits user applications to send SCSI commands to a device
>
>      It is logically equivalent to a write followed by a read.
>
> Implementation notes:
>
>      For SG_GET_VERSION_NUM the value is an int and the implementation is
>      straightforward.
>
>      For SG_IO, the generic thunk mechanism is used, and works correctly when
>      the host and guest architecture have the same pointer size. A special ioctl
>      handler may be needed in other situations and is not covered in this
>      implementation.
>
> Signed-off-by: Leif N Huhn <leif.n.huhn@gmail.com>
> ---
>   linux-user/ioctls.h        |  2 ++
>   linux-user/syscall.c       |  1 +
>   linux-user/syscall_defs.h  | 33 +++++++++++++++++++++++++++++++++
>   linux-user/syscall_types.h |  5 +++++
>   4 files changed, 41 insertions(+)
>
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0713ae1311..92e2f65e05 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -333,6 +333,8 @@
>     IOCTL(CDROM_DRIVE_STATUS, 0, TYPE_NULL)
>     IOCTL(CDROM_DISC_STATUS, 0, TYPE_NULL)
>     IOCTL(CDROMAUDIOBUFSIZ, 0, TYPE_INT)
I think there should be a space between ioctls of different groups (in 
this case CDROM and SG).
> +  IOCTL(SG_GET_VERSION_NUM, 0, TYPE_INT)

SG_GET_VERSION_NUM reads the SG driver version number which means it is of

type IOC_R. The 0 is used only for ioctl types that don't have the third 
argument. Also,

the third argument is a pointer to a 'TYPE_INT' since it is used for 
reading. I tried

your patch with sg_simple1 and I get the different version number with 
native and

cross execution so I think this needs to be corrected. The IOCTL(...) 
definition should be:

         IOCTL(SG_GET_VERSION_NUM, IOC_R, MK_PTR(TYPE_INT))

After this, the 'SG_GET_VERSION_NUM' works fine.

> +  IOCTL(SG_IO, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_sg_io_hdr)))
>   
>   #if 0
>     IOCTL(SNDCTL_COPR_HALT, IOC_RW, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 945fc25279..d846ef1af2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -115,6 +115,7 @@
>   #ifdef HAVE_DRM_H
>   #include <libdrm/drm.h>
>   #endif
> +#include <scsi/sg.h>
>   #include "linux_loop.h"
>   #include "uname.h"
>   
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..0e3004eb31 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2774,4 +2774,37 @@ struct target_statx {
>      /* 0x100 */
>   };
>   
> +/* from kernel's include/scsi/sg.h */
> +
> +#define TARGET_SG_GET_VERSION_NUM 0x2282 /* Example: version 2.1.34 yields 20134 */
> +/* synchronous SCSI command ioctl, (only in version 3 interface) */
> +#define TARGET_SG_IO 0x2285   /* similar effect as write() followed by read() */
> +
> +struct target_sg_io_hdr
> +{
> +    int interface_id;           /* [i] 'S' for SCSI generic (required) */
> +    int dxfer_direction;        /* [i] data transfer direction  */
> +    unsigned char cmd_len;      /* [i] SCSI command length */
> +    unsigned char mx_sb_len;    /* [i] max length to write to sbp */
> +    unsigned short iovec_count; /* [i] 0 implies no scatter gather */
> +    unsigned int dxfer_len;     /* [i] byte count of data transfer */
> +    abi_ulong    dxferp;	/* [i], [*io] points to data transfer memory
> +					      or scatter gather list */
> +    abi_ulong    cmdp;          /* [i], [*i] points to command to perform */
> +    abi_ulong    sbp;		/* [i], [*o] points to sense_buffer memory */
> +    unsigned int timeout;       /* [i] MAX_UINT->no timeout (unit: millisec) */
> +    unsigned int flags;         /* [i] 0 -> default, see SG_FLAG... */
> +    int pack_id;                /* [i->o] unused internally (normally) */
> +    abi_ulong     usr_ptr;      /* [i->o] unused internally */
> +    unsigned char status;       /* [o] scsi status */
> +    unsigned char masked_status;/* [o] shifted, masked scsi status */
> +    unsigned char msg_status;   /* [o] messaging level data (optional) */
> +    unsigned char sb_len_wr;    /* [o] byte count actually written to sbp */
> +    unsigned short host_status; /* [o] errors from host adapter */
> +    unsigned short driver_status;/* [o] errors from software driver */
> +    int resid;                  /* [o] dxfer_len - actual_transferred */
> +    unsigned int duration;      /* [o] time taken by cmd (unit: millisec) */
> +    unsigned int info;          /* [o] auxiliary information */
> +};  /* 64 bytes long (on i386) */
> +

This target structure is defined, but is not used anywhere. It should be 
used

in a special ioctl handling function for SG_IO to convert the values of 
'sg_io_hdr'

between host and target.

>   #endif
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 3f1f033464..3752d217e2 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -59,6 +59,11 @@ STRUCT(cdrom_read_audio,
>          TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_INT, TYPE_PTRVOID,
>          TYPE_NULL)
>   
> +STRUCT(sg_io_hdr,
> +       TYPE_INT, TYPE_INT, TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_INT, TYPE_PTRVOID,
> +       TYPE_PTRVOID, TYPE_PTRVOID, TYPE_INT, TYPE_INT, TYPE_INT, TYPE_PTRVOID, TYPE_CHAR,
> +       TYPE_CHAR, TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_SHORT, TYPE_INT, TYPE_INT, TYPE_INT)
> +

I think a nicer and cleaner way to define the thunk types is to write 
the types in separate lines

followed by a tail comment which describes the field type. Something like:

        STRUCT(sg_io_hdr,

                      TYPE_INT, /* interface_id */

                      TYPE_INT, /* dxfer_direction */

                      TYPE_CHAR, /* cmd_len */

                       ...

This way it is less likely that an issue can ocurr (i.e. to forget a 
field) and it makes the

code more reviewable. You can check out other examples from 
'syscall_types.h' (i.e. snd_timer_id,

loop_info).


Best regards,

Filip

>   STRUCT(hd_geometry,
>          TYPE_CHAR, TYPE_CHAR, TYPE_SHORT, TYPE_ULONG)
>   


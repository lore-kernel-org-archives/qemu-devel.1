Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59022C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262E820723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="u7Rj4tt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262E820723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJ9Q-0006ns-ER
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stefan.Brankovic@syrmia.com>)
 id 1jrJ8P-0005Su-7y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:41:33 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com
 ([40.107.3.104]:55008 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stefan.Brankovic@syrmia.com>)
 id 1jrJ8N-0005av-2i
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr3uXaR+Ty/pCJjapuajoycs+TnuJcFwv0aR3C/BPSN+Omar4KLm5LGKNlcoSgxE2gUOIeFHRpBTdbXuGUmOzsy4a5v0GFHNsShpf/0k86EJxAXTeBj1JkH/4fKZCJ2KrHFs5VXx/S3vqdX2sQdDfWvh30CVsWHS37hUAaPR5dbPcuTV2gevf2bYNOVqTjC2KfaambMRpX47hiaNVqbVyI5vnzDiXXn+SXXE4pHg7iCUfMuHRWIU9BEaim5ORn5QHJJFPK3ndbV3iNgnnw9q5+LRuaZhBIw+DxBGXyTmajWYXe+xTHDOSQF4CrmMW2JCsNx9bRJTV6f3dOCDhLpyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S8nvVkG36YU52ZiJVr4xiPOIc9K5SiCVpnzRGzM6TY=;
 b=dN/VuhbmoR/Wtrgg9Ycdmn82eq8UHzaPPhi2m9oZry40qLLRlQ+0CSo27uS+Zx0B3KY60QlDItX8ShDEy1o1yBqVli0/YWIYy3vSyCI61MS+XEqUmaD8cKynB3houWqAqPlr25t0FZbn1M3FZ43vCwVkSh0FPpk0iRxKIeJ2xyFSSVP0/WvqHxLQvqLViRGvDql65Ok4esIqTFtDWO5lZTBGUbE6h/fN4uWrqCnIqDU6o3irxTq6uvI2iqnKScoiNWbGmdIFbNuA+XWYXufG3IXQPdOrxmfO4FpUESJQbxF2iWSs2fek5xJdkaiFQ5c4y/zr0yFIEKrviWYHCIB5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S8nvVkG36YU52ZiJVr4xiPOIc9K5SiCVpnzRGzM6TY=;
 b=u7Rj4tt/g3CXngs56CMHwPLh5wnqJzNgrr51Bn73sKl1ii00/AM6IuTHepFZ+Obif7hmGxpOI+8P0eArEM/EmAsyz5MdB4ixpBY5ZM3DHHkyBaaMSvpbRJ4BwoUdw9FVxRNHaKNmB3BDbolOf1prdN7XrW9c5mSzK3eYazbUfoE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=syrmia.com;
Received: from AM0PR03MB3844.eurprd03.prod.outlook.com (2603:10a6:208:6b::15)
 by AM0PR0302MB3170.eurprd03.prod.outlook.com (2603:10a6:208:a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Fri, 3 Jul
 2020 10:41:28 +0000
Received: from AM0PR03MB3844.eurprd03.prod.outlook.com
 ([fe80::948d:5fa2:b171:c070]) by AM0PR03MB3844.eurprd03.prod.outlook.com
 ([fe80::948d:5fa2:b171:c070%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 10:41:28 +0000
Subject: Re: [PATCH 1/1] disas: mips: Add Loongson 2F disassembler
To: Thomas Huth <thuth@redhat.com>,
 Stefan Brankovic <stefanbrankovic96@gmail.com>, qemu-devel@nongnu.org
References: <20200702194230.10769-1-stefan.brankovic@syrmia.com>
 <20200702194230.10769-2-stefan.brankovic@syrmia.com>
 <59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com>
 <9f3e8408-3e8c-86ca-989a-a373f9656493@syrmia.com>
 <bbffd90c-d4f1-19ed-ec43-7c6de4cd2aaf@redhat.com>
From: Stefan Brankovic <stefan.brankovic@syrmia.com>
Message-ID: <433fd2c6-1ce0-ec2e-e024-c9e17469bf8d@syrmia.com>
Date: Fri, 3 Jul 2020 12:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <bbffd90c-d4f1-19ed-ec43-7c6de4cd2aaf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: VI1PR08CA0113.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::15) To AM0PR03MB3844.eurprd03.prod.outlook.com
 (2603:10a6:208:6b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (109.93.62.240) by
 VI1PR08CA0113.eurprd08.prod.outlook.com (2603:10a6:800:d4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Fri, 3 Jul 2020 10:41:27 +0000
X-Originating-IP: [109.93.62.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1bf645d-f79f-4571-e4c8-08d81f3da409
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3170:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0302MB31703AFF2F71EF724E4EA7C8EA6A0@AM0PR0302MB3170.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHyiNFMaRhsiNhJscsSD2FkdFeJSwKJIdoTMir6AybGoqWLOMxxWUQw5umzS302GHsRiCyVfPEvgnSPmKBVBu7Ihkly9Q2amUF65s54ODkg4nLUPVSJbAAUB7p8/4I6Mx/vcrcrBy3aShEQAE0UKeJHZByr3f76pd30kSSrG7i9Ud09fis8+NLBfk/i1y5kqUXzREDAYbjBUqypezU6PWssmYYe3XhrxUL0zkjC+ck3zFVr4fo5+H7OIWMIVnRjwMebLAycWKb3qOrhPdxjgV242hlPm1fL4GfaXQHH/3A9wwNpczkcFJ43e1r3lTYfPyrrUFDMgbGCwIcstoYaWxl7zp9GAXGcUUqso1wspFtByfs7d2JGjgTrLRd98Hb6O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB3844.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(136003)(39830400003)(346002)(396003)(376002)(186003)(31686004)(2906002)(36756003)(66946007)(16576012)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(26005)(8936002)(16526019)(31696002)(86362001)(2616005)(6486002)(956004)(52116002)(508600001)(54906003)(110136005)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HfM7rKO+UPXYdTd7PG9WoilbtcEx0ijGeNSSZVjeKNNkwWG4mI2dLwMv7SsnzhZomHeI3LbpANmwpCk9N+raeUG1EceS5wDLUh6wGyU3FO/w9Sp/79p51OZz4Umi3+fQTBGS6Q10RHZYKqwyOHIAZOns1ALzr3C4cQtFmWLGag73Z45QwWC1ihh/inwVYWiVj6g/XF2z1JTguFAsG42KN9J0dIstndgbbvSnp66iK6au2neIHD+ZiJUWge40/yzq2nTyH8XQsufYTfJvR4xloM1Slpcwr8Akj2HNjBDpz/H9W7HX8sqgOTb6LppV6PqZiOZRGkTypsbgwGR0+OGcgHKNCyJTFj2HQp2cFJk5wTVjngABcEmR9yrXWBnZqVVPJtFkFNPE+dWCBuM+RMSmyErFJWc5klJRN/VPHGu4FBPZn5/BTKdFyR6cL6GcHaSnVscQY+4kFOZOp2iAKH3DbM3YLbJ9JcH842V3FOKBGJ8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bf645d-f79f-4571-e4c8-08d81f3da409
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB3844.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 10:41:27.9822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2JvnQ02wH4XlfdnRXBRCuCAO5FpOia3pdxTjvO6LUD7/I92ZBykubE1F9BNQDBVZ5vjWac0JiC2AxZo620HuYoEHiHKf2hyWVcoeh4EDv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3170
Received-SPF: pass client-ip=40.107.3.104;
 envelope-from=Stefan.Brankovic@syrmia.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 06:41:29
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@syrmia.com, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 3.7.20. 12:09, Thomas Huth wrote:
> On 03/07/2020 11.49, Stefan Brankovic wrote:
>> On 3.7.20. 09:59, Thomas Huth wrote:
>>> On 02/07/2020 21.42, Stefan Brankovic wrote:
>>>> Add disassembler for Loongson 2F instruction set.
>>>>
>>>> Testing is done by comparing qemu disassembly output, obtained by
>>>> using -d in_asm command line option, with appropriate objdump output.
>>>>
>>>> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
>>>> ---
>>>>    MAINTAINERS             |    1 +
>>>>    configure               |    1 +
>>>>    disas/Makefile.objs     |    1 +
>>>>    disas/loongson2f.cpp    | 8134 +++++++++++++++++++++++++++++++++++++++
>>>>    disas/loongson2f.h      | 2542 ++++++++++++
>>>>    include/disas/dis-asm.h |    1 +
>>>>    include/exec/poison.h   |    1 +
>>>>    target/mips/cpu.c       |    4 +
>>>>    8 files changed, 10685 insertions(+)
>>>>    create mode 100644 disas/loongson2f.cpp
>>>>    create mode 100644 disas/loongson2f.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3abe3faa4e..913ed2a6d3 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -219,6 +219,7 @@ S: Maintained
>>>>    F: target/mips/
>>>>    F: default-configs/*mips*
>>>>    F: disas/*mips*
>>>> +F: disas/loongson*
>>>>    F: docs/system/cpu-models-mips.rst.inc
>>>>    F: hw/intc/mips_gic.c
>>>>    F: hw/mips/
>>>> diff --git a/configure b/configure
>>>> index 597e909b53..e163dac53e 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -8102,6 +8102,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>>>>        disas_config "MIPS"
>>>>        if test -n "${cxx}"; then
>>>>          disas_config "NANOMIPS"
>>>> +      disas_config "LOONGSON2F"
>>>>        fi
>>>>      ;;
>>>>      moxie*)
>>>> diff --git a/disas/Makefile.objs b/disas/Makefile.objs
>>>> index 3c1cdce026..0d5ee1e038 100644
>>>> --- a/disas/Makefile.objs
>>>> +++ b/disas/Makefile.objs
>>>> @@ -14,6 +14,7 @@ common-obj-$(CONFIG_I386_DIS) += i386.o
>>>>    common-obj-$(CONFIG_M68K_DIS) += m68k.o
>>>>    common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
>>>>    common-obj-$(CONFIG_MIPS_DIS) += mips.o
>>>> +common-obj-$(CONFIG_LOONGSON2F_DIS) += loongson2f.o
>>>>    common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
>>>>    common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
>>>>    common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
>>>> diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp
>>>> new file mode 100644
>>>> index 0000000000..a2f32dcf93
>>>> --- /dev/null
>>>> +++ b/disas/loongson2f.cpp
>>>> @@ -0,0 +1,8134 @@
>>> This file (and the header) lack a proper header comment. Which license
>>> do you want to use for this code? Who wrote the initial implementation?
>> I will add proper license comments in v2. I will use GPL2+ license.
>> Thanks for reminding. This is the initial implementation, and I am the
>> author.
>>> Also, unless you've copied the code from another project that uses
>>> C++, why did you use C++ here?
>> This is disassembler is written as a generic disassembler that can be
>> integrated into other projects. In this case, it is integrated into
>> QEMU. One of initial key requirements was that it uses C++ as its
>> language.
> Ok, fair, but please mention that rationale in the commit description
> when you send v2.

I will mention it in commit description. Thanks for your suggestions.


Kind Regard,

Stefan

>
>   Thanks,
>    Thomas
>


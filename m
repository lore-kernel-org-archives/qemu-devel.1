Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA92C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA3D20720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Rmi9jGtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA3D20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIa0-0002XW-NM
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stefan.Brankovic@syrmia.com>)
 id 1jrIZD-00021U-La
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:05:15 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com
 ([40.107.15.128]:38729 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stefan.Brankovic@syrmia.com>)
 id 1jrIZ7-00050d-4V
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrXw1mNSEQeuGTpiT/hWRAU6ChNMGDPJ0I6IdUQELDn8ATbTovPFHOTM6u38SVeoFtoZ/+0ioDYB1D4o7gsPxbfqNiqFQ+No37BX7oKB93VN3KSyu2WTddN1GpgLbJrBQQyiqNYqdO2nQOy/xBgJIl+CgFNS73vhQPfi33KlL/d1VaFG6eUX27b3IrUw09iLz5vYUETXNXj/j+VQy9ZruCNOAFFKg1+ozMU+iswNdYqxWACXi1c0nNGucN9A7hPdAep83u2CfdDbHvMwwuE7ZFAVwFDXRkan17NBlHWtM/4tU+Z0iSuN5A1Z83b+jio+VxV4DUj+c5HwNgIuX8FHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTYP5rWDSaySTqtfsxZOtL+P6Ly8MZusmqdw7s+VK3I=;
 b=O7Ku8F11fQn+TfkoH4V4nSNDqrHG33tr2vSRbIhCIYNznB5ZOutaMxuhQtO37vwNJ4WYBVUxjE6/9VFbLbqVrpadmtNLuDsuYouMvOlcDIiyuoZm2OuoFRn9YGPlb73yRM14ZxZytwkM1jqZ7DiSmlhqt5V0PRuQk6bCrArbODVv7srQyJHnuQTlzjrJ8D5krnAYpMq/m52jKYksMVNC8S2XNTyT4LtSi/mxPERmcC5NVYf9MeA9JPDnXwMM+ht1Iz+/XuWTXVZePfzNbg8HgsOGPUfYhZDdf4EQ0s8IgF4pMtgoxX73+1/XNbAtAImYWlpfLndftJ9nUNlpZtpKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTYP5rWDSaySTqtfsxZOtL+P6Ly8MZusmqdw7s+VK3I=;
 b=Rmi9jGtlXmDKzLQLwCOqFcw1mzAZPsdC0Rz+RoPPjQeS7PLpvyyUe7IDwObBVSUBycWJHLd7jIppbL+33lwKynkdZacbFNXc401jRYGbmatT5EniGUSxf98dfdStDvP/axGVEerXAIjRnbue57rwYc4bYqjR9IV4LOpcFCu6pOU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=syrmia.com;
Received: from AM0PR03MB3844.eurprd03.prod.outlook.com (2603:10a6:208:6b::15)
 by AM0PR03MB5860.eurprd03.prod.outlook.com (2603:10a6:208:165::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 09:49:58 +0000
Received: from AM0PR03MB3844.eurprd03.prod.outlook.com
 ([fe80::948d:5fa2:b171:c070]) by AM0PR03MB3844.eurprd03.prod.outlook.com
 ([fe80::948d:5fa2:b171:c070%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 09:49:58 +0000
Subject: Re: [PATCH 1/1] disas: mips: Add Loongson 2F disassembler
To: Thomas Huth <thuth@redhat.com>,
 Stefan Brankovic <stefanbrankovic96@gmail.com>, qemu-devel@nongnu.org
References: <20200702194230.10769-1-stefan.brankovic@syrmia.com>
 <20200702194230.10769-2-stefan.brankovic@syrmia.com>
 <59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com>
From: Stefan Brankovic <stefan.brankovic@syrmia.com>
Message-ID: <9f3e8408-3e8c-86ca-989a-a373f9656493@syrmia.com>
Date: Fri, 3 Jul 2020 11:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------6B60959D4BE86CF1DB4B3308"
Content-Language: en-US
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To AM0PR03MB3844.eurprd03.prod.outlook.com
 (2603:10a6:208:6b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (109.93.62.240) by
 VI1P195CA0073.EURP195.PROD.OUTLOOK.COM (2603:10a6:802:59::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 09:49:58 +0000
X-Originating-IP: [109.93.62.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a00df4b2-8838-4d46-3ad5-08d81f3672be
X-MS-TrafficTypeDiagnostic: AM0PR03MB5860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR03MB5860C6C446BCC6A466888374EA6A0@AM0PR03MB5860.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMaocbXnrwU7u9fM3kPNG0EhcTJstK0SXpp1s8AtMjTOvpao7qd2ZpcfGg3uXTHN0aqMlrjvleIViDxwJrKY+CZmxlLYtLDi3jNbLByuQ68GHXc8E+Ofoyxct3/Fi2X46UxPvaiub1ZfXl15K4SdiKRgUk019YszYKQx69DmWE6HTMRyt8mfPeUglZZDBZvXAdz4yc/DUVC2SJ2/QtwELkEWWq9xqbzNeEo+8wrIY/2BoE7EHRxzOp4a3+dw/izfrQW5EuF0nUpSborDjd6qoWnrOtfu1cwMo4JckQDKKOGgKwIulOGswNeZSK83KjJgbNevi2E+/Q6nJxxlzJQYjZWMfWMPmT3Q4jnjwaaLHpAd2Vpu6kMrefvtRd/3yQgm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB3844.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(136003)(366004)(346002)(508600001)(5660300002)(8936002)(4326008)(2616005)(956004)(316002)(52116002)(54906003)(110136005)(31686004)(8676002)(16576012)(33964004)(16526019)(186003)(26005)(6486002)(44832011)(66476007)(86362001)(31696002)(83380400001)(2906002)(36756003)(66556008)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6F+gmZ7kBNR/+q9klkjZnd0/ub1fwPyhXgQ/KgNWo2WhnOe9ZvfxL5I4t1lGjb09TaSA56Sky/Dg2puPSSXRaV79ndbU+lc0LwDHpoTeO014YMLLlFYNb7uFwgfu374SAIc3GXSdgCDXLNIC2wH7pNk0ZeDsGGddTKYPeUUCSQWqA6xwOvxaEJmjC9MwqPcDlTRzTVvIe7/BgBpXa6w6eyBdZYJaFVAqY5TxwrMOwh2FooaQ20tcvxayshmKJ/ZMFbtGEiQPsEbssKMH5rl5+bai16CXfrmm2/nR2BTLLMHv+K21C2MHQHN1FSC1cthXLYw73J2/FpwNk7J5uBReVq0haIPPOeFKQ3YaeFTlZHe23Kz/S+aIYAMWr99jByEejl0H2PlMNhwhgmwHJY3hBctxb0pEfujzDw0z0DcVOwAqK9Bx4KdU0Enu5vcM7uida4lfuEHMyJa0+MRfz1OEPkFXetAEs1sLdMP7WaidHag=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00df4b2-8838-4d46-3ad5-08d81f3672be
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB3844.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:49:58.8358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMJ9Z+qRDi8BSyWXWRGLMbrwualRn5VyYHFQLBnWX6M/B9GD+hoQVA0nNRykIkk0I+N+gMu3lrsCtX41lhOcNXpAdMIRwrGV+Lx1jxje0sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5860
Received-SPF: pass client-ip=40.107.15.128;
 envelope-from=Stefan.Brankovic@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 06:05:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------6B60959D4BE86CF1DB4B3308
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3.7.20. 09:59, Thomas Huth wrote:
> On 02/07/2020 21.42, Stefan Brankovic wrote:
>> Add disassembler for Loongson 2F instruction set.
>>
>> Testing is done by comparing qemu disassembly output, obtained by
>> using -d in_asm command line option, with appropriate objdump output.
>>
>> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
>> ---
>>   MAINTAINERS             |    1 +
>>   configure               |    1 +
>>   disas/Makefile.objs     |    1 +
>>   disas/loongson2f.cpp    | 8134 +++++++++++++++++++++++++++++++++++++++
>>   disas/loongson2f.h      | 2542 ++++++++++++
>>   include/disas/dis-asm.h |    1 +
>>   include/exec/poison.h   |    1 +
>>   target/mips/cpu.c       |    4 +
>>   8 files changed, 10685 insertions(+)
>>   create mode 100644 disas/loongson2f.cpp
>>   create mode 100644 disas/loongson2f.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3abe3faa4e..913ed2a6d3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -219,6 +219,7 @@ S: Maintained
>>   F: target/mips/
>>   F: default-configs/*mips*
>>   F: disas/*mips*
>> +F: disas/loongson*
>>   F: docs/system/cpu-models-mips.rst.inc
>>   F: hw/intc/mips_gic.c
>>   F: hw/mips/
>> diff --git a/configure b/configure
>> index 597e909b53..e163dac53e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -8102,6 +8102,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>>       disas_config "MIPS"
>>       if test -n "${cxx}"; then
>>         disas_config "NANOMIPS"
>> +      disas_config "LOONGSON2F"
>>       fi
>>     ;;
>>     moxie*)
>> diff --git a/disas/Makefile.objs b/disas/Makefile.objs
>> index 3c1cdce026..0d5ee1e038 100644
>> --- a/disas/Makefile.objs
>> +++ b/disas/Makefile.objs
>> @@ -14,6 +14,7 @@ common-obj-$(CONFIG_I386_DIS) += i386.o
>>   common-obj-$(CONFIG_M68K_DIS) += m68k.o
>>   common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
>>   common-obj-$(CONFIG_MIPS_DIS) += mips.o
>> +common-obj-$(CONFIG_LOONGSON2F_DIS) += loongson2f.o
>>   common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
>>   common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
>>   common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
>> diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp
>> new file mode 100644
>> index 0000000000..a2f32dcf93
>> --- /dev/null
>> +++ b/disas/loongson2f.cpp
>> @@ -0,0 +1,8134 @@
>
> This file (and the header) lack a proper header comment. Which license 
> do you want to use for this code? Who wrote the initial implementation?
I will add proper license comments in v2. I will use GPL2+ license.
Thanks for reminding. This is the initial implementation, and I am the
author.
>
> Also, unless you've copied the code from another project that uses 
> C++, why did you use C++ here?
This is disassembler is written as a generic disassembler that can be
integrated into other projects. In this case, it is integrated into
QEMU. One of initial key requirements was that it uses C++ as its
language.
> QEMU is C by default, we only allow C++ for some files that have been 
> taken from other C++ projects and need to be kept in sync from time to 
> time. So if you wrote this code from scratch, please use C instead.
There is no need for updating this disassembler, it is a complete
solution - with exceptions of possible bugs. However, I did extensive
testing, using objdump disassembly as a reference. Switching to C is
certainly possible, however it would be time-consuming, and at this
moment I simply don't have enough resources to do this.

Kind Regards,
Stefan
>
>
>  Thanks,
>   Thomas
>
>
>> +extern "C" {
>> +#include "qemu/osdep.h"
>> +#include "qemu/bitops.h"
>> +#include "disas/dis-asm.h"
>> +}
>> +
>> +#include "loongson2f.h"
>> +
>> +int print_insn_loongson2f(bfd_vma addr, disassemble_info *info)
>> +{
>> +    bfd_byte buffer[4];
>> +    uint32_t insn32;
>> +    int status;
>> +    Decoder *decoder = new Decoder();
>> +
>> +    status = info->read_memory_func(addr, buffer, 4, info);
>> +    if (status != 0) {
>> +        info->memory_error_func(status, addr, info);
>> +        return -1;
>> +    }
>> +    if (info->endian == BFD_ENDIAN_BIG) {
>> +        insn32 = bfd_getb32(buffer);
>> +    } else {
>> +        insn32 = bfd_getl32(buffer);
>> +    }
>> +
>> +    status = decoder->decode32(info, insn32);
>> +
>> +    delete decoder;
>> +
>> +    return status == 0 ? -1 : 4;
>> +}
>

--------------6B60959D4BE86CF1DB4B3308
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3.7.20. 09:59, Thomas Huth wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com">On
      02/07/2020 21.42, Stefan Brankovic wrote:
      <br>
      <blockquote type="cite">Add disassembler for Loongson 2F
        instruction set.
        <br>
        <br>
        Testing is done by comparing qemu disassembly output, obtained
        by
        <br>
        using -d in_asm command line option, with appropriate objdump
        output.
        <br>
        <br>
        Signed-off-by: Stefan Brankovic
        <a class="moz-txt-link-rfc2396E" href="mailto:stefan.brankovic@syrmia.com">&lt;stefan.brankovic@syrmia.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 &#43;
        <br>
        &nbsp; configure&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 &#43;
        <br>
        &nbsp; disas/Makefile.objs&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 &#43;
        <br>
        &nbsp; disas/loongson2f.cpp&nbsp;&nbsp;&nbsp; | 8134
        &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;
        <br>
        &nbsp; disas/loongson2f.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2542 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;
        <br>
        &nbsp; include/disas/dis-asm.h |&nbsp;&nbsp;&nbsp; 1 &#43;
        <br>
        &nbsp; include/exec/poison.h&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 &#43;
        <br>
        &nbsp; target/mips/cpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 &#43;
        <br>
        &nbsp; 8 files changed, 10685 insertions(&#43;)
        <br>
        &nbsp; create mode 100644 disas/loongson2f.cpp
        <br>
        &nbsp; create mode 100644 disas/loongson2f.h
        <br>
        <br>
        diff --git a/MAINTAINERS b/MAINTAINERS
        <br>
        index 3abe3faa4e..913ed2a6d3 100644
        <br>
        --- a/MAINTAINERS
        <br>
        &#43;&#43;&#43; b/MAINTAINERS
        <br>
        @@ -219,6 &#43;219,7 @@ S: Maintained
        <br>
        &nbsp; F: target/mips/
        <br>
        &nbsp; F: default-configs/*mips*
        <br>
        &nbsp; F: disas/*mips*
        <br>
        &#43;F: disas/loongson*
        <br>
        &nbsp; F: docs/system/cpu-models-mips.rst.inc
        <br>
        &nbsp; F: hw/intc/mips_gic.c
        <br>
        &nbsp; F: hw/mips/
        <br>
        diff --git a/configure b/configure
        <br>
        index 597e909b53..e163dac53e 100755
        <br>
        --- a/configure
        <br>
        &#43;&#43;&#43; b/configure
        <br>
        @@ -8102,6 &#43;8102,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disas_config &quot;MIPS&quot;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if test -n &quot;${cxx}&quot;; then
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disas_config &quot;NANOMIPS&quot;
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disas_config &quot;LOONGSON2F&quot;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi
        <br>
        &nbsp;&nbsp;&nbsp; ;;
        <br>
        &nbsp;&nbsp;&nbsp; moxie*)
        <br>
        diff --git a/disas/Makefile.objs b/disas/Makefile.objs
        <br>
        index 3c1cdce026..0d5ee1e038 100644
        <br>
        --- a/disas/Makefile.objs
        <br>
        &#43;&#43;&#43; b/disas/Makefile.objs
        <br>
        @@ -14,6 &#43;14,7 @@ common-obj-$(CONFIG_I386_DIS) &#43;= i386.o
        <br>
        &nbsp; common-obj-$(CONFIG_M68K_DIS) &#43;= m68k.o
        <br>
        &nbsp; common-obj-$(CONFIG_MICROBLAZE_DIS) &#43;= microblaze.o
        <br>
        &nbsp; common-obj-$(CONFIG_MIPS_DIS) &#43;= mips.o
        <br>
        &#43;common-obj-$(CONFIG_LOONGSON2F_DIS) &#43;= loongson2f.o
        <br>
        &nbsp; common-obj-$(CONFIG_NANOMIPS_DIS) &#43;= nanomips.o
        <br>
        &nbsp; common-obj-$(CONFIG_NIOS2_DIS) &#43;= nios2.o
        <br>
        &nbsp; common-obj-$(CONFIG_MOXIE_DIS) &#43;= moxie.o
        <br>
        diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp
        <br>
        new file mode 100644
        <br>
        index 0000000000..a2f32dcf93
        <br>
        --- /dev/null
        <br>
        &#43;&#43;&#43; b/disas/loongson2f.cpp
        <br>
        @@ -0,0 &#43;1,8134 @@
        <br>
      </blockquote>
      <br>
      This file (and the header) lack a proper header comment. Which
      license do you want to use for this code? Who wrote the initial
      implementation?
      <br>
    </blockquote>
    <font size="2"><span style="font-size:11pt;">I will add proper
        license comments in v2. I will use GPL2&#43; license.<br>
        Thanks for reminding. This is the initial implementation, and I
        am the<br>
        author.</span></font>
    <blockquote type="cite" cite="mid:59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com">
      <br>
      Also, unless you've copied the code from another project that uses
      C&#43;&#43;, why did you use C&#43;&#43; here?</blockquote>
    <font size="2"><span style="font-size:11pt;">This is disassembler is
        written as a generic disassembler that can be<br>
        integrated into other projects. In this case, it is integrated
        into<br>
        QEMU. One of initial key requirements was that it uses C&#43;&#43; as
        its<br>
        language.</span></font>
    <blockquote type="cite" cite="mid:59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com"> QEMU
      is C by default, we only allow C&#43;&#43; for some files that have been
      taken from other C&#43;&#43; projects and need to be kept in sync from
      time to time. So if you wrote this code from scratch, please use C
      instead.</blockquote>
    <font size="2"><span style="font-size:11pt;">There is no need for
        updating this disassembler, it is a complete<br>
        solution - with exceptions of possible bugs. However, I did
        extensive<br>
        testing, using objdump disassembly as a reference. Switching to
        C is<br>
        certainly possible, however it would be time-consuming, and at
        this<br>
        moment I simply don't have enough resources to do this.<br>
        <br>
        Kind Regards,<br>
        Stefan</span></font>
    <blockquote type="cite" cite="mid:59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com">
      <br>
      <br>
      &nbsp;Thanks,
      <br>
      &nbsp; Thomas
      <br>
      <br>
      <br>
      <blockquote type="cite">&#43;extern &quot;C&quot; {
        <br>
        &#43;#include &quot;qemu/osdep.h&quot;
        <br>
        &#43;#include &quot;qemu/bitops.h&quot;
        <br>
        &#43;#include &quot;disas/dis-asm.h&quot;
        <br>
        &#43;}
        <br>
        &#43;
        <br>
        &#43;#include &quot;loongson2f.h&quot;
        <br>
        &#43;
        <br>
        &#43;int print_insn_loongson2f(bfd_vma addr, disassemble_info *info)
        <br>
        &#43;{
        <br>
        &#43;&nbsp;&nbsp;&nbsp; bfd_byte buffer[4];
        <br>
        &#43;&nbsp;&nbsp;&nbsp; uint32_t insn32;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; int status;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; Decoder *decoder = new Decoder();
        <br>
        &#43;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; status = info-&gt;read_memory_func(addr, buffer, 4, info);
        <br>
        &#43;&nbsp;&nbsp;&nbsp; if (status != 0) {
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;memory_error_func(status, addr, info);
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; }
        <br>
        &#43;&nbsp;&nbsp;&nbsp; if (info-&gt;endian == BFD_ENDIAN_BIG) {
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insn32 = bfd_getb32(buffer);
        <br>
        &#43;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insn32 = bfd_getl32(buffer);
        <br>
        &#43;&nbsp;&nbsp;&nbsp; }
        <br>
        &#43;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; status = decoder-&gt;decode32(info, insn32);
        <br>
        &#43;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; delete decoder;
        <br>
        &#43;
        <br>
        &#43;&nbsp;&nbsp;&nbsp; return status == 0 ? -1 : 4;
        <br>
        &#43;}
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------6B60959D4BE86CF1DB4B3308--


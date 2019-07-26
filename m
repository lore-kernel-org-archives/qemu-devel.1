Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4AC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F18A22ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsBNHP00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18A22ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr6lN-0004xX-HP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 16:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hr6lC-0004Xn-77
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hr6lB-0000ma-6f
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:24:14 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hr6lA-0000kR-Th; Fri, 26 Jul 2019 16:24:13 -0400
Received: by mail-lf1-x144.google.com with SMTP id b29so30670199lfq.1;
 Fri, 26 Jul 2019 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PXPU/+3u/PF1EvWautdMOVSW0hs0VZxvTGJk3krtKXg=;
 b=XsBNHP00PjgCSCbp7vhXTjhYiiO0d8Mex4NT7yyc4R2wgtfnI86maYj+ZQQfO6BO4U
 IE80ETyTO7Y9VWBGtAuyQbayghxAZfgmnTihvJSgPw/TCJgFDS/bdFBtrhwiUDFW/a9F
 TZ4im8vSlgMqAE1QaaLd8wKsROKMhMN6sM/tW7FU4VQXXvQH4g+Uf9OgHAMi85zMlp67
 2LM+Fz8ocFmQNn7kGnW/tf6knTcsZRIcUCVsRYlN5CMHuIY2w+xNMpbEbUk/KtGQO+rl
 fkgI1SXY9enHn1Re9MT32QqPte+ZV9lBWSRUxN8L5brL9l4fMkQ9CmdEtUQVzvpggjIv
 cKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PXPU/+3u/PF1EvWautdMOVSW0hs0VZxvTGJk3krtKXg=;
 b=KUekyOtAv669V0UaVtPtqOx8bSH7Zq07RG2AibEq0WhkQqlR6aEyzdgGdkasvJiCp2
 LGTRvr9QEWt1Tue0IhIxd2Z750MHBucBnHfGOIJZcWDSZ/RakREddrriDPM6dvT4FMs0
 vOZ2kbvH1cM/FcG6wgZ1b2TGOHv9vg55puz+1+hIiob3I96v5UmbkjdvmlwuRmeSKgLv
 pO6OAwTvpZpKdK5O47sfspjP0V3/EL4/ccXjXluAfkgQrqu5ruDL/4XOAnJLSmi2yPkS
 ZIUI74szdHhiJBvdgA52puOHgewxNBe3g2Z0KyzywSV7deW9OGM155bEUHn6r8vK2NRm
 V4Mw==
X-Gm-Message-State: APjAAAUb5kNWjFCGEWTVNBGrQauy4v1xpZa/TbenY2i4Jk73J01T4JJ3
 WJGj3el2/m4YTxJell0GeSY10it0Xc5Wm6HxMbdIPKx4
X-Google-Smtp-Source: APXvYqyiaMU5q318h6TYVoZgB5sqKMzzvw1zMtJCj2+hgyta6uvWH/zYTwMAbXfQXzCkXXPAgFBakMv71EObS0ZosNg=
X-Received: by 2002:a19:6904:: with SMTP id e4mr26517940lfc.156.1564172651710; 
 Fri, 26 Jul 2019 13:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <10db21dad60854653b7b6272a44a63e2473af2b0.1564080680.git.alistair.francis@wdc.com>
 <CAEiOBXV1CfOfpTFFNas0cALjAkhjgDb78GkLusPO2bzoHROrxA@mail.gmail.com>
In-Reply-To: <CAEiOBXV1CfOfpTFFNas0cALjAkhjgDb78GkLusPO2bzoHROrxA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2019 13:20:38 -0700
Message-ID: <CAKmqyKPcC8x2vguti1V_c6LXdTrPQU_T1OFftvpvU1iwuofjjA@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 5/6] target/riscv: Update the
 Hypervisor CSRs to v0.4
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 10:41 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Fri, Jul 26, 2019 at 2:55 AM Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> Update the Hypervisor CSR addresses to match the v0.4 spec.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  target/riscv/cpu_bits.h | 35 ++++++++++++++++++-----------------
>>  1 file changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index 11f971ad5d..97b96c4e19 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -173,6 +173,24 @@
>>  #define CSR_SPTBR           0x180
>>  #define CSR_SATP            0x180
>>
>> +/* Hpervisor CSRs */
>> +#define CSR_HSTATUS         0x600
>> +#define CSR_HEDELEG         0x602
>> +#define CSR_HIDELEG         0x603
>> +#define CSR_HCOUNTERNEN     0x606
>> +#define CSR_HGATP           0x680
>> +
>> +#if defined(TARGET_RISCV32)
>> +#define HGATP_MODE           SATP32_MODE
>> +#define HGATP_ASID           SATP32_ASID
>> +#define HGATP_PPN            SATP32_PPN
>> +#endif
>> +#if defined(TARGET_RISCV64)
>> +#define HGATP_MODE           SATP64_MODE
>> +#define HGATP_ASID           SATP64_ASID
>> +#define HGATP_PPN            SATP64_PPN
>> +#endif
>> +
>
>
> Basd on spec, is HGATP_VMID  preferable ?

Yep, updated.

Alistair

>
> chihmin
>>
>>  /* Physical Memory Protection */
>>  #define CSR_PMPCFG0         0x3a0
>>  #define CSR_PMPCFG1         0x3a1
>> @@ -206,23 +224,6 @@
>>  #define CSR_DPC             0x7b1
>>  #define CSR_DSCRATCH        0x7b2
>>
>> -/* Hpervisor CSRs */
>> -#define CSR_HSTATUS         0xa00
>> -#define CSR_HEDELEG         0xa02
>> -#define CSR_HIDELEG         0xa03
>> -#define CSR_HGATP           0xa80
>> -
>> -#if defined(TARGET_RISCV32)
>> -#define HGATP_MODE           SATP32_MODE
>> -#define HGATP_ASID           SATP32_ASID
>> -#define HGATP_PPN            SATP32_PPN
>> -#endif
>> -#if defined(TARGET_RISCV64)
>> -#define HGATP_MODE           SATP64_MODE
>> -#define HGATP_ASID           SATP64_ASID
>> -#define HGATP_PPN            SATP64_PPN
>> -#endif
>> -
>>  /* Performance Counters */
>>  #define CSR_MHPMCOUNTER3    0xb03
>>  #define CSR_MHPMCOUNTER4    0xb04
>> --
>> 2.22.0
>>
>>


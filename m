Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 15:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589B820739
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 15:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toiFi3mA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589B820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js6Xr-0000vH-Hu
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 11:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1js6WY-0008QI-En
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 11:25:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1js6WR-0000s6-5Z
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 11:25:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so30001612wrs.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=pGzYKFmuqOEtMUiDwRVTevzN3SW1yRGNXVN7ByQ04to=;
 b=toiFi3mASEk+mXjIEb0XpD0ibwvIA9EAdG+UctcE4nMfFYUa3xA3mw9ocU8+89tYfa
 qoTke7i7DGP5QlaMddTRqoElk2tZiNwcHTTUQJJubk803KizwKP1+3zfbdBKzwMiIQOs
 wVSxtLSFMpoYm0zTkx9ZEgJFrvEjyyx4D0Wp7y+MgrZh6kfUY9IqSbgciXB/ZjMchTIk
 l1ogI5blVvZ/ugyrGppqPjKIokwqvFSV+VkW9R2OnfjomSKsqt+SiUyqBRvC9Ya3KWJm
 VDVxeZYQBzkkb144iLG9p2/7jeaCTGe5lzMfz4rBUGznpAxHa/jWb9V9GOVH66NoTRpe
 Fvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=pGzYKFmuqOEtMUiDwRVTevzN3SW1yRGNXVN7ByQ04to=;
 b=E3ottlyHyS7c9kELGzOBOrBlFfpTCuToQXaTugCqY620jfAQ3BoVvFug8eDWPhKv2+
 3DDxJUazvieOTdUnXBc9L6muqkk4bDLDC0biNL6jMbDFOw45hn3aqAk8C9txYvuVcIoK
 vmQuJqrN1UfN11ESIa581wM60ZA3pUPQgDQYEFNaEC4/agiE8YQuy13Hm0A5T4LUP4Hp
 B0HjBo3nqSeBqFN/Yubnjgj6khQ9o2U3krDYiaNI4rQ4RFBYaGFaNHnhO5qgj7dsCOHP
 WSAmqKJGoEnHvuFUbU9hyM9OtAUu//3egBvSWhB9P5JfZZybwW+hKhTG8oLwkJlGNbW/
 ijKw==
X-Gm-Message-State: AOAM532ux2qdN9cIDD+nb4oEGJDMpHkkrQnNYXZA3pmmTRr54C+ielDu
 vEh0VoPgOGKbiKf1cI/py9jFbLD2hoy1L7d02ds=
X-Google-Smtp-Source: ABdhPJxvyBkbcuaPGltfGrzmT9Q9ZmWztQ45W5X6XnMwXpbPJavkFMicqIP31tfWeZCZj9JtmG/KOVx3K4myQhIxsyg=
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr20504399wru.147.1593962736867; 
 Sun, 05 Jul 2020 08:25:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Sun, 5 Jul 2020 08:25:36 -0700 (PDT)
In-Reply-To: <CAHiYmc4bcYx6O1fekPbTj3SVZn+ZbnHgFXUUgb3Ym75w-h7-5g@mail.gmail.com>
References: <20200703104409.6986-1-stefan.brankovic@syrmia.com>
 <20200703104409.6986-2-stefan.brankovic@syrmia.com>
 <CAHiYmc4bcYx6O1fekPbTj3SVZn+ZbnHgFXUUgb3Ym75w-h7-5g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 5 Jul 2020 17:25:36 +0200
Message-ID: <CAHiYmc4YhTJUUhkN9DqMo_b=rZ4grTr+Hv=c5yjDSmKgb5wc1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] disas: mips: Add Loongson 2F disassembler
To: Stefan Brankovic <stefanbrankovic96@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b7611305a9b35e3a"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefan.brankovic@syrmia.com" <stefan.brankovic@syrmia.com>,
 "chenhc@lemote.com" <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b7611305a9b35e3a
Content-Type: text/plain; charset="UTF-8"

On Saturday, July 4, 2020, Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

>
>
> On Friday, July 3, 2020, Stefan Brankovic <stefanbrankovic96@gmail.com>
> wrote:
>
>> Add disassembler for Loongson 2F instruction set.
>>
>> Testing is done by comparing qemu disassembly output, obtained by
>> using -d in_asm command line option, with appropriate objdump output.
>>
>> This disassembler is written as a generic disassembler that can be
>> integrated into other projects. In this case, it is integrated into
>> QEMU. One of initial key requirements was that it uses C++ as its
>> language.
>>
>> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
>> ---
>
>
>
I did some basic tests, and the output matches objdump's.

Apart from the mentioned cosmetic changes with ALIAS_MAX_LEN, there is one
function invocation that should be under "ifdef", similar to the nanomips
counterpart case.

Otherwise:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>



> Thank you, Stefan!
>
> I am going to dor some independant testing in next few days, including
> building on systems without g++ (build should be successful, and the
> disassembler should fallback on the current one).
>
> I noticed some cosmetic improvements may still be done, like, for example,
> using [ALIAS_MAX_LEN] instead of [5] in numerous places. But, there is no
> need to respin (send a new version) just for this. Overall, the code looks
> well-organized and clean.
>
> An interesting topic for future work would be the automation of QEMU
> disassembler testing. Not only for this dissasembler, but for any supported
> disassembler in QEMU. I don't say you should do it, this is just a
> brainstorming idea, somebody may hopefully pick it up.
>
> Congratulations on this interesting work!
>
> Aleksandar
>
>
>
>
>>  MAINTAINERS             |    1 +
>>  configure               |    1 +
>>  disas/Makefile.objs     |    1 +
>>  disas/loongson2f.cpp    | 8154 +++++++++++++++++++++++++++++++++++++++
>>  disas/loongson2f.h      | 2562 ++++++++++++
>>  include/disas/dis-asm.h |    1 +
>>  include/exec/poison.h   |    1 +
>>  target/mips/cpu.c       |    4 +
>>  8 files changed, 10725 insertions(+)
>>  create mode 100644 disas/loongson2f.cpp
>>  create mode 100644 disas/loongson2f.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3abe3faa4e..913ed2a6d3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -219,6 +219,7 @@ S: Maintained
>>  F: target/mips/
>>  F: default-configs/*mips*
>>  F: disas/*mips*
>> +F: disas/loongson*
>>  F: docs/system/cpu-models-mips.rst.inc
>>  F: hw/intc/mips_gic.c
>>  F: hw/mips/
>> diff --git a/configure b/configure
>> index 597e909b53..e163dac53e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -8102,6 +8102,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>>      disas_config "MIPS"
>>      if test -n "${cxx}"; then
>>        disas_config "NANOMIPS"
>> +      disas_config "LOONGSON2F"
>>      fi
>>    ;;
>>    moxie*)
>> diff --git a/disas/Makefile.objs b/disas/Makefile.objs
>> index 3c1cdce026..0d5ee1e038 100644
>> --- a/disas/Makefile.objs
>> +++ b/disas/Makefile.objs
>> @@ -14,6 +14,7 @@ common-obj-$(CONFIG_I386_DIS) += i386.o
>>  common-obj-$(CONFIG_M68K_DIS) += m68k.o
>>  common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
>>  common-obj-$(CONFIG_MIPS_DIS) += mips.o
>> +common-obj-$(CONFIG_LOONGSON2F_DIS) += loongson2f.o
>>  common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
>>  common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
>>  common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
>> diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp
>> new file mode 100644
>> index 0000000000..e84a2c0f09
>> --- /dev/null
>> +++ b/disas/loongson2f.cpp
>> @@ -0,0 +1,8154 @@
>> +/*
>> + *  Source file for Loongson 2F disassembler component of QEMU
>> + *
>> + *  Copyright (C) 2020  Stefan Brankovic <stefan.brankovic@syrmia.com>
>> + *
>> + *  This program is free software: you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation, either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License
>> + *  along with this program.  If not, see <https://www.gnu.org/licenses/
>> >.
>> + *
>> + */
>> +
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
>> +    bfd_byte buffer[4];
>> +    uint32_t insn32;
>> +    int status;
>> +    Decoder *decoder = new Decoder();
>> +
>> +    status = info->read_memory_func(addr, buffer, 4, info);
>> +    if (status != 0) {
>> +        info->memory_error_func(status, addr, info);
>> +        return -1;
>> +    }
>> +    if (info->endian == BFD_ENDIAN_BIG) {
>> +        insn32 = bfd_getb32(buffer);
>> +    } else {
>> +        insn32 = bfd_getl32(buffer);
>> +    }
>> +
>> +    status = decoder->decode32(info, insn32);
>> +
>> +    delete decoder;
>> +
>> +    return status == 0 ? -1 : 4;
>> +}
>> +
>> +int Fields32RdRsRt::getRd()
>> +{
>> +    return this->rd;
>> +}
>> +
>> +int Fields32RdRsRt::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32RdRsRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32ImmRsRt::getImm()
>> +{
>> +    return this->imm;
>> +}
>> +
>> +int Fields32ImmRsRt::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32ImmRsRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32RdRs::getRd()
>> +{
>> +    return this->rd;
>> +}
>> +
>> +int Fields32RdRs::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32Rs::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32BaseOffsetRt::getBase()
>> +{
>> +    return this->base;
>> +}
>> +
>> +int Fields32BaseOffsetRt::getOffset()
>> +{
>> +    return this->offset;
>> +}
>> +
>> +int Fields32BaseOffsetRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32ImmRt::getImm()
>> +{
>> +    return this->imm;
>> +}
>> +
>> +int Fields32ImmRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32Rd::getRd()
>> +{
>> +    return this->rd;
>> +}
>> +
>> +int Fields32Stype::getStype()
>> +{
>> +    return this->stype;
>> +}
>> +
>> +int Fields32CodeRsRt::getCode()
>> +{
>> +    return this->code;
>> +}
>> +
>> +int Fields32CodeRsRt::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32CodeRsRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32ImmRs::getImm()
>> +{
>> +    return this->imm;
>> +}
>> +
>> +int Fields32ImmRs::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32FdFs::getFd()
>> +{
>> +    return this->fd;
>> +}
>> +
>> +int Fields32FdFs::getFs()
>> +{
>> +    return this->fs;
>> +}
>> +
>> +int Fields32FdFsFt::getFd()
>> +{
>> +    return this->fd;
>> +}
>> +
>> +int Fields32FdFsFt::getFs()
>> +{
>> +    return this->fs;
>> +}
>> +
>> +int Fields32FdFsFt::getFt()
>> +{
>> +    return this->ft;
>> +}
>> +
>> +int Fields32Offset::getOffset()
>> +{
>> +    return this->offset;
>> +}
>> +
>> +int Fields32FsFt::getFs()
>> +{
>> +    return this->fs;
>> +}
>> +
>> +int Fields32FsFt::getFt()
>> +{
>> +    return this->ft;
>> +}
>> +
>> +int Fields32FsRt::getFs()
>> +{
>> +    return this->fs;
>> +}
>> +
>> +int Fields32FsRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32BaseFtOffset::getBase()
>> +{
>> +    return this->base;
>> +}
>> +
>> +int Fields32BaseFtOffset::getFt()
>> +{
>> +    return this->ft;
>> +}
>> +
>> +int Fields32BaseFtOffset::getOffset()
>> +{
>> +    return this->offset;
>> +}
>> +
>> +int Fields32OffsetRsRt::getOffset()
>> +{
>> +    return this->offset;
>> +}
>> +
>> +int Fields32OffsetRsRt::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32OffsetRsRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32OffsetRs::getOffset()
>> +{
>> +    return this->offset;
>> +}
>> +
>> +int Fields32OffsetRs::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32Code::getCode()
>> +{
>> +    return this->code;
>> +}
>> +
>> +int Fields32Cop_fun::getCop_fun()
>> +{
>> +    return this->cop_fun;
>> +}
>> +
>> +int Fields32RsRt::getRs()
>> +{
>> +    return this->rs;
>> +}
>> +
>> +int Fields32RsRt::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32RdRtSa::getRd()
>> +{
>> +    return this->rd;
>> +}
>> +
>> +int Fields32RdRtSa::getRt()
>> +{
>> +    return this->rt;
>> +}
>> +
>> +int Fields32RdRtSa::getSa()
>> +{
>> +    return this->sa;
>> +}
>> +
>> +int Fields32Instr_index::getInstr_index()
>> +{
>> +    return this->instr_index;
>> +}
>> +
>> +void Fields32RdRsRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->rd = extract32(insn, 11, 5);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32ImmRsRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->imm = sextract32(insn, 0, 16);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32RdRsD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rd = extract32(insn, 11, 5);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32RsD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32BaseOffsetRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->base = extract32(insn, 21, 5);
>> +    this->offset = sextract32(insn, 0, 16);
>> +}
>> +
>> +void Fields32ImmRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->imm = extract32(insn, 0, 16);
>> +}
>> +
>> +void Fields32RdD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rd = extract32(insn, 11, 5);
>> +}
>> +
>> +void Fields32StypeD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->stype = extract32(insn, 6, 5);
>> +}
>> +
>> +void Fields32CodeRsRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->code = extract32(insn, 6, 10);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32ImmRsD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->imm = sextract32(insn, 0, 16);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32FdFsD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->fs = extract32(insn, 11, 5);
>> +    this->fd = extract32(insn, 6, 5);
>> +}
>> +
>> +void Fields32FdFsFtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->ft = extract32(insn, 16, 5);
>> +    this->fs = extract32(insn, 11, 5);
>> +    this->fd = extract32(insn, 6, 5);
>> +}
>> +
>> +void Fields32ImmRsRtD1::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->imm = extract32(insn, 0, 16);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32OffsetD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->offset = sextract32(insn, 0, 16);
>> +}
>> +
>> +void Fields32FsFtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->fs = extract32(insn, 11, 5);
>> +    this->ft = extract32(insn, 16, 5);
>> +}
>> +
>> +void Fields32FsRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->fs = extract32(insn, 11, 5);
>> +}
>> +
>> +void Fields32BaseFtOffsetD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->base = extract32(insn, 21, 5);
>> +    this->ft = extract32(insn, 16, 5);
>> +    this->offset = sextract32(insn, 0, 16);
>> +}
>> +
>> +void Fields32OffsetRsRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->rs = extract32(insn, 21, 5);
>> +    this->offset = sextract32(insn, 0, 16);
>> +}
>> +
>> +void Fields32OffsetRsD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rs = extract32(insn, 21, 5);
>> +    this->offset = sextract32(insn, 0, 16);
>> +}
>> +
>> +void Fields32CodeD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->code = extract32(insn, 6, 20);
>> +}
>> +
>> +void Fields32Cop_funD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->cop_fun = extract32(insn, 0, 26);
>> +}
>> +
>> +void Fields32RsRtD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->rs = extract32(insn, 21, 5);
>> +}
>> +
>> +void Fields32RdRtSaD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->rt = extract32(insn, 16, 5);
>> +    this->rd = extract32(insn, 11, 5);
>> +    this->sa = extract32(insn, 6, 5);
>> +}
>> +
>> +void Fields32Instr_indexD0::decode_fields32(uint32_t insn)
>> +{
>> +    this->instr_index = extract32(insn, 0, 26);
>> +}
>> +
>> +void Instruction32::getAlias(char *buffer, int regNo)
>> +{
>> +    switch (regNo) {
>> +    case 0:
>> +        strncpy(buffer, "zero", 5);
>> +        break;
>> +    case 1:
>> +        strncpy(buffer, "at", 5);
>> +        break;
>> +    case 2:
>> +    case 3:
>> +        sprintf(buffer, "v%d", regNo - 2);
>> +        break;
>> +    case 4:
>> +    case 5:
>> +    case 6:
>> +    case 7:
>> +    case 8:
>> +    case 9:
>> +    case 10:
>> +    case 11:
>> +        sprintf(buffer, "a%d", regNo - 4);
>> +        break;
>> +    case 12:
>> +    case 13:
>> +    case 14:
>> +    case 15:
>> +        sprintf(buffer, "t%d", regNo - 12);
>> +        break;
>> +    case 16:
>> +    case 17:
>> +    case 18:
>> +    case 19:
>> +    case 20:
>> +    case 21:
>> +    case 22:
>> +    case 23:
>> +        sprintf(buffer, "s%d", regNo - 16);
>> +        break;
>> +    case 24:
>> +    case 25:
>> +        sprintf(buffer, "t%d", regNo - 16);
>> +        break;
>> +    case 28:
>> +        strncpy(buffer, "gp", 5);
>> +        break;
>> +    case 29:
>> +        strncpy(buffer, "sp", 5);
>> +        break;
>> +    case 30:
>> +        strncpy(buffer, "s8", 5);
>> +        break;
>> +    case 31:
>> +        strncpy(buffer, "ra", 5);
>> +        break;
>> +    default:
>> +        sprintf(buffer, "r%d", regNo);
>> +        break;
>> +    }
>> +}
>> +
>> +Instruction32::~Instruction32() {}
>> +
>> +ADD::ADD(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool ADD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "ADD",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +ADDI::ADDI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool ADDI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ADDI",
>> +     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +ADDIU::ADDIU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool ADDIU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ADDIU",
>> +     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +ADDU::ADDU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool ADDU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "ADDU",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +AND::AND(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool AND::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "AND",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +ANDI::ANDI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRsRtD1();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool ANDI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ANDI",
>> +     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +BEQ::BEQ(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BEQ::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BEQ",
>> +     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()
>> ));
>> +    return true;
>> +}
>> +
>> +BEQL::BEQL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BEQL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BEQL",
>> +     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()
>> ));
>> +    return true;
>> +}
>> +
>> +BGEZ::BGEZ(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BGEZ::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZ",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BGEZAL::BGEZAL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BGEZAL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZAL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BGEZALL::BGEZALL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BGEZALL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZALL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BGEZL::BGEZL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BGEZL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGEZL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BGTZ::BGTZ(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BGTZ::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGTZ",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BGTZL::BGTZL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BGTZL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BGTZL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BLEZ::BLEZ(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BLEZ::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLEZ",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BLEZL::BLEZL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BLEZL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLEZL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BLTZ::BLTZ(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BLTZ::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZ",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BLTZAL::BLTZAL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BLTZAL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZAL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BLTZALL::BLTZALL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BLTZALL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZALL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BLTZL::BLTZL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BLTZL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32OffsetRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "BLTZL",
>> +     alias1, ((Fields32OffsetRs *)this->fields32)->getOffset()));
>> +    return true;
>> +}
>> +
>> +BNE::BNE(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BNE::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BNE",
>> +     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()
>> ));
>> +    return true;
>> +}
>> +
>> +BNEL::BNEL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32OffsetRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BNEL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32OffsetRsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32OffsetRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "BNEL",
>> +     alias1, alias2, ((Fields32OffsetRsRt *)this->fields32)->getOffset()
>> ));
>> +    return true;
>> +}
>> +
>> +BREAK::BREAK(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32CodeD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool BREAK::disas_output(disassemble_info *info)
>> +{
>> +    (info->fprintf_func(info->stream, "%-9s" " %d", "" "BREAK",
>> +     ((Fields32Code *)this->fields32)->getCode()));
>> +    return true;
>> +}
>> +
>> +COP0::COP0(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32Cop_funD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool COP0::disas_output(disassemble_info *info)
>> +{
>> +    (info->fprintf_func(info->stream, "%-9s" " %d", "" "COP0",
>> +     ((Fields32Cop_fun *)this->fields32)->getCop_fun()));
>> +    return true;
>> +}
>> +
>> +COP3::COP3(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32Cop_funD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool COP3::disas_output(disassemble_info *info)
>> +{
>> +    (info->fprintf_func(info->stream, "%-9s" " %d", "" "COP3",
>> +     ((Fields32Cop_fun *)this->fields32)->getCop_fun()));
>> +    return true;
>> +}
>> +
>> +DADD::DADD(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DADD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DADD",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +DADDI::DADDI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DADDI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DADDI",
>> +     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +DADDIU::DADDIU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DADDIU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DADDIU",
>> +     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +DADDU::DADDU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DADDU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DADDU",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +DDIV::DDIV(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DDIV::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DDIV",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +DDIVU::DDIVU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DDIVU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DDIVU",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +DIV::DIV(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DIV::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DIV",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +DIVU::DIVU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DIVU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DIVU",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +DMULT::DMULT(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DMULT::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DMULT",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +DMULTU::DMULTU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DMULTU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "DMULTU",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +DSLL::DSLL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRtSaD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSLL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSLL",
>> +     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
>> +    return true;
>> +}
>> +
>> +DSLL32::DSLL32(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRtSaD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSLL32::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSLL32",
>> +     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
>> +    return true;
>> +}
>> +
>> +DSLLV::DSLLV(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSLLV::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSLLV",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +DSRA::DSRA(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRtSaD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSRA::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRA",
>> +     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
>> +    return true;
>> +}
>> +
>> +DSRA32::DSRA32(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRtSaD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSRA32::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRA32",
>> +     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
>> +    return true;
>> +}
>> +
>> +DSRAV::DSRAV(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSRAV::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSRAV",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +DSRL::DSRL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRtSaD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSRL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRL",
>> +     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
>> +    return true;
>> +}
>> +
>> +DSRL32::DSRL32(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRtSaD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSRL32::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRtSa *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRtSa *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "DSRL32",
>> +     alias1, alias2, ((Fields32RdRtSa *)this->fields32)->getSa()));
>> +    return true;
>> +}
>> +
>> +DSRLV::DSRLV(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSRLV::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSRLV",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +DSUB::DSUB(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSUB::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSUB",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +DSUBU::DSUBU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool DSUBU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "DSUBU",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +J::J(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32Instr_indexD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool J::disas_output(disassemble_info *info)
>> +{
>> +    (info->fprintf_func(info->stream, "%-9s" " %d", "" "J",
>> +     ((Fields32Instr_index *)this->fields32)->getInstr_index()));
>> +    return true;
>> +}
>> +
>> +JAL::JAL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32Instr_indexD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool JAL::disas_output(disassemble_info *info)
>> +{
>> +    (info->fprintf_func(info->stream, "%-9s" " %d", "" "JAL",
>> +     ((Fields32Instr_index *)this->fields32)->getInstr_index()));
>> +    return true;
>> +}
>> +
>> +JALR::JALR(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool JALR::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RdRs *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "JALR",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +JR::JR(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool JR::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32Rs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s", "" "JR",
>> +     alias1));
>> +    return true;
>> +}
>> +
>> +LB::LB(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LB::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LB",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LBU::LBU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LBU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LBU",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LD::LD(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LD",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LDC2::LDC2(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LDC2::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LDC2",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LDL::LDL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LDL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LDL",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LDR::LDR(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LDR::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LDR",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LH::LH(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LH::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LH",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LHU::LHU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LHU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LHU",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LL::LL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LL",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LLD::LLD(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LLD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LLD",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LUI::LUI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LUI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32ImmRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d", "" "LUI",
>> +     alias1, ((Fields32ImmRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +LW::LW(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LW::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LW",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LWC2::LWC2(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LWC2::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWC2",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LWC3::LWC3(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LWC3::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWC3",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LWL::LWL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LWL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWL",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LWR::LWR(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LWR::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWR",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +LWU::LWU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool LWU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "LWU",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +MFHI::MFHI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool MFHI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32Rd *)this->fields32)->getRd());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MFHI",
>> +     alias1));
>> +    return true;
>> +}
>> +
>> +MFLO::MFLO(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool MFLO::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32Rd *)this->fields32)->getRd());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MFLO",
>> +     alias1));
>> +    return true;
>> +}
>> +
>> +MTHI::MTHI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool MTHI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32Rs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MTHI",
>> +     alias1));
>> +    return true;
>> +}
>> +
>> +MTLO::MTLO(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool MTLO::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    getAlias(alias1, ((Fields32Rs *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s", "" "MTLO",
>> +     alias1));
>> +    return true;
>> +}
>> +
>> +MULT::MULT(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool MULT::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "MULT",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +MULTU::MULTU(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool MULTU::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32RsRt *)this->fields32)->getRs());
>> +    getAlias(alias2, ((Fields32RsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s", "" "MULTU",
>> +     alias1, alias2));
>> +    return true;
>> +}
>> +
>> +NOR::NOR(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool NOR::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "NOR",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +OR::OR(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32RdRsRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool OR::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> +    getAlias(alias1, ((Fields32RdRsRt *)this->fields32)->getRd());
>> +    getAlias(alias2, ((Fields32RdRsRt *)this->fields32)->getRs());
>> +    getAlias(alias3, ((Fields32RdRsRt *)this->fields32)->getRt());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %s", "" "OR",
>> +     alias1, alias2, alias3));
>> +    return true;
>> +}
>> +
>> +ORI::ORI(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32ImmRsRtD1();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool ORI::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32ImmRsRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32ImmRsRt *)this->fields32)->getRs());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %s, %d", "" "ORI",
>> +     alias1, alias2, ((Fields32ImmRsRt *)this->fields32)->getImm()));
>> +    return true;
>> +}
>> +
>> +SB::SB(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool SB::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SB",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +SC::SC(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool SC::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SC",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +SCD::SCD(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool SCD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SCD",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +SD::SD(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool SD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SD",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +SDC2::SDC2(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool SDC2::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s" " %s, %d(%s)", "" "SDC2",
>> +     alias1, ((Fields32BaseOffsetRt *)this->fields32)->getOffset(),
>> alias2));
>> +    return true;
>> +}
>> +
>> +SDL::SDL(uint32_t insn)
>> +{
>> +    this->fields32 = new Fields32BaseOffsetRtD0();
>> +    this->fields32->decode_fields32(insn);
>> +}
>> +
>> +bool SDL::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    getAlias(alias1, ((Fields32BaseOffsetRt *)this->fields32)->getRt());
>> +    getAlias(alias2, ((Fields32BaseOffsetRt
>> *)this->fields32)->getBase());
>> +    (info->fprintf_func(info->stream, "%-9s"
>
>

--000000000000b7611305a9b35e3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, July 4, 2020, Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br><br>On Friday, July 3, 2020, S=
tefan Brankovic &lt;<a href=3D"mailto:stefanbrankovic96@gmail.com" target=
=3D"_blank">stefanbrankovic96@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Add disassembler for Loongson 2F instruction set.<br>
<br>
Testing is done by comparing qemu disassembly output, obtained by<br>
using -d in_asm command line option, with appropriate objdump output.<br>
<br>
This disassembler is written as a generic disassembler that can be<br>
integrated into other projects. In this case, it is integrated into<br>
QEMU. One of initial key requirements was that it uses C++ as its<br>
language.<br>
<br>
Signed-off-by: Stefan Brankovic &lt;<a href=3D"mailto:stefan.brankovic@syrm=
ia.com" target=3D"_blank">stefan.brankovic@syrmia.com</a>&gt;<br>
---</blockquote><div><br></div></blockquote><div><br></div><div>I did some =
basic tests, and the output matches objdump&#39;s.</div><div><br></div><div=
>Apart from the mentioned cosmetic changes with ALIAS_MAX_LEN, there is one=
 function invocation that should be under &quot;ifdef&quot;, similar to the=
 nanomips counterpart case.</div><div><br></div><div>Otherwise:</div><div><=
br></div><div>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksa=
ndar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>Thank you,=
 Stefan!</div><div><br></div><div>I am going to dor some independant testin=
g in next few days, including building on systems without g++ (build should=
 be successful, and the disassembler should fallback on the current one).</=
div><div><br></div><div>I noticed some cosmetic improvements may still be d=
one, like, for example, using [ALIAS_MAX_LEN] instead of [5] in numerous pl=
aces. But, there is no need to respin (send a new version) just for this. O=
verall, the code looks well-organized and clean.</div><div><br></div><div>A=
n interesting topic for future work would be the automation of QEMU disasse=
mbler testing. Not only for this dissasembler, but for any supported disass=
embler in QEMU. I don&#39;t say you should do it, this is just a brainstorm=
ing idea, somebody may hopefully pick it up.</div><div><br></div><div>Congr=
atulations on this interesting work!</div><div><br></div><div>Aleksandar</d=
iv><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 1 +<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 1 +<br>
=C2=A0disas/Makefile.objs=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0disas/loongson2f.cpp=C2=A0 =C2=A0 | 8154 ++++++++++++++++++++++++++++=
++<wbr>+++++++++<br>
=C2=A0disas/loongson2f.h=C2=A0 =C2=A0 =C2=A0 | 2562 ++++++++++++<br>
=C2=A0include/disas/dis-asm.h |=C2=A0 =C2=A0 1 +<br>
=C2=A0include/exec/poison.h=C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0target/mips/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +<br>
=C2=A08 files changed, 10725 insertions(+)<br>
=C2=A0create mode 100644 disas/loongson2f.cpp<br>
=C2=A0create mode 100644 disas/loongson2f.h<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 3abe3faa4e..913ed2a6d3 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -219,6 +219,7 @@ S: Maintained<br>
=C2=A0F: target/mips/<br>
=C2=A0F: default-configs/*mips*<br>
=C2=A0F: disas/*mips*<br>
+F: disas/loongson*<br>
=C2=A0F: docs/system/<a href=3D"http://cpu-models-mips.rs">cpu-models-mips.=
rs</a><wbr>t.inc<br>
=C2=A0F: hw/intc/mips_gic.c<br>
=C2=A0F: hw/mips/<br>
diff --git a/configure b/configure<br>
index 597e909b53..e163dac53e 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -8102,6 +8102,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do<br>
=C2=A0 =C2=A0 =C2=A0disas_config &quot;MIPS&quot;<br>
=C2=A0 =C2=A0 =C2=A0if test -n &quot;${cxx}&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0disas_config &quot;NANOMIPS&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 disas_config &quot;LOONGSON2F&quot;<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0moxie*)<br>
diff --git a/disas/Makefile.objs b/disas/Makefile.objs<br>
index 3c1cdce026..0d5ee1e038 100644<br>
--- a/disas/Makefile.objs<br>
+++ b/disas/Makefile.objs<br>
@@ -14,6 +14,7 @@ common-obj-$(CONFIG_I386_DIS) +=3D i386.o<br>
=C2=A0common-obj-$(CONFIG_M68K_DIS) +=3D m68k.o<br>
=C2=A0common-obj-$(CONFIG_MICROBLAZ<wbr>E_DIS) +=3D microblaze.o<br>
=C2=A0common-obj-$(CONFIG_MIPS_DIS) +=3D mips.o<br>
+common-obj-$(CONFIG_LOONGSON2<wbr>F_DIS) +=3D loongson2f.o<br>
=C2=A0common-obj-$(CONFIG_NANOMIPS_<wbr>DIS) +=3D nanomips.o<br>
=C2=A0common-obj-$(CONFIG_NIOS2_DIS<wbr>) +=3D nios2.o<br>
=C2=A0common-obj-$(CONFIG_MOXIE_DIS<wbr>) +=3D moxie.o<br>
diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp<br>
new file mode 100644<br>
index 0000000000..e84a2c0f09<br>
--- /dev/null<br>
+++ b/disas/loongson2f.cpp<br>
@@ -0,0 +1,8154 @@<br>
+/*<br>
+ *=C2=A0 Source file for Loongson 2F disassembler component of QEMU<br>
+ *<br>
+ *=C2=A0 Copyright (C) 2020=C2=A0 Stefan Brankovic &lt;<a href=3D"mailto:s=
tefan.brankovic@syrmia.com" target=3D"_blank">stefan.brankovic@syrmia.com</=
a>&gt;<br>
+ *<br>
+ *=C2=A0 This program is free software: you can redistribute it and/or mod=
ify<br>
+ *=C2=A0 it under the terms of the GNU General Public License as published=
 by<br>
+ *=C2=A0 the Free Software Foundation, either version 2 of the License, or=
<br>
+ *=C2=A0 (at your option) any later version.<br>
+ *<br>
+ *=C2=A0 This program is distributed in the hope that it will be useful,<b=
r>
+ *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+ *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e<br>
+ *=C2=A0 GNU General Public License for more details.<br>
+ *<br>
+ *=C2=A0 You should have received a copy of the GNU General Public License=
<br>
+ *=C2=A0 along with this program.=C2=A0 If not, see &lt;<a href=3D"https:/=
/www.gnu.org/licenses/" target=3D"_blank">https://www.gnu.org/licenses/</a>=
<wbr>&gt;.<br>
+ *<br>
+ */<br>
+<br>
+extern &quot;C&quot; {<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/bitops.h&quot;<br>
+#include &quot;disas/dis-asm.h&quot;<br>
+}<br>
+<br>
+#include &quot;loongson2f.h&quot;<br>
+<br>
+int print_insn_loongson2f(bfd_vma addr, disassemble_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 bfd_byte buffer[4];<br>
+=C2=A0 =C2=A0 uint32_t insn32;<br>
+=C2=A0 =C2=A0 int status;<br>
+=C2=A0 =C2=A0 Decoder *decoder =3D new Decoder();<br>
+<br>
+=C2=A0 =C2=A0 status =3D info-&gt;read_memory_func(addr, buffer, 4, info);=
<br>
+=C2=A0 =C2=A0 if (status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;memory_error_func(status<wbr>, addr, =
info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (info-&gt;endian =3D=3D BFD_ENDIAN_BIG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 insn32 =3D bfd_getb32(buffer);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 insn32 =3D bfd_getl32(buffer);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 status =3D decoder-&gt;decode32(info, insn32);<br>
+<br>
+=C2=A0 =C2=A0 delete decoder;<br>
+<br>
+=C2=A0 =C2=A0 return status =3D=3D 0 ? -1 : 4;<br>
+}<br>
+<br>
+int Fields32RdRsRt::getRd()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rd;<br>
+}<br>
+<br>
+int Fields32RdRsRt::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32RdRsRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32ImmRsRt::getImm()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;imm;<br>
+}<br>
+<br>
+int Fields32ImmRsRt::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32ImmRsRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32RdRs::getRd()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rd;<br>
+}<br>
+<br>
+int Fields32RdRs::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32Rs::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32BaseOffsetRt::getBase(<wbr>)<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;base;<br>
+}<br>
+<br>
+int Fields32BaseOffsetRt::getOffse<wbr>t()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;offset;<br>
+}<br>
+<br>
+int Fields32BaseOffsetRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32ImmRt::getImm()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;imm;<br>
+}<br>
+<br>
+int Fields32ImmRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32Rd::getRd()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rd;<br>
+}<br>
+<br>
+int Fields32Stype::getStype()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;stype;<br>
+}<br>
+<br>
+int Fields32CodeRsRt::getCode()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;code;<br>
+}<br>
+<br>
+int Fields32CodeRsRt::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32CodeRsRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32ImmRs::getImm()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;imm;<br>
+}<br>
+<br>
+int Fields32ImmRs::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32FdFs::getFd()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;fd;<br>
+}<br>
+<br>
+int Fields32FdFs::getFs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;fs;<br>
+}<br>
+<br>
+int Fields32FdFsFt::getFd()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;fd;<br>
+}<br>
+<br>
+int Fields32FdFsFt::getFs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;fs;<br>
+}<br>
+<br>
+int Fields32FdFsFt::getFt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;ft;<br>
+}<br>
+<br>
+int Fields32Offset::getOffset()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;offset;<br>
+}<br>
+<br>
+int Fields32FsFt::getFs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;fs;<br>
+}<br>
+<br>
+int Fields32FsFt::getFt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;ft;<br>
+}<br>
+<br>
+int Fields32FsRt::getFs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;fs;<br>
+}<br>
+<br>
+int Fields32FsRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32BaseFtOffset::getBase(<wbr>)<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;base;<br>
+}<br>
+<br>
+int Fields32BaseFtOffset::getFt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;ft;<br>
+}<br>
+<br>
+int Fields32BaseFtOffset::getOffse<wbr>t()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;offset;<br>
+}<br>
+<br>
+int Fields32OffsetRsRt::getOffset(<wbr>)<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;offset;<br>
+}<br>
+<br>
+int Fields32OffsetRsRt::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32OffsetRsRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32OffsetRs::getOffset()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;offset;<br>
+}<br>
+<br>
+int Fields32OffsetRs::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32Code::getCode()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;code;<br>
+}<br>
+<br>
+int Fields32Cop_fun::getCop_fun()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;cop_fun;<br>
+}<br>
+<br>
+int Fields32RsRt::getRs()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rs;<br>
+}<br>
+<br>
+int Fields32RsRt::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32RdRtSa::getRd()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rd;<br>
+}<br>
+<br>
+int Fields32RdRtSa::getRt()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;rt;<br>
+}<br>
+<br>
+int Fields32RdRtSa::getSa()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;sa;<br>
+}<br>
+<br>
+int Fields32Instr_index::getInstr_<wbr>index()<br>
+{<br>
+=C2=A0 =C2=A0 return this-&gt;instr_index;<br>
+}<br>
+<br>
+void Fields32RdRsRtD0::decode_field<wbr>s32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;rd =3D extract32(insn, 11, 5);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32ImmRsRtD0::decode_fiel<wbr>ds32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;imm =3D sextract32(insn, 0, 16);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32RdRsD0::decode_fields3<wbr>2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rd =3D extract32(insn, 11, 5);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32RsD0::decode_fields32(<wbr>uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32BaseOffsetRtD0::decode<wbr>_fields32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;base =3D extract32(insn, 21, 5);<br>
+=C2=A0 =C2=A0 this-&gt;offset =3D sextract32(insn, 0, 16);<br>
+}<br>
+<br>
+void Fields32ImmRtD0::decode_fields<wbr>32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;imm =3D extract32(insn, 0, 16);<br>
+}<br>
+<br>
+void Fields32RdD0::decode_fields32(<wbr>uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rd =3D extract32(insn, 11, 5);<br>
+}<br>
+<br>
+void Fields32StypeD0::decode_fields<wbr>32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;stype =3D extract32(insn, 6, 5);<br>
+}<br>
+<br>
+void Fields32CodeRsRtD0::decode_fie<wbr>lds32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;code =3D extract32(insn, 6, 10);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32ImmRsD0::decode_fields<wbr>32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;imm =3D sextract32(insn, 0, 16);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32FdFsD0::decode_fields3<wbr>2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fs =3D extract32(insn, 11, 5);<br>
+=C2=A0 =C2=A0 this-&gt;fd =3D extract32(insn, 6, 5);<br>
+}<br>
+<br>
+void Fields32FdFsFtD0::decode_field<wbr>s32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;ft =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;fs =3D extract32(insn, 11, 5);<br>
+=C2=A0 =C2=A0 this-&gt;fd =3D extract32(insn, 6, 5);<br>
+}<br>
+<br>
+void Fields32ImmRsRtD1::decode_fiel<wbr>ds32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;imm =3D extract32(insn, 0, 16);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32OffsetD0::decode_field<wbr>s32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;offset =3D sextract32(insn, 0, 16);<br>
+}<br>
+<br>
+void Fields32FsFtD0::decode_fields3<wbr>2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fs =3D extract32(insn, 11, 5);<br>
+=C2=A0 =C2=A0 this-&gt;ft =3D extract32(insn, 16, 5);<br>
+}<br>
+<br>
+void Fields32FsRtD0::decode_fields3<wbr>2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;fs =3D extract32(insn, 11, 5);<br>
+}<br>
+<br>
+void Fields32BaseFtOffsetD0::decode<wbr>_fields32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;base =3D extract32(insn, 21, 5);<br>
+=C2=A0 =C2=A0 this-&gt;ft =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;offset =3D sextract32(insn, 0, 16);<br>
+}<br>
+<br>
+void Fields32OffsetRsRtD0::decode_f<wbr>ields32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+=C2=A0 =C2=A0 this-&gt;offset =3D sextract32(insn, 0, 16);<br>
+}<br>
+<br>
+void Fields32OffsetRsD0::decode_fie<wbr>lds32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+=C2=A0 =C2=A0 this-&gt;offset =3D sextract32(insn, 0, 16);<br>
+}<br>
+<br>
+void Fields32CodeD0::decode_fields3<wbr>2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;code =3D extract32(insn, 6, 20);<br>
+}<br>
+<br>
+void Fields32Cop_funD0::decode_fiel<wbr>ds32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;cop_fun =3D extract32(insn, 0, 26);<br>
+}<br>
+<br>
+void Fields32RsRtD0::decode_fields3<wbr>2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;rs =3D extract32(insn, 21, 5);<br>
+}<br>
+<br>
+void Fields32RdRtSaD0::decode_field<wbr>s32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;rt =3D extract32(insn, 16, 5);<br>
+=C2=A0 =C2=A0 this-&gt;rd =3D extract32(insn, 11, 5);<br>
+=C2=A0 =C2=A0 this-&gt;sa =3D extract32(insn, 6, 5);<br>
+}<br>
+<br>
+void Fields32Instr_indexD0::decode_<wbr>fields32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;instr_index =3D extract32(insn, 0, 26);<br>
+}<br>
+<br>
+void Instruction32::getAlias(char *buffer, int regNo)<br>
+{<br>
+=C2=A0 =C2=A0 switch (regNo) {<br>
+=C2=A0 =C2=A0 case 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;zero&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;at&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 case 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;v%d&quot;, regNo - 2);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 4:<br>
+=C2=A0 =C2=A0 case 5:<br>
+=C2=A0 =C2=A0 case 6:<br>
+=C2=A0 =C2=A0 case 7:<br>
+=C2=A0 =C2=A0 case 8:<br>
+=C2=A0 =C2=A0 case 9:<br>
+=C2=A0 =C2=A0 case 10:<br>
+=C2=A0 =C2=A0 case 11:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;a%d&quot;, regNo - 4);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 12:<br>
+=C2=A0 =C2=A0 case 13:<br>
+=C2=A0 =C2=A0 case 14:<br>
+=C2=A0 =C2=A0 case 15:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;t%d&quot;, regNo - 12);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 16:<br>
+=C2=A0 =C2=A0 case 17:<br>
+=C2=A0 =C2=A0 case 18:<br>
+=C2=A0 =C2=A0 case 19:<br>
+=C2=A0 =C2=A0 case 20:<br>
+=C2=A0 =C2=A0 case 21:<br>
+=C2=A0 =C2=A0 case 22:<br>
+=C2=A0 =C2=A0 case 23:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;s%d&quot;, regNo - 16);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 24:<br>
+=C2=A0 =C2=A0 case 25:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;t%d&quot;, regNo - 16);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 28:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;gp&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 29:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;sp&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 30:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;s8&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 31:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;ra&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;r%d&quot;, regNo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+Instruction32::~Instruction32<wbr>() {}<br>
+<br>
+ADD::ADD(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool ADD::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;ADD&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+ADDI::ADDI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool ADDI::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;ADDI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32ImmRsRt *)this-&gt;fields32)=
-&gt;getImm()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+ADDIU::ADDIU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool ADDIU::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;ADDIU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32ImmRsRt *)this-&gt;fields32)=
-&gt;getImm()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+ADDU::ADDU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool ADDU::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;ADDU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+AND::AND(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool AND::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;AND&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+ANDI::ANDI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRsRtD1();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool ANDI::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;ANDI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32ImmRsRt *)this-&gt;fields32)=
-&gt;getImm()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BEQ::BEQ(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BEQ::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;BEQ&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32OffsetRsRt *)this-&gt;fields=
32)-&gt;getOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BEQL::BEQL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BEQL::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;BEQL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32OffsetRsRt *)this-&gt;fields=
32)-&gt;getOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BGEZ::BGEZ(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BGEZ::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BGEZ&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BGEZAL::BGEZAL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BGEZAL::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BGEZAL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BGEZALL::BGEZALL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BGEZALL::disas_output(disassem<wbr>ble_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BGEZALL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BGEZL::BGEZL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BGEZL::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BGEZL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BGTZ::BGTZ(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BGTZ::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BGTZ&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BGTZL::BGTZL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BGTZL::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BGTZL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BLEZ::BLEZ(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BLEZ::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BLEZ&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BLEZL::BLEZL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BLEZL::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BLEZL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BLTZ::BLTZ(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BLTZ::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BLTZ&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BLTZAL::BLTZAL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BLTZAL::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BLTZAL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BLTZALL::BLTZALL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BLTZALL::disas_output(disassem<wbr>ble_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BLTZALL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BLTZL::BLTZL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BLTZL::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt=
;getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;BLTZL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32OffsetRs *)this-&gt;fields32)-&gt;ge=
tOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BNE::BNE(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BNE::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;BNE&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32OffsetRsRt *)this-&gt;fields=
32)-&gt;getOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BNEL::BNEL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32OffsetRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BNEL::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32OffsetRsRt *)this-&gt;fields32)-&=
gt;getRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;BNEL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32OffsetRsRt *)this-&gt;fields=
32)-&gt;getOffset()<wbr>));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+BREAK::BREAK(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32CodeD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool BREAK::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %d&quot;, &quot;&quot; &quot;BREAK&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0((Fields32Code *)this-&gt;fields32)-&gt;getCode()))<wb=
r>;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+COP0::COP0(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32Cop_funD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool COP0::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %d&quot;, &quot;&quot; &quot;COP0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0((Fields32Cop_fun *)this-&gt;fields32)-&gt;getCop_fun(=
<wbr>)));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+COP3::COP3(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32Cop_funD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool COP3::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %d&quot;, &quot;&quot; &quot;COP3&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0((Fields32Cop_fun *)this-&gt;fields32)-&gt;getCop_fun(=
<wbr>)));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DADD::DADD(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DADD::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DADD&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DADDI::DADDI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DADDI::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DADDI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32ImmRsRt *)this-&gt;fields32)=
-&gt;getImm()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DADDIU::DADDIU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DADDIU::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DADDIU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32ImmRsRt *)this-&gt;fields32)=
-&gt;getImm()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DADDU::DADDU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DADDU::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DADDU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DDIV::DDIV(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DDIV::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;DDIV&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DDIVU::DDIVU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DDIVU::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;DDIVU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DIV::DIV(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DIV::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;DIV&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DIVU::DIVU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DIVU::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;DIVU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DMULT::DMULT(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DMULT::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;DMULT&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DMULTU::DMULTU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DMULTU::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;DMULTU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSLL::DSLL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRtSaD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSLL::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DSLL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32RdRtSa *)this-&gt;fields32)-=
&gt;getSa()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSLL32::DSLL32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRtSaD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSLL32::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DSLL32&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32RdRtSa *)this-&gt;fields32)-=
&gt;getSa()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSLLV::DSLLV(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSLLV::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DSLLV&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSRA::DSRA(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRtSaD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSRA::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DSRA&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32RdRtSa *)this-&gt;fields32)-=
&gt;getSa()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSRA32::DSRA32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRtSaD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSRA32::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DSRA32&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32RdRtSa *)this-&gt;fields32)-=
&gt;getSa()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSRAV::DSRAV(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSRAV::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DSRAV&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSRL::DSRL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRtSaD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSRL::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DSRL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32RdRtSa *)this-&gt;fields32)-=
&gt;getSa()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSRL32::DSRL32(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRtSaD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSRL32::disas_output(disassemb<wbr>le_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRtSa *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;DSRL32&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32RdRtSa *)this-&gt;fields32)-=
&gt;getSa()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSRLV::DSRLV(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSRLV::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DSRLV&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSUB::DSUB(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSUB::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DSUB&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+DSUBU::DSUBU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool DSUBU::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;DSUBU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+J::J(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32Instr_indexD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool J::disas_output(disassemble_in<wbr>fo *info)<br>
+{<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %d&quot;, &quot;&quot; &quot;J&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0((Fields32Instr_index *)this-&gt;fields32)-&gt;getInst=
r_in<wbr>dex()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+JAL::JAL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32Instr_indexD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool JAL::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %d&quot;, &quot;&quot; &quot;JAL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0((Fields32Instr_index *)this-&gt;fields32)-&gt;getInst=
r_in<wbr>dex()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+JALR::JALR(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool JALR::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRs *)this-&gt;fields32)-&gt;get=
Rd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRs *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;JALR&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+JR::JR(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool JR::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32Rs *)this-&gt;fields32)-&gt;getRs=
());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s&quot;, &quot;&quot; &quot;JR&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LB::LB(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LB::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LB&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LBU::LBU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LBU::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LBU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LD::LD(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LD::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LD&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LDC2::LDC2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LDC2::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LDC2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LDL::LDL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LDL::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LDL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LDR::LDR(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LDR::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LDR&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LH::LH(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LH::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LH&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LHU::LHU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LHU::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LHU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LL::LL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LL::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LLD::LLD(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LLD::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LLD&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LUI::LUI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LUI::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRt *)this-&gt;fields32)-&gt;ge=
tRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d&quot;, &quot;&quot; &quot;LUI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32ImmRt *)this-&gt;fields32)-&gt;getIm=
m()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LW::LW(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LW::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LW&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LWC2::LWC2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LWC2::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LWC2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LWC3::LWC3(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LWC3::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LWC3&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LWL::LWL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LWL::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LWL&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LWR::LWR(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LWR::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LWR&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+LWU::LWU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool LWU::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;LWU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+MFHI::MFHI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool MFHI::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32Rd *)this-&gt;fields32)-&gt;getRd=
());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s&quot;, &quot;&quot; &quot;MFHI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+MFLO::MFLO(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool MFLO::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32Rd *)this-&gt;fields32)-&gt;getRd=
());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s&quot;, &quot;&quot; &quot;MFLO&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+MTHI::MTHI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool MTHI::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32Rs *)this-&gt;fields32)-&gt;getRs=
());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s&quot;, &quot;&quot; &quot;MTHI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+MTLO::MTLO(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool MTLO::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32Rs *)this-&gt;fields32)-&gt;getRs=
());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s&quot;, &quot;&quot; &quot;MTLO&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+MULT::MULT(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool MULT::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;MULT&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+MULTU::MULTU(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool MULTU::disas_output(disassembl<wbr>e_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rs());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RsRt *)this-&gt;fields32)-&gt;get=
Rt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s&quot;, &quot;&quot; &quot;MULTU&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+NOR::NOR(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool NOR::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;NOR&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+OR::OR(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32RdRsRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool OR::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRd());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRs());<br>
+=C2=A0 =C2=A0 getAlias(alias3, ((Fields32RdRsRt *)this-&gt;fields32)-&gt;g=
etRt());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %s&quot;, &quot;&quot; &quot;OR&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, alias3));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+ORI::ORI(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32ImmRsRtD1();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool ORI::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32ImmRsRt *)this-&gt;fields32)-&gt;=
getRs());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %s, %d&quot;, &quot;&quot; &quot;ORI&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, alias2, ((Fields32ImmRsRt *)this-&gt;fields32)=
-&gt;getImm()));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+SB::SB(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool SB::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;SB&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+SC::SC(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool SC::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;SC&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+SCD::SCD(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool SCD::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;SCD&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+SD::SD(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool SD::disas_output(disassemble_i<wbr>nfo *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;SD&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+SDC2::SDC2(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool SDC2::disas_output(disassemble<wbr>_info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; &quot; %s, %d(%s)&quot;, &quot;&quot; &quot;SDC2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)-&g=
t;getOffset()<wbr>, alias2));<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+SDL::SDL(uint32_t insn)<br>
+{<br>
+=C2=A0 =C2=A0 this-&gt;fields32 =3D new Fields32BaseOffsetRtD0();<br>
+=C2=A0 =C2=A0 this-&gt;fields32-&gt;decode_fields3<wbr>2(insn);<br>
+}<br>
+<br>
+bool SDL::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 getAlias(alias1, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getRt());<br>
+=C2=A0 =C2=A0 getAlias(alias2, ((Fields32BaseOffsetRt *)this-&gt;fields32)=
-&gt;getBase());<br>
+=C2=A0 =C2=A0 (info-&gt;fprintf_func(info-&gt;stre<wbr>am, &quot;%-9s&quot=
; </blockquote>
</blockquote>

--000000000000b7611305a9b35e3a--


Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287FAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B9B206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L97sSMkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B9B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGcQ-0003Vb-6j
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrGbf-0002jI-61
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:59:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrGbd-0006I4-CK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593763172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCEbZkpKYcR6yNwoTtZTOVinyPElHv7tZvgCKUNTwyE=;
 b=L97sSMkCSE7PzxFFq3kwTj47P9YjxPubcmJLMAU4KhVvCJfzuohMWSFLbJB/HcgTNH5CQi
 1BrnkrhCiZ5xu1JfZclyvmATDliOeSFn7FbCyV2us6FTVP3/Gm/txZv6lQhYlk+SFMYKty
 dRWyB9qDOYh4pxWCP14PS2fcMDfCSK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-Eurarn8fMzC1My6i8Q9nCQ-1; Fri, 03 Jul 2020 03:59:30 -0400
X-MC-Unique: Eurarn8fMzC1My6i8Q9nCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A59491052510;
 Fri,  3 Jul 2020 07:59:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49CAA7FEA6;
 Fri,  3 Jul 2020 07:59:26 +0000 (UTC)
Subject: Re: [PATCH 1/1] disas: mips: Add Loongson 2F disassembler
To: Stefan Brankovic <stefanbrankovic96@gmail.com>, qemu-devel@nongnu.org
References: <20200702194230.10769-1-stefan.brankovic@syrmia.com>
 <20200702194230.10769-2-stefan.brankovic@syrmia.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <59e559c7-d763-cee0-8eb7-7201d6586833@redhat.com>
Date: Fri, 3 Jul 2020 09:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200702194230.10769-2-stefan.brankovic@syrmia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: aleksandar.rikalo@syrmia.com, Markus Armbruster <armbru@redhat.com>,
 aleksandar.qemu.devel@gmail.com, stefan.brankovic@syrmia.com,
 chenhc@lemote.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/2020 21.42, Stefan Brankovic wrote:
> Add disassembler for Loongson 2F instruction set.
> 
> Testing is done by comparing qemu disassembly output, obtained by
> using -d in_asm command line option, with appropriate objdump output.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
> ---
>   MAINTAINERS             |    1 +
>   configure               |    1 +
>   disas/Makefile.objs     |    1 +
>   disas/loongson2f.cpp    | 8134 +++++++++++++++++++++++++++++++++++++++
>   disas/loongson2f.h      | 2542 ++++++++++++
>   include/disas/dis-asm.h |    1 +
>   include/exec/poison.h   |    1 +
>   target/mips/cpu.c       |    4 +
>   8 files changed, 10685 insertions(+)
>   create mode 100644 disas/loongson2f.cpp
>   create mode 100644 disas/loongson2f.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3abe3faa4e..913ed2a6d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -219,6 +219,7 @@ S: Maintained
>   F: target/mips/
>   F: default-configs/*mips*
>   F: disas/*mips*
> +F: disas/loongson*
>   F: docs/system/cpu-models-mips.rst.inc
>   F: hw/intc/mips_gic.c
>   F: hw/mips/
> diff --git a/configure b/configure
> index 597e909b53..e163dac53e 100755
> --- a/configure
> +++ b/configure
> @@ -8102,6 +8102,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>       disas_config "MIPS"
>       if test -n "${cxx}"; then
>         disas_config "NANOMIPS"
> +      disas_config "LOONGSON2F"
>       fi
>     ;;
>     moxie*)
> diff --git a/disas/Makefile.objs b/disas/Makefile.objs
> index 3c1cdce026..0d5ee1e038 100644
> --- a/disas/Makefile.objs
> +++ b/disas/Makefile.objs
> @@ -14,6 +14,7 @@ common-obj-$(CONFIG_I386_DIS) += i386.o
>   common-obj-$(CONFIG_M68K_DIS) += m68k.o
>   common-obj-$(CONFIG_MICROBLAZE_DIS) += microblaze.o
>   common-obj-$(CONFIG_MIPS_DIS) += mips.o
> +common-obj-$(CONFIG_LOONGSON2F_DIS) += loongson2f.o
>   common-obj-$(CONFIG_NANOMIPS_DIS) += nanomips.o
>   common-obj-$(CONFIG_NIOS2_DIS) += nios2.o
>   common-obj-$(CONFIG_MOXIE_DIS) += moxie.o
> diff --git a/disas/loongson2f.cpp b/disas/loongson2f.cpp
> new file mode 100644
> index 0000000000..a2f32dcf93
> --- /dev/null
> +++ b/disas/loongson2f.cpp
> @@ -0,0 +1,8134 @@

This file (and the header) lack a proper header comment. Which license 
do you want to use for this code? Who wrote the initial implementation?

Also, unless you've copied the code from another project that uses C++, 
why did you use C++ here? QEMU is C by default, we only allow C++ for 
some files that have been taken from other C++ projects and need to be 
kept in sync from time to time. So if you wrote this code from scratch, 
please use C instead.

  Thanks,
   Thomas


> +extern "C" {
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "disas/dis-asm.h"
> +}
> +
> +#include "loongson2f.h"
> +
> +int print_insn_loongson2f(bfd_vma addr, disassemble_info *info)
> +{
> +    bfd_byte buffer[4];
> +    uint32_t insn32;
> +    int status;
> +    Decoder *decoder = new Decoder();
> +
> +    status = info->read_memory_func(addr, buffer, 4, info);
> +    if (status != 0) {
> +        info->memory_error_func(status, addr, info);
> +        return -1;
> +    }
> +    if (info->endian == BFD_ENDIAN_BIG) {
> +        insn32 = bfd_getb32(buffer);
> +    } else {
> +        insn32 = bfd_getl32(buffer);
> +    }
> +
> +    status = decoder->decode32(info, insn32);
> +
> +    delete decoder;
> +
> +    return status == 0 ? -1 : 4;
> +}



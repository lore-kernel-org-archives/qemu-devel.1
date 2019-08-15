Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B1C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98D020656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToPS3Qoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98D020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIT9-000398-4G
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hyIRp-0002Mv-JH
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hyIRk-0003dY-WE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:17:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hyIRk-0003cv-9e
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:17:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so2673848wru.13
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sZFQYacpA3b9lJjLJeH36lTup2SJ2siDtva+eNIXx68=;
 b=ToPS3Qoeg7ievd35e0Lv1qJhnHbGZeDuAnxDj8qR93ellfKGXZrOZ9yaApX6V7mw2B
 AX6TTmZsdQqbbmXKxnoCy2PgX4NBfRbzh4TnsU3Plinhn6ciuC5EAQKBvZKsvPEWaUj3
 4tq1ZrWvpGMA2Dsj16GFba55xTI9ULYpCoHmQWovfPYQ/WJdYrqjsergMCEKdiq7+TL9
 Ra0wCFbEeI807zhXMlHyj9RoWVN9QkcW7EPMNEqAqhhXPqmauAcDKiKVgtMofwB2c1pm
 huWQz8a2/MFrllsc0cqvvL59TkP11U13B5PyhWgod+vCVdZkNlUNdWz2xGIEW+uQbP3i
 5G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sZFQYacpA3b9lJjLJeH36lTup2SJ2siDtva+eNIXx68=;
 b=WJW+e80QokGsStFl3snLOeEAbSfSwlgwrqX0o5ljgbdU1rGiu+kiPXcs/bzJuIKKMZ
 lQv4Sh06BoS1qPgLrZQPPLBHJRbOYxqCtAxvpVoOwpcKQn5idwqBAX1m91myQ0IuoQaM
 qg2Y8+5t0JJ4Od3mkljKORqVliWcdwFoU+P+1SmUQcldCtArO2P8XeWhaZuOJyDHf5yA
 9PhFWHlJ28Go7MgbcpqTVweJucZzxvt2Ky2gH8NbiDifC+Iu8ziQtQxr0MvvyMt8CONY
 W8u/2807S6KQQwUPeYCUyR4/4oFQVHw8F/w2o56jTc49n0mgebTXLVzJH01rsONzKrBB
 npsA==
X-Gm-Message-State: APjAAAWNcqo/clcigak8+6lzxBcokBsL8jpoNfjFBG5ACjtwLzds3Yyv
 7wBg3rBrjgMlMyvUvlQtlIqW+A==
X-Google-Smtp-Source: APXvYqzhbsnpFiZpMgQ6OQ0oJo5HzUAzMYGLwUmyqYZPNm3ZLPRJk1hjpnUjpoBobENhbo+NenGcoA==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr6479968wrw.151.1565885870242; 
 Thu, 15 Aug 2019 09:17:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f197sm4075434wme.22.2019.08.15.09.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 09:17:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 19B991FF87;
 Thu, 15 Aug 2019 17:17:49 +0100 (BST)
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
 <20190815023725.2659-2-vandersonmr2@gmail.com>
 <20190815144036.GG10996@stefanha-x1.localdomain>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190815144036.GG10996@stefanha-x1.localdomain>
Date: Thu, 15 Aug 2019 17:17:49 +0100
Message-ID: <87lfvummhe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 1/2] accel/tcg: adding integration with
 linux perf
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, Aug 14, 2019 at 11:37:24PM -0300, vandersonmr wrote:
>> This commit adds support to Linux Perf in order
>> to be able to analyze qemu jitted code and
>> also to able to see the TBs PC in it.
>
> Is there any reference to the file format?  Please include it in a code
> comment, if such a thing exists.
>
>> diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
>> new file mode 100644
>> index 0000000000..6f4c0911c2
>> --- /dev/null
>> +++ b/accel/tcg/perf/jitdump.c
>> @@ -0,0 +1,180 @@
>
> License header?
>
>> +#ifdef __linux__
>
> If the entire source file is #ifdef __linux__ then Makefile.objs should
> probably contain obj-$(CONFIG_LINUX) +=3D jitdump.o instead.  Letting the
> build system decide what to compile is cleaner than ifdeffing large
> amounts of code.
>
>> +
>> +#include <stdint.h>
>> +
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <time.h>
>> +#include <sys/syscall.h>
>> +#include <elf.h>
>> +
>> +#include "jitdump.h"
>> +#include "qemu-common.h"
>
> Please follow QEMU's header ordering conventions.  See ./HACKING "1.2.
> Include directives".
>
>> +void start_jitdump_file(void)
>> +{
>> +    GString *dumpfile_name =3D g_string_new(NULL);;
>> +    g_string_printf(dumpfile_name, "./jit-%d.dump", getpid());
>
> Simpler:
>
>   gchar *dumpfile_name =3D g_strdup_printf("./jit-%d.dump", getpid());
>   ...
>   g_free(dumpfile_name);
>
>> +    dumpfile =3D fopen(dumpfile_name->str, "w+");
>
> getpid() and the global dumpfile variable make me wonder what happens
> with multi-threaded TCG?
>
>> +
>> +    perf_marker =3D mmap(NULL, sysconf(_SC_PAGESIZE),
>
> Please mention the point of this mmap in a comment.  My best guess is
> that perf stores the /proc/$PID/maps and this is how it finds the
> jitdump file?
>
>> +                          PROT_READ | PROT_EXEC,
>> +                          MAP_PRIVATE,
>> +                          fileno(dumpfile), 0);
>> +
>> +    if (perf_marker =3D=3D MAP_FAILED) {
>> +        printf("Failed to create mmap marker file for perf %d\n", filen=
o(dumpfile));
>> +        fclose(dumpfile);
>> +        return;
>> +    }
>> +
>> +    g_string_free(dumpfile_name, TRUE);
>> +
>> +    struct jitheader *header =3D g_new0(struct jitheader, 1);
>
> Why g_new this struct?  It's small and can be declared on the stack.
>
> Please use g_free() with g_malloc/new/etc().  It's not safe to mismatch
> glib and libc memory allocation functions.
>
>> +    header->magic =3D 0x4A695444;
>> +    header->version =3D 1;
>> +    header->elf_mach =3D get_e_machine();
>> +    header->total_size =3D sizeof(struct jitheader);
>> +    header->pid =3D getpid();
>> +    header->timestamp =3D get_timestamp();
>> +
>> +    fwrite(header, header->total_size, 1, dumpfile);
>> +
>> +    free(header);
>> +    fflush(dumpfile);
>> +}
>> +
>> +void append_load_in_jitdump_file(TranslationBlock *tb)
>> +{
>> +    GString *func_name =3D g_string_new(NULL);
>> +    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc, '=
\0');
>
> The explicit NUL character looks strange to me.  I think the idea is to
> avoid func_name->len + 1?  Adding NUL characters to C strings can be a
> source of bugs, I would stick to convention and do len + 1 instead of
> putting NUL characters into the GString.  This is a question of style
> though.

The glib functions always add null characters so you shouldn't need to
manually.

>
>> +
>> +    struct jr_code_load *load_event =3D g_new0(struct jr_code_load, 1);
>
> No need to allocate load_event on the heap.
>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 9621e934c0..1c26eeeb9c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4147,6 +4147,18 @@ STEXI
>>  Enable FIPS 140-2 compliance mode.
>>  ETEXI
>>
>> +#ifdef __linux__
>> +DEF("perf", 0, QEMU_OPTION_perf,
>> +    "-perf    dump jitdump files to help linux perf JIT code visualizat=
ion\n",
>> +    QEMU_ARCH_ALL)
>> +#endif
>> +STEXI
>> +@item -perf
>> +@findex -perf
>> +Dumps jitdump files to help linux perf JIT code visualization
>
> Suggestions on expanding the documentation:
>
> Where are the jitdump files dumped?  The current working directory?
>
> Anything to say about the naming scheme for these files?
>
> Can you include an example of how to load them into perf(1)?


--
Alex Benn=C3=A9e


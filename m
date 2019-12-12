Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93171C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448212077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+RuYOwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448212077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifVBg-0000KY-Ap
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifVAd-0007nm-EV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifVAb-0000qg-6R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:34:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ifVAa-0000oq-Ud
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:34:45 -0500
Received: by mail-ot1-x344.google.com with SMTP id d17so3396524otc.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=FagFkdtiK9jEQFDTU7LTSShb4NPPbVA5eNm5GsJbJAk=;
 b=p+RuYOwaDMEU5ZypsmBAGHikhPsplaMqQkP0gEovIoPdK9bZCby5OuGLLNtouytaSW
 q0TPIbkuMIg6Qi98Om4r8cSg7xa1KntSib2O/iq/NJ5V+ODS0/uywgc55Z7i9hYjlhu7
 y1ZTVc8PwTSblNWIs3db69mR+5bQdYps4I8Mn07OFucQZ4trwI3vnfNWQzaRUl814UKQ
 JY+VQEggZf6zVFbntywM6ObX3eM3JFW0kikXwz3Gu0r+4iwIVYlSJ+Xzhr3m9rpoA9hs
 ifqTq7TISzWnirCaQt/316W/VZYWx/Vlo4AnF1EpnL5sNrJV3DEt8lfA1PlUHDVBJfF5
 MtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=FagFkdtiK9jEQFDTU7LTSShb4NPPbVA5eNm5GsJbJAk=;
 b=fZ02qPwWwDYEFpdza7NY4yZRtiLRmdBkqjD4DlQfBosPjJB2s5ksUUTvXBB3IxeIaa
 0FaxgGHQAofCUsk232rMo+9IawBGq6HU/3+5bccJYA1qe7rhIFwPOACnwrU+M8ck4i2u
 5FJsUp+1cZyGcu9LUHB49AaRjn+e/cYwBi2xM+n7qchZ0VgfD0jufTlVBlCUEgdjMYqE
 lYZx4gYAAUCf2JiDQMSbhcEKWXVZHSsvL/qxyLzILbQZxiTEdP7D7fQvszTrHHv8UQqP
 Oqm62MxKuVZaxatrxEAKs+6Izv4AKTBoHgCdAI6bSb6OYe9HNMRLjgHLOyksKjFqUSif
 JV9w==
X-Gm-Message-State: APjAAAWcxZRG+SpF7IiXugQXe2mL+Y66hsvyMAk5CQuD6rNt9SHGpGbF
 g3FsoXbiclGOutSTznAmhQRUbnZiJKU76cLUk90=
X-Google-Smtp-Source: APXvYqz/y/Cc8R5SnUYyDpZ6Ma8f2+I//g1NcAidVNzWI57adsY2FpitmDACcH3vRvzhlRpyUTV200GLTDmM9zesro0=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr10699144otn.341.1576182883970; 
 Thu, 12 Dec 2019 12:34:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 12 Dec 2019 12:34:43 -0800 (PST)
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 12 Dec 2019 21:34:43 +0100
Message-ID: <CAL1e-=jUf2MVx863YUqg0oHppsHJ6mBpTBP6YNuRipnFTC6Luw@mail.gmail.com>
Subject: Re: [PATCH 00/28] cputlb: Remove support for MMU_MODE*_SUFFIX
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e67279059987aca5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chris Wulff <crwulff@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e67279059987aca5
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 12, 2019, Richard Henderson <
richard.henderson@linaro.org> wrote:

> This is part of a project to raise the limit on NB_MMU_MODES.
>
> One of those is in cpu_ldst.h, in support of MMU_MODE*_SUFFIX.
> While this could be extended, it's not the best interface for
> such things.  Better is a single interface that allows a variable
> mmu_idx.  The best exemplars of that is the usage in target/mips
> and target/ppc.
>
> In the process, I tried to clean up the implementation of these
> functions for softmmu and user-only.
>
>
Just a suggestion: Given the nature of the series, please consider some
additional changes to:

 docs/devel/loads-stores.rst

Aleksandar


> r~
>
>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
>
>
> Richard Henderson (28):
>   target/xtensa: Use probe_access for itlb_hit_test
>   cputlb: Use trace_mem_get_info instead of trace_mem_build_info
>   trace: Remove trace_mem_build_info_no_se_[bl]e
>   cputlb: Move body of cpu_ldst_template.h out of line
>   translator: Use cpu_ld*_code instead of open-coding
>   cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
>   cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
>   target/i386: Use cpu_*_mmuidx_ra instead of templates
>   target/s390x: Include tcg.h in mem_helper.c
>   target/arm: Include tcg.h in sve_helper.c
>   accel/tcg: Include tcg.h in tcg-runtime.c
>   linux-user: Include tcg.h in syscall.c
>   linux-user: Include trace-root.h in syscall-trace.h
>   cputlb: Expand cpu_ldst_useronly_template.h in user-exec.c
>   target/nios2: Remove MMU_MODE{0,1}_SUFFIX
>   target/alpha: Remove MMU_MODE{0,1}_SUFFIX
>   target/cris: Remove MMU_MODE{0,1}_SUFFIX
>   target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
>   target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
>   target/sh4: Remove MMU_MODE{0,1}_SUFFIX
>   target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
>   target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
>   target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,1}_SUFFIX
>   target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
>   target/s390x: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
>   target/ppc: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
>   cputlb: Remove support for MMU_MODE*_SUFFIX
>   cputlb: Expand cpu_ldst_template.h in cputlb.c
>
>  accel/tcg/atomic_template.h               |  67 ++--
>  include/exec/cpu_ldst.h                   | 448 +++++++---------------
>  include/exec/cpu_ldst_template.h          | 211 ----------
>  include/exec/cpu_ldst_useronly_template.h | 159 --------
>  include/exec/translator.h                 |  48 +--
>  include/user/syscall-trace.h              |   2 +
>  target/alpha/cpu.h                        |   2 -
>  target/cris/cpu.h                         |   2 -
>  target/i386/cpu.h                         |   3 -
>  target/m68k/cpu.h                         |   2 -
>  target/microblaze/cpu.h                   |   3 -
>  target/mips/cpu.h                         |   4 -
>  target/nios2/cpu.h                        |   2 -
>  target/ppc/cpu.h                          |   2 -
>  target/s390x/cpu.h                        |   5 -
>  target/sh4/cpu.h                          |   2 -
>  target/unicore32/cpu.h                    |   2 -
>  target/xtensa/cpu.h                       |   4 -
>  tcg/tcg.h                                 |  29 --
>  trace/mem-internal.h                      |  17 -
>  accel/tcg/cputlb.c                        | 315 +++++++++++----
>  accel/tcg/tcg-runtime.c                   |   1 +
>  accel/tcg/user-exec.c                     | 236 ++++++++++++
>  linux-user/syscall.c                      |   1 +
>  target/arm/sve_helper.c                   |   1 +
>  target/i386/seg_helper.c                  |  75 ++--
>  target/m68k/op_helper.c                   |   5 +
>  target/mips/op_helper.c                   | 182 +++------
>  target/ppc/mem_helper.c                   |  11 +-
>  target/s390x/mem_helper.c                 |   6 +
>  target/xtensa/mmu_helper.c                |   5 +-
>  docs/devel/loads-stores.rst               |   4 +-
>  32 files changed, 788 insertions(+), 1068 deletions(-)
>  delete mode 100644 include/exec/cpu_ldst_template.h
>  delete mode 100644 include/exec/cpu_ldst_useronly_template.h
>
> --
> 2.20.1
>
>
>

--000000000000e67279059987aca5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, December 12, 2019, Richard Henderson &lt;<a href=3D"ma=
ilto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">This is part of a project to raise th=
e limit on NB_MMU_MODES.<br>
<br>
One of those is in cpu_ldst.h, in support of MMU_MODE*_SUFFIX.<br>
While this could be extended, it&#39;s not the best interface for<br>
such things.=C2=A0 Better is a single interface that allows a variable<br>
mmu_idx.=C2=A0 The best exemplars of that is the usage in target/mips<br>
and target/ppc.<br>
<br>
In the process, I tried to clean up the implementation of these<br>
functions for softmmu and user-only.<br>
<br></blockquote><div><br></div><div>Just a suggestion: Given the nature of=
 the series, please consider some additional changes to:</div><div><br></di=
v><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120=
0008392334px">=C2=A0docs/devel/loads-stores.rst=C2=A0</span>=C2=A0<br></div=
><div><br></div><div>Aleksandar</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
r~<br>
<br>
<br>
Cc: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">amark=
ovic@wavecomp.com</a>&gt;<br>
Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com">al=
eksandar.rikalo@rt-rk.com</a>&gt;<br>
Cc: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelien@aur=
el32.net</a>&gt;<br>
Cc: Chris Wulff &lt;<a href=3D"mailto:crwulff@gmail.com">crwulff@gmail.com<=
/a>&gt;<br>
Cc: David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">david@g=
ibson.dropbear.id.au</a>&gt;<br>
Cc: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">david@redhat.=
com</a>&gt;<br>
Cc: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">edgar=
.iglesias@gmail.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@red=
hat.com</a>&gt;<br>
Cc: Guan Xuetao &lt;<a href=3D"mailto:gxt@mprc.pku.edu.cn">gxt@mprc.pku.edu=
.cn</a>&gt;<br>
Cc: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.=
eu</a>&gt;<br>
Cc: Marek Vasut &lt;<a href=3D"mailto:marex@denx.de">marex@denx.de</a>&gt;<=
br>
Cc: Max Filippov &lt;<a href=3D"mailto:jcmvbkbc@gmail.com">jcmvbkbc@gmail.c=
om</a>&gt;<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redha=
t.com</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.may=
dell@linaro.org</a>&gt;<br>
<br>
<br>
Richard Henderson (28):<br>
=C2=A0 target/xtensa: Use probe_access for itlb_hit_test<br>
=C2=A0 cputlb: Use trace_mem_get_info instead of trace_mem_build_info<br>
=C2=A0 trace: Remove trace_mem_build_info_no_se_[<wbr>bl]e<br>
=C2=A0 cputlb: Move body of cpu_ldst_template.h out of line<br>
=C2=A0 translator: Use cpu_ld*_code instead of open-coding<br>
=C2=A0 cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code<br>
=C2=A0 cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only<br>
=C2=A0 target/i386: Use cpu_*_mmuidx_ra instead of templates<br>
=C2=A0 target/s390x: Include tcg.h in mem_helper.c<br>
=C2=A0 target/arm: Include tcg.h in sve_helper.c<br>
=C2=A0 accel/tcg: Include tcg.h in tcg-runtime.c<br>
=C2=A0 linux-user: Include tcg.h in syscall.c<br>
=C2=A0 linux-user: Include trace-root.h in syscall-trace.h<br>
=C2=A0 cputlb: Expand cpu_ldst_useronly_template.h in user-exec.c<br>
=C2=A0 target/nios2: Remove MMU_MODE{0,1}_SUFFIX<br>
=C2=A0 target/alpha: Remove MMU_MODE{0,1}_SUFFIX<br>
=C2=A0 target/cris: Remove MMU_MODE{0,1}_SUFFIX<br>
=C2=A0 target/i386: Remove MMU_MODE{0,1,2}_SUFFIX<br>
=C2=A0 target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX<br>
=C2=A0 target/sh4: Remove MMU_MODE{0,1}_SUFFIX<br>
=C2=A0 target/unicore32: Remove MMU_MODE{0,1}_SUFFIX<br>
=C2=A0 target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX<br>
=C2=A0 target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,1}_SUFFIX<br>
=C2=A0 target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX<br>
=C2=A0 target/s390x: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX<br>
=C2=A0 target/ppc: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX<br>
=C2=A0 cputlb: Remove support for MMU_MODE*_SUFFIX<br>
=C2=A0 cputlb: Expand cpu_ldst_template.h in cputlb.c<br>
<br>
=C2=A0accel/tcg/atomic_template.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 67 ++--<br>
=C2=A0include/exec/cpu_ldst.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 448 +++++++---------------<br>
=C2=A0include/exec/cpu_ldst_<wbr>template.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 211 ----------<br>
=C2=A0include/exec/cpu_ldst_<wbr>useronly_template.h | 159 --------<br>
=C2=A0include/exec/translator.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 48 +--<br>
=C2=A0include/user/syscall-trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0target/alpha/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0target/cris/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
=C2=A0target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 -<br>
=C2=A0target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
=C2=A0target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 -<br>
=C2=A0target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 -<br>
=C2=A0target/nios2/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0target/ppc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0target/s390x/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 -<br>
=C2=A0target/sh4/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0target/unicore32/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0target/xtensa/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 -<br>
=C2=A0tcg/tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 29 --<br=
>
=C2=A0trace/mem-internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 -<br>
=C2=A0accel/tcg/cputlb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 315 +++++++++++----<br>
=C2=A0accel/tcg/tcg-runtime.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0accel/tcg/user-exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 236 ++++++++++++<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0target/arm/sve_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0target/i386/seg_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 75 ++--<br>
=C2=A0target/m68k/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0target/mips/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 182 +++------<br>
=C2=A0target/ppc/mem_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +-<br>
=C2=A0target/s390x/mem_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +<br>
=C2=A0target/xtensa/mmu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0docs/devel/loads-stores.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A032 files changed, 788 insertions(+), 1068 deletions(-)<br>
=C2=A0delete mode 100644 include/exec/cpu_ldst_<wbr>template.h<br>
=C2=A0delete mode 100644 include/exec/cpu_ldst_<wbr>useronly_template.h<br>
<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--000000000000e67279059987aca5--


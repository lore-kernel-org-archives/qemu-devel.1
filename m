Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205BDC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07012054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE3H4IXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07012054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPSZ-0006Yr-QG
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jOP8q-0001Ja-0z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jOP8e-00058H-Kh
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:14:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jONCj-0005WG-Qg; Tue, 14 Apr 2020 11:10:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id u13so14257971wrp.3;
 Tue, 14 Apr 2020 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=th6Itvavqdy0oV564Kr9UBTUBaowHEos7g0Mtw+sY3Y=;
 b=dE3H4IXwA2dxvD6vZAy4J5kEMXqC6XrcH+cufdBA+5YM4nQWTg9rhieB7C95tQRlhc
 YS+jxyrwVlZR7c2/NP3Ofh+qkxR+Ci2TG+2YhzcQiCRjz2rob5vYB9A3A1FTELFa/pJP
 bX4iC9UD0uQhNaUrRzXgFeUaJT+MOIwRAEndTm0B6s22lKjcI8GVVI65WvKsj/RYC3LI
 tSSDAHRJqCViaa4+l+vFkkVy5OAftR4G24qSbtui8h1EIUpDCLge3onsaXjXgtz5/c+M
 eUVgRygvDMoQIIrtYoUxm8VSuOxk9+dL5MdsEz/13ciQl/8PgQhUyjiy4IH5lZq6QG8C
 sdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=th6Itvavqdy0oV564Kr9UBTUBaowHEos7g0Mtw+sY3Y=;
 b=Q61ZznCH/uOVLz//QsVcWEi5eXuphftLHoIYaOMgKnwnkO88fR8O0ZtSO71lbsw4js
 UI1SNzOUvg8T+qhJxXMvO+w7uwcRMpf9it6c/AMSAw51SPJZJrggULF71gHGlbDOwvIA
 bGx/3Itn6v0mCaSpPwDpdv6lE40OKuPsiHzFye3WoM6eoDyY5KELFqgwYZTLBlwr0+Ls
 9/cR0fCONWzrpSu11DLFerVUD2un0pU1XM5Jb/me9A2lhJ3Sop2Qy7nYPW8VjAyDWUKv
 qcrrP0ftUa5W8RmGx/rqK47HzpqP1nNmhA2hHDEiwl0xAaeu7YiX4WBM1ShSgodKPdQP
 PKMw==
X-Gm-Message-State: AGi0Puaiyu5surAMRZvkqFYoohgqDHpAl3s7oFXg1qt+eUwELZ5CzsVR
 vdH0mBLBgykNrpW3ciIKDrKN0Fvrn8H3kXYvt48=
X-Google-Smtp-Source: APiQypIsGvaw+Y+z+ANpoxFa8iWU/h3DIAyMOWFjEmIoTyDj1nvatQIbuw7PtbiVpby54dp9VM62hGCgRQl9ntJy8lI=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr23797221wrp.420.1586877022868; 
 Tue, 14 Apr 2020 08:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200414112849.21787-1-philmd@redhat.com>
 <CAHiYmc6o0TKVmXO4LoR_63RE=u+5xArw-6q9r=w_30T0WOks-A@mail.gmail.com>
 <a096077a-49bf-c7c0-71ca-e7f057c15ad5@redhat.com> <87a73e9m9l.fsf@linaro.org>
In-Reply-To: <87a73e9m9l.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 14 Apr 2020 17:10:04 +0200
Message-ID: <CAHiYmc42Ga_Qk3jyy45RvKr3oGNqRT7-tUJFtpUW2ujUYpCL5g@mail.gmail.com>
Subject: Re: [PATCH-for-5.1] gdbstub: Rename GByteArray variable 'mem_buf' as
 'array'
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004018db05a34199ba"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004018db05a34199ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

4:26 PM Uto, 14.04.2020. Alex Benn=C3=A9e <alex.bennee@linaro.org> =D1=98=
=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 4/14/20 3:35 PM, Aleksandar Markovic wrote:
> >> 1:28 PM Uto, 14.04.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m
> >> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>  >
> >>  > GByteArray type has should not be treated as a u8[] buffer.
> >>  > The GLib Byte Arrays API should be used instead.
> >>  > Rename the 'mem_buf' variable as 'array' to make it more
> >>  > obvious in the code.
> >>  >
> >> Hi, Philippe.
> >> "array" is a horrible choice for a name. It must be more specific.
> >
> > This is how the prototype is documented:
> >
> >
https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html#g-byte-array-=
append
> >
> > GByteArray *
> > g_byte_array_append (GByteArray *array,
> >                      const guint8 *data,
> >                      guint len);
> >
> > What do you suggest?
>
> *buf was also pretty generic. That said I think the "array"-like
> properties of this structure are fairly incidental to it's purpose which
> is a opaque place to store the register data for gdbstub. As we already
> communicate the type in the function prototype maybe *reg or *regdata?
>

I am not a frequent user of this interface, but mostly as an observer,
Alex' "regdata" seems a reasonable choice to me.

Does anybody happen to have a better idea?

Regards,
Aleksandar

> >
> >> Regards,
> >> Aleksandar
> >>  > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >> <mailto:philmd@redhat.com>>
> >>  > ---
> >>  > Based-on: <20200414111846.27495-1-philmd@redhat.com
> >> <mailto:20200414111846.27495-1-philmd@redhat.com>>
> >>  > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >> <mailto:philmd@redhat.com>>
> >>  > ---
> >>  >  include/exec/gdbstub.h      | 34 +++++++-------
> >>  >  include/hw/core/cpu.h       |  2 +-
> >>  >  target/alpha/cpu.h          |  2 +-
> >>  >  target/arm/cpu.h            |  4 +-
> >>  >  target/cris/cpu.h           |  4 +-
> >>  >  target/hppa/cpu.h           |  2 +-
> >>  >  target/i386/cpu.h           |  2 +-
> >>  >  target/lm32/cpu.h           |  2 +-
> >>  >  target/m68k/cpu.h           |  2 +-
> >>  >  target/microblaze/cpu.h     |  2 +-
> >>  >  target/mips/internal.h      |  2 +-
> >>  >  target/openrisc/cpu.h       |  2 +-
> >>  >  target/ppc/cpu.h            |  4 +-
> >>  >  target/riscv/cpu.h          |  2 +-
> >>  >  target/rx/cpu.h             |  2 +-
> >>  >  target/s390x/internal.h     |  2 +-
> >>  >  target/sh4/cpu.h            |  2 +-
> >>  >  target/sparc/cpu.h          |  2 +-
> >>  >  target/xtensa/cpu.h         |  2 +-
> >>  >  gdbstub.c                   |  6 +--
> >>  >  hw/core/cpu.c               |  3 +-
> >>  >  target/alpha/gdbstub.c      |  4 +-
> >>  >  target/arm/gdbstub.c        | 10 ++--
> >>  >  target/arm/gdbstub64.c      | 10 ++--
> >>  >  target/cris/gdbstub.c       | 34 +++++++-------
> >>  >  target/hppa/gdbstub.c       |  6 +--
> >>  >  target/i386/gdbstub.c       | 92
++++++++++++++++++-------------------
> >>  >  target/lm32/gdbstub.c       | 18 ++++----
> >>  >  target/m68k/gdbstub.c       | 10 ++--
> >>  >  target/m68k/helper.c        | 24 +++++-----
> >>  >  target/microblaze/gdbstub.c |  6 +--
> >>  >  target/mips/gdbstub.c       | 30 ++++++------
> >>  >  target/nios2/cpu.c          |  8 ++--
> >>  >  target/openrisc/gdbstub.c   | 10 ++--
> >>  >  target/riscv/gdbstub.c      |  6 +--
> >>  >  target/rx/gdbstub.c         | 22 ++++-----
> >>  >  target/s390x/gdbstub.c      | 28 +++++------
> >>  >  target/sh4/gdbstub.c        | 38 +++++++--------
> >>  >  target/sparc/gdbstub.c      | 46 +++++++++----------
> >>  >  target/xtensa/gdbstub.c     | 20 ++++----
> >>  >  40 files changed, 254 insertions(+), 253 deletions(-)
> >>  >
> >>  > diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> >>  > index 52a4a936c6..29150d1344 100644
> >>  > --- a/include/exec/gdbstub.h
> >>  > +++ b/include/exec/gdbstub.h
> >>  > @@ -80,47 +80,47 @@ void gdb_register_coprocessor(CPUState *cpu,
> >>  >   * append to the array.
> >>  >   */
> >>  >
> >>  > -static inline int gdb_get_reg8(GByteArray *buf, uint8_t val)
> >>  > +static inline int gdb_get_reg8(GByteArray *array, uint8_t val)
> >>  >  {
> >>  > -    g_byte_array_append(buf, &val, 1);
> >>  > +    g_byte_array_append(array, &val, 1);
> >>  >      return 1;
> >>  >  }
> >>  >
> >>  > -static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
> >>  > +static inline int gdb_get_reg16(GByteArray *array, uint16_t val)
> >>  >  {
> >>  >      uint16_t to_word =3D tswap16(val);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_word, 2);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_word, 2);
> >>  >      return 2;
> >>  >  }
> >>  >
> >>  > -static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
> >>  > +static inline int gdb_get_reg32(GByteArray *array, uint32_t val)
> >>  >  {
> >>  >      uint32_t to_long =3D tswap32(val);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_long, 4);
> >>  >      return 4;
> >>  >  }
> >>  >
> >>  > -static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
> >>  > +static inline int gdb_get_reg64(GByteArray *array, uint64_t val)
> >>  >  {
> >>  >      uint64_t to_quad =3D tswap64(val);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
> >>  >      return 8;
> >>  >  }
> >>  >
> >>  > -static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
> >>  > +static inline int gdb_get_reg128(GByteArray *array, uint64_t
val_hi,
> >>  >                                   uint64_t val_lo)
> >>  >  {
> >>  >      uint64_t to_quad;
> >>  >  #ifdef TARGET_WORDS_BIGENDIAN
> >>  >      to_quad =3D tswap64(val_hi);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
> >>  >      to_quad =3D tswap64(val_lo);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
> >>  >  #else
> >>  >      to_quad =3D tswap64(val_lo);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
> >>  >      to_quad =3D tswap64(val_hi);
> >>  > -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> >>  > +    g_byte_array_append(array, (uint8_t *) &to_quad, 8);
> >>  >  #endif
> >>  >      return 16;
> >>  >  }
> >>  > @@ -154,16 +154,16 @@ static inline int gdb_get_zeroes(GByteArray
> >> *array, size_t len)
> >>  >   * element for additional processing. Some front-ends do additiona=
l
> >>  >   * dynamic swapping of the elements based on CPU state.
> >>  >   */
> >>  > -static inline uint8_t * gdb_get_reg_ptr(GByteArray *buf, int len)
> >>  > +static inline uint8_t *gdb_get_reg_ptr(GByteArray *array, int len)
> >>  >  {
> >>  > -    return buf->data + buf->len - len;
> >>  > +    return array->data + array->len - len;
> >>  >  }
> >>  >
> >>  >  #if TARGET_LONG_BITS =3D=3D 64
> >>  > -#define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
> >>  > +#define gdb_get_regl(array, val) gdb_get_reg64(array, val)
> >>  >  #define ldtul_p(addr) ldq_p(addr)
> >>  >  #else
> >>  > -#define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
> >>  > +#define gdb_get_regl(array, val) gdb_get_reg32(array, val)
> >>  >  #define ldtul_p(addr) ldl_p(addr)
> >>  >  #endif
> >>  >
> >>  > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> >>  > index 5bf94d28cf..31434d3b1f 100644
> >>  > --- a/include/hw/core/cpu.h
> >>  > +++ b/include/hw/core/cpu.h
> >>  > @@ -193,7 +193,7 @@ typedef struct CPUClass {
> >>  >      hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
> >>  >                                          MemTxAttrs *attrs);
> >>  >      int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
> >>  > -    int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +    int (*gdb_read_register)(CPUState *cpu, GByteArray *array, int
reg);
> >>  >      int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >      bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint
*wp);
> >>  >      void (*debug_excp_handler)(CPUState *cpu);
> >>  > diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> >>  > index be29bdd530..94853d0bee 100644
> >>  > --- a/target/alpha/cpu.h
> >>  > +++ b/target/alpha/cpu.h
> >>  > @@ -280,7 +280,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  >  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
> >>  >  hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,
> >> int reg);
> >>  > +int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> >>  >                                     MMUAccessType access_type,
> >>  > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >>  > index 8b9f2961ba..cbd3a262f3 100644
> >>  > --- a/target/arm/cpu.h
> >>  > +++ b/target/arm/cpu.h
> >>  > @@ -975,7 +975,7 @@ bool arm_cpu_exec_interrupt(CPUState *cpu,
> >> int int_req);
> >>  >  hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr=
,
> >>  >                                           MemTxAttrs *attrs);
> >>  >
> >>  > -int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >
> >>  >  /*
> >>  > @@ -997,7 +997,7 @@ int
> >> arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> >>  >                               int cpuid, void *opaque);
> >>  >
> >>  >  #ifdef TARGET_AARCH64
> >>  > -int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *buf, int reg);
> >>  > +int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf,
> >> int reg);
> >>  >  void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
> >>  >  void aarch64_sve_change_el(CPUARMState *env, int old_el,
> >>  > diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> >>  > index 8f08d7628b..474a06f929 100644
> >>  > --- a/target/cris/cpu.h
> >>  > +++ b/target/cris/cpu.h
> >>  > @@ -195,8 +195,8 @@ void cris_cpu_dump_state(CPUState *cs, FILE
> >> *f, int flags);
> >>  >
> >>  >  hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  >
> >>  > -int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *buf, int reg);
> >>  > -int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  > +int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int cris_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >
> >>  >  /* you can call this signal handler from your SIGBUS and SIGSEGV
> >>  > diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> >>  > index 801a4fb1ba..d584ad49b4 100644
> >>  > --- a/target/hppa/cpu.h
> >>  > +++ b/target/hppa/cpu.h
> >>  > @@ -321,7 +321,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env)=
;
> >>  >
> >>  >  int cpu_hppa_signal_handler(int host_signum, void *pinfo, void
*puc);
> >>  >  hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
> >>  > -int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void hppa_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >>  > index e818fc712a..9ad798c87e 100644
> >>  > --- a/target/i386/cpu.h
> >>  > +++ b/target/i386/cpu.h
> >>  > @@ -1770,7 +1770,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE
> >> *f, int flags);
> >>  >  hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr=
,
> >>  >                                           MemTxAttrs *attrs);
> >>  >
> >>  > -int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >
> >>  >  void x86_cpu_exec_enter(CPUState *cpu);
> >>  > diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
> >>  > index 01d408eb55..b64e7fdc44 100644
> >>  > --- a/target/lm32/cpu.h
> >>  > +++ b/target/lm32/cpu.h
> >>  > @@ -202,7 +202,7 @@ void lm32_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
> >>  >  void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int lm32_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >
> >>  >  typedef enum {
> >>  > diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> >>  > index 521ac67cdd..705d26746d 100644
> >>  > --- a/target/m68k/cpu.h
> >>  > +++ b/target/m68k/cpu.h
> >>  > @@ -168,7 +168,7 @@ void m68k_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  >  void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >
> >>  >  void m68k_tcg_init(void);
> >>  > diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> >>  > index 1a700a880c..77d6c859ae 100644
> >>  > --- a/target/microblaze/cpu.h
> >>  > +++ b/target/microblaze/cpu.h
> >>  > @@ -313,7 +313,7 @@ void mb_cpu_do_interrupt(CPUState *cs);
> >>  >  bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
> >>  >  void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int
reg);
> >>  >  int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >
> >>  >  void mb_tcg_init(void);
> >>  > diff --git a/target/mips/internal.h b/target/mips/internal.h
> >>  > index 1bf274b3ef..27a9e811f7 100644
> >>  > --- a/target/mips/internal.h
> >>  > +++ b/target/mips/internal.h
> >>  > @@ -82,7 +82,7 @@ void mips_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  >  void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> >>  >                                    MMUAccessType access_type,
> >>  > diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> >>  > index f37a52e153..1d2d5214c2 100644
> >>  > --- a/target/openrisc/cpu.h
> >>  > +++ b/target/openrisc/cpu.h
> >>  > @@ -320,7 +320,7 @@ void openrisc_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  >  void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)=
;
> >>  > -int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *buf, int reg);
> >>  > +int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf,
> >> int reg);
> >>  >  void openrisc_translate_init(void);
> >>  >  bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >>  > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >>  > index 88d9449555..049400f8d7 100644
> >>  > --- a/target/ppc/cpu.h
> >>  > +++ b/target/ppc/cpu.h
> >>  > @@ -1207,8 +1207,8 @@ bool ppc_cpu_exec_interrupt(CPUState *cpu,
> >> int int_req);
> >>  >  void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
> >>  >  hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > -int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray
> >> *buf, int reg);
> >>  > +int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  > +int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t
> >> *buf, int reg);
> >>  >  #ifndef CONFIG_USER_ONLY
> >>  > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >>  > index 7d21addbab..806cb3b044 100644
> >>  > --- a/target/riscv/cpu.h
> >>  > +++ b/target/riscv/cpu.h
> >>  > @@ -293,7 +293,7 @@ extern const char * const riscv_excp_names[];
> >>  >  extern const char * const riscv_intr_names[];
> >>  >
> >>  >  void riscv_cpu_do_interrupt(CPUState *cpu);
> >>  > -int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,
> >> int reg);
> >>  > +int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)=
;
> >>  >  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> >>  > diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> >>  > index d1fb1ef3ca..994ab0c6fd 100644
> >>  > --- a/target/rx/cpu.h
> >>  > +++ b/target/rx/cpu.h
> >>  > @@ -128,7 +128,7 @@ const char *rx_crname(uint8_t cr);
> >>  >  void rx_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  >  void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  > -int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int
reg);
> >>  >  int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  >
> >>  > diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> >>  > index 8c95c734db..04fcb7da74 100644
> >>  > --- a/target/s390x/internal.h
> >>  > +++ b/target/s390x/internal.h
> >>  > @@ -292,7 +292,7 @@ uint16_t float128_dcmask(CPUS390XState *env,
> >> float128 f1);
> >>  >
> >>  >
> >>  >  /* gdbstub.c */
> >>  > -int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg);
> >>  > +int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,
> >> int reg);
> >>  >  int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void s390_cpu_gdb_init(CPUState *cs);
> >>  >
> >>  > diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> >>  > index dbe58c7888..6901c88d7e 100644
> >>  > --- a/target/sh4/cpu.h
> >>  > +++ b/target/sh4/cpu.h
> >>  > @@ -208,7 +208,7 @@ void superh_cpu_do_interrupt(CPUState *cpu);
> >>  >  bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
> >>  >  void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,
> >> int reg);
> >>  > +int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> >>  >                                      MMUAccessType access_type,
> >>  > diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> >>  > index b9369398f2..bb9126b546 100644
> >>  > --- a/target/sparc/cpu.h
> >>  > +++ b/target/sparc/cpu.h
> >>  > @@ -571,7 +571,7 @@ extern const VMStateDescription
vmstate_sparc_cpu;
> >>  >  void sparc_cpu_do_interrupt(CPUState *cpu);
> >>  >  void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> >>  >  hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  > -int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,
> >> int reg);
> >>  > +int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu,
> >> vaddr addr,
> >>  >                                                   MMUAccessType
> >> access_type,
> >>  > diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> >>  > index 7a46dccbe1..8a851e0b00 100644
> >>  > --- a/target/xtensa/cpu.h
> >>  > +++ b/target/xtensa/cpu.h
> >>  > @@ -572,7 +572,7 @@ void xtensa_cpu_dump_state(CPUState *cpu,
> >> FILE *f, int flags);
> >>  >  hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>  >  void xtensa_count_regs(const XtensaConfig *config,
> >>  >                         unsigned *n_regs, unsigned *n_core_regs);
> >>  > -int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,
> >> int reg);
> >>  > +int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray
> >> *array, int reg);
> >>  >  int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
reg);
> >>  >  void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> >>  >                                      MMUAccessType access_type,
> >>  > diff --git a/gdbstub.c b/gdbstub.c
> >>  > index 171e150950..bc24b613b2 100644
> >>  > --- a/gdbstub.c
> >>  > +++ b/gdbstub.c
> >>  > @@ -906,19 +906,19 @@ static const char *get_feature_xml(const
> >> char *p, const char **newp,
> >>  >      return name ? xml_builtin[i][1] : NULL;
> >>  >  }
> >>  >
> >>  > -static int gdb_read_register(CPUState *cpu, GByteArray *buf, int
reg)
> >>  > +static int gdb_read_register(CPUState *cpu, GByteArray *array, int
reg)
> >>  >  {
> >>  >      CPUClass *cc =3D CPU_GET_CLASS(cpu);
> >>  >      CPUArchState *env =3D cpu->env_ptr;
> >>  >      GDBRegisterState *r;
> >>  >
> >>  >      if (reg < cc->gdb_num_core_regs) {
> >>  > -        return cc->gdb_read_register(cpu, buf, reg);
> >>  > +        return cc->gdb_read_register(cpu, array, reg);
> >>  >      }
> >>  >
> >>  >      for (r =3D cpu->gdb_regs; r; r =3D r->next) {
> >>  >          if (r->base_reg <=3D reg && reg < r->base_reg + r->num_reg=
s)
{
> >>  > -            return r->get_reg(env, buf, reg - r->base_reg);
> >>  > +            return r->get_reg(env, array, reg - r->base_reg);
> >>  >          }
> >>  >      }
> >>  >      return 0;
> >>  > diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> >>  > index 786a1bec8a..0f2bd00176 100644
> >>  > --- a/hw/core/cpu.c
> >>  > +++ b/hw/core/cpu.c
> >>  > @@ -177,7 +177,8 @@ static int
> >> cpu_common_write_elf64_note(WriteCoreDumpFunction f,
> >>  >  }
> >>  >
> >>  >
> >>  > -static int cpu_common_gdb_read_register(CPUState *cpu,
> >> GByteArray *buf, int reg)
> >>  > +static int cpu_common_gdb_read_register(CPUState *cpu,
> >> GByteArray *array,
> >>  > +                                        int reg)
> >>  >  {
> >>  >      return 0;
> >>  >  }
> >>  > diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
> >>  > index 0cd76ddaa9..415f422b03 100644
> >>  > --- a/target/alpha/gdbstub.c
> >>  > +++ b/target/alpha/gdbstub.c
> >>  > @@ -21,7 +21,7 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *mem_buf, int n)
> >>  > +int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      AlphaCPU *cpu =3D ALPHA_CPU(cs);
> >>  >      CPUAlphaState *env =3D &cpu->env;
> >>  > @@ -54,7 +54,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >      default:
> >>  >          return 0;
> >>  >      }
> >>  > -    return gdb_get_regl(mem_buf, val);
> >>  > +    return gdb_get_regl(array, val);
> >>  >  }
> >>  >
> >>  >  int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf,
int n)
> >>  > diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> >>  > index 063551df23..66a8af8a19 100644
> >>  > --- a/target/arm/gdbstub.c
> >>  > +++ b/target/arm/gdbstub.c
> >>  > @@ -33,21 +33,21 @@ typedef struct RegisterSysregXmlParam {
> >>  >     We hack round this by giving the FPA regs zero size when
talking to a
> >>  >     newer gdb.  */
> >>  >
> >>  > -int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int
n)
> >>  >  {
> >>  >      ARMCPU *cpu =3D ARM_CPU(cs);
> >>  >      CPUARMState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 16) {
> >>  >          /* Core integer register.  */
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_reg32(array, env->regs[n]);
> >>  >      }
> >>  >      if (n < 24) {
> >>  >          /* FPA registers.  */
> >>  >          if (gdb_has_xml) {
> >>  >              return 0;
> >>  >          }
> >>  > -        return gdb_get_zeroes(mem_buf, 12);
> >>  > +        return gdb_get_zeroes(array, 12);
> >>  >      }
> >>  >      switch (n) {
> >>  >      case 24:
> >>  > @@ -55,10 +55,10 @@ int arm_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >          if (gdb_has_xml) {
> >>  >              return 0;
> >>  >          }
> >>  > -        return gdb_get_reg32(mem_buf, 0);
> >>  > +        return gdb_get_reg32(array, 0);
> >>  >      case 25:
> >>  >          /* CPSR */
> >>  > -        return gdb_get_reg32(mem_buf, cpsr_read(env));
> >>  > +        return gdb_get_reg32(array, cpsr_read(env));
> >>  >      }
> >>  >      /* Unknown register.  */
> >>  >      return 0;
> >>  > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> >>  > index 35d0b80c2d..16860a0522 100644
> >>  > --- a/target/arm/gdbstub64.c
> >>  > +++ b/target/arm/gdbstub64.c
> >>  > @@ -20,22 +20,22 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *mem_buf, int n)
> >>  > +int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *array, int n)
> >>  >  {
> >>  >      ARMCPU *cpu =3D ARM_CPU(cs);
> >>  >      CPUARMState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 31) {
> >>  >          /* Core integer register.  */
> >>  > -        return gdb_get_reg64(mem_buf, env->xregs[n]);
> >>  > +        return gdb_get_reg64(array, env->xregs[n]);
> >>  >      }
> >>  >      switch (n) {
> >>  >      case 31:
> >>  > -        return gdb_get_reg64(mem_buf, env->xregs[31]);
> >>  > +        return gdb_get_reg64(array, env->xregs[31]);
> >>  >      case 32:
> >>  > -        return gdb_get_reg64(mem_buf, env->pc);
> >>  > +        return gdb_get_reg64(array, env->pc);
> >>  >      case 33:
> >>  > -        return gdb_get_reg32(mem_buf, pstate_read(env));
> >>  > +        return gdb_get_reg32(array, pstate_read(env));
> >>  >      }
> >>  >      /* Unknown register.  */
> >>  >      return 0;
> >>  > diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
> >>  > index b01b2aa081..dd7f754935 100644
> >>  > --- a/target/cris/gdbstub.c
> >>  > +++ b/target/cris/gdbstub.c
> >>  > @@ -21,31 +21,31 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *mem_buf, int n)
> >>  > +int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *array, int n)
> >>  >  {
> >>  >      CRISCPU *cpu =3D CRIS_CPU(cs);
> >>  >      CPUCRISState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 15) {
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_reg32(array, env->regs[n]);
> >>  >      }
> >>  >
> >>  >      if (n =3D=3D 15) {
> >>  > -        return gdb_get_reg32(mem_buf, env->pc);
> >>  > +        return gdb_get_reg32(array, env->pc);
> >>  >      }
> >>  >
> >>  >      if (n < 32) {
> >>  >          switch (n) {
> >>  >          case 16:
> >>  > -            return gdb_get_reg8(mem_buf, env->pregs[n - 16]);
> >>  > +            return gdb_get_reg8(array, env->pregs[n - 16]);
> >>  >          case 17:
> >>  > -            return gdb_get_reg8(mem_buf, env->pregs[n - 16]);
> >>  > +            return gdb_get_reg8(array, env->pregs[n - 16]);
> >>  >          case 20:
> >>  >          case 21:
> >>  > -            return gdb_get_reg16(mem_buf, env->pregs[n - 16]);
> >>  > +            return gdb_get_reg16(array, env->pregs[n - 16]);
> >>  >          default:
> >>  >              if (n >=3D 23) {
> >>  > -                return gdb_get_reg32(mem_buf, env->pregs[n - 16]);
> >>  > +                return gdb_get_reg32(array, env->pregs[n - 16]);
> >>  >              }
> >>  >              break;
> >>  >          }
> >>  > @@ -53,7 +53,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >      return 0;
> >>  >  }
> >>  >
> >>  > -int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      CRISCPU *cpu =3D CRIS_CPU(cs);
> >>  >      CPUCRISState *env =3D &cpu->env;
> >>  > @@ -61,28 +61,28 @@ int cris_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >
> >>  >      srs =3D env->pregs[PR_SRS];
> >>  >      if (n < 16) {
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_reg32(array, env->regs[n]);
> >>  >      }
> >>  >
> >>  >      if (n >=3D 21 && n < 32) {
> >>  > -        return gdb_get_reg32(mem_buf, env->pregs[n - 16]);
> >>  > +        return gdb_get_reg32(array, env->pregs[n - 16]);
> >>  >      }
> >>  >      if (n >=3D 33 && n < 49) {
> >>  > -        return gdb_get_reg32(mem_buf, env->sregs[srs][n - 33]);
> >>  > +        return gdb_get_reg32(array, env->sregs[srs][n - 33]);
> >>  >      }
> >>  >      switch (n) {
> >>  >      case 16:
> >>  > -        return gdb_get_reg8(mem_buf, env->pregs[0]);
> >>  > +        return gdb_get_reg8(array, env->pregs[0]);
> >>  >      case 17:
> >>  > -        return gdb_get_reg8(mem_buf, env->pregs[1]);
> >>  > +        return gdb_get_reg8(array, env->pregs[1]);
> >>  >      case 18:
> >>  > -        return gdb_get_reg32(mem_buf, env->pregs[2]);
> >>  > +        return gdb_get_reg32(array, env->pregs[2]);
> >>  >      case 19:
> >>  > -        return gdb_get_reg8(mem_buf, srs);
> >>  > +        return gdb_get_reg8(array, srs);
> >>  >      case 20:
> >>  > -        return gdb_get_reg16(mem_buf, env->pregs[4]);
> >>  > +        return gdb_get_reg16(array, env->pregs[4]);
> >>  >      case 32:
> >>  > -        return gdb_get_reg32(mem_buf, env->pc);
> >>  > +        return gdb_get_reg32(array, env->pc);
> >>  >      }
> >>  >
> >>  >      return 0;
> >>  > diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
> >>  > index a6428a2893..d0618f5175 100644
> >>  > --- a/target/hppa/gdbstub.c
> >>  > +++ b/target/hppa/gdbstub.c
> >>  > @@ -21,7 +21,7 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      HPPACPU *cpu =3D HPPA_CPU(cs);
> >>  >      CPUHPPAState *env =3D &cpu->env;
> >>  > @@ -140,9 +140,9 @@ int hppa_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >      }
> >>  >
> >>  >      if (TARGET_REGISTER_BITS =3D=3D 64) {
> >>  > -        return gdb_get_reg64(mem_buf, val);
> >>  > +        return gdb_get_reg64(array, val);
> >>  >      } else {
> >>  > -        return gdb_get_reg32(mem_buf, val);
> >>  > +        return gdb_get_reg32(array, val);
> >>  >      }
> >>  >  }
> >>  >
> >>  > diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> >>  > index f3d23b614e..40f1b03a36 100644
> >>  > --- a/target/i386/gdbstub.c
> >>  > +++ b/target/i386/gdbstub.c
> >>  > @@ -79,7 +79,7 @@ static const int gpr_map32[8] =3D { 0, 1, 2, 3,
> >> 4, 5, 6, 7 };
> >>  >  #endif
> >>  >
> >>  >
> >>  > -int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int
n)
> >>  >  {
> >>  >      X86CPU *cpu =3D X86_CPU(cs);
> >>  >      CPUX86State *env =3D &cpu->env;
> >>  > @@ -93,25 +93,25 @@ int x86_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >      if (n < CPU_NB_REGS) {
> >>  >          if (TARGET_LONG_BITS =3D=3D 64) {
> >>  >              if (env->hflags & HF_CS64_MASK) {
> >>  > -                return gdb_get_reg64(mem_buf,
env->regs[gpr_map[n]]);
> >>  > +                return gdb_get_reg64(array, env->regs[gpr_map[n]])=
;
> >>  >              } else if (n < CPU_NB_REGS32) {
> >>  > -                return gdb_get_reg64(mem_buf,
> >>  > +                return gdb_get_reg64(array,
> >>  >                                       env->regs[gpr_map[n]] &
> >> 0xffffffffUL);
> >>  >              } else {
> >>  > -                return gdb_get_regl(mem_buf, 0);
> >>  > +                return gdb_get_regl(array, 0);
> >>  >              }
> >>  >          } else {
> >>  > -            return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]])=
;
> >>  > +            return gdb_get_reg32(array, env->regs[gpr_map32[n]]);
> >>  >          }
> >>  >      } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
> >>  >          floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS=
];
> >>  > -        int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> >>  > -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high=
));
> >>  > +        int len =3D gdb_get_reg64(array, cpu_to_le64(fp->low));
> >>  > +        len +=3D gdb_get_reg16(array + len, cpu_to_le16(fp->high))=
;
> >>  >          return len;
> >>  >      } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS +
CPU_NB_REGS) {
> >>  >          n -=3D IDX_XMM_REGS;
> >>  >          if (n < CPU_NB_REGS32 || TARGET_LONG_BITS =3D=3D 64) {
> >>  > -            return gdb_get_reg128(mem_buf,
> >>  > +            return gdb_get_reg128(array,
> >>  >                                    env->xmm_regs[n].ZMM_Q(0),
> >>  >                                    env->xmm_regs[n].ZMM_Q(1));
> >>  >          }
> >>  > @@ -120,95 +120,95 @@ int x86_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >          case IDX_IP_REG:
> >>  >              if (TARGET_LONG_BITS =3D=3D 64) {
> >>  >                  if (env->hflags & HF_CS64_MASK) {
> >>  > -                    return gdb_get_reg64(mem_buf, env->eip);
> >>  > +                    return gdb_get_reg64(array, env->eip);
> >>  >                  } else {
> >>  > -                    return gdb_get_reg64(mem_buf, env->eip &
> >> 0xffffffffUL);
> >>  > +                    return gdb_get_reg64(array, env->eip &
> >> 0xffffffffUL);
> >>  >                  }
> >>  >              } else {
> >>  > -                return gdb_get_reg32(mem_buf, env->eip);
> >>  > +                return gdb_get_reg32(array, env->eip);
> >>  >              }
> >>  >          case IDX_FLAGS_REG:
> >>  > -            return gdb_get_reg32(mem_buf, env->eflags);
> >>  > +            return gdb_get_reg32(array, env->eflags);
> >>  >
> >>  >          case IDX_SEG_REGS:
> >>  > -            return gdb_get_reg32(mem_buf,
env->segs[R_CS].selector);
> >>  > +            return gdb_get_reg32(array, env->segs[R_CS].selector);
> >>  >          case IDX_SEG_REGS + 1:
> >>  > -            return gdb_get_reg32(mem_buf,
env->segs[R_SS].selector);
> >>  > +            return gdb_get_reg32(array, env->segs[R_SS].selector);
> >>  >          case IDX_SEG_REGS + 2:
> >>  > -            return gdb_get_reg32(mem_buf,
env->segs[R_DS].selector);
> >>  > +            return gdb_get_reg32(array, env->segs[R_DS].selector);
> >>  >          case IDX_SEG_REGS + 3:
> >>  > -            return gdb_get_reg32(mem_buf,
env->segs[R_ES].selector);
> >>  > +            return gdb_get_reg32(array, env->segs[R_ES].selector);
> >>  >          case IDX_SEG_REGS + 4:
> >>  > -            return gdb_get_reg32(mem_buf,
env->segs[R_FS].selector);
> >>  > +            return gdb_get_reg32(array, env->segs[R_FS].selector);
> >>  >          case IDX_SEG_REGS + 5:
> >>  > -            return gdb_get_reg32(mem_buf,
env->segs[R_GS].selector);
> >>  > +            return gdb_get_reg32(array, env->segs[R_GS].selector);
> >>  >
> >>  >          case IDX_SEG_REGS + 6:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf,
env->segs[R_FS].base);
> >>  > +                return gdb_get_reg64(array, env->segs[R_FS].base);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->segs[R_FS].base);
> >>  > +            return gdb_get_reg32(array, env->segs[R_FS].base);
> >>  >
> >>  >          case IDX_SEG_REGS + 7:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf,
env->segs[R_GS].base);
> >>  > +                return gdb_get_reg64(array, env->segs[R_GS].base);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->segs[R_GS].base);
> >>  > +            return gdb_get_reg32(array, env->segs[R_GS].base);
> >>  >
> >>  >          case IDX_SEG_REGS + 8:
> >>  >  #ifdef TARGET_X86_64
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, env->kernelgsbase);
> >>  > +                return gdb_get_reg64(array, env->kernelgsbase);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->kernelgsbase);
> >>  > +            return gdb_get_reg32(array, env->kernelgsbase);
> >>  >  #else
> >>  > -            return gdb_get_reg32(mem_buf, 0);
> >>  > +            return gdb_get_reg32(array, 0);
> >>  >  #endif
> >>  >
> >>  >          case IDX_FP_REGS + 8:
> >>  > -            return gdb_get_reg32(mem_buf, env->fpuc);
> >>  > +            return gdb_get_reg32(array, env->fpuc);
> >>  >          case IDX_FP_REGS + 9:
> >>  > -            return gdb_get_reg32(mem_buf, (env->fpus & ~0x3800) |
> >>  > +            return gdb_get_reg32(array, (env->fpus & ~0x3800) |
> >>  >                                            (env->fpstt & 0x7) <<
11);
> >>  >          case IDX_FP_REGS + 10:
> >>  > -            return gdb_get_reg32(mem_buf, 0); /* ftag */
> >>  > +            return gdb_get_reg32(array, 0); /* ftag */
> >>  >          case IDX_FP_REGS + 11:
> >>  > -            return gdb_get_reg32(mem_buf, 0); /* fiseg */
> >>  > +            return gdb_get_reg32(array, 0); /* fiseg */
> >>  >          case IDX_FP_REGS + 12:
> >>  > -            return gdb_get_reg32(mem_buf, 0); /* fioff */
> >>  > +            return gdb_get_reg32(array, 0); /* fioff */
> >>  >          case IDX_FP_REGS + 13:
> >>  > -            return gdb_get_reg32(mem_buf, 0); /* foseg */
> >>  > +            return gdb_get_reg32(array, 0); /* foseg */
> >>  >          case IDX_FP_REGS + 14:
> >>  > -            return gdb_get_reg32(mem_buf, 0); /* fooff */
> >>  > +            return gdb_get_reg32(array, 0); /* fooff */
> >>  >          case IDX_FP_REGS + 15:
> >>  > -            return gdb_get_reg32(mem_buf, 0); /* fop */
> >>  > +            return gdb_get_reg32(array, 0); /* fop */
> >>  >
> >>  >          case IDX_MXCSR_REG:
> >>  > -            return gdb_get_reg32(mem_buf, env->mxcsr);
> >>  > +            return gdb_get_reg32(array, env->mxcsr);
> >>  >
> >>  >          case IDX_CTL_CR0_REG:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, env->cr[0]);
> >>  > +                return gdb_get_reg64(array, env->cr[0]);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->cr[0]);
> >>  > +            return gdb_get_reg32(array, env->cr[0]);
> >>  >
> >>  >          case IDX_CTL_CR2_REG:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, env->cr[2]);
> >>  > +                return gdb_get_reg64(array, env->cr[2]);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->cr[2]);
> >>  > +            return gdb_get_reg32(array, env->cr[2]);
> >>  >
> >>  >          case IDX_CTL_CR3_REG:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, env->cr[3]);
> >>  > +                return gdb_get_reg64(array, env->cr[3]);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->cr[3]);
> >>  > +            return gdb_get_reg32(array, env->cr[3]);
> >>  >
> >>  >          case IDX_CTL_CR4_REG:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, env->cr[4]);
> >>  > +                return gdb_get_reg64(array, env->cr[4]);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->cr[4]);
> >>  > +            return gdb_get_reg32(array, env->cr[4]);
> >>  >
> >>  >          case IDX_CTL_CR8_REG:
> >>  >  #ifdef CONFIG_SOFTMMU
> >>  > @@ -217,15 +217,15 @@ int x86_cpu_gdb_read_register(CPUState *cs,
> >> GByteArray *mem_buf, int n)
> >>  >              tpr =3D 0;
> >>  >  #endif
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, tpr);
> >>  > +                return gdb_get_reg64(array, tpr);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, tpr);
> >>  > +            return gdb_get_reg32(array, tpr);
> >>  >
> >>  >          case IDX_CTL_EFER_REG:
> >>  >              if ((env->hflags & HF_CS64_MASK) || GDB_FORCE_64) {
> >>  > -                return gdb_get_reg64(mem_buf, env->efer);
> >>  > +                return gdb_get_reg64(array, env->efer);
> >>  >              }
> >>  > -            return gdb_get_reg32(mem_buf, env->efer);
> >>  > +            return gdb_get_reg32(array, env->efer);
> >>  >          }
> >>  >      }
> >>  >      return 0;
> >>  > diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
> >>  > index b6fe12e1d6..6198719944 100644
> >>  > --- a/target/lm32/gdbstub.c
> >>  > +++ b/target/lm32/gdbstub.c
> >>  > @@ -22,30 +22,30 @@
> >>  >  #include "exec/gdbstub.h"
> >>  >  #include "hw/lm32/lm32_pic.h"
> >>  >
> >>  > -int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      LM32CPU *cpu =3D LM32_CPU(cs);
> >>  >      CPULM32State *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 32) {
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_reg32(array, env->regs[n]);
> >>  >      } else {
> >>  >          switch (n) {
> >>  >          case 32:
> >>  > -            return gdb_get_reg32(mem_buf, env->pc);
> >>  > +            return gdb_get_reg32(array, env->pc);
> >>  >          /* FIXME: put in right exception ID */
> >>  >          case 33:
> >>  > -            return gdb_get_reg32(mem_buf, 0);
> >>  > +            return gdb_get_reg32(array, 0);
> >>  >          case 34:
> >>  > -            return gdb_get_reg32(mem_buf, env->eba);
> >>  > +            return gdb_get_reg32(array, env->eba);
> >>  >          case 35:
> >>  > -            return gdb_get_reg32(mem_buf, env->deba);
> >>  > +            return gdb_get_reg32(array, env->deba);
> >>  >          case 36:
> >>  > -            return gdb_get_reg32(mem_buf, env->ie);
> >>  > +            return gdb_get_reg32(array, env->ie);
> >>  >          case 37:
> >>  > -            return gdb_get_reg32(mem_buf,
> >> lm32_pic_get_im(env->pic_state));
> >>  > +            return gdb_get_reg32(array,
> >> lm32_pic_get_im(env->pic_state));
> >>  >          case 38:
> >>  > -            return gdb_get_reg32(mem_buf,
> >> lm32_pic_get_ip(env->pic_state));
> >>  > +            return gdb_get_reg32(array,
> >> lm32_pic_get_ip(env->pic_state));
> >>  >          }
> >>  >      }
> >>  >      return 0;
> >>  > diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
> >>  > index eb2d030e14..9405dc4b4e 100644
> >>  > --- a/target/m68k/gdbstub.c
> >>  > +++ b/target/m68k/gdbstub.c
> >>  > @@ -21,24 +21,24 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      M68kCPU *cpu =3D M68K_CPU(cs);
> >>  >      CPUM68KState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 8) {
> >>  >          /* D0-D7 */
> >>  > -        return gdb_get_reg32(mem_buf, env->dregs[n]);
> >>  > +        return gdb_get_reg32(array, env->dregs[n]);
> >>  >      } else if (n < 16) {
> >>  >          /* A0-A7 */
> >>  > -        return gdb_get_reg32(mem_buf, env->aregs[n - 8]);
> >>  > +        return gdb_get_reg32(array, env->aregs[n - 8]);
> >>  >      } else {
> >>  >          switch (n) {
> >>  >          case 16:
> >>  >              /* SR is made of SR+CCR, CCR is many 1bit flags so
> >> uses helper */
> >>  > -            return gdb_get_reg32(mem_buf, env->sr |
> >> cpu_m68k_get_ccr(env));
> >>  > +            return gdb_get_reg32(array, env->sr |
> >> cpu_m68k_get_ccr(env));
> >>  >          case 17:
> >>  > -            return gdb_get_reg32(mem_buf, env->pc);
> >>  > +            return gdb_get_reg32(array, env->pc);
> >>  >          }
> >>  >      }
> >>  >      /*
> >>  > diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> >>  > index 014657c637..968371476a 100644
> >>  > --- a/target/m68k/helper.c
> >>  > +++ b/target/m68k/helper.c
> >>  > @@ -68,19 +68,19 @@ void m68k_cpu_list(void)
> >>  >      g_slist_free(list);
> >>  >  }
> >>  >
> >>  > -static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray
> >> *mem_buf, int n)
> >>  > +static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray
> >> *array, int n)
> >>  >  {
> >>  >      if (n < 8) {
> >>  >          float_status s;
> >>  > -        return gdb_get_reg64(mem_buf,
> >> floatx80_to_float64(env->fregs[n].d, &s));
> >>  > +        return gdb_get_reg64(array,
> >> floatx80_to_float64(env->fregs[n].d, &s));
> >>  >      }
> >>  >      switch (n) {
> >>  >      case 8: /* fpcontrol */
> >>  > -        return gdb_get_reg32(mem_buf, env->fpcr);
> >>  > +        return gdb_get_reg32(array, env->fpcr);
> >>  >      case 9: /* fpstatus */
> >>  > -        return gdb_get_reg32(mem_buf, env->fpsr);
> >>  > +        return gdb_get_reg32(array, env->fpsr);
> >>  >      case 10: /* fpiar, not implemented */
> >>  > -        return gdb_get_reg32(mem_buf, 0);
> >>  > +        return gdb_get_reg32(array, 0);
> >>  >      }
> >>  >      return 0;
> >>  >  }
> >>  > @@ -105,21 +105,21 @@ static int cf_fpu_gdb_set_reg(CPUM68KState
> >> *env, uint8_t *mem_buf, int n)
> >>  >      return 0;
> >>  >  }
> >>  >
> >>  > -static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray
> >> *mem_buf, int n)
> >>  > +static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray
> >> *array, int n)
> >>  >  {
> >>  >      if (n < 8) {
> >>  > -        int len =3D gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
> >>  > -        len +=3D gdb_get_reg16(mem_buf + len, 0);
> >>  > -        len +=3D gdb_get_reg64(mem_buf + len, env->fregs[n].l.lowe=
r);
> >>  > +        int len =3D gdb_get_reg16(array, env->fregs[n].l.upper);
> >>  > +        len +=3D gdb_get_reg16(array + len, 0);
> >>  > +        len +=3D gdb_get_reg64(array + len, env->fregs[n].l.lower)=
;
> >>  >          return len;
> >>  >      }
> >>  >      switch (n) {
> >>  >      case 8: /* fpcontrol */
> >>  > -        return gdb_get_reg32(mem_buf, env->fpcr);
> >>  > +        return gdb_get_reg32(array, env->fpcr);
> >>  >      case 9: /* fpstatus */
> >>  > -        return gdb_get_reg32(mem_buf, env->fpsr);
> >>  > +        return gdb_get_reg32(array, env->fpsr);
> >>  >      case 10: /* fpiar, not implemented */
> >>  > -        return gdb_get_reg32(mem_buf, 0);
> >>  > +        return gdb_get_reg32(array, 0);
> >>  >      }
> >>  >      return 0;
> >>  >  }
> >>  > diff --git a/target/microblaze/gdbstub.c
b/target/microblaze/gdbstub.c
> >>  > index f41ebf1f33..40d41e12ce 100644
> >>  > --- a/target/microblaze/gdbstub.c
> >>  > +++ b/target/microblaze/gdbstub.c
> >>  > @@ -21,15 +21,15 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int
n)
> >>  >  {
> >>  >      MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(cs);
> >>  >      CPUMBState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 32) {
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_reg32(array, env->regs[n]);
> >>  >      } else {
> >>  > -        return gdb_get_reg32(mem_buf, env->sregs[n - 32]);
> >>  > +        return gdb_get_reg32(array, env->sregs[n - 32]);
> >>  >      }
> >>  >      return 0;
> >>  >  }
> >>  > diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
> >>  > index 98f56e660d..0fc957d5cd 100644
> >>  > --- a/target/mips/gdbstub.c
> >>  > +++ b/target/mips/gdbstub.c
> >>  > @@ -22,54 +22,54 @@
> >>  >  #include "internal.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      MIPSCPU *cpu =3D MIPS_CPU(cs);
> >>  >      CPUMIPSState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 32) {
> >>  > -        return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
> >>  > +        return gdb_get_regl(array, env->active_tc.gpr[n]);
> >>  >      }
> >>  >      if (env->CP0_Config1 & (1 << CP0C1_FP) && n >=3D 38 && n < 72)=
 {
> >>  >          switch (n) {
> >>  >          case 70:
> >>  > -            return gdb_get_regl(mem_buf,
> >> (int32_t)env->active_fpu.fcr31);
> >>  > +            return gdb_get_regl(array,
(int32_t)env->active_fpu.fcr31);
> >>  >          case 71:
> >>  > -            return gdb_get_regl(mem_buf,
(int32_t)env->active_fpu.fcr0);
> >>  > +            return gdb_get_regl(array,
(int32_t)env->active_fpu.fcr0);
> >>  >          default:
> >>  >              if (env->CP0_Status & (1 << CP0St_FR)) {
> >>  > -                return gdb_get_regl(mem_buf,
> >>  > +                return gdb_get_regl(array,
> >>  >                      env->active_fpu.fpr[n - 38].d);
> >>  >              } else {
> >>  > -                return gdb_get_regl(mem_buf,
> >>  > +                return gdb_get_regl(array,
> >>  >                      env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX]);
> >>  >              }
> >>  >          }
> >>  >      }
> >>  >      switch (n) {
> >>  >      case 32:
> >>  > -        return gdb_get_regl(mem_buf, (int32_t)env->CP0_Status);
> >>  > +        return gdb_get_regl(array, (int32_t)env->CP0_Status);
> >>  >      case 33:
> >>  > -        return gdb_get_regl(mem_buf, env->active_tc.LO[0]);
> >>  > +        return gdb_get_regl(array, env->active_tc.LO[0]);
> >>  >      case 34:
> >>  > -        return gdb_get_regl(mem_buf, env->active_tc.HI[0]);
> >>  > +        return gdb_get_regl(array, env->active_tc.HI[0]);
> >>  >      case 35:
> >>  > -        return gdb_get_regl(mem_buf, env->CP0_BadVAddr);
> >>  > +        return gdb_get_regl(array, env->CP0_BadVAddr);
> >>  >      case 36:
> >>  > -        return gdb_get_regl(mem_buf, (int32_t)env->CP0_Cause);
> >>  > +        return gdb_get_regl(array, (int32_t)env->CP0_Cause);
> >>  >      case 37:
> >>  > -        return gdb_get_regl(mem_buf, env->active_tc.PC |
> >>  > +        return gdb_get_regl(array, env->active_tc.PC |
> >>  >                                       !!(env->hflags &
MIPS_HFLAG_M16));
> >>  >      case 72:
> >>  > -        return gdb_get_regl(mem_buf, 0); /* fp */
> >>  > +        return gdb_get_regl(array, 0); /* fp */
> >>  >      case 89:
> >>  > -        return gdb_get_regl(mem_buf, (int32_t)env->CP0_PRid);
> >>  > +        return gdb_get_regl(array, (int32_t)env->CP0_PRid);
> >>  >      default:
> >>  >          if (n > 89) {
> >>  >              return 0;
> >>  >          }
> >>  >          /* 16 embedded regs.  */
> >>  > -        return gdb_get_regl(mem_buf, 0);
> >>  > +        return gdb_get_regl(array, 0);
> >>  >      }
> >>  >
> >>  >      return 0;
> >>  > diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> >>  > index 8f7011fcb9..3cf696402f 100644
> >>  > --- a/target/nios2/cpu.c
> >>  > +++ b/target/nios2/cpu.c
> >>  > @@ -124,7 +124,7 @@ static void nios2_cpu_disas_set_info(CPUState
> >> *cpu, disassemble_info *info)
> >>  >  #endif
> >>  >  }
> >>  >
> >>  > -static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *mem_buf, int n)
> >>  > +static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *array, int n)
> >>  >  {
> >>  >      Nios2CPU *cpu =3D NIOS2_CPU(cs);
> >>  >      CPUClass *cc =3D CPU_GET_CLASS(cs);
> >>  > @@ -135,11 +135,11 @@ static int
> >> nios2_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int
> >> n)
> >>  >      }
> >>  >
> >>  >      if (n < 32) {          /* GP regs */
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_reg32(array, env->regs[n]);
> >>  >      } else if (n =3D=3D 32) {    /* PC */
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[R_PC]);
> >>  > +        return gdb_get_reg32(array, env->regs[R_PC]);
> >>  >      } else if (n < 49) {     /* Status regs */
> >>  > -        return gdb_get_reg32(mem_buf, env->regs[n - 1]);
> >>  > +        return gdb_get_reg32(array, env->regs[n - 1]);
> >>  >      }
> >>  >
> >>  >      /* Invalid regs */
> >>  > diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
> >>  > index 095bf76c12..c34d3696ec 100644
> >>  > --- a/target/openrisc/gdbstub.c
> >>  > +++ b/target/openrisc/gdbstub.c
> >>  > @@ -21,23 +21,23 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *mem_buf, int n)
> >>  > +int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *array, int n)
> >>  >  {
> >>  >      OpenRISCCPU *cpu =3D OPENRISC_CPU(cs);
> >>  >      CPUOpenRISCState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 32) {
> >>  > -        return gdb_get_reg32(mem_buf, cpu_get_gpr(env, n));
> >>  > +        return gdb_get_reg32(array, cpu_get_gpr(env, n));
> >>  >      } else {
> >>  >          switch (n) {
> >>  >          case 32:    /* PPC */
> >>  > -            return gdb_get_reg32(mem_buf, env->ppc);
> >>  > +            return gdb_get_reg32(array, env->ppc);
> >>  >
> >>  >          case 33:    /* NPC (equals PC) */
> >>  > -            return gdb_get_reg32(mem_buf, env->pc);
> >>  > +            return gdb_get_reg32(array, env->pc);
> >>  >
> >>  >          case 34:    /* SR */
> >>  > -            return gdb_get_reg32(mem_buf, cpu_get_sr(env));
> >>  > +            return gdb_get_reg32(array, cpu_get_sr(env));
> >>  >
> >>  >          default:
> >>  >              break;
> >>  > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> >>  > index eba12a86f2..8e1d64c1cf 100644
> >>  > --- a/target/riscv/gdbstub.c
> >>  > +++ b/target/riscv/gdbstub.c
> >>  > @@ -270,15 +270,15 @@ static int csr_register_map[] =3D {
> >>  >      CSR_MHCOUNTEREN,
> >>  >  };
> >>  >
> >>  > -int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray
> >> *mem_buf, int n)
> >>  > +int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      RISCVCPU *cpu =3D RISCV_CPU(cs);
> >>  >      CPURISCVState *env =3D &cpu->env;
> >>  >
> >>  >      if (n < 32) {
> >>  > -        return gdb_get_regl(mem_buf, env->gpr[n]);
> >>  > +        return gdb_get_regl(array, env->gpr[n]);
> >>  >      } else if (n =3D=3D 32) {
> >>  > -        return gdb_get_regl(mem_buf, env->pc);
> >>  > +        return gdb_get_regl(array, env->pc);
> >>  >      }
> >>  >      return 0;
> >>  >  }
> >>  > diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
> >>  > index 9391e8151e..91dee774f6 100644
> >>  > --- a/target/rx/gdbstub.c
> >>  > +++ b/target/rx/gdbstub.c
> >>  > @@ -20,32 +20,32 @@
> >>  >  #include "cpu.h"
> >>  >  #include "exec/gdbstub.h"
> >>  >
> >>  > -int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int
n)
> >>  >  {
> >>  >      RXCPU *cpu =3D RXCPU(cs);
> >>  >      CPURXState *env =3D &cpu->env;
> >>  >
> >>  >      switch (n) {
> >>  >      case 0 ... 15:
> >>  > -        return gdb_get_regl(mem_buf, env->regs[n]);
> >>  > +        return gdb_get_regl(array, env->regs[n]);
> >>  >      case 16:
> >>  > -        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0]
> >> : env->usp);
> >>  > +        return gdb_get_regl(array, (env->psw_u) ? env->regs[0] :
> >> env->usp);
> >>  >      case 17:
> >>  > -        return gdb_get_regl(mem_buf, (!env->psw_u) ?
> >> env->regs[0] : env->isp);
> >>  > +        return gdb_get_regl(array, (!env->psw_u) ? env->regs[0]
> >> : env->isp);
> >>  >      case 18:
> >>  > -        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
> >>  > +        return gdb_get_regl(array, rx_cpu_pack_psw(env));
> >>  >      case 19:
> >>  > -        return gdb_get_regl(mem_buf, env->pc);
> >>  > +        return gdb_get_regl(array, env->pc);
> >>  >      case 20:
> >>  > -        return gdb_get_regl(mem_buf, env->intb);
> >>  > +        return gdb_get_regl(array, env->intb);
> >>  >      case 21:
> >>  > -        return gdb_get_regl(mem_buf, env->bpsw);
> >>  > +        return gdb_get_regl(array, env->bpsw);
> >>  >      case 22:
> >>  > -        return gdb_get_regl(mem_buf, env->bpc);
> >>  > +        return gdb_get_regl(array, env->bpc);
> >>  >      case 23:
> >>  > -        return gdb_get_regl(mem_buf, env->fintv);
> >>  > +        return gdb_get_regl(array, env->fintv);
> >>  >      case 24:
> >>  > -        return gdb_get_regl(mem_buf, env->fpsw);
> >>  > +        return gdb_get_regl(array, env->fpsw);
> >>  >      case 25:
> >>  >          return 0;
> >>  >      }
> >>  > diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
> >>  > index d6fce5ff1e..adbe7b5d39 100644
> >>  > --- a/target/s390x/gdbstub.c
> >>  > +++ b/target/s390x/gdbstub.c
> >>  > @@ -27,7 +27,7 @@
> >>  >  #include "sysemu/hw_accel.h"
> >>  >  #include "sysemu/tcg.h"
> >>  >
> >>  > -int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,
int n)
> >>  > +int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *array,
int n)
> >>  >  {
> >>  >      S390CPU *cpu =3D S390_CPU(cs);
> >>

--0000000000004018db05a34199ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">4:26 PM Uto, 14.04.2020. Alex Benn=C3=A9e &lt;<a href=3D"mai=
lto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt;<br>
&gt; Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">p=
hilmd@redhat.com</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; On 4/14/20 3:35 PM, Aleksandar Markovic wrote:<br>
&gt; &gt;&gt; 1:28 PM Uto, 14.04.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a><br>
&gt; &gt;&gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com">philmd@redhat=
.com</a>&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; GByteArray type has should not be treated as a u8[=
] buffer.<br>
&gt; &gt;&gt;=C2=A0 &gt; The GLib Byte Arrays API should be used instead.<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; Rename the &#39;mem_buf&#39; variable as &#39;arra=
y&#39; to make it more<br>
&gt; &gt;&gt;=C2=A0 &gt; obvious in the code.<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt; Hi, Philippe.<br>
&gt; &gt;&gt; &quot;array&quot; is a horrible choice for a name. It must be=
 more specific.<br>
&gt; &gt;<br>
&gt; &gt; This is how the prototype is documented:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://developer.gnome.org/glib/stable/glib-Byte-Arra=
ys.html#g-byte-array-append">https://developer.gnome.org/glib/stable/glib-B=
yte-Arrays.html#g-byte-array-append</a><br>
&gt; &gt;<br>
&gt; &gt; GByteArray *<br>
&gt; &gt; g_byte_array_append (GByteArray *array,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const guint8 *data,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 guint len);<br>
&gt; &gt;<br>
&gt; &gt; What do you suggest?<br>
&gt;<br>
&gt; *buf was also pretty generic. That said I think the &quot;array&quot;-=
like<br>
&gt; properties of this structure are fairly incidental to it&#39;s purpose=
 which<br>
&gt; is a opaque place to store the register data for gdbstub. As we alread=
y<br>
&gt; communicate the type in the function prototype maybe *reg or *regdata?=
<br>
&gt;</p>
<p dir=3D"ltr">I am not a frequent user of this interface, but mostly as an=
 observer, Alex&#39; &quot;regdata&quot; seems a reasonable choice to me.</=
p>
<p dir=3D"ltr">Does anybody happen to have a better idea?</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt;&gt; Regards,<br>
&gt; &gt;&gt; Aleksandar<br>
&gt; &gt;&gt;=C2=A0 &gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a> <br>
&gt; &gt;&gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com">philmd@redhat=
.com</a>&gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; ---<br>
&gt; &gt;&gt;=C2=A0 &gt; Based-on: &lt;<a href=3D"mailto:20200414111846.274=
95-1-philmd@redhat.com">20200414111846.27495-1-philmd@redhat.com</a><br>
&gt; &gt;&gt; &lt;mailto:<a href=3D"mailto:20200414111846.27495-1-philmd@re=
dhat.com">20200414111846.27495-1-philmd@redhat.com</a>&gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a><br>
&gt; &gt;&gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com">philmd@redhat=
.com</a>&gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; ---<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 include/exec/gdbstub.h=C2=A0 =C2=A0 =C2=A0 |=
 34 +++++++-------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/alpha/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 4 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/cris/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/hppa/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/lm32/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/mips/internal.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/openrisc/cpu.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/ppc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 4 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/rx/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/s390x/internal.h=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/sh4/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/sparc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/xtensa/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 2 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hw/core/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/alpha/gdbstub.c=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 4 +-<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/arm/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 10 ++--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/arm/gdbstub64.c=C2=A0 =C2=A0 =C2=A0 |=
 10 ++--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/cris/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 34 +++++++-------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/hppa/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 +--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/i386/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 92 ++++++++++++++++++-------------------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/lm32/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 18 ++++----<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/m68k/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 10 ++--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/m68k/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 24 +++++-----<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/microblaze/gdbstub.c |=C2=A0 6 +--<br=
>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/mips/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 30 ++++++------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/nios2/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 8 ++--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/openrisc/gdbstub.c=C2=A0 =C2=A0| 10 +=
+--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 6 +--<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/rx/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 22 ++++-----<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/s390x/gdbstub.c=C2=A0 =C2=A0 =C2=A0 |=
 28 +++++------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/sh4/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 38 +++++++--------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/sparc/gdbstub.c=C2=A0 =C2=A0 =C2=A0 |=
 46 +++++++++----------<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 target/xtensa/gdbstub.c=C2=A0 =C2=A0 =C2=A0|=
 20 ++++----<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 40 files changed, 254 insertions(+), 253 del=
etions(-)<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/include/exec/gdbstub.h b/include/exec=
/gdbstub.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 52a4a936c6..29150d1344 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/include/exec/gdbstub.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/include/exec/gdbstub.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -80,47 +80,47 @@ void gdb_register_coprocessor(=
CPUState *cpu,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0* append to the array.<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static inline int gdb_get_reg8(GByteArray *buf, u=
int8_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static inline int gdb_get_reg8(GByteArray *array,=
 uint8_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, &amp;val, =
1);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, &amp;val=
, 1);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static inline int gdb_get_reg16(GByteArray *buf, =
uint16_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static inline int gdb_get_reg16(GByteArray *array=
, uint16_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 uint16_t to_word =3D tswap16(v=
al);<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_word, 2);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_word, 2);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 2;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static inline int gdb_get_reg32(GByteArray *buf, =
uint32_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static inline int gdb_get_reg32(GByteArray *array=
, uint32_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t to_long =3D tswap32(v=
al);<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_long, 4);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_long, 4);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 4;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static inline int gdb_get_reg64(GByteArray *buf, =
uint64_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static inline int gdb_get_reg64(GByteArray *array=
, uint64_t val)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t to_quad =3D tswap64(v=
al);<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static inline int gdb_get_reg128(GByteArray *buf,=
 uint64_t val_hi,<br>
&gt; &gt;&gt;=C2=A0 &gt; +static inline int gdb_get_reg128(GByteArray *arra=
y, uint64_t val_hi,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t val_lo)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t to_quad;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #ifdef TARGET_WORDS_BIGENDIAN<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 to_quad =3D tswap64(val_hi);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 to_quad =3D tswap64(val_lo);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #else<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 to_quad =3D tswap64(val_lo);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 to_quad =3D tswap64(val_hi);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *=
) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t=
 *) &amp;to_quad, 8);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 16;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -154,16 +154,16 @@ static inline int gdb_get_ze=
roes(GByteArray<br>
&gt; &gt;&gt; *array, size_t len)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0* element for additional processing. S=
ome front-ends do additional<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0* dynamic swapping of the elements bas=
ed on CPU state.<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt;&gt;=C2=A0 &gt; -static inline uint8_t * gdb_get_reg_ptr(GByteArra=
y *buf, int len)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static inline uint8_t *gdb_get_reg_ptr(GByteArray=
 *array, int len)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 return buf-&gt;data + buf-&gt;len -=
 len;<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 return array-&gt;data + array-&gt;l=
en - len;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #if TARGET_LONG_BITS =3D=3D 64<br>
&gt; &gt;&gt;=C2=A0 &gt; -#define gdb_get_regl(buf, val) gdb_get_reg64(buf,=
 val)<br>
&gt; &gt;&gt;=C2=A0 &gt; +#define gdb_get_regl(array, val) gdb_get_reg64(ar=
ray, val)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #define ldtul_p(addr) ldq_p(addr)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #else<br>
&gt; &gt;&gt;=C2=A0 &gt; -#define gdb_get_regl(buf, val) gdb_get_reg32(buf,=
 val)<br>
&gt; &gt;&gt;=C2=A0 &gt; +#define gdb_get_regl(array, val) gdb_get_reg32(ar=
ray, val)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #define ldtul_p(addr) ldl_p(addr)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/include/hw/core/cpu.h b/include/hw/co=
re/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 5bf94d28cf..31434d3b1f 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/include/hw/core/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/include/hw/core/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -193,7 +193,7 @@ typedef struct CPUClass {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 hwaddr (*get_phys_page_attrs_d=
ebug)(CPUState *cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAttrs *attrs);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 int (*asidx_from_attrs)(CPUSta=
te *cpu, MemTxAttrs attrs);<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 int (*gdb_read_register)(CPUState *=
cpu, GByteArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 int (*gdb_read_register)(CPUState *=
cpu, GByteArray *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 int (*gdb_write_register)(CPUS=
tate *cpu, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 bool (*debug_check_watchpoint)=
(CPUState *cpu, CPUWatchpoint *wp);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 void (*debug_excp_handler)(CPU=
State *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/alpha/cpu.h b/target/alpha/cpu=
.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index be29bdd530..94853d0bee 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/alpha/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/alpha/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -280,7 +280,7 @@ void alpha_cpu_do_interrupt(CP=
UState *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool alpha_cpu_exec_interrupt(CPUState *cpu,=
 int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void alpha_cpu_dump_state(CPUState *cs, FILE=
 *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr alpha_cpu_get_phys_page_debug(CPUStat=
e *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int alpha_cpu_gdb_read_register(CPUState *cpu, GB=
yteArray *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int alpha_cpu_gdb_read_register(CPUState *cpu, GB=
yteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int alpha_cpu_gdb_write_register(CPUState *c=
pu, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void alpha_cpu_do_unaligned_access(CPUState =
*cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MMUAccessType access_type,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/arm/cpu.h b/target/arm/cpu.h<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; index 8b9f2961ba..cbd3a262f3 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/arm/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/arm/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -975,7 +975,7 @@ bool arm_cpu_exec_interrupt(CP=
UState *cpu,<br>
&gt; &gt;&gt; int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr arm_cpu_get_phys_page_attrs_debug(CPU=
State *cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs *attrs);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int arm_cpu_gdb_read_register(CPUState *cpu, GByt=
eArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int arm_cpu_gdb_read_register(CPUState *cpu, GByt=
eArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int arm_cpu_gdb_write_register(CPUState *cpu=
, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 /*<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -997,7 +997,7 @@ int<br>
&gt; &gt;&gt; arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *c=
s,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int cpuid, vo=
id *opaque);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #ifdef TARGET_AARCH64<br>
&gt; &gt;&gt;=C2=A0 &gt; -int aarch64_cpu_gdb_read_register(CPUState *cpu, =
GByteArray<br>
&gt; &gt;&gt; *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int aarch64_cpu_gdb_read_register(CPUState *cpu, =
GByteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int aarch64_cpu_gdb_write_register(CPUState =
*cpu, uint8_t *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void aarch64_sve_narrow_vq(CPUARMState *env,=
 unsigned vq);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void aarch64_sve_change_el(CPUARMState *env,=
 int old_el,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/cris/cpu.h b/target/cris/cpu.h=
<br>
&gt; &gt;&gt;=C2=A0 &gt; index 8f08d7628b..474a06f929 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/cris/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/cris/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -195,8 +195,8 @@ void cris_cpu_dump_state(CPUSt=
ate *cs, FILE<br>
&gt; &gt;&gt; *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr cris_cpu_get_phys_page_debug(CPUState=
 *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int crisv10_cpu_gdb_read_register(CPUState *cpu, =
GByteArray<br>
&gt; &gt;&gt; *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int cris_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int crisv10_cpu_gdb_read_register(CPUState *cpu, =
GByteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int cris_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int cris_cpu_gdb_write_register(CPUState *cp=
u, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 /* you can call this signal handler from you=
r SIGBUS and SIGSEGV<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h=
<br>
&gt; &gt;&gt;=C2=A0 &gt; index 801a4fb1ba..d584ad49b4 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/hppa/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/hppa/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -321,7 +321,7 @@ void cpu_hppa_change_prot_id(C=
PUHPPAState *env);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int cpu_hppa_signal_handler(int host_signum,=
 void *pinfo, void *puc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr hppa_cpu_get_phys_page_debug(CPUState=
 *cs, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int hppa_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int hppa_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int hppa_cpu_gdb_write_register(CPUState *cp=
u, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void hppa_cpu_do_interrupt(CPUState *cpu);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool hppa_cpu_exec_interrupt(CPUState *cpu, =
int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/i386/cpu.h b/target/i386/cpu.h=
<br>
&gt; &gt;&gt;=C2=A0 &gt; index e818fc712a..9ad798c87e 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/i386/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/i386/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -1770,7 +1770,7 @@ void x86_cpu_dump_state(CPUS=
tate *cs, FILE<br>
&gt; &gt;&gt; *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr x86_cpu_get_phys_page_attrs_debug(CPU=
State *cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs *attrs);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int x86_cpu_gdb_read_register(CPUState *cpu, GByt=
eArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int x86_cpu_gdb_read_register(CPUState *cpu, GByt=
eArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int x86_cpu_gdb_write_register(CPUState *cpu=
, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void x86_cpu_exec_enter(CPUState *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h=
<br>
&gt; &gt;&gt;=C2=A0 &gt; index 01d408eb55..b64e7fdc44 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/lm32/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/lm32/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -202,7 +202,7 @@ void lm32_cpu_do_interrupt(CPU=
State *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool lm32_cpu_exec_interrupt(CPUState *cs, i=
nt int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void lm32_cpu_dump_state(CPUState *cpu, FILE=
 *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr lm32_cpu_get_phys_page_debug(CPUState=
 *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int lm32_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int lm32_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int lm32_cpu_gdb_write_register(CPUState *cp=
u, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 typedef enum {<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h=
<br>
&gt; &gt;&gt;=C2=A0 &gt; index 521ac67cdd..705d26746d 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/m68k/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/m68k/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -168,7 +168,7 @@ void m68k_cpu_do_interrupt(CPU=
State *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool m68k_cpu_exec_interrupt(CPUState *cpu, =
int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void m68k_cpu_dump_state(CPUState *cpu, FILE=
 *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr m68k_cpu_get_phys_page_debug(CPUState=
 *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int m68k_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int m68k_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int m68k_cpu_gdb_write_register(CPUState *cp=
u, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void m68k_tcg_init(void);<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/microblaze/cpu.h b/target/micr=
oblaze/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 1a700a880c..77d6c859ae 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/microblaze/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/microblaze/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -313,7 +313,7 @@ void mb_cpu_do_interrupt(CPUSt=
ate *cs);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool mb_cpu_exec_interrupt(CPUState *cs, int=
 int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void mb_cpu_dump_state(CPUState *cpu, FILE *=
f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr mb_cpu_get_phys_page_debug(CPUState *=
cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int mb_cpu_gdb_read_register(CPUState *cpu, GByte=
Array *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int mb_cpu_gdb_read_register(CPUState *cpu, GByte=
Array *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int mb_cpu_gdb_write_register(CPUState *cpu,=
 uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void mb_tcg_init(void);<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/mips/internal.h b/target/mips/=
internal.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 1bf274b3ef..27a9e811f7 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/mips/internal.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/mips/internal.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -82,7 +82,7 @@ void mips_cpu_do_interrupt(CPUSt=
ate *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool mips_cpu_exec_interrupt(CPUState *cpu, =
int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void mips_cpu_dump_state(CPUState *cpu, FILE=
 *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr mips_cpu_get_phys_page_debug(CPUState=
 *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int mips_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int mips_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int mips_cpu_gdb_write_register(CPUState *cp=
u, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void mips_cpu_do_unaligned_access(CPUState *=
cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MMUAccessType access_type,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/openrisc/cpu.h b/target/openri=
sc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index f37a52e153..1d2d5214c2 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/openrisc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/openrisc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -320,7 +320,7 @@ void openrisc_cpu_do_interrupt=
(CPUState *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool openrisc_cpu_exec_interrupt(CPUState *c=
pu, int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void openrisc_cpu_dump_state(CPUState *cpu, =
FILE *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr openrisc_cpu_get_phys_page_debug(CPUS=
tate *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int openrisc_cpu_gdb_read_register(CPUState *cpu,=
 GByteArray<br>
&gt; &gt;&gt; *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int openrisc_cpu_gdb_read_register(CPUState *cpu,=
 GByteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int openrisc_cpu_gdb_write_register(CPUState=
 *cpu, uint8_t *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void openrisc_translate_init(void);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool openrisc_cpu_tlb_fill(CPUState *cs, vad=
dr address, int size,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; index 88d9449555..049400f8d7 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/ppc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/ppc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -1207,8 +1207,8 @@ bool ppc_cpu_exec_interrupt(=
CPUState *cpu,<br>
&gt; &gt;&gt; int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void ppc_cpu_dump_state(CPUState *cpu, FILE =
*f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void ppc_cpu_dump_statistics(CPUState *cpu, =
int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr ppc_cpu_get_phys_page_debug(CPUState =
*cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int ppc_cpu_gdb_read_register(CPUState *cpu, GByt=
eArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int ppc_cpu_gdb_read_register_apple(CPUState *cpu=
, GByteArray<br>
&gt; &gt;&gt; *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int ppc_cpu_gdb_read_register(CPUState *cpu, GByt=
eArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int ppc_cpu_gdb_read_register_apple(CPUState *cpu=
, GByteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int ppc_cpu_gdb_write_register(CPUState *cpu=
, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int ppc_cpu_gdb_write_register_apple(CPUStat=
e *cpu, uint8_t<br>
&gt; &gt;&gt; *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu=
.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 7d21addbab..806cb3b044 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/riscv/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/riscv/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -293,7 +293,7 @@ extern const char * const risc=
v_excp_names[];<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 extern const char * const riscv_intr_names[]=
;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void riscv_cpu_do_interrupt(CPUState *cpu);<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -int riscv_cpu_gdb_read_register(CPUState *cpu, GB=
yteArray *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int riscv_cpu_gdb_read_register(CPUState *cpu, GB=
yteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int riscv_cpu_gdb_write_register(CPUState *c=
pu, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool riscv_cpu_exec_interrupt(CPUState *cs, =
int interrupt_request);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool riscv_cpu_fp_enabled(CPURISCVState *env=
);<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/rx/cpu.h b/target/rx/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index d1fb1ef3ca..994ab0c6fd 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/rx/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/rx/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -128,7 +128,7 @@ const char *rx_crname(uint8_t =
cr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void rx_cpu_do_interrupt(CPUState *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool rx_cpu_exec_interrupt(CPUState *cpu, in=
t int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void rx_cpu_dump_state(CPUState *cpu, FILE *=
f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int rx_cpu_gdb_read_register(CPUState *cpu, GByte=
Array *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int rx_cpu_gdb_read_register(CPUState *cpu, GByte=
Array *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int rx_cpu_gdb_write_register(CPUState *cpu,=
 uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr rx_cpu_get_phys_page_debug(CPUState *=
cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/s390x/internal.h b/target/s390=
x/internal.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 8c95c734db..04fcb7da74 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/s390x/internal.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/s390x/internal.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -292,7 +292,7 @@ uint16_t float128_dcmask(CPUS3=
90XState *env,<br>
&gt; &gt;&gt; float128 f1);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 /* gdbstub.c */<br>
&gt; &gt;&gt;=C2=A0 &gt; -int s390_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int s390_cpu_gdb_read_register(CPUState *cpu, GBy=
teArray *array,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int s390_cpu_gdb_write_register(CPUState *cp=
u, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void s390_cpu_gdb_init(CPUState *cs);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h<b=
r>
&gt; &gt;&gt;=C2=A0 &gt; index dbe58c7888..6901c88d7e 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/sh4/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/sh4/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -208,7 +208,7 @@ void superh_cpu_do_interrupt(C=
PUState *cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 bool superh_cpu_exec_interrupt(CPUState *cpu=
, int int_req);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void superh_cpu_dump_state(CPUState *cpu, FI=
LE *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr superh_cpu_get_phys_page_debug(CPUSta=
te *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int superh_cpu_gdb_read_register(CPUState *cpu, G=
ByteArray *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int superh_cpu_gdb_read_register(CPUState *cpu, G=
ByteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int superh_cpu_gdb_write_register(CPUState *=
cpu, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void superh_cpu_do_unaligned_access(CPUState=
 *cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 MMUAccessType access_type,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/sparc/cpu.h b/target/sparc/cpu=
.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index b9369398f2..bb9126b546 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/sparc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/sparc/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -571,7 +571,7 @@ extern const VMStateDescriptio=
n vmstate_sparc_cpu;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void sparc_cpu_do_interrupt(CPUState *cpu);<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void sparc_cpu_dump_state(CPUState *cpu, FIL=
E *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr sparc_cpu_get_phys_page_debug(CPUStat=
e *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int sparc_cpu_gdb_read_register(CPUState *cpu, GB=
yteArray *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int sparc_cpu_gdb_read_register(CPUState *cpu, GB=
yteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int sparc_cpu_gdb_write_register(CPUState *c=
pu, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void QEMU_NORETURN sparc_cpu_do_unaligned_ac=
cess(CPUState *cpu,<br>
&gt; &gt;&gt; vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType<br=
>
&gt; &gt;&gt; access_type,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/xtensa/cpu.h b/target/xtensa/c=
pu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; index 7a46dccbe1..8a851e0b00 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/xtensa/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/xtensa/cpu.h<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -572,7 +572,7 @@ void xtensa_cpu_dump_state(CPU=
State *cpu,<br>
&gt; &gt;&gt; FILE *f, int flags);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 hwaddr xtensa_cpu_get_phys_page_debug(CPUSta=
te *cpu, vaddr addr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void xtensa_count_regs(const XtensaConfig *c=
onfig,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned *n_regs, unsigned *n_core=
_regs);<br>
&gt; &gt;&gt;=C2=A0 &gt; -int xtensa_cpu_gdb_read_register(CPUState *cpu, G=
ByteArray *buf,<br>
&gt; &gt;&gt; int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +int xtensa_cpu_gdb_read_register(CPUState *cpu, G=
ByteArray<br>
&gt; &gt;&gt; *array, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int xtensa_cpu_gdb_write_register(CPUState *=
cpu, uint8_t *buf, int reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 void xtensa_cpu_do_unaligned_access(CPUState=
 *cpu, vaddr addr,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 MMUAccessType access_type,<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/gdbstub.c b/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 171e150950..bc24b613b2 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -906,19 +906,19 @@ static const char *get_featu=
re_xml(const<br>
&gt; &gt;&gt; char *p, const char **newp,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return name ? xml_builtin[i][1=
] : NULL;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static int gdb_read_register(CPUState *cpu, GByte=
Array *buf, int reg)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static int gdb_read_register(CPUState *cpu, GByte=
Array *array, int reg)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUClass *cc =3D CPU_GET_CLASS=
(cpu);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUArchState *env =3D cpu-&gt;=
env_ptr;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 GDBRegisterState *r;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (reg &lt; cc-&gt;gdb_num_co=
re_regs) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cc-&gt;gdb_rea=
d_register(cpu, buf, reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cc-&gt;gdb_rea=
d_register(cpu, array, reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 for (r =3D cpu-&gt;gdb_regs; r=
; r =3D r-&gt;next) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r-&gt;base_r=
eg &lt;=3D reg &amp;&amp; reg &lt; r-&gt;base_reg + r-&gt;num_regs) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
r-&gt;get_reg(env, buf, reg - r-&gt;base_reg);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
r-&gt;get_reg(env, array, reg - r-&gt;base_reg);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/hw/core/cpu.c b/hw/core/cpu.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 786a1bec8a..0f2bd00176 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/hw/core/cpu.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/hw/core/cpu.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -177,7 +177,8 @@ static int<br>
&gt; &gt;&gt; cpu_common_write_elf64_note(WriteCoreDumpFunction f,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static int cpu_common_gdb_read_register(CPUState =
*cpu,<br>
&gt; &gt;&gt; GByteArray *buf, int reg)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static int cpu_common_gdb_read_register(CPUState =
*cpu,<br>
&gt; &gt;&gt; GByteArray *array,<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int reg)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/alpha/gdbstub.c b/target/alpha=
/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 0cd76ddaa9..415f422b03 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/alpha/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/alpha/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -21,7 +21,7 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int alpha_cpu_gdb_read_register(CPUState *cs, GBy=
teArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int alpha_cpu_gdb_read_register(CPUState *cs, GBy=
teArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 AlphaCPU *cpu =3D ALPHA_CPU(cs=
);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUAlphaState *env =3D &amp;cp=
u-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -54,7 +54,7 @@ int alpha_cpu_gdb_read_register(=
CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 return gdb_get_regl(mem_buf, val);<=
br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 return gdb_get_regl(array, val);<br=
>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 int alpha_cpu_gdb_write_register(CPUState *c=
s, uint8_t *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/arm/gdbstub.c b/target/arm/gdb=
stub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 063551df23..66a8af8a19 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/arm/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/arm/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -33,21 +33,21 @@ typedef struct RegisterSysregX=
mlParam {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0We hack round this by giving th=
e FPA regs zero size when talking to a<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0newer gdb.=C2=A0 */<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int arm_cpu_gdb_read_register(CPUState *cs, GByte=
Array *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int arm_cpu_gdb_read_register(CPUState *cs, GByte=
Array *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-=
&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 16) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Core integer =
register.=C2=A0 */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 24) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FPA registers=
.=C2=A0 */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gdb_has_xml)=
 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes=
(mem_buf, 12);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes=
(array, 12);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 24:<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -55,10 +55,10 @@ int arm_cpu_gdb_read_register(=
CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gdb_has_xml)=
 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 25:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPSR */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, cpsr_read(env));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, cpsr_read(env));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 /* Unknown register.=C2=A0 */<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/arm/gdbstub64.c b/target/arm/g=
dbstub64.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 35d0b80c2d..16860a0522 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/arm/gdbstub64.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/arm/gdbstub64.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -20,22 +20,22 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int aarch64_cpu_gdb_read_register(CPUState *cs, G=
ByteArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int aarch64_cpu_gdb_read_register(CPUState *cs, G=
ByteArray<br>
&gt; &gt;&gt; *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-=
&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 31) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Core integer =
register.=C2=A0 */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
mem_buf, env-&gt;xregs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
array, env-&gt;xregs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 31:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
mem_buf, env-&gt;xregs[31]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
array, env-&gt;xregs[31]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 32:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
mem_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
array, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 33:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, pstate_read(env));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, pstate_read(env));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 /* Unknown register.=C2=A0 */<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/cris/gdbstub.c b/target/cris/g=
dbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index b01b2aa081..dd7f754935 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/cris/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/cris/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -21,31 +21,31 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int crisv10_cpu_gdb_read_register(CPUState *cs, G=
ByteArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int crisv10_cpu_gdb_read_register(CPUState *cs, G=
ByteArray<br>
&gt; &gt;&gt; *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CRISCPU *cpu =3D CRIS_CPU(cs);=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUCRISState *env =3D &amp;cpu=
-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 15) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n =3D=3D 15) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 16:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg8(mem_buf, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg8(array, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg8(mem_buf, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg8(array, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 20:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 21:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg16(mem_buf, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg16(array, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (n &gt;=3D 23) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg32(mem_buf, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg32(array, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -53,7 +53,7 @@ int crisv10_cpu_gdb_read_registe=
r(CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int cris_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int cris_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CRISCPU *cpu =3D CRIS_CPU(cs);=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUCRISState *env =3D &amp;cpu=
-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -61,28 +61,28 @@ int cris_cpu_gdb_read_register=
(CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 srs =3D env-&gt;pregs[PR_SRS];=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 16) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &gt;=3D 21 &amp;&amp; n =
&lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;pregs[n - 16]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &gt;=3D 33 &amp;&amp; n =
&lt; 49) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;sregs[srs][n - 33]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;sregs[srs][n - 33]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 16:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(m=
em_buf, env-&gt;pregs[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(a=
rray, env-&gt;pregs[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(m=
em_buf, env-&gt;pregs[1]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(a=
rray, env-&gt;pregs[1]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 18:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;pregs[2]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;pregs[2]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 19:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(m=
em_buf, srs);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(a=
rray, srs);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 20:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(=
mem_buf, env-&gt;pregs[4]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(=
array, env-&gt;pregs[4]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 32:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/hppa/gdbstub.c b/target/hppa/g=
dbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index a6428a2893..d0618f5175 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/hppa/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/hppa/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -21,7 +21,7 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int hppa_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int hppa_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 HPPACPU *cpu =3D HPPA_CPU(cs);=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUHPPAState *env =3D &amp;cpu=
-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -140,9 +140,9 @@ int hppa_cpu_gdb_read_register=
(CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (TARGET_REGISTER_BITS =3D=
=3D 64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
mem_buf, val);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
array, val);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, val);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, val);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/i386/gdbstub.c b/target/i386/g=
dbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index f3d23b614e..40f1b03a36 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/i386/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/i386/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -79,7 +79,7 @@ static const int gpr_map32[8] =
=3D { 0, 1, 2, 3,<br>
&gt; &gt;&gt; 4, 5, 6, 7 };<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int x86_cpu_gdb_read_register(CPUState *cs, GByte=
Array *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int x86_cpu_gdb_read_register(CPUState *cs, GByte=
Array *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 X86CPU *cpu =3D X86_CPU(cs);<b=
r>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUX86State *env =3D &amp;cpu-=
&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -93,25 +93,25 @@ int x86_cpu_gdb_read_register(=
CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; CPU_NB_REGS) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TARGET_LONG_=
BITS =3D=3D 64) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (env-&gt;hflags &amp; HF_CS64_MASK) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;regs[gpr_map[n]]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;regs[gpr_map[n]]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =
else if (n &lt; CPU_NB_REGS32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf,<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0env-&gt;regs[gpr_map[n]] &amp;<br>
&gt; &gt;&gt; 0xffffffffUL);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =
else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_regl(mem_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_regl(array, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;regs[gpr_map32[n]]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;regs[gpr_map32[n]]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else if (n &gt;=3D IDX_FP_RE=
GS &amp;&amp; n &lt; IDX_FP_REGS + 8) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 floatx80 *fp =3D=
 (floatx80 *) &amp;env-&gt;fpregs[n - IDX_FP_REGS];<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_r=
eg64(mem_buf, cpu_to_le64(fp-&gt;low));<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg1=
6(mem_buf + len, cpu_to_le16(fp-&gt;high));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_r=
eg64(array, cpu_to_le64(fp-&gt;low));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg1=
6(array + len, cpu_to_le16(fp-&gt;high));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else if (n &gt;=3D IDX_XMM_R=
EGS &amp;&amp; n &lt; IDX_XMM_REGS + CPU_NB_REGS) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n -=3D IDX_XMM_R=
EGS;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &lt; CPU_N=
B_REGS32 || TARGET_LONG_BITS =3D=3D 64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg128(mem_buf,<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg128(array,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 env-&gt;xmm_regs[n].ZMM_Q(0),<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 env-&gt;xmm_regs[n].ZMM_Q(1));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -120,95 +120,95 @@ int x86_cpu_gdb_read_registe=
r(CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_IP_REG:=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (TARGET_LONG_BITS =3D=3D 64) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (env-&gt;hflags &amp; HF_CS64_MASK) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, env-&gt;eip);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, env-&gt;eip);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, env-&gt;eip &amp;<br>
&gt; &gt;&gt; 0xffffffffUL);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, env-&gt;eip &amp;<br>
&gt; &gt;&gt; 0xffffffffUL);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =
else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg32(mem_buf, env-&gt;eip);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg32(array, env-&gt;eip);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FLAGS_R=
EG:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;eflags);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;eflags);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_CS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_CS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 1:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_SS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_SS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 2:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_DS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_DS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 3:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_ES].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_ES].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 4:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_FS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_FS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 5:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_GS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_GS].selector);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 6:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;segs[R_FS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;segs[R_FS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_FS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_FS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 7:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;segs[R_GS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;segs[R_GS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;segs[R_GS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;segs[R_GS].base);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_SEG_REG=
S + 8:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #ifdef TARGET_X86_64<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;kernelgsbase);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;kernelgsbase);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;kernelgsbase);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;kernelgsbase);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #else<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 8:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;fpuc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;fpuc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 9:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, (env-&gt;fpus &amp; ~0x3800) |<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, (env-&gt;fpus &amp; ~0x3800) |<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;fpstt &amp; 0x7) &lt;&lt; 11);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 10:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0); /* ftag */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0); /* ftag */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 11:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0); /* fiseg */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0); /* fiseg */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 12:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0); /* fioff */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0); /* fioff */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 13:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0); /* foseg */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0); /* foseg */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 14:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0); /* fooff */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0); /* fooff */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_FP_REGS=
 + 15:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0); /* fop */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0); /* fop */<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_MXCSR_R=
EG:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;mxcsr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;mxcsr);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_CTL_CR0=
_REG:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;cr[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;cr[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;cr[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;cr[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_CTL_CR2=
_REG:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;cr[2]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;cr[2]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;cr[2]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;cr[2]);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_CTL_CR3=
_REG:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;cr[3]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;cr[3]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;cr[3]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;cr[3]);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_CTL_CR4=
_REG:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;cr[4]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;cr[4]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;cr[4]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;cr[4]);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_CTL_CR8=
_REG:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #ifdef CONFIG_SOFTMMU<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -217,15 +217,15 @@ int x86_cpu_gdb_read_registe=
r(CPUState *cs,<br>
&gt; &gt;&gt; GByteArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tp=
r =3D 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, tpr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, tpr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, tpr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, tpr);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IDX_CTL_EFE=
R_REG:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 ((env-&gt;hflags &amp; HF_CS64_MASK) || GDB_FORCE_64) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(mem_buf, env-&gt;efer);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_reg64(array, env-&gt;efer);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;efer);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;efer);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/lm32/gdbstub.c b/target/lm32/g=
dbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index b6fe12e1d6..6198719944 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/lm32/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/lm32/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -22,30 +22,30 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;hw/lm32/lm32_pic.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int lm32_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int lm32_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 LM32CPU *cpu =3D LM32_CPU(cs);=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPULM32State *env =3D &amp;cpu=
-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 32:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME: put in=
 right exception ID */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 33:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 34:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;eba);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;eba);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 35:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;deba);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;deba);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 36:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;ie);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;ie);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 37:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf,<br>
&gt; &gt;&gt; lm32_pic_get_im(env-&gt;pic_state));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array,<br>
&gt; &gt;&gt; lm32_pic_get_im(env-&gt;pic_state));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 38:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf,<br>
&gt; &gt;&gt; lm32_pic_get_ip(env-&gt;pic_state));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array,<br>
&gt; &gt;&gt; lm32_pic_get_ip(env-&gt;pic_state));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/m68k/gdbstub.c b/target/m68k/g=
dbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index eb2d030e14..9405dc4b4e 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/m68k/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/m68k/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -21,24 +21,24 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int m68k_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int m68k_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 M68kCPU *cpu =3D M68K_CPU(cs);=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUM68KState *env =3D &amp;cpu=
-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 8) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* D0-D7 */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;dregs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;dregs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else if (n &lt; 16) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* A0-A7 */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;aregs[n - 8]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;aregs[n - 8]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 16:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 SR is made of SR+CCR, CCR is many 1bit flags so<br>
&gt; &gt;&gt; uses helper */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;sr |<br>
&gt; &gt;&gt; cpu_m68k_get_ccr(env));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;sr |<br>
&gt; &gt;&gt; cpu_m68k_get_ccr(env));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/m68k/helper.c b/target/m68k/he=
lper.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 014657c637..968371476a 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/m68k/helper.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/m68k/helper.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -68,19 +68,19 @@ void m68k_cpu_list(void)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 g_slist_free(list);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static int cf_fpu_gdb_get_reg(CPUM68KState *env, =
GByteArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static int cf_fpu_gdb_get_reg(CPUM68KState *env, =
GByteArray<br>
&gt; &gt;&gt; *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 8) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_status s;<=
br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
mem_buf,<br>
&gt; &gt;&gt; floatx80_to_float64(env-&gt;fregs[n].d, &amp;s));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(=
array,<br>
&gt; &gt;&gt; floatx80_to_float64(env-&gt;fregs[n].d, &amp;s));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 8: /* fpcontrol */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;fpcr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;fpcr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 9: /* fpstatus */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;fpsr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;fpsr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 10: /* fpiar, not impleme=
nted */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -105,21 +105,21 @@ static int cf_fpu_gdb_set_re=
g(CPUM68KState<br>
&gt; &gt;&gt; *env, uint8_t *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static int m68k_fpu_gdb_get_reg(CPUM68KState *env=
, GByteArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static int m68k_fpu_gdb_get_reg(CPUM68KState *env=
, GByteArray<br>
&gt; &gt;&gt; *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 8) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_r=
eg16(mem_buf, env-&gt;fregs[n].l.upper);<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg1=
6(mem_buf + len, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg6=
4(mem_buf + len, env-&gt;fregs[n].l.lower);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_r=
eg16(array, env-&gt;fregs[n].l.upper);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg1=
6(array + len, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg6=
4(array + len, env-&gt;fregs[n].l.lower);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 8: /* fpcontrol */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;fpcr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;fpcr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 9: /* fpstatus */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;fpsr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;fpsr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 10: /* fpiar, not impleme=
nted */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/microblaze/gdbstub.c b/target/=
microblaze/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index f41ebf1f33..40d41e12ce 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/microblaze/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/microblaze/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -21,15 +21,15 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int mb_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int mb_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 MicroBlazeCPU *cpu =3D MICROBL=
AZE_CPU(cs);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUMBState *env =3D &amp;cpu-&=
gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;sregs[n - 32]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;sregs[n - 32]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/mips/gdbstub.c b/target/mips/g=
dbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 98f56e660d..0fc957d5cd 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/mips/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/mips/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -22,54 +22,54 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;internal.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int mips_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int mips_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 MIPSCPU *cpu =3D MIPS_CPU(cs);=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUMIPSState *env =3D &amp;cpu=
-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;active_tc.gpr[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;active_tc.gpr[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (env-&gt;CP0_Config1 &amp; =
(1 &lt;&lt; CP0C1_FP) &amp;&amp; n &gt;=3D 38 &amp;&amp; n &lt; 72) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 70:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_regl(mem_buf,<br>
&gt; &gt;&gt; (int32_t)env-&gt;active_fpu.fcr31);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_regl(array, (int32_t)env-&gt;active_fpu.fcr31);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 71:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_regl(mem_buf, (int32_t)env-&gt;active_fpu.fcr0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_regl(array, (int32_t)env-&gt;active_fpu.fcr0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (env-&gt;CP0_Status &amp; (1 &lt;&lt; CP0St_FR)) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_regl(mem_buf,<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_regl(array,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_fpu.fpr[n - 38].d);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =
else {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_regl(mem_buf,<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return gdb_get_regl(array,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX]=
);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 32:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, (int32_t)env-&gt;CP0_Status);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, (int32_t)env-&gt;CP0_Status);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 33:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;active_tc.LO[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;active_tc.LO[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 34:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;active_tc.HI[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;active_tc.HI[0]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 35:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;CP0_BadVAddr);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;CP0_BadVAddr);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 36:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, (int32_t)env-&gt;CP0_Cause);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, (int32_t)env-&gt;CP0_Cause);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 37:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;active_tc.PC |<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;active_tc.PC |<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0!!(env-&gt;hflags &amp; MIPS_HFLAG_M16));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 72:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, 0); /* fp */<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, 0); /* fp */<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 89:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, (int32_t)env-&gt;CP0_PRid);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, (int32_t)env-&gt;CP0_PRid);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n &gt; 89) {=
<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 16 embedded r=
egs.=C2=A0 */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, 0);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/nios2/cpu.c b/target/nios2/cpu=
.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 8f7011fcb9..3cf696402f 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/nios2/cpu.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/nios2/cpu.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -124,7 +124,7 @@ static void nios2_cpu_disas_se=
t_info(CPUState<br>
&gt; &gt;&gt; *cpu, disassemble_info *info)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #endif<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -static int nios2_cpu_gdb_read_register(CPUState *=
cs, GByteArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +static int nios2_cpu_gdb_read_register(CPUState *=
cs, GByteArray<br>
&gt; &gt;&gt; *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 Nios2CPU *cpu =3D NIOS2_CPU(cs=
);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUClass *cc =3D CPU_GET_CLASS=
(cs);<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -135,11 +135,11 @@ static int<br>
&gt; &gt;&gt; nios2_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf=
, int<br>
&gt; &gt;&gt; n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* GP regs */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else if (n =3D=3D 32) {=C2=
=A0 =C2=A0 /* PC */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[R_PC]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[R_PC]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else if (n &lt; 49) {=C2=A0 =
=C2=A0 =C2=A0/* Status regs */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, env-&gt;regs[n - 1]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, env-&gt;regs[n - 1]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 /* Invalid regs */<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/openrisc/gdbstub.c b/target/op=
enrisc/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 095bf76c12..c34d3696ec 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/openrisc/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/openrisc/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -21,23 +21,23 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int openrisc_cpu_gdb_read_register(CPUState *cs, =
GByteArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int openrisc_cpu_gdb_read_register(CPUState *cs, =
GByteArray<br>
&gt; &gt;&gt; *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 OpenRISCCPU *cpu =3D OPENRISC_=
CPU(cs);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPUOpenRISCState *env =3D &amp=
;cpu-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
mem_buf, cpu_get_gpr(env, n));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(=
array, cpu_get_gpr(env, n));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 32:=C2=A0 =
=C2=A0 /* PPC */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;ppc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;ppc);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 33:=C2=A0 =
=C2=A0 /* NPC (equals PC) */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 34:=C2=A0 =
=C2=A0 /* SR */<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(mem_buf, cpu_get_sr(env));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
gdb_get_reg32(array, cpu_get_sr(env));<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/riscv/gdbstub.c b/target/riscv=
/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index eba12a86f2..8e1d64c1cf 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/riscv/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/riscv/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -270,15 +270,15 @@ static int csr_register_map[=
] =3D {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CSR_MHCOUNTEREN,<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 };<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int riscv_cpu_gdb_read_register(CPUState *cs, GBy=
teArray<br>
&gt; &gt;&gt; *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int riscv_cpu_gdb_read_register(CPUState *cs, GBy=
teArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 RISCVCPU *cpu =3D RISCV_CPU(cs=
);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPURISCVState *env =3D &amp;cp=
u-&gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (n &lt; 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;gpr[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;gpr[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 } else if (n =3D=3D 32) {<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/rx/gdbstub.c b/target/rx/gdbst=
ub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index 9391e8151e..91dee774f6 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/rx/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/rx/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -20,32 +20,32 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;exec/gdbstub.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int rx_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int rx_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 RXCPU *cpu =3D RXCPU(cs);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 CPURXState *env =3D &amp;cpu-&=
gt;env;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 switch (n) {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 0 ... 15:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;regs[n]);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 16:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, (env-&gt;psw_u) ? env-&gt;regs[0]<br>
&gt; &gt;&gt; : env-&gt;usp);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, (env-&gt;psw_u) ? env-&gt;regs[0] :<br>
&gt; &gt;&gt; env-&gt;usp);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, (!env-&gt;psw_u) ?<br>
&gt; &gt;&gt; env-&gt;regs[0] : env-&gt;isp);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, (!env-&gt;psw_u) ? env-&gt;regs[0]<br>
&gt; &gt;&gt; : env-&gt;isp);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 18:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, rx_cpu_pack_psw(env));<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, rx_cpu_pack_psw(env));<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 19:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;pc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 20:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;intb);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;intb);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 21:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;bpsw);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;bpsw);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 22:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;bpc);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;bpc);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 23:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;fintv);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;fintv);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 24:<br>
&gt; &gt;&gt;=C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(m=
em_buf, env-&gt;fpsw);<br>
&gt; &gt;&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(a=
rray, env-&gt;fpsw);<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 case 25:<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;=C2=A0 &gt; diff --git a/target/s390x/gdbstub.c b/target/s390x=
/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; index d6fce5ff1e..adbe7b5d39 100644<br>
&gt; &gt;&gt;=C2=A0 &gt; --- a/target/s390x/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; +++ b/target/s390x/gdbstub.c<br>
&gt; &gt;&gt;=C2=A0 &gt; @@ -27,7 +27,7 @@<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;sysemu/hw_accel.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 #include &quot;sysemu/tcg.h&quot;<br>
&gt; &gt;&gt;=C2=A0 &gt;<br>
&gt; &gt;&gt;=C2=A0 &gt; -int s390_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *mem_buf, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt; +int s390_cpu_gdb_read_register(CPUState *cs, GByt=
eArray *array, int n)<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt; &gt;&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 S390CPU *cpu =3D S390_CPU(cs);=
<br>
&gt; &gt;&gt;</p>

--0000000000004018db05a34199ba--


Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C55C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40F5215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWP1P6W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40F5215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3PM8-0006Ck-3k
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3PE4-0008W8-8C
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i3PDt-0003Pp-No
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:32:52 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i3PDT-0002sw-Rq; Thu, 29 Aug 2019 14:32:16 -0400
Received: by mail-ot1-x32f.google.com with SMTP id 97so1565273otr.4;
 Thu, 29 Aug 2019 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jKM/8NXP+1zbihxoRcd+xzm77KG6I5XcyBBpT/SB1TY=;
 b=gWP1P6W4P7fG1osqoXXSUo+5cYXC3eOZx9D6J79bygXMFm5qVv4JTEOUBZIMmh8gG3
 Y3Eh87cExIYOn005fRl8L9bH/Tsqhl+vlvREHOyRa/10xgikgWKO1dxY6sKpwZPSBANL
 gjACczvm3lii9utjlwYTPU98/pBPUeowRsd43YZLvPX5JmvP5PDtSIcQY+DxkEL04Kon
 QpAKA49mBApNhWGoRA6F0rcTmikGLimbg6+3MI2qcF8Dx3yEGZsD83q4kc2Y2ZiN5bc5
 17mn6WDkXO2QSLksSFB+hI3gjK7dXHsVZIRnym9eNWGlPI8W36Z1aoEli0vuQ/E328t4
 x//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jKM/8NXP+1zbihxoRcd+xzm77KG6I5XcyBBpT/SB1TY=;
 b=ik0cuNL7EjdC9rvVir52QCAhr7KmMQCTnHScB9TXnuFPcoMCcU1nNTob/MV6l1fJdo
 C/OAUYoTtZS30kcYj4xC4BhnZiY0guxd5vcXncvtYGr1NzN0CBDyKseg/XMD2n92oFB7
 4AEDbHLDdfrf9abv8w4EuHFIoL02bHRJrRDWtB4drDWdnijsl5/fyL2WVOQcYvY98B8J
 Ix17khpW2ypX7aRn6jCcNXlI5xC5DMzU3KMUfGskPQq4xtCMLnF2DiRb+1BxfTE8evUu
 T6pPG3X2JOsx64w7ndJOA2eXMyQe8DQBRgVapmCYWT5UG6eC1cYF+KPjMUa0PZ07bMga
 2Htg==
X-Gm-Message-State: APjAAAVvUXZ0jkmVaMbpp9/79H7TMmm13Xbx1O+9NMD2JH4YNqq9m1JC
 fwlLJFFT21CtyViEa9YjAYuYV1nvKpM/xy4v8ws=
X-Google-Smtp-Source: APXvYqwEBzJv5tkvfjGf/x6F8WtUHIn/1lR/YpZWdXyDNnd2KUVCPwBfpoM4lVVlI4diPUPFguGzAL6xAK52kBi7Xbw=
X-Received: by 2002:a9d:4912:: with SMTP id e18mr5760023otf.341.1567103533667; 
 Thu, 29 Aug 2019 11:32:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 29 Aug 2019 11:32:12
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 29 Aug 2019 11:32:12
 -0700 (PDT)
In-Reply-To: <46ade3da-d642-bd19-7975-7dc228d401e4@c-sky.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAL1e-=iHangj7w+HgJ+FM=iqRLmaY-_CYeUv0gx+c8bpScb9RQ@mail.gmail.com>
 <46ade3da-d642-bd19-7975-7dc228d401e4@c-sky.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 29 Aug 2019 20:32:12 +0200
Message-ID: <CAL1e-=g9_1wu9_mkFpism1c6qWj7F71Kgyi_K6zg4gckAnep5g@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.08.2019. 15.02, "liuzhiwei" <zhiwei_liu@c-sky.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> On 2019/8/29 =E4=B8=8A=E5=8D=883:20, Aleksandar Markovic wrote:
>>
>>
>>
>> > On Wed, Aug 28, 2019 at 9:04 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote=
:
>>>
>>> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
>>> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
>>> ---
>>
>>
>> Such large patch and "Change-Id:
I3cf891bc400713b95f47ecca82b1bf773f3dcb25" is its entire commit message??
Horrible.
>
> Hi,  Aleksandar
>
> I am so sorry. A patch set with cover letter will be sent later.
>
> Best Regards,
>
> Zhiwei

OK, Zhiwei,

You'll soon get more used  to participating in open source, and write much
better patches.

Try to follow guidelines described at
https://wiki.qemu.org/Contribute/SubmitAPatch
Thanks,
Aleksandar



>>
>> Aleksandar
>>
>>>
>>>  fpu/softfloat.c                         |   119 +
>>>  include/fpu/softfloat.h                 |     4 +
>>>  linux-user/riscv/cpu_loop.c             |     8 +-
>>>  target/riscv/Makefile.objs              |     2 +-
>>>  target/riscv/cpu.h                      |    30 +
>>>  target/riscv/cpu_bits.h                 |    15 +
>>>  target/riscv/cpu_helper.c               |     7 +
>>>  target/riscv/csr.c                      |    65 +-
>>>  target/riscv/helper.h                   |   354 +
>>>  target/riscv/insn32.decode              |   374 +-
>>>  target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>>>  target/riscv/translate.c                |     1 +
>>>  target/riscv/vector_helper.c            | 26563
++++++++++++++++++++++++++++++
>>>  13 files changed, 28017 insertions(+), 9 deletions(-)
>>>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>>>  create mode 100644 target/riscv/vector_helper.c
>>>
>>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>>> index 2ba36ec..da155ea 100644
>>> --- a/fpu/softfloat.c
>>> +++ b/fpu/softfloat.c
>>> @@ -433,6 +433,16 @@ static inline int extractFloat16Exp(float16 a)
>>>  }
>>>
>>>
 /*------------------------------------------------------------------------=
----
>>> +| Returns the sign bit of the half-precision floating-point value `a'.
>>>
+*-------------------------------------------------------------------------=
---*/
>>> +
>>> +static inline flag extractFloat16Sign(float16 a)
>>> +{
>>> +    return float16_val(a) >> 0xf;
>>> +}
>>> +
>>> +
>>>
+/*------------------------------------------------------------------------=
----
>>>  | Returns the fraction bits of the single-precision floating-point
value `a'.
>>>
 *-------------------------------------------------------------------------=
---*/
>>>
>>> @@ -4790,6 +4800,35 @@ int float32_eq(float32 a, float32 b,
float_status *status)
>>>  }
>>>
>>>
 /*------------------------------------------------------------------------=
----
>>> +| Returns 1 if the half-precision floating-point value `a' is less tha=
n
>>> +| or equal to the corresponding value `b', and 0 otherwise.  The
invalid
>>> +| exception is raised if either operand is a NaN.  The comparison is
performed
>>> +| according to the IEC/IEEE Standard for Binary Floating-Point
Arithmetic.
>>>
+*-------------------------------------------------------------------------=
---*/
>>> +
>>> +int float16_le(float16 a, float16 b, float_status *status)
>>> +{
>>> +    flag aSign, bSign;
>>> +    uint16_t av, bv;
>>> +    a =3D float16_squash_input_denormal(a, status);
>>> +    b =3D float16_squash_input_denormal(b, status);
>>> +
>>> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) &&
extractFloat16Frac( a ) )
>>> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) &&
extractFloat16Frac( b ) )
>>> +       ) {
>>> +        float_raise(float_flag_invalid, status);
>>> +        return 0;
>>> +    }
>>> +    aSign =3D extractFloat16Sign( a );
>>> +    bSign =3D extractFloat16Sign( b );
>>> +    av =3D float16_val(a);
>>> +    bv =3D float16_val(b);
>>> +    if ( aSign !=3D bSign ) return aSign || ( (uint16_t) ( ( av | bv
)<<1 ) =3D=3D 0 );
>>> +    return ( av =3D=3D bv ) || ( aSign ^ ( av < bv ) );
>>> +
>>> +}
>>> +
>>>
+/*------------------------------------------------------------------------=
----
>>>  | Returns 1 if the single-precision floating-point value `a' is less
than
>>>  | or equal to the corresponding value `b', and 0 otherwise.  The
invalid
>>>  | exception is raised if either operand is a NaN.  The comparison is
performed
>>> @@ -4825,6 +4864,35 @@ int float32_le(float32 a, float32 b,
float_status *status)
>>>  | to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
>>>
 *-------------------------------------------------------------------------=
---*/
>>>
>>> +int float16_lt(float16 a, float16 b, float_status *status)
>>> +{
>>> +    flag aSign, bSign;
>>> +    uint16_t av, bv;
>>> +    a =3D float16_squash_input_denormal(a, status);
>>> +    b =3D float16_squash_input_denormal(b, status);
>>> +
>>> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) &&
extractFloat16Frac( a ) )
>>> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) &&
extractFloat16Frac( b ) )
>>> +       ) {
>>> +        float_raise(float_flag_invalid, status);
>>> +        return 0;
>>> +    }
>>> +    aSign =3D extractFloat16Sign( a );
>>> +    bSign =3D extractFloat16Sign( b );
>>> +    av =3D float16_val(a);
>>> +    bv =3D float16_val(b);
>>> +    if ( aSign !=3D bSign ) return aSign && ( (uint16_t) ( ( av | bv
)<<1 ) !=3D 0 );
>>> +    return ( av !=3D bv ) && ( aSign ^ ( av < bv ) );
>>> +
>>> +}
>>> +
>>>
+/*------------------------------------------------------------------------=
----
>>> +| Returns 1 if the single-precision floating-point value `a' is less
than
>>> +| the corresponding value `b', and 0 otherwise.  The invalid exception
is
>>> +| raised if either operand is a NaN.  The comparison is performed
according
>>> +| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
>>>
+*-------------------------------------------------------------------------=
---*/
>>> +
>>>  int float32_lt(float32 a, float32 b, float_status *status)
>>>  {
>>>      flag aSign, bSign;
>>> @@ -4869,6 +4937,32 @@ int float32_unordered(float32 a, float32 b,
float_status *status)
>>>  }
>>>
>>>
 /*------------------------------------------------------------------------=
----
>>> +| Returns 1 if the half-precision floating-point value `a' is equal to
>>> +| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
cause an
>>> +| exception.  The comparison is performed according to the IEC/IEEE
Standard
>>> +| for Binary Floating-Point Arithmetic.
>>>
+*-------------------------------------------------------------------------=
---*/
>>> +
>>> +int float16_eq_quiet(float16 a, float16 b, float_status *status)
>>> +{
>>> +    a =3D float16_squash_input_denormal(a, status);
>>> +    b =3D float16_squash_input_denormal(b, status);
>>> +
>>> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) &&
extractFloat16Frac( a ) )
>>> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) &&
extractFloat16Frac( b ) )
>>> +       ) {
>>> +        if (float16_is_signaling_nan(a, status)
>>> +         || float16_is_signaling_nan(b, status)) {
>>> +            float_raise(float_flag_invalid, status);
>>> +        }
>>> +        return 0;
>>> +    }
>>> +    return ( float16_val(a) =3D=3D float16_val(b) ) ||
>>> +            ( (uint16_t) ( ( float16_val(a) | float16_val(b) )<<1 ) =
=3D=3D
0 );
>>> +}
>>> +
>>> +
>>>
+/*------------------------------------------------------------------------=
----
>>>  | Returns 1 if the single-precision floating-point value `a' is equal
to
>>>  | the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
cause an
>>>  | exception.  The comparison is performed according to the IEC/IEEE
Standard
>>> @@ -4958,6 +5052,31 @@ int float32_lt_quiet(float32 a, float32 b,
float_status *status)
>>>  }
>>>
>>>
 /*------------------------------------------------------------------------=
----
>>> +| Returns 1 if the half-precision floating-point values `a' and `b'
cannot
>>> +| be compared, and 0 otherwise.  Quiet NaNs do not cause an
exception.  The
>>> +| comparison is performed according to the IEC/IEEE Standard for Binar=
y
>>> +| Floating-Point Arithmetic.
>>>
+*-------------------------------------------------------------------------=
---*/
>>> +
>>> +int float16_unordered_quiet(float16 a, float16 b, float_status *status=
)
>>> +{
>>> +    a =3D float16_squash_input_denormal(a, status);
>>> +    b =3D float16_squash_input_denormal(b, status);
>>> +
>>> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) &&
extractFloat16Frac( a ) )
>>> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) &&
extractFloat16Frac( b ) )
>>> +       ) {
>>> +        if (float16_is_signaling_nan(a, status)
>>> +         || float16_is_signaling_nan(b, status)) {
>>> +            float_raise(float_flag_invalid, status);
>>> +        }
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +
>>>
+/*------------------------------------------------------------------------=
----
>>>  | Returns 1 if the single-precision floating-point values `a' and `b'
cannot
>>>  | be compared, and 0 otherwise.  Quiet NaNs do not cause an
exception.  The
>>>  | comparison is performed according to the IEC/IEEE Standard for Binar=
y
>>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>>> index 3ff3fa5..3b0754c 100644
>>> --- a/include/fpu/softfloat.h
>>> +++ b/include/fpu/softfloat.h
>>> @@ -293,6 +293,10 @@ float16 float16_maxnummag(float16, float16,
float_status *status);
>>>  float16 float16_sqrt(float16, float_status *status);
>>>  int float16_compare(float16, float16, float_status *status);
>>>  int float16_compare_quiet(float16, float16, float_status *status);
>>> +int float16_unordered_quiet(float16, float16, float_status *status);
>>> +int float16_le(float16, float16, float_status *status);
>>> +int float16_lt(float16, float16, float_status *status);
>>> +int float16_eq_quiet(float16, float16, float_status *status);
>>>
>>>  int float16_is_quiet_nan(float16, float_status *status);
>>>  int float16_is_signaling_nan(float16, float_status *status);
>>> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
>>> index 12aa3c0..b01548a 100644
>>> --- a/linux-user/riscv/cpu_loop.c
>>> +++ b/linux-user/riscv/cpu_loop.c
>>> @@ -40,7 +40,13 @@ void cpu_loop(CPURISCVState *env)
>>>          signum =3D 0;
>>>          sigcode =3D 0;
>>>          sigaddr =3D 0;
>>> -
>>> +        if (env->foflag) {
>>> +            if (env->vfp.vl !=3D 0) {
>>> +                env->foflag =3D false;
>>> +                env->pc +=3D 4;
>>> +                continue;
>>> +            }
>>> +        }
>>>          switch (trapnr) {
>>>          case EXCP_INTERRUPT:
>>>              /* just indicate that signals should be handled asap */
>>> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
>>> index b1c79bc..d577cef 100644
>>> --- a/target/riscv/Makefile.objs
>>> +++ b/target/riscv/Makefile.objs
>>> @@ -1,4 +1,4 @@
>>> -obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper=
.o
gdbstub.o pmp.o
>>> +obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper=
.o
vector_helper.o gdbstub.o pmp.o
>>>
>>>  DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>>>
>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> index 0adb307..5a93aa2 100644
>>> --- a/target/riscv/cpu.h
>>> +++ b/target/riscv/cpu.h
>>> @@ -67,6 +67,7 @@
>>>  #define RVC RV('C')
>>>  #define RVS RV('S')
>>>  #define RVU RV('U')
>>> +#define RVV RV('V')
>>>
>>>  /* S extension denotes that Supervisor mode exists, however it is
possible
>>>     to have a core that support S mode but does not have an MMU and
there
>>> @@ -93,9 +94,38 @@ typedef struct CPURISCVState CPURISCVState;
>>>
>>>  #include "pmp.h"
>>>
>>> +#define VLEN 128
>>> +#define VUNIT(x) (VLEN / x)
>>> +
>>>  struct CPURISCVState {
>>>      target_ulong gpr[32];
>>>      uint64_t fpr[32]; /* assume both F and D extensions */
>>> +
>>> +    /* vector coprocessor state.  */
>>> +    struct {
>>> +        union VECTOR {
>>> +            float64  f64[VUNIT(64)];
>>> +            float32  f32[VUNIT(32)];
>>> +            float16  f16[VUNIT(16)];
>>> +            target_ulong ul[VUNIT(sizeof(target_ulong))];
>>> +            uint64_t u64[VUNIT(64)];
>>> +            int64_t  s64[VUNIT(64)];
>>> +            uint32_t u32[VUNIT(32)];
>>> +            int32_t  s32[VUNIT(32)];
>>> +            uint16_t u16[VUNIT(16)];
>>> +            int16_t  s16[VUNIT(16)];
>>> +            uint8_t  u8[VUNIT(8)];
>>> +            int8_t   s8[VUNIT(8)];
>>> +        } vreg[32];
>>> +        target_ulong vxrm;
>>> +        target_ulong vxsat;
>>> +        target_ulong vl;
>>> +        target_ulong vstart;
>>> +        target_ulong vtype;
>>> +        float_status fp_status;
>>> +    } vfp;
>>> +
>>> +    bool         foflag;
>>>      target_ulong pc;
>>>      target_ulong load_res;
>>>      target_ulong load_val;
>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>> index 11f971a..9eb43ec 100644
>>> --- a/target/riscv/cpu_bits.h
>>> +++ b/target/riscv/cpu_bits.h
>>> @@ -29,6 +29,14 @@
>>>  #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>>>  #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA |
FSR_NXA)
>>>
>>> +/* Vector Fixed-Point round model */
>>> +#define FSR_VXRM_SHIFT      9
>>> +#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
>>> +
>>> +/* Vector Fixed-Point saturation flag */
>>> +#define FSR_VXSAT_SHIFT     8
>>> +#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
>>> +
>>>  /* Control and Status Registers */
>>>
>>>  /* User Trap Setup */
>>> @@ -48,6 +56,13 @@
>>>  #define CSR_FRM             0x002
>>>  #define CSR_FCSR            0x003
>>>
>>> +/* User Vector CSRs */
>>> +#define CSR_VSTART          0x008
>>> +#define CSR_VXSAT           0x009
>>> +#define CSR_VXRM            0x00a
>>> +#define CSR_VL              0xc20
>>> +#define CSR_VTYPE           0xc21
>>> +
>>>  /* User Timers and Counters */
>>>  #define CSR_CYCLE           0xc00
>>>  #define CSR_TIME            0xc01
>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> index e32b612..405caf6 100644
>>> --- a/target/riscv/cpu_helper.c
>>> +++ b/target/riscv/cpu_helper.c
>>> @@ -521,6 +521,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>>          [PRV_H] =3D RISCV_EXCP_H_ECALL,
>>>          [PRV_M] =3D RISCV_EXCP_M_ECALL
>>>      };
>>> +    if (env->foflag) {
>>> +        if (env->vfp.vl !=3D 0) {
>>> +            env->foflag =3D false;
>>> +            env->pc +=3D 4;
>>> +            return;
>>> +        }
>>> +    }
>>>
>>>      if (!async) {
>>>          /* set tval to badaddr for traps with address information */
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> index e0d4586..a6131ff 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -87,12 +87,12 @@ static int ctr(CPURISCVState *env, int csrno)
>>>      return 0;
>>>  }
>>>
>>> -#if !defined(CONFIG_USER_ONLY)
>>>  static int any(CPURISCVState *env, int csrno)
>>>  {
>>>      return 0;
>>>  }
>>>
>>> +#if !defined(CONFIG_USER_ONLY)
>>>  static int smode(CPURISCVState *env, int csrno)
>>>  {
>>>      return -!riscv_has_ext(env, RVS);
>>> @@ -158,8 +158,10 @@ static int read_fcsr(CPURISCVState *env, int
csrno, target_ulong *val)
>>>          return -1;
>>>      }
>>>  #endif
>>> -    *val =3D (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>>> -        | (env->frm << FSR_RD_SHIFT);
>>> +    *val =3D (env->vfp.vxrm << FSR_VXRM_SHIFT)
>>> +            | (env->vfp.vxsat << FSR_VXSAT_SHIFT)
>>> +            | (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
>>> +            | (env->frm << FSR_RD_SHIFT);
>>>      return 0;
>>>  }
>>>
>>> @@ -172,10 +174,60 @@ static int write_fcsr(CPURISCVState *env, int
csrno, target_ulong val)
>>>      env->mstatus |=3D MSTATUS_FS;
>>>  #endif
>>>      env->frm =3D (val & FSR_RD) >> FSR_RD_SHIFT;
>>> +    env->vfp.vxrm =3D (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
>>> +    env->vfp.vxsat =3D (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
>>>      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>>>      return 0;
>>>  }
>>>
>>> +static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val=
)
>>> +{
>>> +    *val =3D env->vfp.vtype;
>>> +    return 0;
>>> +}
>>> +
>>> +static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
>>> +{
>>> +    *val =3D env->vfp.vl;
>>> +    return 0;
>>> +}
>>> +
>>> +static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
>>> +{
>>> +    *val =3D env->vfp.vxrm;
>>> +    return 0;
>>> +}
>>> +
>>> +static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val=
)
>>> +{
>>> +    *val =3D env->vfp.vxsat;
>>> +    return 0;
>>> +}
>>> +
>>> +static int read_vstart(CPURISCVState *env, int csrno, target_ulong
*val)
>>> +{
>>> +    *val =3D env->vfp.vstart;
>>> +    return 0;
>>> +}
>>> +
>>> +static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
>>> +{
>>> +    env->vfp.vxrm =3D val;
>>> +    return 0;
>>> +}
>>> +
>>> +static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val=
)
>>> +{
>>> +    env->vfp.vxsat =3D val;
>>> +    return 0;
>>> +}
>>> +
>>> +static int write_vstart(CPURISCVState *env, int csrno, target_ulong
val)
>>> +{
>>> +    env->vfp.vstart =3D val;
>>> +    return 0;
>>> +}
>>> +
>>>  /* User Timers and Counters */
>>>  static int read_instret(CPURISCVState *env, int csrno, target_ulong
*val)
>>>  {
>>> @@ -873,7 +925,12 @@ static riscv_csr_operations
csr_ops[CSR_TABLE_SIZE] =3D {
>>>      [CSR_FFLAGS] =3D              { fs,   read_fflags,
write_fflags      },
>>>      [CSR_FRM] =3D                 { fs,   read_frm,         write_frm
     },
>>>      [CSR_FCSR] =3D                { fs,   read_fcsr,        write_fcsr
      },
>>> -
>>> +    /* Vector CSRs */
>>> +    [CSR_VSTART] =3D              { any,   read_vstart,
 write_vstart      },
>>> +    [CSR_VXSAT] =3D               { any,   read_vxsat,      write_vxsa=
t
     },
>>> +    [CSR_VXRM] =3D                { any,   read_vxrm,       write_vxrm
      },
>>> +    [CSR_VL] =3D                  { any,   read_vl
      },
>>> +    [CSR_VTYPE] =3D               { any,   read_vtype
     },
>>>      /* User Timers and Counters */
>>>      [CSR_CYCLE] =3D               { ctr,  read_instret
      },
>>>      [CSR_INSTRET] =3D             { ctr,  read_instret
      },
>>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>>> index debb22a..fee02c0 100644
>>> --- a/target/riscv/helper.h
>>> +++ b/target/riscv/helper.h
>>> @@ -76,3 +76,357 @@ DEF_HELPER_2(mret, tl, env, tl)
>>>  DEF_HELPER_1(wfi, void, env)
>>>  DEF_HELPER_1(tlb_flush, void, env)
>>>  #endif
>>> +/* Vector functions */
>>> +DEF_HELPER_5(vector_vlb_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlh_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlw_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vle_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlbu_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlhu_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlwu_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlbff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlhff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlwff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vleff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlbuff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlhuff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vlwuff_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsb_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsh_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsw_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vse_v, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlsb_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlsh_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlsw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlse_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlsbu_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlshu_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlswu_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vssb_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vssh_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vssw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsse_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxb_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxh_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxe_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxbu_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxhu_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vlxwu_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsxb_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsxh_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsxw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsxe_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsuxb_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsuxh_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsuxw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vsuxe_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoswapw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoswapd_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoaddw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoaddd_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoxorw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoxord_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoandw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoandd_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoorw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamoord_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamominw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamomind_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamomaxw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamomaxd_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamominuw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamominud_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamomaxuw_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_6(vector_vamomaxud_v, void, env, i32, i32, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vext_x_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfmv_f_s, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmv_s_x, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfmv_s_f, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vadc_vvm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vadc_vxm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vadc_vim, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmadc_vvm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmadc_vxm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmadc_vim, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vsbc_vvm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vsbc_vxm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmsbc_vvm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmsbc_vxm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmpopc_m, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmfirst_m, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vcompress_vm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmandnot_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmand_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmor_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmxor_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmornot_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmnand_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmnor_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmxnor_mm, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmsbf_m, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmsof_m, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vmsif_m, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_viota_m, void, env, i32, i32, i32)
>>> +DEF_HELPER_3(vector_vid_v, void, env, i32, i32)
>>> +DEF_HELPER_4(vector_vfcvt_xu_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfcvt_x_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfcvt_f_xu_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfcvt_f_x_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfwcvt_xu_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfwcvt_x_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfwcvt_f_xu_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfwcvt_f_x_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfwcvt_f_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfncvt_xu_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfncvt_x_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfncvt_f_xu_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfncvt_f_x_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfncvt_f_f_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfsqrt_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vfclass_v, void, env, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vadd_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vadd_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredsum_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfadd_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredand_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfredsum_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsub_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredor_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsub_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrsub_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrsub_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredxor_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfredosum_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vminu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vminu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredminu_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmin_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmin_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmin_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmin_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredmin_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfredmin_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmaxu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmaxu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredmaxu_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmax_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmax_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmax_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmax_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vredmax_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfredmax_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsgnj_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsgnj_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vand_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vand_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vand_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsgnjn_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsgnjn_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vor_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vor_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vor_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsgnjx_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfsgnjx_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vxor_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vxor_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vxor_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrgather_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrgather_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrgather_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vslideup_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vslideup_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vslide1up_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vslidedown_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vslidedown_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vslide1down_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmerge_vvm, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmerge_vxm, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmerge_vim, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmerge_vfm, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmseq_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmseq_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmseq_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfeq_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfeq_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsne_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsne_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsne_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfle_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfle_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsltu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsltu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmford_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmford_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmslt_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmslt_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmflt_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmflt_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsleu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsleu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsleu_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfne_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfne_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsle_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsle_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsle_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfgt_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsgtu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsgtu_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsgt_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmsgt_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmfge_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsaddu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsaddu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsaddu_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vdivu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vdivu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfdiv_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfdiv_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsadd_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsadd_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vdiv_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vdiv_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfrdiv_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssubu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssubu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vremu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vremu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssub_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrem_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vrem_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vaadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vaadd_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vaadd_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmulhu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmulhu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmul_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmul_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsll_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsll_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsll_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmul_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmul_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vasub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vasub_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmulhsu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmulhsu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsmul_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsmul_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmulh_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmulh_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfrsub_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsrl_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsrl_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsrl_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmadd_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsra_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsra_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vsra_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmadd_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmadd_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssrl_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssrl_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssrl_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmsub_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssra_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssra_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vssra_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnmsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnmsub_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmsub_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnsrl_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnsrl_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnsrl_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmacc_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnsra_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnsra_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnsra_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vmacc_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmacc_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnclipu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnclipu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnclipu_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmsac_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfmsac_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnclip_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnclip_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnclip_vi, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnmsac_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vnmsac_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmsac_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfnmsac_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwredsumu_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwaddu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwaddu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwadd_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwredsum_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwadd_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwadd_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwredsum_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsubu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsubu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwsub_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsub_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsub_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwredosum_vs, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwaddu_wv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwaddu_wx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwadd_wv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwadd_wf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwadd_wv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwadd_wx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsubu_wv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsubu_wx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwsub_wv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwsub_wf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsub_wv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsub_wx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmulu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmulu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwmul_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwmul_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmulsu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmulsu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmul_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmul_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmaccu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmaccu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmaccu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmaccu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwmacc_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmacc_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmacc_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwnmacc_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwnmacc_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmaccsu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmaccsu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmaccsu_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmaccsu_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwmsac_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwmsac_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwsmaccus_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vwmaccus_vx, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwnmsac_vv, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_5(vector_vfwnmsac_vf, void, env, i32, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vsetvli, void, env, i32, i32, i32)
>>> +DEF_HELPER_4(vector_vsetvl, void, env, i32, i32, i32)
>>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>>> index 77f794e..d125ff9 100644
>>> --- a/target/riscv/insn32.decode
>>> +++ b/target/riscv/insn32.decode
>>> @@ -25,7 +25,7 @@
>>>  %sh10    20:10
>>>  %csr    20:12
>>>  %rm     12:3
>>> -
>>> +%nf     29:3
>>>  # immediates:
>>>  %imm_i    20:s12
>>>  %imm_s    25:s7 7:5
>>> @@ -43,7 +43,6 @@
>>>  &u    imm rd
>>>  &shift     shamt rs1 rd
>>>  &atomic    aq rl rs2 rs1 rd
>>> -
>>>  # Formats 32:
>>>  @r       .......   ..... ..... ... ..... ....... &r
%rs2 %rs1 %rd
>>>  @i       ............    ..... ... ..... ....... &i      imm=3D%imm_i
 %rs1 %rd
>>> @@ -62,11 +61,17 @@
>>>  @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
>>>  @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>>>  @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
>>> +@r_vm    ...... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
>>> +@r_wdvm  ..... wd:1 vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
>>> +@r_nfvm  nf:3 ... vm:1 ..... ..... ... ..... ....... %rs2 %rs1 %rd
>>> +@r2_nfvm nf:3 ... vm:1 ..... ..... ... ..... ....... %rs1 %rd
>>> +@r2_vm   ...... vm:1 ..... ..... ... ..... ....... %rs2 %rd
>>> +@r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
>>> +@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
>>>
>>>  @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
>>>  @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
>>>
>>> -
>>>  # *** Privileged Instructions ***
>>>  ecall      000000000000     00000 000 00000 1110011
>>>  ebreak     000000000001     00000 000 00000 1110011
>>> @@ -203,3 +208,366 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011
@r2_rm
>>>  fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
>>>  fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
>>>  fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
>>> +
>>> +# *** RV32V Standard Extension ***
>>> +
>>> +# *** Vector loads and stores are encoded within LOADFP/STORE-FP ***
>>> +vlb_v      ... 100 . 00000 ..... 000 ..... 0000111 @r2_nfvm
>>> +vlh_v      ... 100 . 00000 ..... 101 ..... 0000111 @r2_nfvm
>>> +vlw_v      ... 100 . 00000 ..... 110 ..... 0000111 @r2_nfvm
>>> +vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
>>> +vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
>>> +vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
>>> +vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
>>> +vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
>>> +vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
>>> +vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
>>> +vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
>>> +vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
>>> +vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
>>> +vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
>>> +vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
>>> +vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
>>> +vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
>>> +vse_v      ... 000 . 00000 ..... 111 ..... 0100111 @r2_nfvm
>>> +
>>> +vlsb_v     ... 110 . ..... ..... 000 ..... 0000111 @r_nfvm
>>> +vlsh_v     ... 110 . ..... ..... 101 ..... 0000111 @r_nfvm
>>> +vlsw_v     ... 110 . ..... ..... 110 ..... 0000111 @r_nfvm
>>> +vlse_v     ... 010 . ..... ..... 111 ..... 0000111 @r_nfvm
>>> +vlsbu_v    ... 010 . ..... ..... 000 ..... 0000111 @r_nfvm
>>> +vlshu_v    ... 010 . ..... ..... 101 ..... 0000111 @r_nfvm
>>> +vlswu_v    ... 010 . ..... ..... 110 ..... 0000111 @r_nfvm
>>> +vssb_v     ... 010 . ..... ..... 000 ..... 0100111 @r_nfvm
>>> +vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
>>> +vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
>>> +vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
>>> +
>>> +vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
>>> +vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
>>> +vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
>>> +vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
>>> +vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
>>> +vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
>>> +vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
>>> +vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
>>> +vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
>>> +vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
>>> +vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
>>> +vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
>>> +vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
>>> +vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
>>> +vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
>>> +
>>> +#*** Vector AMO operations are encoded under the standard AMO major
opcode.***
>>> +vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamoswapd_v     00001 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamoaddd_v      00000 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamoxorw_v      00100 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamoxord_v      00100 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamoandw_v      01100 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamoandd_v      01100 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamoorw_v       01000 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamoord_v       01000 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamominw_v      10000 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamomind_v      10000 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamomaxw_v      10100 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamomaxd_v      10100 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamominud_v     11000 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
>>> +vamomaxud_v     11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
>>> +
>>> +#*** new major opcode OP-V ***
>>> +vadd_vv         000000 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vadd_vx         000000 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vadd_vi         000000 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vredsum_vs      000000 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfadd_vv        000000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vredand_vs      000001 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfredsum_vs     000001 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vsub_vv         000010 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsub_vx         000010 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vredor_vs       000010 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfsub_vf        000010 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vrsub_vx        000011 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vrsub_vi        000011 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vredxor_vs      000011 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfredosum_vs    000011 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vminu_vv        000100 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vminu_vx        000100 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vredminu_vs     000100 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfmin_vv        000100 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmin_vf        000100 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmin_vv         000101 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmin_vx         000101 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vredmin_vs      000101 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfredmin_vs     000101 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vmaxu_vv        000110 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmaxu_vx        000110 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vredmaxu_vs     000110 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfmax_vv        000110 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmax_vf        000110 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmax_vv         000111 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmax_vx         000111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vredmax_vs      000111 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfsgnj_vv       001000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfsgnj_vf       001000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vand_vx         001001 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vand_vi         001001 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vor_vv          001010 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vor_vx          001010 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vor_vi          001010 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vxor_vv         001011 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vxor_vx         001011 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vxor_vi         001011 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
>>> +vfmv_f_s        001100 1 ..... ..... 001 ..... 1010111 @r
>>> +vmv_s_x         001101 1 ..... ..... 110 ..... 1010111 @r
>>> +vfmv_s_f        001101 1 ..... ..... 101 ..... 1010111 @r
>>> +vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vslideup_vi     001110 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vslide1up_vx    001110 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vadc_vvm        010000 1 ..... ..... 000 ..... 1010111 @r
>>> +vadc_vxm        010000 1 ..... ..... 100 ..... 1010111 @r
>>> +vadc_vim        010000 1 ..... ..... 011 ..... 1010111 @r
>>> +vmadc_vvm       010001 1 ..... ..... 000 ..... 1010111 @r
>>> +vmadc_vxm       010001 1 ..... ..... 100 ..... 1010111 @r
>>> +vmadc_vim       010001 1 ..... ..... 011 ..... 1010111 @r
>>> +vsbc_vvm        010010 1 ..... ..... 000 ..... 1010111 @r
>>> +vsbc_vxm        010010 1 ..... ..... 100 ..... 1010111 @r
>>> +vmsbc_vvm       010011 1 ..... ..... 000 ..... 1010111 @r
>>> +vmsbc_vxm       010011 1 ..... ..... 100 ..... 1010111 @r
>>> +vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
>>> +vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
>>> +vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
>>> +vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
>>> +vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
>>> +viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
>>> +vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
>>> +vmerge_vvm      010111 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmerge_vxm      010111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmerge_vim      010111 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
>>> +vfmerge_vfm     010111 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmseq_vv        011000 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmseq_vx        011000 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmseq_vi        011000 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmandnot_mm     011000 - ..... ..... 010 ..... 1010111 @r
>>> +vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmsne_vv        011001 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmsne_vx        011001 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmsne_vi        011001 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
>>> +vmfle_vv        011001 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vmfle_vf        011001 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmsltu_vv       011010 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmsltu_vx       011010 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
>>> +vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmslt_vv        011011 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmslt_vx        011011 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
>>> +vmflt_vv        011011 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vmflt_vf        011011 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmsleu_vv       011100 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmsleu_vx       011100 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmsleu_vi       011100 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
>>> +vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vmfne_vf        011100 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmsle_vv        011101 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vmsle_vx        011101 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmsle_vi        011101 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
>>> +vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vmsgtu_vx       011110 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmsgtu_vi       011110 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
>>> +vmsgt_vx        011111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmsgt_vi        011111 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
>>> +vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vsaddu_vv       100000 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsaddu_vx       100000 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vsaddu_vi       100000 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vdivu_vv        100000 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vdivu_vx        100000 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfdiv_vv        100000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfdiv_vf        100000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vsadd_vv        100001 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsadd_vx        100001 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vsadd_vi        100001 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vdiv_vv         100001 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vdiv_vx         100001 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfrdiv_vf       100001 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vremu_vv        100010 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vremu_vx        100010 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
>>> +vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
>>> +vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
>>> +vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
>>> +vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
>>> +vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
>>> +vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
>>> +vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
>>> +vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
>>> +vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
>>> +vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
>>> +vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
>>> +vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
>>> +vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
>>> +vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vrem_vv         100011 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vrem_vx         100011 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfsqrt_v        100011 . ..... 00000 001 ..... 1010111 @r2_vm
>>> +vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
>>> +vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmulhu_vv       100100 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vmulhu_vx       100100 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfmul_vv        100100 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmul_vf        100100 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vsll_vv         100101 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsll_vx         100101 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vsll_vi         100101 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmul_vv         100101 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vmul_vx         100101 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmulhsu_vv      100110 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vmulhsu_vx      100110 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vmulh_vv        100111 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vmulh_vx        100111 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfrsub_vf       100111 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vsrl_vv         101000 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsrl_vx         101000 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vsrl_vi         101000 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vfmadd_vv       101000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmadd_vf       101000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vsra_vv         101001 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vsra_vx         101001 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vsra_vi         101001 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmadd_vv        101001 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vmadd_vx        101001 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfnmadd_vv      101001 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfnmadd_vf      101001 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vssrl_vv        101010 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vssrl_vx        101010 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vfmsub_vv       101010 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmsub_vf       101010 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vnmsub_vv       101011 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vnmsub_vx       101011 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfnmsub_vv      101011 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfnmsub_vf      101011 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vnsrl_vv        101100 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vnsrl_vx        101100 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vnsrl_vi        101100 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vfmacc_vv       101100 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmacc_vf       101100 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vnsra_vv        101101 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vnsra_vx        101101 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vnsra_vi        101101 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vmacc_vv        101101 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vmacc_vx        101101 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfnmacc_vv      101101 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfnmacc_vf      101101 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vnclipu_vv      101110 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vnclipu_vx      101110 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vfmsac_vv       101110 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfmsac_vf       101110 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
>>> +vnmsac_vv       101111 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vnmsac_vx       101111 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfnmsac_vv      101111 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfnmsac_vf      101111 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwredsumu_vs    110000 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwaddu_vv       110000 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwaddu_vx       110000 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwadd_vv       110000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwadd_vf       110000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwredsum_vs     110001 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwadd_vv        110001 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwadd_vx        110001 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwredsum_vs    110001 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vwsubu_vv       110010 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwsubu_vx       110010 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwsub_vv       110010 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwsub_vf       110010 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwsub_vv        110011 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwsub_vx        110011 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vwaddu_wv       110100 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwaddu_wx       110100 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwadd_wv       110100 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwadd_wf       110100 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwadd_wv        110101 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwadd_wx        110101 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwsub_wv       110110 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwsub_wf       110110 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vwmulu_vv       111000 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwmulu_vx       111000 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwmul_vv       111000 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwmul_vf       111000 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwmulsu_vv      111010 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwmulsu_vx      111010 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vwmul_vv        111011 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwmul_vx        111011 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwsmaccu_vx     111100 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwmacc_vv      111100 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwmacc_vf      111100 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwsmacc_vv      111101 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwsmacc_vx      111101 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwnmacc_vv     111101 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwnmacc_vf     111101 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwsmaccsu_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>>> +vwsmaccsu_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
>>> +vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwmsac_vv      111110 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwmsac_vf      111110 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vwsmaccus_vx    111111 . ..... ..... 100 ..... 1010111 @r_vm
>>> +vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
>>> +vfwnmsac_vv     111111 . ..... ..... 001 ..... 1010111 @r_vm
>>> +vfwnmsac_vf     111111 . ..... ..... 101 ..... 1010111 @r_vm
>>> +vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
>>> +vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
>>> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c
b/target/riscv/insn_trans/trans_rvv.inc.c
>>> new file mode 100644
>>> index 0000000..dc8e6ce
>>> --- /dev/null
>>> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
>>> @@ -0,0 +1,484 @@
>>> +/*
>>> + * RISC-V translation routines for the RVV Standard Extension.
>>> + *
>>> + * Copyright (c) 2011-2019 C-SKY Limited. All rights reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
modify it
>>> + * under the terms and conditions of the GNU General Public License,
>>> + * version 2 or later, as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope it will be useful, but
WITHOUT
>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
>>> + * more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
along with
>>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#define GEN_VECTOR_R2_NFVM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s1 =3D tcg_const_i32(a->rs1);               \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    TCGv_i32 nf  =3D tcg_const_i32(a->nf);               \
>>> +    TCGv_i32 vm =3D tcg_const_i32(a->vm);                \
>>> +    gen_helper_vector_##INSN(cpu_env, nf, vm, s1, d);    \
>>> +    tcg_temp_free_i32(s1);                             \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    tcg_temp_free_i32(nf);                             \
>>> +    tcg_temp_free_i32(vm);                             \
>>> +    return true;                                       \
>>> +}
>>> +#define GEN_VECTOR_R_NFVM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s1 =3D tcg_const_i32(a->rs1);               \
>>> +    TCGv_i32 s2 =3D tcg_const_i32(a->rs2);               \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    TCGv_i32 nf  =3D tcg_const_i32(a->nf);               \
>>> +    TCGv_i32 vm =3D tcg_const_i32(a->vm);                \
>>> +    gen_helper_vector_##INSN(cpu_env, nf, vm, s1, s2, d);\
>>> +    tcg_temp_free_i32(s1);                             \
>>> +    tcg_temp_free_i32(s2);                             \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    tcg_temp_free_i32(nf);                             \
>>> +    tcg_temp_free_i32(vm);                             \
>>> +    return true;                                       \
>>> +}
>>> +
>>> +#define GEN_VECTOR_R_WDVM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s1 =3D tcg_const_i32(a->rs1);               \
>>> +    TCGv_i32 s2 =3D tcg_const_i32(a->rs2);               \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    TCGv_i32 wd  =3D tcg_const_i32(a->wd);               \
>>> +    TCGv_i32 vm =3D tcg_const_i32(a->vm);                \
>>> +    gen_helper_vector_##INSN(cpu_env, wd, vm, s1, s2, d);\
>>> +    tcg_temp_free_i32(s1);                             \
>>> +    tcg_temp_free_i32(s2);                             \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    tcg_temp_free_i32(wd);                             \
>>> +    tcg_temp_free_i32(vm);                             \
>>> +    return true;                                       \
>>> +}
>>> +#define GEN_VECTOR_R(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s1 =3D tcg_const_i32(a->rs1);               \
>>> +    TCGv_i32 s2 =3D tcg_const_i32(a->rs2);               \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    gen_helper_vector_##INSN(cpu_env, s1, s2, d);    \
>>> +    tcg_temp_free_i32(s1);                             \
>>> +    tcg_temp_free_i32(s2);                             \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    return true;                                       \
>>> +}
>>> +#define GEN_VECTOR_R2_VM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s2 =3D tcg_const_i32(a->rs2);               \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    TCGv_i32 vm =3D tcg_const_i32(a->vm);                \
>>> +    gen_helper_vector_##INSN(cpu_env, vm, s2, d);        \
>>> +    tcg_temp_free_i32(s2);                             \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    tcg_temp_free_i32(vm);                             \
>>> +    return true;                                       \
>>> +}
>>> +
>>> +#define GEN_VECTOR_R1_VM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    TCGv_i32 vm =3D tcg_const_i32(a->vm);                \
>>> +    gen_helper_vector_##INSN(cpu_env, vm, d);        \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    tcg_temp_free_i32(vm);                             \
>>> +    return true;                                       \
>>> +}
>>> +#define GEN_VECTOR_R_VM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s1 =3D tcg_const_i32(a->rs1);               \
>>> +    TCGv_i32 s2 =3D tcg_const_i32(a->rs2);               \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    TCGv_i32 vm =3D tcg_const_i32(a->vm);                \
>>> +    gen_helper_vector_##INSN(cpu_env, vm, s1, s2, d);    \
>>> +    tcg_temp_free_i32(s1);                             \
>>> +    tcg_temp_free_i32(s2);                             \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    tcg_temp_free_i32(vm);                             \
>>> +    return true;                                       \
>>> +}
>>> +#define GEN_VECTOR_R2_ZIMM(INSN) \
>>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a) \
>>> +{                                                      \
>>> +    TCGv_i32 s1 =3D tcg_const_i32(a->rs1);               \
>>> +    TCGv_i32 zimm =3D tcg_const_i32(a->zimm);            \
>>> +    TCGv_i32 d  =3D tcg_const_i32(a->rd);                \
>>> +    gen_helper_vector_##INSN(cpu_env, s1, zimm, d);      \
>>> +    tcg_temp_free_i32(s1);                             \
>>> +    tcg_temp_free_i32(zimm);                           \
>>> +    tcg_temp_free_i32(d);                              \
>>> +    return true;                                       \
>>> +}
>>> +
>>> +GEN_VECTOR_R2_NFVM(vlb_v)
>>> +GEN_VECTOR_R2_NFVM(vlh_v)
>
> ...

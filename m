Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999ECC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EC7206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJ9sT+Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EC7206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHN0-0007dR-Dd
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45199)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdGZf-0007vS-2l
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdGZE-0007EW-PW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:03:06 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdGZE-00079O-Du; Tue, 18 Jun 2019 12:02:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id v24so48388ljg.13;
 Tue, 18 Jun 2019 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xnoRudHO2CuC9aj4VruAgmdpO4r/RXjyhyTGnuZx8V8=;
 b=uJ9sT+KhCVRUQkLuSAf3lrJYN768pLXsc1i8yeI2mu+n19+l/axN+Z0wQVKeANWkKH
 QP1j/NsK2mXOuamvuErOhZSB5RsYwyx4gVeBsx0GwmJ0W8dRHlbK+nmu1K3Nq347qLyL
 eLSjlaBr4u+aAr0U0k5Voo1ny5H9T0NNDIDJys4tX/WERA6ftPuT8gPEOaUmi0To3FnE
 ZNl6tj9FeomkpFqrg8FNZ9iUfErvatEuPFkr9dUft3fvzYzYLH8E9JibL38OgQsg1vR+
 tANNpPgfHS1SxYhp2fgvzfqHomNx49t5iVNJVvCiJd1lE2/n8Qp74pLXe2Cn9W6ofknI
 Li4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xnoRudHO2CuC9aj4VruAgmdpO4r/RXjyhyTGnuZx8V8=;
 b=o+GNWjpgJg3RRchR2A25P9ycgj21YHFcAGWfANGW6XRpSznmG4dZhuNJz09iM4GsK/
 a9xpf0VmRjQB9y8w2TtJxlQFwkIGtPPHZYjPdnHL4CLql2FZAoILoMoylFgUQ1EWjm6W
 hEftEE/tB0SipMFhW6s3YeN5h5LqQNhCeBmHGju+MtUtsnwPyq4CleGkXpIBF81xnuFr
 WFNuyvKLatpj7cwVdzkGITTOfwD2qaPfLT+D4CDPIejfwgWUdI2mmnEXO0MW8p683iqV
 C9Y5gXkFB+oKwMu4stkgP/siv50H/U2MyVREC+jI1Yef1OU7cWTFcYJscq6PpDivpLuh
 GDYw==
X-Gm-Message-State: APjAAAX3zQ/xLZax61WehGB1sYvnKZrlWGWtu7LG0WU4zwIsntWo/w3g
 uLoglWyAQAFW/AXVLjyDaQ8LIrKExRBYfgpJXd4=
X-Google-Smtp-Source: APXvYqy8wJnBFdgxqPs8MSq9XI+s0SjDtnftndF7/H1RNuEXAj2cp3DDV9HBAtf4rQt3KEoD/OqgAf37VTiMjADS8qQ=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr3813021ljg.33.1560873758010;
 Tue, 18 Jun 2019 09:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560821342.git.alistair.francis@wdc.com>
 <1483cda620f3bff57b7c47ad74c44f586cfde4a5.1560821342.git.alistair.francis@wdc.com>
 <aec3b345-5ecd-6192-acee-dbfa296330d5@redhat.com>
In-Reply-To: <aec3b345-5ecd-6192-acee-dbfa296330d5@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Jun 2019 08:59:50 -0700
Message-ID: <CAKmqyKPSRw29VSGirQ4XnRD5Pu4W8_-fRzeYZes5oh9bf0jTLw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 1/9] target/riscv: Restructure deprecatd
 CPUs
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

On Mon, Jun 17, 2019 at 10:23 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 6/18/19 3:31 AM, Alistair Francis wrote:
> > Restructure the deprecated CPUs to make it clear in the code that these
> > are depreated. They are already marked as deprecated in
> > qemu-deprecated.texi. There are no functional changes.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.c | 18 ++++++++++--------
> >  target/riscv/cpu.h | 13 +++++++------
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 0632ac08cf..a4dd7ae6fc 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -558,18 +558,20 @@ static const TypeInfo riscv_cpu_type_infos[] =3D =
{
> >      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
> >  #if defined(TARGET_RISCV32)
> >      DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init)=
,
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cp=
u_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cp=
u_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_in=
it),
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_in=
it),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cp=
u_init)
> > +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cp=
u_init),
> > +    /* Depreacted */
>
> "Deprecated" in patch subject and here ;)

Thanks, fixed!

Alistair

>
> > +    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_in=
it),
> > +    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cp=
u_init),
> > +    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cp=
u_init)
> >  #elif defined(TARGET_RISCV64)
> >      DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init)=
,
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cp=
u_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cp=
u_init),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_in=
it),
> >      DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_in=
it),
> > -    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cp=
u_init)
> > +    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cp=
u_init),
> > +    /* Deprecated */
> > +    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_in=
it),
> > +    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cp=
u_init),
> > +    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cp=
u_init)
> >  #endif
> >  };
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index b47cde5017..1668d12018 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -35,16 +35,17 @@
> >  #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
> >  #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
> >  #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
> > -#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-=
v1.9.1")
> > -#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-=
v1.10.0")
> > -#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu=
-nommu")
> > -#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-=
v1.9.1")
> > -#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-=
v1.10.0")
> > -#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu=
-nommu")
> >  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e3=
1")
> >  #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e5=
1")
> >  #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u3=
4")
> >  #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u5=
4")
> > +/* Deprecated */
> > +#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu=
-nommu")
> > +#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-=
v1.9.1")
> > +#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-=
v1.10.0")
> > +#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu=
-nommu")
> > +#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-=
v1.9.1")
> > +#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-=
v1.10.0")
> >
> >  #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
> >  #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
> >


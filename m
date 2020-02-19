Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1986C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913CD24656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC8atTUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913CD24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Dvm-0004yy-RI
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j4Duj-00046M-Od
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j4Dui-0001hv-6B
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:12:33 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:32866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j4Duh-0001hL-UO; Tue, 18 Feb 2020 20:12:32 -0500
Received: by mail-lj1-x243.google.com with SMTP id y6so25214417lji.0;
 Tue, 18 Feb 2020 17:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Uc1rnFArpCrnrzRHRbrRKPXAtcLPWZhS6Dh9jV3fr98=;
 b=fC8atTUUcwQUtlrQ3llBUGK62W9sc2NKjni3JO24HSZJXkt30PAYDViG3v2szM9F8Y
 vBZ3NnZJ9rtKHf3WySFilPH3GnAfu4GSxheUEEptXtZvrDfopjPr75SG/PGSzwEkn1IN
 5GaDoHlG7h1Em4F2VVOoGUN+cqOcnBTFKk8DOabq6EbHjq0ExfTpglsqd7UOLE3gwKor
 FJTakfXiS3BdsqrCqjIxQ6HdpYGSWaIqr07mfIvkAttx2rloDVVxiMDCZv3Gep6mpmwj
 sd9GJrTVdslB5Io9RjcDEbNjM12Lg4gKZ9C+TwGtkr7o+YImZmnfVx/BuXX2JbBW3Hmt
 ih/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Uc1rnFArpCrnrzRHRbrRKPXAtcLPWZhS6Dh9jV3fr98=;
 b=uTxrLtOUsO/WOl4TNMKLuC0koEO4T5m1H5MBAzsurS5HLugoIWWuzTOCIizElax9u2
 Sbjg4iR3cUIc1tTeLJR97CvnM9MOgZof0LaRd5qPh/xKfA5zdX4Up29M1EqjB2v32Bu7
 9TJH6owC/NFGMq3G4GXDJc2qijNLXT04Cm4S2Gh5e8nOGRgWo/gPxi/4MAx6knWqEhqb
 PIJFRJT4IkPR5IcGHMPnUTj6judrOCj5YYmv0zRzuMrNkwNsAtTctIu4cfMFHyTKvWzQ
 PY4vmirPCaOV75SnHDQde5S+88bmaxpf8C8A099mcRgsrnl1XaDsbjmsX6BEd5OpiLJI
 A72g==
X-Gm-Message-State: APjAAAU+qncRYLiAR5hUXXlFsaoyPGFI/+Ak/MEMw2MaL91fvgoDP26o
 8MmOn0IVMFYVn4ocDF/fwvgC4+k1Gk1xVVot86c=
X-Google-Smtp-Source: APXvYqynZMmaKkJBsEo6H45GxcOmQ4R8MCmjGLXLeVo+g7XsmWvOxMB0bH9lxjQUj+AdBxYN8qXOgmE4UPBNfxbS/PQ=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr13978247ljn.107.1582074749973; 
 Tue, 18 Feb 2020 17:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
 <20200210081240.11481-3-zhiwei_liu@c-sky.com>
 <CAKmqyKORm9dfkgSOe0WR1aDBzJyMq9YP9+bBPwkeX2J2jYmLAg@mail.gmail.com>
 <0eb6836a-b133-b3b1-6ef6-74dd341b1dd5@c-sky.com>
In-Reply-To: <0eb6836a-b133-b3b1-6ef6-74dd341b1dd5@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2020 17:05:04 -0800
Message-ID: <CAKmqyKOhaHLcixnX2edge=t9xOYR7Sq486+ky1xd_OmWLO54Gw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] target/riscv: configure and turn on vector
 extension from command line
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 4:46 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Hi, Alistair
>
> On 2020/2/19 6:34, Alistair Francis wrote:
> > On Mon, Feb 10, 2020 at 12:12 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrot=
e:
> >> Vector extension is default on only for "any" cpu. It can be turned
> >> on by command line "-cpu rv64,v=3Dtrue,vlen=3D128,elen=3D64,vext_spec=
=3Dv0.7.1".
> >>
> >> vlen is the vector register length, default value is 128 bit.
> >> elen is the max operator size in bits, default value is 64 bit.
> >> vext_spec is the vector specification version, default value is v0.7.1=
.
> >> Thest properties and cpu can be specified with other values.
> >>
> >> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> > This looks fine to me. Shouldn't this be the last patch though?
> Yes=EF=BC=8C it should be the last patch.
> > As in
> > once the vector extension has been added to QEMU you can turn it on
> > from the command line. Right now this turns it on but it isn't
> > implemented.
> Maybe I should just add fields in RISCVCPU structure. And never open the
> vector extension on or add configure properties until the implementation
> is ready.

Yes, I think that is a good idea.

>
> It's still a little awkward as the reviewers will not be able to test
> the patch until the
> last patch.

I understand, but I don't think anyone is going to want to test the
extension half way through it being added to QEMU. This way we can
start to merge patches even without full support as users can't turn
it on.

Alistair

>
> > Alistair
> >
> >> ---
> >>   target/riscv/cpu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++=
--
> >>   target/riscv/cpu.h |  8 ++++++++
> >>   2 files changed, 54 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index 8c86ebc109..95fdb6261e 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -98,6 +98,11 @@ static void set_priv_version(CPURISCVState *env, in=
t priv_ver)
> >>       env->priv_ver =3D priv_ver;
> >>   }
> >>
> >> +static void set_vext_version(CPURISCVState *env, int vext_ver)
> >> +{
> >> +    env->vext_ver =3D vext_ver;
> >> +}
> >> +
> >>   static void set_feature(CPURISCVState *env, int feature)
> >>   {
> >>       env->features |=3D (1ULL << feature);
> >> @@ -113,7 +118,7 @@ static void set_resetvec(CPURISCVState *env, int r=
esetvec)
> >>   static void riscv_any_cpu_init(Object *obj)
> >>   {
> >>       CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> >> -    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> >> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU | =
RVV);
> >>       set_priv_version(env, PRIV_VERSION_1_11_0);
> >>       set_resetvec(env, DEFAULT_RSTVEC);
> >>   }
> >> @@ -320,6 +325,7 @@ static void riscv_cpu_realize(DeviceState *dev, Er=
ror **errp)
> >>       CPURISCVState *env =3D &cpu->env;
> >>       RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
> >>       int priv_version =3D PRIV_VERSION_1_11_0;
> >> +    int vext_version =3D VEXT_VERSION_0_07_1;
> >>       target_ulong target_misa =3D 0;
> >>       Error *local_err =3D NULL;
> >>
> >> @@ -343,8 +349,18 @@ static void riscv_cpu_realize(DeviceState *dev, E=
rror **errp)
> >>               return;
> >>           }
> >>       }
> >> -
> >> +    if (cpu->cfg.vext_spec) {
> >> +        if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
> >> +            vext_version =3D VEXT_VERSION_0_07_1;
> >> +        } else {
> >> +            error_setg(errp,
> >> +                       "Unsupported vector spec version '%s'",
> >> +                       cpu->cfg.vext_spec);
> >> +            return;
> >> +        }
> >> +    }
> >>       set_priv_version(env, priv_version);
> >> +    set_vext_version(env, vext_version);
> >>       set_resetvec(env, DEFAULT_RSTVEC);
> >>
> >>       if (cpu->cfg.mmu) {
> >> @@ -409,6 +425,30 @@ static void riscv_cpu_realize(DeviceState *dev, E=
rror **errp)
> >>           if (cpu->cfg.ext_u) {
> >>               target_misa |=3D RVU;
> >>           }
> >> +        if (cpu->cfg.ext_v) {
> >> +            target_misa |=3D RVV;
> >> +            if (!is_power_of_2(cpu->cfg.vlen)) {
> >> +                error_setg(errp,
> >> +                       "Vector extension VLEN must be power of 2");
> >> +                return;
> >> +            }
> >> +            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
> >> +                error_setg(errp,
> >> +                       "Vector extension implementation only supports=
 VLEN "
> >> +                       "in the range [128, %d]", RV_VLEN_MAX);
> >> +                return;
> >> +            }
> >> +            if (!is_power_of_2(cpu->cfg.elen)) {
> >> +                error_setg(errp,
> >> +                       "Vector extension ELEN must be power of 2");
> >> +                return;
> >> +            }
> >> +            if (cpu->cfg.elen > 64) {
> >> +                error_setg(errp,
> >> +                       "Vector extension ELEN must <=3D 64");
> >> +                return;
> >> +            }
> >> +        }
> >>
> >>           set_misa(env, RVXLEN | target_misa);
> >>       }
> >> @@ -444,10 +484,14 @@ static Property riscv_cpu_properties[] =3D {
> >>       DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
> >>       DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
> >>       DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
> >> +    DEFINE_PROP_BOOL("v", RISCVCPU, cfg.ext_v, false),
> >>       DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
> >>       DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
> >>       DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
> >>       DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
> >> +    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
> >> +    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
> >> +    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
> >>       DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
> >>       DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
> >>       DEFINE_PROP_END_OF_LIST(),
> >> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >> index 07e63016a7..bf2b4b55af 100644
> >> --- a/target/riscv/cpu.h
> >> +++ b/target/riscv/cpu.h
> >> @@ -64,6 +64,7 @@
> >>   #define RVA RV('A')
> >>   #define RVF RV('F')
> >>   #define RVD RV('D')
> >> +#define RVV RV('V')
> >>   #define RVC RV('C')
> >>   #define RVS RV('S')
> >>   #define RVU RV('U')
> >> @@ -82,6 +83,8 @@ enum {
> >>   #define PRIV_VERSION_1_10_0 0x00011000
> >>   #define PRIV_VERSION_1_11_0 0x00011100
> >>
> >> +#define VEXT_VERSION_0_07_1 0x00000701
> >> +
> >>   #define TRANSLATE_PMP_FAIL 2
> >>   #define TRANSLATE_FAIL 1
> >>   #define TRANSLATE_SUCCESS 0
> >> @@ -118,6 +121,7 @@ struct CPURISCVState {
> >>       target_ulong badaddr;
> >>
> >>       target_ulong priv_ver;
> >> +    target_ulong vext_ver;
> >>       target_ulong misa;
> >>       target_ulong misa_mask;
> >>
> >> @@ -226,12 +230,16 @@ typedef struct RISCVCPU {
> >>           bool ext_c;
> >>           bool ext_s;
> >>           bool ext_u;
> >> +        bool ext_v;
> >>           bool ext_counters;
> >>           bool ext_ifencei;
> >>           bool ext_icsr;
> >>
> >>           char *priv_spec;
> >>           char *user_spec;
> >> +        char *vext_spec;
> >> +        uint16_t vlen;
> >> +        uint16_t elen;
> >>           bool mmu;
> >>           bool pmp;
> >>       } cfg;
> >> --
> >> 2.23.0
> >>
>


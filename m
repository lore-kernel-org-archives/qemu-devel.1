Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D92C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC4D205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC4D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip6Rv-0005e5-3c
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ip6RE-00057s-QD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ip6RD-0000F2-ED
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:11:36 -0500
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:45624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ip6RD-0000EL-7H
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:11:35 -0500
Received: from player797.ha.ovh.net (unknown [10.108.35.13])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id EA69311D4CF
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 09:11:32 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id 628B09EE4ECD;
 Wed,  8 Jan 2020 08:11:24 +0000 (UTC)
Date: Wed, 8 Jan 2020 09:11:23 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 02/10] ppc: Remove stub of PPC970 HID4 implementation
Message-ID: <20200108091123.79ad7e76@bahia.lan>
In-Reply-To: <20200108010850.GJ2137@umbus.fritz.box>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-3-david@gibson.dropbear.id.au>
 <20200107183215.09ce18c6@bahia.lan>
 <20200107183638.1c84f172@bahia.lan>
 <20200108010850.GJ2137@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t3jfj5SUz9l6HFsqKeC8ldt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 10282843850695219686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehjedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.98
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 qemu-ppc@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/t3jfj5SUz9l6HFsqKeC8ldt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2020 12:08:50 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jan 07, 2020 at 06:36:38PM +0100, Greg Kurz wrote:
> > On Tue, 7 Jan 2020 18:32:15 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Tue,  7 Jan 2020 15:48:19 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor cap=
ability.
> > > > However, it can be (and often was) strapped into "Apple mode", wher=
e the
> > > > hypervisor capabilities were disabled (essentially putting it alway=
s in
> > > > hypervisor mode).
> >=20
> > Isn't it supervisor mode instead of hypervisor mode ?
>=20
> No; hypervisor is correct.  If the cpu was always in supervisor mode,
> the boot OS couldn't access the hypervisor privileged registers that
> are needed for basic setup (e.g. SDR1).  "Apple mode" means the cpu
> doesn't have a supervisor mode that _isn't_ hypervisor privileged and
> hence, can't run guests.
>=20

Ok, thanks for the clarification.

> >=20
> > > >=20
> > > > That's actually the only mode of the 970 we support in qemu, and we=
're
> > > > unlikely to change that any time soon.  However, we do have a parti=
al
> > > > implementation of the 970's HID4 register which affects things only
> > > > relevant for hypervisor mode.
> > > >=20
> > > > That stub is also really ugly, since it attempts to duplicate the e=
ffects
> > > > of HID4 by re-encoding it into the LPCR register used in newer CPUs=
, but
> > > > in a really confusing way.
> > > >=20
> > > > Just get rid of it.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > >=20
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > >=20
> > > >  target/ppc/mmu-hash64.c         | 28 +---------------------------
> > > >  target/ppc/translate_init.inc.c | 17 ++++++-----------
> > > >  2 files changed, 7 insertions(+), 38 deletions(-)
> > > >=20
> > > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > > index da8966ccf5..a881876647 100644
> > > > --- a/target/ppc/mmu-hash64.c
> > > > +++ b/target/ppc/mmu-hash64.c
> > > > @@ -1091,33 +1091,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_=
ulong val)
> > > > =20
> > > >      /* Filter out bits */
> > > >      switch (env->mmu_model) {
> > > > -    case POWERPC_MMU_64B: /* 970 */
> > > > -        if (val & 0x40) {
> > > > -            lpcr |=3D LPCR_LPES0;
> > > > -        }
> > > > -        if (val & 0x8000000000000000ull) {
> > > > -            lpcr |=3D LPCR_LPES1;
> > > > -        }
> > > > -        if (val & 0x20) {
> > > > -            lpcr |=3D (0x4ull << LPCR_RMLS_SHIFT);
> > > > -        }
> > > > -        if (val & 0x4000000000000000ull) {
> > > > -            lpcr |=3D (0x2ull << LPCR_RMLS_SHIFT);
> > > > -        }
> > > > -        if (val & 0x2000000000000000ull) {
> > > > -            lpcr |=3D (0x1ull << LPCR_RMLS_SHIFT);
> > > > -        }
> > > > -        env->spr[SPR_RMOR] =3D ((lpcr >> 41) & 0xffffull) << 26;
> > > > -
> > > > -        /*
> > > > -         * XXX We could also write LPID from HID4 here
> > > > -         * but since we don't tag any translation on it
> > > > -         * it doesn't actually matter
> > > > -         *
> > > > -         * XXX For proper emulation of 970 we also need
> > > > -         * to dig HRMOR out of HID5
> > > > -         */
> > > > -        break;
> > > >      case POWERPC_MMU_2_03: /* P5p */
> > > >          lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
> > > >                        LPCR_LPES0 | LPCR_LPES1 |
> > > > @@ -1154,6 +1127,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_u=
long val)
> > > >          }
> > > >          break;
> > > >      default:
> > > > +        g_assert_not_reached();
> > > >          ;
> > > >      }
> > > >      env->spr[SPR_LPCR] =3D lpcr;
> > > > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate=
_init.inc.c
> > > > index d33d65dff7..436d0d5a51 100644
> > > > --- a/target/ppc/translate_init.inc.c
> > > > +++ b/target/ppc/translate_init.inc.c
> > > > @@ -7884,25 +7884,20 @@ static void spr_write_lpcr(DisasContext *ct=
x, int sprn, int gprn)
> > > >  {
> > > >      gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> > > >  }
> > > > -
> > > > -static void spr_write_970_hid4(DisasContext *ctx, int sprn, int gp=
rn)
> > > > -{
> > > > -#if defined(TARGET_PPC64)
> > > > -    spr_write_generic(ctx, sprn, gprn);
> > > > -    gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> > > > -#endif
> > > > -}
> > > > -
> > > >  #endif /* !defined(CONFIG_USER_ONLY) */
> > > > =20
> > > >  static void gen_spr_970_lpar(CPUPPCState *env)
> > > >  {
> > > >  #if !defined(CONFIG_USER_ONLY)
> > > >      /* Logical partitionning */
> > > > -    /* PPC970: HID4 is effectively the LPCR */
> > > > +    /* PPC970: HID4 covers things later controlled by the LPCR and
> > > > +     * RMOR in later CPUs, but with a different encoding.  We only
> > > > +     * support the 970 in "Apple mode" which has all hypervisor
> > > > +     * facilities disabled by strapping, so we can basically just
> > > > +     * ignore it */
> > > >      spr_register(env, SPR_970_HID4, "HID4",
> > > >                   SPR_NOACCESS, SPR_NOACCESS,
> > > > -                 &spr_read_generic, &spr_write_970_hid4,
> > > > +                 &spr_read_generic, &spr_write_generic,
> > > >                   0x00000000);
> > > >  #endif
> > > >  }
> > >=20
> > >=20
> >=20
>=20


--Sig_/t3jfj5SUz9l6HFsqKeC8ldt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl4VjqsACgkQcdTV5YIv
c9ZiSRAApfsyUZfCwMqL5kbP8E6uyS7KC5IQGLGyP11K1SSXfNFWma+SE9RY0t04
rof9O3aLjV7S2F3++NQt7WWBNFnvUlRSFy/zc9Cv6w02PxCZmToyLGfgYxcra7qv
Y/MisUpVg9abeyP7qzazzPUQsOB0G4nBxIK2SHFClULY1sC/uJ2ZjARa3pS0LERz
cU9mVH4Tk+YKNjiXRWw31SggS7Apn38K5Vp6lejJY0AiGwp6WutUIi4WWAZVgDjw
NYpkMqddEOguwmsRpS479MkGl+CVZxwnqyirj3e6kPlYHWKrwR4akIBidMynfk5d
rapUGG04d4jk5c5rjrpBiCeEPe/SRSyYmcdYHw1e+ASO0g4et9Id1V8Yv27rcnHT
6KFji+6zpsXug7seJ7Y2wK0mdwD2bCXCzHKsAwvz4e4+AkX9F5Ndk5Fq4GJCswH6
ViIU5qrqjifsBMhWh16EcIeAWgcjCVRERR2huOub3UI6P9aGn+Hu3qcuicVEGXyE
FgyV1ATRW6AYN42pMjyu02/DgMQtNWks9iwIz4WGOkcFeqeg6QeqtybQvwqT+z7w
MDiOt8DppKXIHUIRqlh6HCNevFSSb8dNvRJeoMOdplB02m6dLePSLtx2eAGw1M8J
iUGL2Zi8eG8+9BfMl3HoRM3MWeFMhTLzeyCUoZC7u46LNSvfccU=
=VKdV
-----END PGP SIGNATURE-----

--Sig_/t3jfj5SUz9l6HFsqKeC8ldt--


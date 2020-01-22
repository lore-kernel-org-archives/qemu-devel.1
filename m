Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B55B24655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 03:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j2/d3ymN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55B24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu6T5-0002H3-Jc
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 22:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iu6R4-0001M2-Mz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iu6R3-00073A-1W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 22:12:06 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46671 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iu6R0-00070e-Mo; Tue, 21 Jan 2020 22:12:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 482Vn74fj0z9sP6; Wed, 22 Jan 2020 14:11:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579662715;
 bh=2+GcYO8V3KBH6KFQCUuzrtg4uo2/hRcOVyPLuYtyofU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j2/d3ymNaGxzDbvdJfhPxiHbCqpPFR9R27wfLozRXIwjNtJo06g5Upqqcqvc3rp3I
 T0t/11HloWj1WA/avvl2sz75FxXFZ4HBe3Copb3lVv9Kf5AaVvDghi4LH3g3rqfOa/
 kZalPqvzXM7Q3KKHEFNx8tP/rmIfM9isyoyNcjP8=
Date: Wed, 22 Jan 2020 14:11:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH v6 3/3] target/ppc: support single stepping with KVM HV
Message-ID: <20200122031149.GE2347@umbus.fritz.box>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
 <20200110151344.278471-4-farosas@linux.ibm.com>
 <20200120023555.GK54439@umbus> <87d0bd28hl.fsf@linux.ibm.com>
 <20200121033241.GM54439@umbus> <87y2u0wod4.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <87y2u0wod4.fsf@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 05:23:03PM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> (...)
> >> > Hrm.... I don't actually see how changing env->msr helps you here.
> >> > AFAICT if kvm_insert_breakpoint() resolves to kvm_arch_sw_breakpoint=
()
> >> > it doesn't rely on the MSR value at all.  If it resolves to
> >> > kvm_arch_hw_breakpoint(), then it looks like it just stashes
> >> > information to be pushed into KVM when we re-enter the guest.  None =
of
> >> > the information stashed appears to depend on the current MSR, and on=
ce
> >> > we re-enter the MSR will already have been restored.
> >> >
> >>
> >> This is the call chain:
> >>=20
> >> kvm_arch_insert_sw_breakpoint -> cpu_memory_rw_debug ->
> >> cpu_get_phys_page_attrs_debug -> ppc_cpu_get_phys_page_debug ->
> >> ppc64_v3_get_phys_page_debug -> ppc_radix64_get_phys_page_debug:
> >>=20
> >>     /* Handle Real Mode */
> >>     if (msr_dr =3D=3D 0) {
> >>         /* In real mode top 4 effective addr bits (mostly) ignored */
> >>         return eaddr & 0x0FFFFFFFFFFFFFFFULL;
> >>     }
> >
> > Ah, right.  Basically the issue is that kvm_insert_breakpoint() takes
> > an effective address, not a real address, but it might be happening in
> > a different context than we're executing right now.
> >
> > Ok, that makes sense.  Though.. aren't you always inserting the
> > breakpoint into an interrupt vector?  So wouldn't it always be MMU
> > off?  Under what circumstances would this get called with mmu_on =3D
> > true?
>=20
> Well, the MSR state at the moment of the breakpoint is that of the
> currently executing instruction.

Uh... at the moment of setting the breakpoint, or the moment of
hitting the breakpoint.

> So this gets called with mmu_on =3D true
> very often because we're often debugging code than runs with
> IR|DR=3D1.

Uh... but isn't the whole point here that the state of mmu_on might
not match the MSR state.  So the two sentences above don't seem to
mesh together.

What I think I'm understanding from the code is that in order to *set*
the breakpoint, you need to set up the MSR to match what you expect it
will be when you *hit* the breakpoint.  Yes?

But since the breakpoint is always placed in an interrupt vector,
won't that always be real mode?  Or is this one of the vectors that
can be entered in virtual mode on recent chips?

> However, we could be at a point when IR|DR=3D1, but the next traced
> instruction will execute with IR|DR=3D0. This happens at the rfid at the
> end of __enter_rtas, for instance.
>=20
> So ppc_radix64_get_phys_page_debug will check the MSR, see that we are
> (now) not in real mode and proceed with the page table walk, which could
> fail.
>=20
> In the particular case of the __enter_rtas rfid, we have PIDR=3D1 [1] so
> if we don't exit ppc_radix64_get_phys_page_debug at the msr_dr =3D=3D 0
> check, it will fail to translate the address.
>=20
> 1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Deeb715c3e995fbdda0cc05e61216c6c5609bce66
>=20
> >> Actually, I think there is a bug after ppc_cpu_get_phys_page_debug
> >> somewhere. There are some cases where GDB wants to read/write to some
> >> memory, but it gets denied access. Presumably because of one such
> >> discrepancy as the one above. I need to spend more time looking at this
> >> to define the problem properly, though.
> >
> > Hm, ok.
> >
> >> >> +    /*
> >> >> +     * MSR_SE =3D 1 will cause a Trace Interrupt in the guest afte=
r the
> >> >> +     * next instruction executes. If this is a rfid, use SRR1 inst=
ead
> >> >> +     * of MSR.
> >> >> +     */
> >> >> +    if (rfid) {
> >> >> +        if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
> >> >> +            /*
> >> >> +             * The guest is doing a single step itself. Make sure =
we
> >> >> +             * restore it later.
> >> >> +             */
> >> >> +            env->sstep_kind =3D SSTEP_GUEST;
> >> >> +        }
> >> >> +
> >> >> +        env->spr[SPR_SRR1] |=3D (1ULL << MSR_SE);
> >> >> +        mmu_on =3D srr1_ir & srr1_dr;
> >> >
> >> > s/&/&&/
> >> >
> >>=20
> >> Ack.
> >>=20
> >> >> +    } else {
> >> >> +        env->msr |=3D (1ULL << MSR_SE);
> >> >> +        mmu_on =3D msr_ir & msr_dr;
> >> >
> >> > s/&/&&/
> >> >
> >>=20
> >> Ack.
> >>=20
> >> > Also, what happens if the guest is using MSR[DR] !=3D MSR[IR]?  It's
> >> > rare, but it is occasionally useful.
> >>=20
> >> I understand from the ISA that for the purposes of AIL, both bits need
> >> to be set. So mmu_on =3D 0 is correct here.
> >
> > I'm not sure what you mean by "for the purposes of AIL".
> >
>=20
> The reason I'm tracking the translation state here is to be able to tell
> what will be the value of AIL, since an Alternate Interrupt Location is
> not used when translation is disabled. In the ISA, under "Alternate
> Interrupt Location" the only mention of MSR_IR !=3D MSR_DR is:
>=20
> "Other interrupts that occur when MSR IR=3D0 or MSR DR=3D0, are taken as
> if LPCR AIL=3D0."
>=20
> and my interpretation of that text is that AIL value is 0 when IR DR are
> either 0b00, 0b01 or 0b10.
>=20
> So "for the purposes of AIL", I'm considering either IR=3D0 or DR=3D0 as
> meaning MMU off.

But AFAICT the mmu_on flag you're setting here has influences other
than tracking AIL.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4nvXUACgkQbDjKyiDZ
s5Khtg//dv1egbLER60V8Ko87AO8ubqBjjPmadoT1cLPboR/zWgzjYFNlrsgk4Oz
4ydWMxOeIGy8+s0JVaP9UYDrDvSVCGq3vvmmnOWSAc3q/RgwK+gAH3dRNR8DFb7z
KaLsIvXqZn0OYNXwyZgBEm6LmOcxPuQUyGDI0Nbrz494xXZ3/FnQXQhwuZzWasye
e3uhoMx47N2S51GbzQGsGEmzAw155Gv7Zh/M9K8A/KN7gQnGB0uHCE6arlll2JVO
9bW8U7st0GdeUEaxn0I0FgI0/zSulwe4CcISZDoOWKBilYGIhjvoCftWAyrzBOIA
92+YYhzb2E8lQUbTD/AHHeZfV2cXy/1v4Zhp/jnEXNZuFSTNzHNkJHYO1SdbYlhv
V0cR7cVLyH02WrBWrPtu0q5xB6s9Lmu4bMNnoQ161HzQuMgvXSMk9aHGg0KDTA0f
uFzZqEcfqiOZKabN4QITwDSeV41BE2IcxaYZXv6QRuyCRzxXH+IWvveryd/c+VMH
1viLZXFCUtWguyVa0A9sROJ6t07GqRa3+WRxJhfd96BHEey4QwIlaGecG0NvL3jz
Zn/Ypq+NvMzHiIaAerXyz93l49oGfoEtqxjcnByLPp1HwyWHHzIcI6il62Fja2iM
1wu5Zz+IPNAA7mUnDTZdFjCXNL0hXf8v1D6yzUX4b8UzHHQZ2LM=
=fem+
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--


Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABFC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397212467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T6M0P4JJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397212467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUot-0000Jn-CZ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iuUn1-0006uW-DI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iuUmz-00083W-Nj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44769 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iuUmy-00081Q-Rt; Thu, 23 Jan 2020 00:12:21 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4839PX65mDz9sSN; Thu, 23 Jan 2020 16:12:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579756336;
 bh=NvZxWbbwUGxf0V9zQr67OhTGAmhceNG7NJXPsyJm3+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6M0P4JJEVFXP+DC7BZa09x4aNDU5o91pXLLkNjZbMl6E72eGe5PdZpKL8o1sW5nk
 HUBlGveU4uLWW4v9QWM83qgJxn6wvjAneA9Sx8ELOH5rpM7ndQ+327RoWSE7OqKf6S
 Oblhwr4FkU/wTyipQ2hKLB/kHF+8txGw0HYoxnKg=
Date: Thu, 23 Jan 2020 16:11:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v5] spapr: Kill SLOF
Message-ID: <20200123051156.GO2347@umbus.fritz.box>
References: <20200110020925.98711-1-aik@ozlabs.ru>
 <20200121051100.GG265522@umbus.fritz.box>
 <2aee3928-0acb-65ee-de54-de2e8106a6ba@ozlabs.ru>
 <20200122063222.GJ2347@umbus.fritz.box>
 <6ccbb008-9300-0e4d-bfc2-873d8562cb68@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ctUzwJm0i+kwMBIK"
Content-Disposition: inline
In-Reply-To: <6ccbb008-9300-0e4d-bfc2-873d8562cb68@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ctUzwJm0i+kwMBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 06:14:37PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 22/01/2020 17:32, David Gibson wrote:
> > On Tue, Jan 21, 2020 at 06:25:36PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 21/01/2020 16:11, David Gibson wrote:
> >>> On Fri, Jan 10, 2020 at 01:09:25PM +1100, Alexey Kardashevskiy wrote:
> >>>> The Petitboot bootloader is way more advanced than SLOF is ever goin=
g to
> >>>> be as Petitboot comes with the full-featured Linux kernel with all
> >>>> the drivers, and initramdisk with quite user friendly interface.
> >>>> The problem with ditching SLOF is that an unmodified pseries kernel =
can
> >>>> either start via:
> >>>> 1. kexec, this requires presence of RTAS and skips
> >>>> ibm,client-architecture-support entirely;
> >>>> 2. normal boot, this heavily relies on the OF1275 client interface to
> >>>> fetch the device tree and do early setup (claim memory).
> >>>>
> >>>> This adds a new bios-less mode to the pseries machine: "bios=3Don|of=
f".
> >>>> When enabled, QEMU does not load SLOF and jumps to the kernel from
> >>>> "-kernel".
> >>>
> >>> I don't love the name "bios" for this flag, since BIOS tends to refer
> >>> to old-school x86 firmware.  Given the various plans we're considering
> >>> the future, I'd suggest "firmware=3Dslof" for the current in-guest SL=
OF
> >>> mode, and say "firmware=3Dvof" (Virtual Open Firmware) for the new
> >>> model.  We can consider firmware=3Dpetitboot or firmware=3Dnone (for
> >>> direct kexec-style boot into -kernel) or whatever in the future
> >>
> >> Ok. We could also enforce default loading addresses for SLOF/kernel/gr=
ub
> >> and drop "kernel-addr", although it is going to be confusing if it
> >> changes in not so obvious way...
> >=20
> > Yes, I think that would be confusing, so I think adding the
> > kernel-addr override is a good idea, I'd just like it split out for
> > clarity.
> >=20
> >> In fact, I will ideally need 3 flags:
> >> -bios: on|off to stop loading SLOF;
> >> -kernel-addr: 0x0 for slof/kernel; 0x20000 for grub;
> >=20
> > I'm happy for that one to be separate from the "firmware style"
> > option.
> >=20
> >> -kernel-translate-hack: on|off - as grub is linked to run from 0x20000
> >> and it only works when placed there, the hack breaks it.
> >=20
> > Hrm.  I don't really understand what this one is about.  That doesn't
> > really seem like something the user would ever want to fiddle with
> > directly.
>=20
> This allows loading grub, or actually any elf (not that I have anything
> else in mind that just grub but still) which is not capable of
> relocating itself.

Ok, why would we ever not want that?

> >> Or we can pass grub via -bios and not via -kernel but strictly speaking
> >> there is still a firmware - that new 20 bytes blob so it would not be
> >> accurate.
> >>
> >> We can put this all into a single
> >> -firmware slof|vof|grub|linux. Not sure.
> >=20
> > I'm not thinking of "grub" as a separate option - that would be the
> > same as "vof".  Using vof + no -kernel we'd need to scan the disks in
> > the same way SLOF does, and look for a boot partition, which will
> > probably contain a GRUB image.=20
>=20
> I was hoping we can avoid that by allowing
> "-kernel grub" and let grub do filesystems and MBR/GPT.

I don't want that to be the only way, because I want the GRUB
installed by the OS installer to be the GRUB we use.

> > Then we'd need enough faked OF client
> > calls to let GRUB operate.
>=20
> v6 does very basic block devices. Now I need to learn how to build grub
> properly, it is 32bit and it is not straight forward how to build it
> 100% properly on ppc64 machine, I see occasional issues such as
> uint32->uint64 extension with a garbage in the top 32bits, things like
> this... But it can definitely read MBR/GPT, parse FS, etc.

Ok.

[snip]
> >>>> +/*
> >>>> + * "claim" claims memory at @virt if @align=3D=3D0; otherwise it al=
locates
> >>>> + * memory at the requested alignment.
> >>>> + */
> >>>> +uint64_t spapr_do_of_client_claim(SpaprMachineState *spapr, uint64_=
t virt,
> >>>> +                                  uint64_t size, uint64_t align)
> >>>> +{
> >>>> +    uint32_t ret;
> >>>> +
> >>>> +    if (align =3D=3D 0) {
> >>>> +        if (!of_client_claim_avail(spapr->claimed, virt, size)) {
> >>>> +            return -1;
> >>>> +        }
> >>>> +        ret =3D virt;
> >>>> +    } else {
> >>>> +        align =3D pow2ceil(align);
> >>>
> >>> Should this be a pow2ceil, or should it just return an error if align
> >>> is not a power of 2. > Note that aligning something to 4 bytes will
> >>> (probably) make it *not* aligned to 3 bytes.
> >>
> >> I did not see any notes about the specific alignment requirements here,
> >> the idea is that clients may just not expect unaligned memory at all; I
> >> could probably just drop it and see what happens...
> >=20
> > I don't follow you.  Isn't the align value coming from the client?
>=20
> This code is used by the client and QEMU. So for QEMU users, I'll have
> to align myself everywhere, not a huge deal. And since it is an old
> interface which nobody follows 100%, I can imagine clients (grub/yaboot)
> asking to claim with alignments other than power of two in expectation
> that the firmware will align it, may be.
>=20
>=20
> >=20
> >>>> +        spapr->claimed_base =3D (spapr->claimed_base + align - 1) &=
 ~(align - 1);
> >>>> +        while (1) {
> >>>> +            if (spapr->claimed_base >=3D spapr->rma_size) {
> >>>> +                perror("Out of memory");
> >>>
> >>> error_report() or qemu_log() or something and a message with some more
> >>> specificity, please.
> >>
> >>
> >> What kind of specificity is missing here?
> >=20
> > That it's on the OF claim interface specifically, and how much they
> > were trying to claim.
>=20
> Changing it to
>=20
> error_report("Out of RMA memory for the OF client")
>=20
> Thanks for the review! I'll post it when we settle on the new bios/vof
> machine parameter.
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ctUzwJm0i+kwMBIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4pKxwACgkQbDjKyiDZ
s5IXXg//ThENk0gtsNGnJhpnkqHSCLgmJI7GmeWUZsgKQDaIBOeG2Xu76QAlU+Mi
nkWWX0GtL7U5CLkZCMI7amI3RJdYngMbDpCE9dBAklOPh2KqNUdCfafHRL90zfRu
O3o0vQali5kQtKksr1fXffWXuycDFrv/6RbbmZIiV9YE673Q6+Byg5SzXf5CJVJS
BjD64Xa50H+sWKC6s8MfnVHijXzFkeHqXD8/Balw9xAdXBs9s9TGIuaCO1lE0X4i
e4+B6ltfDwElthLPH5Qk7hZ0NRL0z5ieQedyMFAiMrR3aXcg0iUfa40CQu5HVNB1
8Y6qBETDztmd9WTqr9KVgqqJi2w5l5ZIBwpTtUjBL2qi1q6qgPXfavPWtluDD7J0
UFViEHXCzlHs31cxys1ha+78zZHDKu6XYYrnJqnrJVDSSCWks4/FGhapmNGiJn3W
NqB8CqdtwzWccYHrEMuBsx93i9XohNBJASKXB54BvgXnSsL2BBniGakd+myOgzTo
LnxK+xUt3TXOO/jgDUcmWIzJx0FNksMpP0JkRkl0M+x+pcp7crtLnzZorcEDN5vU
tveCMXEmZ0QVlQUKrdNgQvygu2O756D0JQNAEzwqZD9jchpcaVA60NeahJQLbHLM
ztm/Z76ismkavZwVfSEoxCJSNVcEhw9SQ/j+DKi+NoiNGU8Odiw=
=g0qf
-----END PGP SIGNATURE-----

--ctUzwJm0i+kwMBIK--


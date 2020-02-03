Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBEBC35249
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 01:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BFB20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 01:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fuG2w5Y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BFB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyQb5-0007bT-0P
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 20:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyQaH-0006mF-LE
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 20:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyQaF-0001b8-TA
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 20:31:29 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41009 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iyQaF-0001VM-2m
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 20:31:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489qzY4Prwz9sRm; Mon,  3 Feb 2020 12:31:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580693481;
 bh=4tmT2QdZwuWUgs5U/bAR7qqtPP4hDaREcHwmac/J7QU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fuG2w5Y21GCjq8nww6/Miw5agE+ypduFtZk10nBp8bk9nx0w00uVacc9+5NsdNBIh
 vuaLtqCEOBMb1FeKpz9e8O/abCpLUVOpXmXBK2rf07OzOzzJsRn/XIct/YCNdaDF5N
 z2Ae6d3StcOm/JwrCNYBZoE3E2HvJHk15l2WmOTU=
Date: Mon, 3 Feb 2020 12:28:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200203012842.GD52446@umbus.fritz.box>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 01, 2020 at 08:04:25PM +0100, Paolo Bonzini wrote:
> On 01/02/20 14:39, Alexey Kardashevskiy wrote:
> > QEMU needs to load GRUB from the disk. The current workaround is to read
> > it from qcow2, save in a file and then call load_elf(). Not nice.
> >=20
> > 2 problems with that.
> >=20
> > 1. when load_elf calls address_space_write() - I need to know where and
> > how much RAM was used to mark this memory "used" for the OF client
> > interface (/memory@0/available FDT property). So I'll need "preload()"
> > hook.
> >=20
> > 2. (bigger) GRUB comes from PReP partition which is 8MB. load_elf{32|64}
> > consumes filename, not a memory pointer nor a "read_fn" callback - so I
> > thought I need a "read_fn" callback.
> >=20
> > And then I discovered that load_elf actually maps the passed file. And
> > here I got lost.
> >=20
> > Why does not load_elf just map the entire file and parse the bits? It
> > still reads chunks with seek+read and then it maps the file in a loop
> > potentially multiple times - is this even correct? Passing "fd" around
> > is weird.
>=20
> QEMU must not load GRUB from disk, that's the firmware's task.  If you
> want to kill SLOF, you can rewrite it, but loading the kernel GRUB from
> disk within QEMU is a bad idea: the next feature you'll be requested to
> implement will be network boot, and there's no way to do that in QEMU.

So.. I'm going to dispute this.  Or at least dispute that writing "the
firmware" as part of qemu isn't a feasible strategy.  At least in the
case of the "pseries" machine type, and possibly some other explicitly
paravirt machine types.

I do agree that we should leave firmware things to firmware when we're
implementing a real hardware platform and can therefore (at least in
theory) run the same firmware binary under qemu as for the real
hardware.

But "pseries" is different.  We're implementing the PAPR platform,
which describes an OS environment that's presented by a combination of
a hypervisor and firmware.  The features it specifies *require*
collaboration between the firmware and the hypervisor.

In PowerVM the environment is implemented with a substantial firmware
as well as hypervisor.  How those two communicate is in closed code,
it's not documented anywhere public, and I suspect it's not even
documented anywhere internal to IBM.

So, for qemu we've taken a different approach.  Since the beginning,
the runtime component of the firmware (RTAS) has been implemented as a
20 byte shim which simply forwards it to a hypercall implemented in
qemu.  The boottime firmware component is SLOF - but a build that's
specific to qemu, and has always needed to be updated in sync with
it.  Even though we've managed to limit the amount of runtime
communication we need between qemu and SLOF, there's some, and it's
become increasingly awkward to handle as we've implemented new features.

So really, the question isn't whether we implement things in firmware
or in qemu.  It's whether we implement the firmware functionality as
guest cpu code, which needs to be coded to work with a limited
environment, built with a special toolchain, then emulated with TCG.
Or, do we just implement it in normal C code, with a full C library,
and existing device and backend abstractions inside qemu.

That's what killing slof is about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl43d0gACgkQbDjKyiDZ
s5I7kxAA12Xo57QTzJqTD/scPJhbp4k4IS/01++R0vLuAYcg9CC6G5dyt3OrjpoU
BsMwtRZR6Wspzv4envcJEe1GtVIzuDoPxBDDzoMmnAKKGSNP6yqJeynENbGKUCvb
vrYDLvFvC6yAP87DfOb61DWij8CV3KhA/vwI0M0qXklo5z9m6jqklH5l0BMZiu17
qZkNvofPap91mR6krl/IRmvWBICT2ai4OqOosaRWSBJ5uUmX5wEENYu/C2FQ6oev
+JJYe1fBzDhPN9yz61cJWBnLDhy0WJvUPdDTi94ht6/81VBDQrLCxN3vZ6zkNpiI
3T2o9ffaNUmrOA03ORyPNPrcgBLKA1PlW82PQsAyMSxipoOw+f7QZ6Q91Ifxcev6
6EglDeiHKHJHbzE/aBWP6hyRQ548RORQCNMJzyFNxiTCDg8UeCnNswkpIeh52Z4x
aZ1FUKm1WrNnHG8NUYeAFgcMzS4pAMkJGXgP/+uKu7ag2ElckpWjdeWXEH/xDG/k
DefuCoJhr1hJzsy4mWr0Q1DdoHICLtrLF2Umj+1npqTtkfqFMp6ks2K7SygKVV7U
3ZUeCKsmQb2WG4nklJR8k+i3T094sepySEylVzXtr8IKXmr1YXKULiFhyIbO7Ik9
Ow1opsye/BFCiMIn6RHilyJsZU2Iyn1DvYDn2Pe9J298h9Oo0fw=
=Zp9m
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--


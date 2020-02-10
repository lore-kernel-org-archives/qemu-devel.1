Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE6C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0D720733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p24zfo6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0D720733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58009 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13vv-0003wC-0f
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j13v4-0002ha-Ms
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j13v3-00023P-6i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:50 -0500
Received: from ozlabs.org ([203.11.71.1]:47635)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1j13v0-0001vP-UW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48GJ9p2Gd0z9sRL; Mon, 10 Feb 2020 18:55:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581321342;
 bh=Z49yNKW/Mv/lbFRr8YI5RK8+0kkLGVZMHhHn/i0YbwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p24zfo6GXA2M3PgfaeDUmZvv2yeKBkoQ5QJUZH9kI+ItYAj9aYHF3cPfBArWVNIYp
 E4VQeomUD9/mVZaL8Vt8IVTZGeVxqm8WFHvZjmdKoIvwN6UuyiNQlUYqDCoucsUrd8
 zJN5TuopThbkjN9aI7vOyjbMWJWXOHOHeZsLeHf4=
Date: Mon, 10 Feb 2020 18:28:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200210072802.GD22584@umbus.fritz.box>
References: <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
 <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 09:27:01AM +0100, Paolo Bonzini wrote:
> On 05/02/20 07:06, David Gibson wrote:
> > On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:
> >> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru> ha scrit=
to:
> >>> Speaking seriously, what would I put into the guest?
> >>
> >> Only things that would be considered drivers. Ignore the partitions is=
sue
> >> for now so that you can just pass the device tree services to QEMU with
> >> hypercalls.
> >=20
> > Urgh... first, I don't really see how you'd do that.  OF's whole
> > device model is based around the device tree.  So implementing OF
> > driver interactions would require the firmware to do a bunch of
> > internal hypercalls to do all the DT stuff, which brings us back to a
> > much more complex and active interface between firmware and hypervisor
> > than we really want.
>=20
> I'm really sorry if what I am saying is stupid; but I was thinking of a
> firmware entrypoint like
>=20
> 	if (op =3D=3D "read" || op =3D=3D "write")
> 		do_driver_stuff(op);
> 	else
> 		hypercall();

Um... I'm not really clear on where you're imagining this going.  In
the OF model, device operations are done by "opening" a device tree
node then executing methods on it, so you can't really even get to
this point without a bunch of DT stuff.

> This is not even close to pseudocode, but hopefully enough to give the
> idea.  Perhaps what I don't understand is why you can't start the
> firmware with r3 pointing to the device tree, and stash it for when you
> leave control to GRUB.

Again, I'm not even really sure what you mean by this.  We already
enter SLOF with r3 pointing to a device tree.  I'm not sure what
stashing it would accomplish.  GRUB as it stands expects an OF style
entry point though, not a flat tree style entry point.

Are you suggesting rewriting it to run in that environment?  That
might be an option, but it's certainly not easy.  We'd have to write
"native" grub drivers for all the devices we care about, rather than
calling into OF for them.  Maybe there's some x86 code we could
already use here?  I don't know how much GRUB relies on the BIOS or
UEFI for device access on PC.

> Or to put it another way, what petitboot does
> that you cannot do in your own firmware.

So, part of the confusion is that there are two things we're
considering here and it's not really clear yet how much they overlap.

1) Is using petitboot as our bootloader.  That gives us basically
every driver, network protocol and tool we could ever want.  However,
it gets to the next stage via kexec(), so it can only support OSes
which are kexec()able - i.e. Linux.  This is mostly speculation at
this point.

2) Having a way of booting existing clients - i.e. those that expect
OF-style entry conditions - but without having to maintain a blob of
Forth.  The "kill slof" patches are a concrete, if limited, attempt at
this.

> > Second, drivers are kind of where we'd get the most benefit by putting
> > them in qemu: from qemu we can just talk to the device backends
> > directly so we don't need to re-abstract the differences between
> > different device models of the same type.
>=20
> Of course, but drivers are easy to write.

I'm not really sure I agree with you there.

> Not as easy as s390 probably
> because you'd have to link in libfdt and so on, but between
> kvm-unit-tests and s390-ccw there's quite a bit of code can be reused.

Maybe, but I'm not really sure where you're picturing it fitting in.

> >> You can generalize and reuse the s390 code. All you have to write is t=
he
> >> PCI scan and virtio-pci setup.
> >=20
> > If we assume virtio only.
>=20
> Do you actually need something else?

Well.. that's an interesting question.

> The TTY can use the simple
> getchar/putchar hypercalls,

Yes... though if people attach a graphical console they might be
pretty surprised that they don't get anything on there.  Supporting
that means adding vga, which adds substantial complexity (especially
since text mode isn't really a thing for a vga on a POWER machine).

> and sPAPR-vSCSI clients can keep using SLOF.

We can possibly ignore the spapr virtual devices.  They seemed like
they'd be important for people transitioning from guests under
PowerVM, but honestly I'm not sure they've ever been used much.

We do support emulated (or passthrough) PCI devices.  I don't know if
they're common enough that we need boot support for them.  Netboot
=66rom a vfio network adaptor might be something people want.

USB storage is also a fairly likely candidate, and that would add a
*lot* of extra complexity, since we'd need both the HCD and storage
drivers.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5BBf8ACgkQbDjKyiDZ
s5KHrBAAiuY1A0XoMUNijyhuLabbQm9ZNpfNosB/5Wko1SSY4ltbVgoSZVSvdMib
/tsmTxa6Y3P3RWMCMHaEgrKJG0ATrEuDCO6M/iP4eQRgyqdMxN5fIKnxpoGFRZU3
oJkVtjHXakpJvdWwmGq+I0krEZemSYS0YLt6iJYYaq5gjRRiiuvmjNPYRNm8uXZk
SO0mbu+0DInvhWptPTdc0FwuVcSTP8Wb4mNhN/kjcfbUJP99KGqY2biPWlMeH03m
Jyv25vUrsj8Nn+K7wgOKWTRxxt2GX59evGwSvYEtzFSpXSswMgkEBRcfZf9tL1ek
0G9n8hb1JP67q8G+Ed16/Nx/wfA8UPQ6tQbw+heuw+YSkKrl69fxKpASse6Fd6zP
ZaGfoDe0b8T7HX5xHb23HwGMpwu4zuV4fPBbNU67zeiEAftWwhfQqDkkxHdnZ5v3
GQx876ZHOpmIUd5zYZQjXkIMh4XxZu8JmDVWOqV5xmwqrBlO4MBS/Rx8OVfYMRDq
LaNh835XqZaIGYEERwWlTZWhq7BaBOuVMxC1+hmHZq/xSL9SoDx70FQYSCBhzJp7
9ILwvn1Xie+YUzu2vY84Tb4Lj9pyUFOHNOtzO4V9jci9Tq9CmJilz58Tg1y1sLDg
FxC7bMUrgOpO6qy/wMO7XUbH3AEUqucZOU9mPEgDpbODx1c1gVw=
=s4QB
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--


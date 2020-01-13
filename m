Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB79C33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 03:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0975B21744
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 03:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D/x4JOzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0975B21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqqhh-0007tu-RT
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 22:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iqqgZ-0006an-0f
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 22:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iqqgX-0006LO-GA
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 22:46:38 -0500
Received: from ozlabs.org ([203.11.71.1]:58979)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iqqgX-0006HQ-3p; Sun, 12 Jan 2020 22:46:37 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47wzzB2S6tz9s4Y; Mon, 13 Jan 2020 14:46:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578887190;
 bh=EH9MnePokeqal3DvDaXfJ+a1a3byOnrbRbYPcdi/3DE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D/x4JOzgwuAXFNe7wkwTyncL7+Jjcc+StcSmgLsRkOP54h4idQnlYsymU1vWitrpR
 dpg9j68h5Vvapmsi0nckBjZ3l4rW4ZTlnAYKWqyYBZvQ9RKhN5jlEaoPXAgzmNnlUK
 EDDoLq+xGpGe9Nja+KidvjoTR765OJbOa7kidL/o=
Date: Mon, 13 Jan 2020 13:32:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200113033202.GA19995@umbus>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
 <20200107052604.GH2098@umbus>
 <a76e906f-4cf0-aa49-759d-e64b7f219a1b@ozlabs.ru>
 <20200109040715.GM8586@umbus.fritz.box>
 <11640067-3b69-b8f2-bf06-27be0ba019de@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <11640067-3b69-b8f2-bf06-27be0ba019de@ozlabs.ru>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 05:31:24PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 09/01/2020 15:07, David Gibson wrote:
> > On Wed, Jan 08, 2020 at 03:07:41PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 07/01/2020 16:26, David Gibson wrote:
> >>
> >>>>>>>> +static uint32_t client_setprop(SpaprMachineState *sm,
> >>>>>>>> +                               uint32_t nodeph, uint32_t pname,
> >>>>>>>> +                               uint32_t valaddr, uint32_t valle=
n)
> >>>>>>>> +{
> >>>>>>>> +    char propname[64];
> >>>>>>>> +    uint32_t ret =3D -1;
> >>>>>>>> +    int proplen =3D 0;
> >>>>>>>> +    const void *prop;
> >>>>>>>> +
> >>>>>>>> +    readstr(pname, propname);
> >>>>>>>> +    if (vallen =3D=3D sizeof(uint32_t) &&
> >>>>>>>> +        ((strncmp(propname, "linux,rtas-base", 15) =3D=3D 0) ||
> >>>>>>>> +         (strncmp(propname, "linux,rtas-entry", 16) =3D=3D 0)))=
 {
> >>>>>>>> +
> >>>>>>>> +        sm->rtas_base =3D readuint32(valaddr);
> >>>>>>>> +        prop =3D fdt_getprop_namelen(sm->fdt_blob,
> >>>>>>>> +                                   fdt_node_offset_by_phandle(s=
m->fdt_blob,
> >>>>>>>> +                                                              n=
odeph),
> >>>>>>>> +                                   propname, strlen(propname), =
&proplen);
> >>>>>>>> +        if (proplen =3D=3D vallen) {
> >>>>>>>> +            *(uint32_t *) prop =3D cpu_to_be32(sm->rtas_base);
> >>>>>>>> +            ret =3D proplen;
> >>>>>>>> +        }
> >>>>>>>
> >>>>>>> Is there a particular reason to restrict this to the rtas propert=
ies,
> >>>>>>> rather than just allowing the guest to fdt_setprop() something
> >>>>>>> arbitrary?
> >>>>>>
> >>>>>> The FDT is flatten and I am not quite sure if libfdt can handle up=
dating
> >>>>>> properties if the length has changed.
> >>>>>
> >>>>> fdt_setprop() will handle updating properties with changed length (=
in
> >>>>> fact there's a special fdt_setprop_inplace() optimized for the case
> >>>>> where you don't need that).  It's not particularly efficient, but it
> >>>>> should work fine for the cases we have here.  In fact, I think you'=
re
> >>>>> already relying on this for the code that adds the phandles to
> >>>>> everything.
> >>>>
> >>>> Well, I used to add phandles before calling fdt_pack() so it is not =
exactly the same.
> >>>
> >>> Ah, right, that's why adding the phandles worked.
> >>>
> >>>>> One complication is that it can return FDT_ERR_NOSPACE if there isn=
't
> >>>>> enough buffer for the increased thing.  We could either trap that,
> >>>>> resize and retry, or we could leave a bunch of extra space.  The
> >>>>> latter would be basically equivalent to not doing fdt_pack() on the
> >>>>> blob in the nobios case.
> >>>>
> >>>>
> >>>> This is what I ended up doing.
> >>>>
> >>>>
> >>>>>> Also, more importantly, potentially property changes like this may=
 have
> >>>>>> to be reflected in the QEMU device tree so I allowed only the prop=
erties
> >>>>>> which I know how to deal with.
> >>>>>
> >>>>> That's a reasonable concern, but the nice thing about not having SL=
OF
> >>>>> is that there's only one copy of the device tree - the blob in qemu.
> >>>>> So a setprop() on that is automatically a setprop() everywhere (this
> >>>>> is another reason not to write the fdt into guest memory in the nob=
ios
> >>>>> case - it will become stale as soon as the client changes anything).
> >>>>
> >>>>
> >>>> True to a degree. It is "setprop" to the current fdt blob which we d=
o not
> >>>> analyze after we build the fdt. We either need to do parse the tree =
before
> >>>> we rebuild it as CAS so we do not lose the updates or do selective c=
hanges
> >>>> to the QEMUs objects from the "setprop" handler (this is what I do
> >>>> now).
> >>>
> >>> Hrm.. do those setprops happen before CAS?
> >>
> >> Yes, vmlinux/zimage call "setprop" for "linux,initrd-start",
> >> "linux,initrd-end", "bootargs", "linux,stdout-path"; vmlinux sets
> >> properties if linux,initrd-* came from r3/r4 and zImage sets properties
> >> no matter how it discovered them - from r3/r4 or the device tree.
> >=20
> > Ok, and those setprops happen before CAS?
>=20
> Yes.
>=20
> > In a sense this is kind of a fundamental problem with rebuilding the
> > whole DT at CAS time.  Except that strictly speaking it's a problem
> > even without that: we just get away with it by accident because CAS
> > isn't likely to change the same things that guest setprops do.
>=20
> > It's still basically unsynchronized mutations by two parties to a
> > shared data structure.
>=20
> True... We may end up not having FDT at all and reuse QOM objects for
> that, can even use hashes of QObject pointers as phandles :)

Hm, interesting idea.  I suspect the QOM hierarchy won't be quite
similar enough to the fdt hierarchy (or at least not guaranteed to be)
to make it work, but it's worth thinking about at least.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4b5LIACgkQbDjKyiDZ
s5LP+Q/+L+tlAEU8rvikqUZJEvmOn7z5AE3g1x4ee3d0YCcCQg/ALuCDZBQ06UOg
65PPpWM/ANM9nHm8d//wdm/zeIZbLGaN+gX7MK566PS5AoKNlEqJq5mPF80C2V0m
9Gybadp8hzPlYuh3dEy64UNnCXLAWSwGxsChKKYG1PJ1sb1PSzkw9qVwZzbEeT+O
wtY4wfL5ls/GqCbOnKNUhY7jUeIv7kmYBixK7vM9udmq3tLe8RUxqZqHE0S4nULx
YzEgJ8mOIr5QuhyXBW9YS20WPHVKCzOkkO91Ht7kH5CusrgTd519bLfDlASWi6ns
z/+UQ4V0Sj1ZN/fOUF1Og6VGGHmDjCwgaLEf0HD5d87Dh2++LBKBX3hDITS9GfuA
02NedT52ewr7DObm52N7VrQXBE3WfbshGWZzaMgpSzrBP98NSRrX3lwx5OCTb4Tv
UjeePgriPVv/o5bIkOnqsuztqYOITwGKgZTDpZbyshXTX0IHwn09MJSgbX1b4ICj
3ywPNW+IVEs2nj/u3FX7Zxh5mbRDNKyjOWGkBMWQOR8WncdyhKIQwkvUssKgvwW2
XfY+wYrWgRaqTtujUBpSiHE3cK3f8IShTyn/lMNO/Oza+wADF3OvZ66aTf1X4KyP
WVX0MS4W3veQvydYwB44QiLOIlzBzFSw3Z1CDTfFleZWVFR4JLk=
=akxi
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--


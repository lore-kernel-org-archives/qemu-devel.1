Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B2C3B184
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DDB20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZvHjpnDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DDB20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13vw-0003y3-06
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j13v4-0002hZ-J9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j13v3-00023C-3k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:55:50 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44347 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j13v0-0001vR-Tu; Mon, 10 Feb 2020 02:55:49 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48GJ9p3V8Tz9sRN; Mon, 10 Feb 2020 18:55:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581321342;
 bh=ZhJwOENWGkBWWTqyMQBBmVUREUFXxkx2KPz4N4XtVqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZvHjpnDhI9iF2U7lHrAAzJ0YOZ7qCkovcPtnackAmTUEFRTXh2lX53GApseavzv+/
 bwaNBym4REqKTfWg3hoTITPaSmN1etIV0iE4gaW0S+QVZajWGgiaMCBwF780GdMctB
 vDH9uuXCfqhRxcxRRe7a3d0UE4dWXHYm1b9loQfE=
Date: Mon, 10 Feb 2020 18:55:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Restrictions of libnet (was: Re: VW ELF loader)
Message-ID: <20200210075516.GF22584@umbus.fritz.box>
References: <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
 <20200204095403.04d9dd29.conny@cornelia-huck.de>
 <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
 <20200205053049.GF60221@umbus.fritz.box>
 <bfe9398a-7108-9bf7-8589-6d01580bbb3a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline
In-Reply-To: <bfe9398a-7108-9bf7-8589-6d01580bbb3a@redhat.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Cornelia Huck <conny@cornelia-huck.de>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 07:24:04AM +0100, Thomas Huth wrote:
> On 05/02/2020 06.30, David Gibson wrote:
> > On Tue, Feb 04, 2020 at 10:20:14AM +0100, Thomas Huth wrote:
> >> On 04/02/2020 09.54, Cornelia Huck wrote:
> >>> On Tue, 4 Feb 2020 07:16:46 +0100
> >>> Thomas Huth <thuth@redhat.com> wrote:
> >>>
> >>>> On 04/02/2020 00.26, Paolo Bonzini wrote:
> >>>>>
> >>>>>
> >>>>> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
> >>>>> <mailto:aik@ozlabs.ru>> ha scritto:
> >>>>>
> >>>>>     Speaking seriously, what would I put into the guest?
> >>>>>
> >>>>> Only things that would be considered drivers. Ignore the partitions
> >>>>> issue for now so that you can just pass the device tree services to=
 QEMU
> >>>>> with hypercalls.
> >>>>>
> >>>>>     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another S=
LOF,
> >>>>>     smaller but adhoc with only a couple of people knowing it.
> >>>>>
> >>>>>
> >>>>> You can generalize and reuse the s390 code. All you have to write i=
s the
> >>>>> PCI scan and virtio-pci setup. =20
> >>>>
> >>>> Well, for netbooting, the s390-ccw bios uses the libnet code from SL=
OF,
> >>>> so re-using this for a slim netboot client on ppc64 would certainly =
be
> >>>> feasible (especially since there are also already virtio drivers in =
SLOF
> >>>> that are written in C), but I think it is not very future proof. The
> >>>> libnet from SLOF only supports UDP, and no TCP. So for advanced boot
> >>>> scenarios like booting from HTTP or even HTTPS, you need something e=
lse
> >>>> (i.e. maybe grub is the better option, indeed).
> >>>
> >>> That makes me wonder what that means for s390: We're inheriting
> >>> libnet's limitations, but we don't have grub -- do we need to come up
> >>> with something different? Or improve libnet?
> >>
> >> I don't think that it makes sense to re-invent the wheel yet another
> >> time and write yet another TCP implementation (which is likely quite a
> >> bit of work, too, especially if you also want to do secure HTTPS in the
> >> end). So yes, in the long run (as soon as somebody seriously asks for
> >> HTTP booting on s390x) we need something different here.
> >>
> >> Now looking at our standard s390x bootloader zipl - this has been givi=
ng
> >> us a headache a couple of times in the past, too (from a distro point =
of
> >> view since s390x is the only major platform left that does not use gru=
b,
> >> but also from a s390-ccw bios point of view, see e.g.
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03046.html and
> >> related discussions).
> >>
> >> So IMHO the s390x world should move towards grub2, too. We could e.g.
> >> link it initially into the s390-ccw bios bios ... and if that works out
> >> well, later also use it as normal bootloader instead of zipl (not sure
> >> if that works in all cases, though, IIRC there were some size
> >> constraints and stuff like that).
> >=20
> > petitboot would be another reasonable thing to consider here.  Since
> > it's Linux based, you have all the drivers you have there.  It's not
> > quite grub, but it does at least parse the same configuration files.
> >=20
> > You do need kexec() of course, I don't know if you have that already
> > for s390 or not.
>=20
> AFAIK we have kexec on s390. So yes, petitboot would be another option
> for replacing the s390-ccw bios. But when it comes to LPARs and z/VMs, I
> don't think it's really feasible to replace the zipl bootloader there
> with petitboot, so in that case grub2 still sounds like the better
> option to me.

Actually, between that and Paolo's suggestions, I thought of another
idea that could be helpful for both s390 and power.  Could we load
non-kexec() things (legacy kernels, non-Linux OSes) from Petitboot by
having it kexec() into a shim mini-kernel that just sets up the boot
environment for the other thing.

What I'm imagining is that petitboot loads everything that will be
needed for the other OS into RAM - probably as (or part of) the
"initrd" image.  That means the shim doesn't need to have drivers or
a network stack to load that in.  It just needs to construct
environment and jump into the real kernel.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5BDGIACgkQbDjKyiDZ
s5ICUg//d7uMm2f1LU/aEmy5ilcsj91eo/sfrCzbxh0shOMoF5D68kqOJvDQdOo2
6vrYzMJYQjiDOL1N1VB7sjcCA0E5oHkov3bbHF3cXni31PcNtLIAAKqTlN9ut2//
Vve9Og0EA+lEfXfXC9akSomEU9nYRuBCOkZZJ1lRjJwXkAIhy7BzG5G9yRcorFJ5
KcqUBJq2hPRCIEVmKCLye7rV5JKub+1UODF67lcTKSBfyrpTtn3jKCZO/j9B8vgT
gddQWc2ksWQnFCOPCyd4cO+pKT8YL+bDr1LURe6swqBjONRQxCokmfDpXgVYFdNc
axy26InQ1E9KD+m15UAGdkeEjrRGm+G6JM1NwCs+dvu87XEYnxbbKmGUFz1U4Xtt
9migzbSi0LtK4XlGEw0MGXXajzt14olblzkJBcOJy4uzHIl7gaeL3Bu2v/pFZTMF
MLk8UQiX8gcS4XkDFaQcXmaNf4hwcOcakaPgcwBNFnAzndBwVp014FGUvy3f0MAo
Vj+HhETfeutl3f6fzBPGJ/5HnRLLR20hgKAL0/IMR0n9AmZO26VJZnzjLUxpP++u
TvXZdEWlj4rcGf87iGFe4UrjIcezHL0q2L2AksVoamzV4OPCgu3sMtskZzaW6QtN
jY3lVfo9MpgKN4SaT6b+QfYO9Vra+TfbYUS3a9+VirTmMsyesA4=
=KIDD
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--


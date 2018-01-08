Received: from eggs.gnu.org ([2001:4830:134:3::10]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZ3u-0006Uy-IJ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZ3r-0001o3-Cz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:10:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYZ3r-0001nd-3N
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:10:03 -0500
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
	<CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
Date: Mon, 8 Jan 2018 09:10:00 -0600
MIME-Version: 1.0
In-Reply-To: <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lgDTPNGDPYoZbd5nbJJ5Kj9lzVFofxyvw"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lgDTPNGDPYoZbd5nbJJ5Kj9lzVFofxyvw
From: Eric Blake <eblake@redhat.com>
To: Ed Swierk <eswierk@skyportsystems.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
 <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
In-Reply-To: <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 07:30 AM, Ed Swierk via Qemu-devel wrote:

> Applied, thanks.
>=20
> PS: just noticed, but "Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>=
"
> is a bit of an odd Author string to end up in git commit logs, so you
> and/or Ed might like to fix that up for any future patches.
>=20
>=20
> Thanks for pointing that out. I wonder if it's happening because I let
> git-send-email automatically fill in the From: line.

It's also a factor of how strict your ISP is about DMARC handling; the
list automatically rewrites the 'From:' header to insert the 'via
Qemu-devel' tag if it detects DMARC settings at your ISP that won't
allow your email through as originally written.  Sadly, mailman doesn't
know to insert a manual 'From:' line in the body when it rewrites the
original From: header; but if you know that DMARC settings are going to
munge your original header, you can probably convince git to always
insert an explicit From: line in the message body to override whatever
munging the list does.

>=20
> Anyway if it's not too late to fix, the correct address is Ed Swierk <
> eswierk@skyportsystems.com> .

You can also submit a patch against .mailmap so that existing
submissions with the suspect data will at least be credited to the
correct address for the purposes of crawling through git history.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lgDTPNGDPYoZbd5nbJJ5Kj9lzVFofxyvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTicgACgkQp6FrSiUn
Q2qJEwgAmYP/peDqNVR90k44cQf0erThq9avWt65mz50DDDGjGPE2KTnUzt34YnZ
rrfvhn5r6MAcnEeQSHnU5xoD4njMDRTtgfI91FVIKg2MRaalnJgGg6+UTMGj2Gfq
P9aNeQX7P/wTyg9U/FnQkcGA/hSkYj0OsLtxoBv0k42oMv2sxZkWhuSjpbBV4iQo
IDJRuWrso0HulSdv7HMQgDzJhtUZCthtYp+SKwYorrpo2mM3CjV79oFj66C2TaWW
E0RRfn4Wr6MiYghhgwj5694pTtq94gF5QpBiuGbLURvGRQm6Nf8nB2PQ56JZ624a
/hD0Lg15V6wCRGELOZydB2lzz+WdVA==
=7RVU
-----END PGP SIGNATURE-----

--lgDTPNGDPYoZbd5nbJJ5Kj9lzVFofxyvw--

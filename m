Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8BBf-0005GX-Ff
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8BBe-0005VD-JZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:52:47 -0400
References: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
	<20170509154439.GA16494@localhost.localdomain>
	<20170509194344.za4abntjp3tkrilt@post>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61e0501a-6ebc-cef0-5a2b-a26b4481eceb@redhat.com>
Date: Tue, 9 May 2017 14:52:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170509194344.za4abntjp3tkrilt@post>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bD0B38xU8XL3j47Q48hdttWgqgWXSW4UK"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: curl: Allow passing
 cookies via QCryptoSecret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bD0B38xU8XL3j47Q48hdttWgqgWXSW4UK
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <61e0501a-6ebc-cef0-5a2b-a26b4481eceb@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: curl: Allow passing
 cookies via QCryptoSecret
References: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
 <20170509154439.GA16494@localhost.localdomain>
 <20170509194344.za4abntjp3tkrilt@post>
In-Reply-To: <20170509194344.za4abntjp3tkrilt@post>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 02:43 PM, Manos Pitsidianakis wrote:
> On Thu, May 04, 2017 at 04:00:06PM +0200, Peter Krempa wrote:
>> +    cookie_secret =3D qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE_SECRET=
);
>> +
>> +    if (cookie && cookie_secret) {
>> +        error_setg(errp,
>> +                   "curl driver cannot handle both cookie and cookie
>> secret");
>> +        goto out_noclean;
>> +    }
>> +
>> +    if (cookie_secret) {
>> +        s->cookie =3D qcrypto_secret_lookup_as_utf8(cookie_secret, er=
rp);
>> +        if (!s->cookie) {
>> +            goto out_noclean;
>> +        }
>> +    } else {
>> +        s->cookie =3D g_strdup(cookie);
>> +    }
>=20
> There's no check here for if both cookie and cookie_secret are NULL.

Is that a problem?  s->cookie ends up as NULL (thanks to g_strdup()
semantics), which merely means there's no cookie to be sent after all.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bD0B38xU8XL3j47Q48hdttWgqgWXSW4UK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEh4GAAoJEKeha0olJ0Nqa9YIAJ1z3/PzslrscbVaYubi3Lao
avwhtvYRFE506cjQiuUvOp9gdtUzxulN379uXqhNlJ0Dc7m0pxfEOVdJ9Hw9Csjj
tQjOHUQnihrWZY0ndVmWBOAfidBseNHraEjLuJ6QgNlH+W0Yxif4Axo+1UiQ0kxv
vL2FpROyaSaSOWzbK1RjSrrkTU8NmyhOdkf492bMFDhV1CK2lZkRps97P1R9D6p9
si8VsLnZhh5nnRXQChOVAVdwnnhSb7iU1qrM9dKb8CAebvN9YYF8Hxb4h8ZUEAEo
k1HFANSRX25iAGFR/rN0n2QeEjA2vSEiFUzVN9FJUFRAlvJg3PH8CYPMrfCNuzk=
=Njwn
-----END PGP SIGNATURE-----

--bD0B38xU8XL3j47Q48hdttWgqgWXSW4UK--

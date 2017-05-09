Received: from eggs.gnu.org ([2001:4830:134:3::10]:35672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d8BM1-0000If-OX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d8BLy-00082r-Hb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:03:29 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:37839)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d8BLy-00082R-62
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:03:26 -0400
Date: Tue, 9 May 2017 23:03:16 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170509200316.hibznxhc4dph6wxy@post>
References: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
	<20170509154439.GA16494@localhost.localdomain>
	<20170509194344.za4abntjp3tkrilt@post>
	<61e0501a-6ebc-cef0-5a2b-a26b4481eceb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el2p7efxsgerwbtd"
Content-Disposition: inline
In-Reply-To: <61e0501a-6ebc-cef0-5a2b-a26b4481eceb@redhat.com>
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
To: qemu-devel@nongnu.org, qemu-block@nongnu.org


--el2p7efxsgerwbtd
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 02:52:38PM -0500, Eric Blake wrote:
>On 05/09/2017 02:43 PM, Manos Pitsidianakis wrote:
>> On Thu, May 04, 2017 at 04:00:06PM +0200, Peter Krempa wrote:
>>> +    cookie_secret =3D qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE_SECRET);
>>> +
>>> +    if (cookie && cookie_secret) {
>>> +        error_setg(errp,
>>> +                   "curl driver cannot handle both cookie and cookie
>>> secret");
>>> +        goto out_noclean;
>>> +    }
>>> +
>>> +    if (cookie_secret) {
>>> +        s->cookie =3D qcrypto_secret_lookup_as_utf8(cookie_secret, err=
p);
>>> +        if (!s->cookie) {
>>> +            goto out_noclean;
>>> +        }
>>> +    } else {
>>> +        s->cookie =3D g_strdup(cookie);
>>> +    }
>>
>> There's no check here for if both cookie and cookie_secret are NULL.
>
>Is that a problem?  s->cookie ends up as NULL (thanks to g_strdup()
>semantics), which merely means there's no cookie to be sent after all.

Ah yes, g_strdup(NULL) returns NULL. Apologies for the noise.


>--=20
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3266
>Virtualization:  qemu.org | libvirt.org
>



--el2p7efxsgerwbtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEiCEAAoJEHNifC9pDfcQGmcQAJY4XjhmHDlfxdED0lKA17af
LXe6yWcpvX7FC2MnbAEYkqHzUbkUEDYxTYy0PbO68GhEJ5IaC/KaraRc6+w00Gm+
rn8Rm17uoyyboaktv69gDSsSFmIA8oAnL/b/2CmbkFbelBUvl+DftpCijB0CO/BP
0EuWM32YY4+99S2TV9Zps9h286Mqr9E544LfZW72eP5xZ69XKpgVvzNWg9GfWDrf
voKVxfGI63ZaTEZiQm8dy5mu8w1tqhyX+suBPGHY5bgcjW8TyEvp2HCY62H/T+8y
7NCw+YiSZM9aduTq2QvjZXvi+TMv9hzwU5DiM8td2C82NHz3e9jap57O3OKTWtre
B0ZbUiBdVfGrQnq2eDTP9+sRYUeenzmWmKsMWgMPdbIjvpoiurqYormQ23bBTd7+
cEhMVgCKgLmE3A+Op81ZM9dCEopQFovL4Wv0zpKPxKsmUYB77+wLFawjhUb+AtjD
kOjaL8O+FOq776Eqxo37YSXjvPA2tHi2FHI+f2om6+mrL1/87H1Thvt+FENfom44
TIU5s1QnEC59QyXf6p2SvG1FK1az94vG9wXUMZXCn7vOdXzILXltQKIz9ee0/VYh
dLDon6eYgOhQCmiPlfxekLJtbYEEkJcCE58BxPV5zbd2X4aaGvler5r17GmbMqWF
FpAYURaerNrPGAJ+8N46
=3Wki
-----END PGP SIGNATURE-----

--el2p7efxsgerwbtd--

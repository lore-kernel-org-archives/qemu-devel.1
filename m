Received: from eggs.gnu.org ([2001:4830:134:3::10]:55911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwqOf-0003sE-SO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwqOe-0002Vj-RU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dwqOe-0002VJ-Ew
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:59:36 -0400
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
	<1506083624-20621-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
	<1506427596.5843.104.camel@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0ae0926-cf82-2ce7-39e2-d17d6db70d68@redhat.com>
Date: Tue, 26 Sep 2017 08:59:33 -0500
MIME-Version: 1.0
In-Reply-To: <1506427596.5843.104.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P2ADmFtPTcLWiOiDkXFRxLSdLV6nlQUtS"
Subject: Re: [Qemu-devel] [PATCH v7 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>
Cc: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P2ADmFtPTcLWiOiDkXFRxLSdLV6nlQUtS
From: Eric Blake <eblake@redhat.com>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>
Cc: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
Message-ID: <d0ae0926-cf82-2ce7-39e2-d17d6db70d68@redhat.com>
Subject: Re: [Qemu-devel][PATCH v7 8/8] tpm: Added support for TPM emulator
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
 <1506083624-20621-9-git-send-email-amarnath.valluri@intel.com>
 <CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
 <1506427596.5843.104.camel@intel.com>
In-Reply-To: <1506427596.5843.104.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 07:05 AM, Valluri, Amarnath wrote:

>>> +
>>> +#define DPRINT(fmt, ...) do { \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0if (DEBUG_TPM) { \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprintf(stderr, fmt,=
 ## __VA_ARGS__); \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0} \
>>> +} while (0);

Do not include the trailing ';' directly in the macro definition. The
whole point of wrapping things in a do{}while(0) is so that you can do:

if (foo)
    DPRINT(...);
else
    ...

(of course, that violates our coding style, as we require {} everywhere,
but it makes your macro appropriate for copying and pasting to other
projects that have different styles).


>>> +=C2=A0=C2=A0=C2=A0=C2=A0ret =3D qio_channel_read(tpm_pt->data_ioc, (=
char *)out, out_len,
>>> &err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0 || err) {
>> read_all() ?
> The issue with read_all() is it does not return the no of bytes it
> read, so i would like to stict to _read()

But you KNOW the number of bytes read if read_all() succeeded - it read
as many bytes as you requested!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--P2ADmFtPTcLWiOiDkXFRxLSdLV6nlQUtS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKXUUACgkQp6FrSiUn
Q2ocrAgAk6nH6w7wxDrO+BJHizhVwikA3M3vD/HZoL4d6/fbuPmn97FERkxWKlhk
yy2bvVgP5PWFgkkE0BgqJkQLnJBuYrdFLXFX8n6wIDYA0NVLRNQyLZf6I53DyKRt
rZzVfvLheTK2oLHE5hmdjR0GW8vPF5QMLGNAxVPM/M3fSbSvIlFVY2vZ7IU/izdT
Fkpf7AariqTcd2cdPvjf3WjU8r2DxPFkDXU2+2J6KBmGrO1F8cfgZOagHIyCN3DX
VfMRU3o4Cs1lpJtTM6MkofnbOZN74R6FU3xHjULq1q0YQ6ttsXKo3/qU8980aCuv
57hHfMAWzeF/JAyI9C+ohH+nIoiUcA==
=YH0H
-----END PGP SIGNATURE-----

--P2ADmFtPTcLWiOiDkXFRxLSdLV6nlQUtS--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecXpV-0005jC-Rt
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ecXpR-0005qc-NT
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:39:41 -0500
References: <20180118085316.27400-1-lvivier@redhat.com>
	<445b8b3e-1394-8cdc-ae20-e14cac32c5fa@ilande.co.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <780c8da7-0a5a-4e00-fdbe-fd99f2ddab06@redhat.com>
Date: Fri, 19 Jan 2018 08:39:33 -0600
MIME-Version: 1.0
In-Reply-To: <445b8b3e-1394-8cdc-ae20-e14cac32c5fa@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MNcJykiv6DJCcF8KoxzqyrnOEvCam6Ehq"
Subject: Re: [Qemu-devel] [PATCH] hw/char: remove legacy interface
 escc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MNcJykiv6DJCcF8KoxzqyrnOEvCam6Ehq
From: Eric Blake <eblake@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <780c8da7-0a5a-4e00-fdbe-fd99f2ddab06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char: remove legacy interface escc_init()
References: <20180118085316.27400-1-lvivier@redhat.com>
 <445b8b3e-1394-8cdc-ae20-e14cac32c5fa@ilande.co.uk>
In-Reply-To: <445b8b3e-1394-8cdc-ae20-e14cac32c5fa@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 06:47 AM, Mark Cave-Ayland wrote:
> On 18/01/18 08:53, Laurent Vivier wrote:
>> Move necessary stuff in escc.h and update type names.
>> Remove slavio_serial_ms_kbd_init().
>> Fix code style problems reported by checkpatch.pl
>> Update mac_newworld, mac_oldworld and sun4m to use directly the
>> QDEV interface.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>> =C2=A0 hw/char/escc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 208

>> =C2=A0 -static inline void set_rxint(ChannelState *s)
>> +static inline void set_rxint(ESCCChannelState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rxint =3D 1;
>> -=C2=A0=C2=A0=C2=A0 /* XXX: missing daisy chainnig: chn_b rx should ha=
ve a lower
>> priority
>> +=C2=A0=C2=A0=C2=A0 /* XXX: missing daisy chainnig: escc_chn_b rx shou=
ld have a lower
>> priority

As long as you are touching this, s/chainnig/chaining/


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MNcJykiv6DJCcF8KoxzqyrnOEvCam6Ehq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpiAyYACgkQp6FrSiUn
Q2p2sAf9FCT9Fy2FouHD9DFoe02iKMQ1i+y07ODjjDoLaogOnwdKBlLPxFV1MnjR
wwdCVTrTDtjdzMb8i6lY8EwUuAsmeSC+d3f3WmVxXmCCAZvxxm2pn+gZuoMsGCyr
pcXBpfMxbjqVdShS0asKrrrvANb9f15Uxp9DdXAn5QvUXT/j1YrUNmYoE4lwhRCN
NMzNr8UL5xOI4AbH/jNy8vnEDYaRpJHVdJyWd5c0GC+aa4G2RkSYn3ybt9OsD+pZ
aZ/xk2zg0TjR9E1qvBuSstfvn9g1REcZdSLL1jgVu3Ovvl182E+l+qFTxFEy+E8M
cu3EVcGrL+QAKpJ4TL0NX1zW5VjZUg==
=EBHr
-----END PGP SIGNATURE-----

--MNcJykiv6DJCcF8KoxzqyrnOEvCam6Ehq--

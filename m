Received: from eggs.gnu.org ([209.51.188.92]:49853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giVYe-0003JL-RN
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giVYd-00014i-0H
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1giVYb-0000y0-BZ
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 21:31:25 -0500
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
	<20190111162649.GC14776@stefanha-x1.localdomain>
	<CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
	<20190111124742-mutt-send-email-mst@kernel.org>
	<a313ccb0-4c81-5753-6ca7-95b6811d6f5d@redhat.com>
	<CAGxU2F7RuG9LSrXykKnYG+Ax9x5Pk7FhNuBFXx7gh0evo=kqBQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <996140fc-9daf-8488-37cb-4b7104dedec8@redhat.com>
Date: Sat, 12 Jan 2019 20:31:04 -0600
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7RuG9LSrXykKnYG+Ax9x5Pk7FhNuBFXx7gh0evo=kqBQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4IOc8BpZFyVErE5h1Pj9joWEv8JFs7xQO"
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions
 in a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4IOc8BpZFyVErE5h1Pj9joWEv8JFs7xQO
From: Eric Blake <eblake@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson
 <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <996140fc-9daf-8488-37cb-4b7104dedec8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions in
 a new header
References: <20190111131836.107549-1-sgarzare@redhat.com>
 <20190111131836.107549-3-sgarzare@redhat.com>
 <20190111162649.GC14776@stefanha-x1.localdomain>
 <CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
 <20190111124742-mutt-send-email-mst@kernel.org>
 <a313ccb0-4c81-5753-6ca7-95b6811d6f5d@redhat.com>
 <CAGxU2F7RuG9LSrXykKnYG+Ax9x5Pk7FhNuBFXx7gh0evo=kqBQ@mail.gmail.com>
In-Reply-To: <CAGxU2F7RuG9LSrXykKnYG+Ax9x5Pk7FhNuBFXx7gh0evo=kqBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/12/19 12:25 PM, Stefano Garzarella wrote:

>>> Better to just pull in qemu/osdep.h
>>
>> Except that qemu/osdep.h should already have been pulled in by whateve=
r
>> .c file is including this header. We specifically document that .h fil=
es
>> shouldn't need to include osdep.h (and in turn, anything that osdep.h
>> already pulls in, like <stdint.h>).
>=20
> Since I can't include qemu/osdep.h because this header file is used by
> the option roms (bare metal), do you think is better to include
> stdint.h in optrom.h or in the .c files that use it?
> As Stefan pointed out, I'm including qemu_fw_cfg.h in optrom.h and it
> depends on stdint.h. In this case, what is the best approach?

If this is one of the exception files that is used to build files
outside of qemu, then its should probably be mentioned as an exception
in scripts/clean-includes (okay, I see that pc-bios/ is already
exempted) - and thus using osdep.h is not an option, but using
<stdint.h> is, because it is the exception to the rule, in relation to
files used only for qemu.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4IOc8BpZFyVErE5h1Pj9joWEv8JFs7xQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw6ougACgkQp6FrSiUn
Q2q9Pwf6A8jSP3rzALPnpPhQGIG5SQN7FlsxkopvRmISFebIopvClOLnM2+7SjKH
iiqvkw2sgUnksFSd/0DZ38y6J2azEpx+RNrarkmbScGZO79Y02dNuMhtuzzeTefT
RdMmKU84147+o/9aPjw5gDTtxX3N/VmH3noJ2gf6s0t1Jvv9MCvMCGySFmZJ9uPn
29clkQ69SomGq+rHq0000OalPisRY2NJjW6QmAIdXpuPqBlg2hbiISxA8jvAzrAn
/qu1ITfw/Nh5kO48OY7219SXFMYcxmohU9Dt/G8jVfrGscwABCPUF/PkVeRTsyli
P6lsXeiiWAbYjTyg7NM0cjzqvdtY6w==
=ETjd
-----END PGP SIGNATURE-----

--4IOc8BpZFyVErE5h1Pj9joWEv8JFs7xQO--

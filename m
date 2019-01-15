Received: from eggs.gnu.org ([209.51.188.92]:35484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjU8e-0006mM-3Q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjU8d-00085P-5b
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:12:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjU8c-00084L-Qh
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:12:39 -0500
References: <20190115100058.44712-1-sgarzare@redhat.com>
	<20190115100058.44712-5-sgarzare@redhat.com>
	<20190115135548-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3db58f6f-44fc-da64-2cfb-41404a9b2319@redhat.com>
Date: Tue, 15 Jan 2019 13:12:21 -0600
MIME-Version: 1.0
In-Reply-To: <20190115135548-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FPVuBz9tMqygg4p1AFcTlxHiP4kf8SPqf"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Maran Wilson <maran.wilson@oracle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FPVuBz9tMqygg4p1AFcTlxHiP4kf8SPqf
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 George Kennedy <george.kennedy@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>,
 Maran Wilson <maran.wilson@oracle.com>
Message-ID: <3db58f6f-44fc-da64-2cfb-41404a9b2319@redhat.com>
Subject: Re: [PATCH v2 4/4] hw/i386/pc: use PVH option rom
References: <20190115100058.44712-1-sgarzare@redhat.com>
 <20190115100058.44712-5-sgarzare@redhat.com>
 <20190115135548-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190115135548-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 12:57 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 15, 2019 at 11:00:58AM +0100, Stefano Garzarella wrote:
>> Use pvh.bin option rom when we are booting an uncompressed
>> kernel using the x86/HVM direct boot ABI.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
>=20
> I don't think this is a great way to give attribution.
> Can you pls include the author name and the S.O.B from there as well?
>=20
>=20
>> ---

Patchew understands Based-on: tags as meaning a prerequisite patch on
the list that must be applied first before this patch can apply (and NOT
in the sense that this patch is an updated revision to replace an
earlier revision posted by someone else) - but when using the annotation
to keep Patchew happy, it should either be in a 0/N cover letter, or for
a single patch, after the --- separator, as the condition of a
prerequisite patch not being applied is a transient condition relevant
to the current build but not something that needs to be recorded in
long-term git history.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FPVuBz9tMqygg4p1AFcTlxHiP4kf8SPqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+MJUACgkQp6FrSiUn
Q2rZRAf48qHc66BrOPcGIx+pW+EFujkU1FCGELMg7wsWX3GKUshqAL0fIvCtMG8L
SHelPnM5PuvMpUqPCK05RQenvuce18SUADgnrGB6R7RwVbvD+6ou5dnvuhoUaYPz
GcCYpynlC/HFa93atjvbnKwDvf6lVzUf3C+V4Xfsx77ahv02UOuhpkTGOm/RGf3r
zBxIYJ4arHvlmkc7FL3/AOeB7RjGH0zTs9hc8jDAPQfNr74Joi2EjziJiGtQjUBS
YdfxtH0jTmqEwyNedC4OACbP2j27vqQPbkkec9NZXfR3FTGkvkSg3rPl86JNItDb
qajezLxKk7lMRWGp0DP+C4QBqDbE
=d6ip
-----END PGP SIGNATURE-----

--FPVuBz9tMqygg4p1AFcTlxHiP4kf8SPqf--

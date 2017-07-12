Received: from eggs.gnu.org ([2001:4830:134:3::10]:38746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVGtQ-0001Hj-S6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dVGtN-0007D6-Ov
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dVGtN-0007Bw-F8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:37:21 -0400
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
	<040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
	<CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <471dbf3c-5e48-9245-30c1-31cad440b601@redhat.com>
Date: Wed, 12 Jul 2017 14:37:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4K3eSIaP76sG7w0gDBhGaRSM0kRDCVjJE"
Subject: Re: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, philippe@mathieu-daude.net, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4K3eSIaP76sG7w0gDBhGaRSM0kRDCVjJE
From: Max Reitz <mreitz@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 philippe@mathieu-daude.net, Markus Armbruster <armbru@redhat.com>
Message-ID: <471dbf3c-5e48-9245-30c1-31cad440b601@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
 error_report()
References: <cover.1499774331.git.alistair.francis@xilinx.com>
 <12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
 <040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
 <CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
In-Reply-To: <CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-12 14:27, Alistair Francis wrote:
> On Tue, Jul 11, 2017 at 7:44 PM, Max Reitz <mreitz@redhat.com> wrote:
>> On 2017-07-11 14:07, Alistair Francis wrote:
>>> As we don't regard error messages as a stable API the let's add a
>>> 'error: ' prefix to the original error_report() messages.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> ---
>>>
>>>  util/qemu-error.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> This breaks quite a few qemu-iotests.
>=20
> Hmmm... Ok, I'll have to dig into that.
>=20
> I'm traveling at the moment so I won't get a chance to fix this. I'm
> going to send the next version of this series, but remove this patch
> and I can look at adding it again when I get back. There is already a
> few things that have been pointed out that need to be fixed after this
> patch set.
>=20
> Do people think we should add this prefix or leave the error messages
> as is? I haven't heard a definitive answer if people think this is the
> right path to take.

I don't really mind either way.  But it probably is a good idea to
separate this one patch from this series.

Max


--4K3eSIaP76sG7w0gDBhGaRSM0kRDCVjJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZhf5EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQD/6
B/95cExau/lfHr8d7peMoAgZZVBvV1YOEbXwvFtgQSg/JBFJPnm18CvyRs2UnWnF
nM3Zic0n+3zZoHBby4A4qoUE93MHynmggjcav2x1QqweRAFXMPDddpBQbx3T99Qt
+fDBtNe9brXaGn6YvsG0upxCbKo8tayWedkY2YY3DOPMSOCFM6jBNOGMZP1f6C2a
nbH5WntjsNwn3cE0klyyhjW39hn8jD1/zaAfmbkVlgKomYZ2UQ1GjjFHRtXxm7aX
GDbXlGJF5KKK1h174yD0WtF7XcpH3TJu8u3rtBLqmHXelolbMK790IRedme5iXPl
AFOH8zED8tMzrAQFdPO1ABrq
=E4Nv
-----END PGP SIGNATURE-----

--4K3eSIaP76sG7w0gDBhGaRSM0kRDCVjJE--

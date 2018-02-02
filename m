Received: from eggs.gnu.org ([2001:4830:134:3::10]:40678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd7v-0006Wx-7D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehd7t-0004fO-TB
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehd7t-0004ee-I4
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:19:41 -0500
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
	<20180201202649.GG26425@localhost.localdomain>
	<edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
	<20180202141554.GH26425@localhost.localdomain>
	<20180202141938.GJ15403@redhat.com>
	<20180202092159.48d9bd4c@redhat.com>
	<20180202145014.GI26425@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90263e16-cbb8-d7d5-368c-c4e1e72da9ee@redhat.com>
Date: Fri, 2 Feb 2018 09:19:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180202145014.GI26425@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GZNkcXGVjmW0tQWvWAGIFywanyUMY107x"
Subject: Re: [Qemu-devel] [RFC] kvm: x86: export vCPU halted state to sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>, John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GZNkcXGVjmW0tQWvWAGIFywanyUMY107x
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>
Cc: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org,
 pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <90263e16-cbb8-d7d5-368c-c4e1e72da9ee@redhat.com>
Subject: Re: [RFC] kvm: x86: export vCPU halted state to sysfs
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
 <20180201202649.GG26425@localhost.localdomain>
 <edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
 <20180202141554.GH26425@localhost.localdomain>
 <20180202141938.GJ15403@redhat.com> <20180202092159.48d9bd4c@redhat.com>
 <20180202145014.GI26425@localhost.localdomain>
In-Reply-To: <20180202145014.GI26425@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 08:50 AM, Eduardo Habkost wrote:
> (CCing qemu-devel)
>=20
> On Fri, Feb 02, 2018 at 09:21:59AM -0500, Luiz Capitulino wrote:
>> On Fri, 2 Feb 2018 14:19:38 +0000
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>>> On Fri, Feb 02, 2018 at 12:15:54PM -0200, Eduardo Habkost wrote:
> [...]
>>>> It would be also interesting to update QEMU QMP documentation to
>>>> clarify the arch-specific semantics of "halted". =20
>>>
>>> Any also especially clarify the awful performance implications of run=
ning
>>> this particular query command. In general I would not expect query-xx=
x
>>> monitor commands to interrupt all vcpus, so we should clearly warn ab=
out
>>> this !
>>
>> Or deprecate it...
>=20
> We could deprecate the expensive fields on query-cpus, and move
> them to a more expensive query-cpu-state command.  I believe most
> users of query-cpus are only interested in qom_path, thread_id,
> and topology info.
>=20
> Markus, Eric: from the QAPI point of view, is it OK to remove
> fields between QEMU versions, as long as we follow our
> deprecation policy?

Removing an output field outright may break a client that depended on
the field; so a deprecation period is definitely required there.  But it
is okay, documentation-wise, to state that a field is output always as 0
for back-compatibility reasons and that modern clients should ignore it
(which would then let old clients still parse the field, but no longer
see a non-zero value), whether or not we also pursue the deprecation
course and eventually remove the field after more releases.

See CpuInfo::current, for an example.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GZNkcXGVjmW0tQWvWAGIFywanyUMY107x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0gXoACgkQp6FrSiUn
Q2qsvgf/dRdvfcjj9Lv7h1iaX06sjR/YoGHkVWwZo12YDcpqv1I9wNAg6P/MdxdP
HbeDKYL65OrZajSwozkgMZaQC5jYAIdjUcjcBE8Dw+82ysmaPy1LKEzwv/xJvmXX
FpSDn+nmtEVJJe+m8AjoMeXMEohtM+hJv2DmIm5PcFABNCciVrK5UwBmpSask4FE
UbzUbRdcBjvC1/dYNIFchHqQntEXDg4bKwuYvbYgNIG8v0lEEcgMMKZ3PDszuW+y
88XsBNA0iLGoxXSL1miB/9dz4zTGwUt7dBz8N44e6OjuKoqMBvpDMnjZBEdtBhWW
gQ+OBRKtNaDyudEt7eWC4NDyJ0H1Kw==
=/fF2
-----END PGP SIGNATURE-----

--GZNkcXGVjmW0tQWvWAGIFywanyUMY107x--

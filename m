Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehe8V-0000wH-G1
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehe7Q-00087o-Ql
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:24:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehe7Q-00086H-6n
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:23:16 -0500
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
	<20180201202649.GG26425@localhost.localdomain>
	<edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
	<20180202141554.GH26425@localhost.localdomain>
	<20180202141938.GJ15403@redhat.com>
	<20180202092159.48d9bd4c@redhat.com>
	<20180202145014.GI26425@localhost.localdomain>
	<20180202150718.GL15403@redhat.com>
	<20180202152532.GL26425@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97d2b544-f4d4-8d95-1904-f07963091aa2@redhat.com>
Date: Fri, 2 Feb 2018 10:23:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180202152532.GL26425@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MDcYcpckcN2pXVs3AAgXm9rTifSplqGz8"
Subject: Re: [Qemu-devel] [RFC] kvm: x86: export vCPU halted state to sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>, John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MDcYcpckcN2pXVs3AAgXm9rTifSplqGz8
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
 Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org,
 pbonzini@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 John Ferlan <jferlan@redhat.com>, libvir-list@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <97d2b544-f4d4-8d95-1904-f07963091aa2@redhat.com>
Subject: Re: [RFC] kvm: x86: export vCPU halted state to sysfs
References: <20180201125441.2f5b4fdd@redhat.com> <20180201201514.GB660@flask>
 <20180201202649.GG26425@localhost.localdomain>
 <edc27e9a-9660-eed0-dd03-016fa2e966b7@linux.vnet.ibm.com>
 <20180202141554.GH26425@localhost.localdomain>
 <20180202141938.GJ15403@redhat.com> <20180202092159.48d9bd4c@redhat.com>
 <20180202145014.GI26425@localhost.localdomain>
 <20180202150718.GL15403@redhat.com>
 <20180202152532.GL26425@localhost.localdomain>
In-Reply-To: <20180202152532.GL26425@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 09:25 AM, Eduardo Habkost wrote:

>>> Markus, Eric: from the QAPI point of view, is it OK to remove
>>> fields between QEMU versions, as long as we follow our
>>> deprecation policy?
>>
>> I would expect that to not be OK.  A fully backwards compatible way to=

>> deal with this would just be to add a flag to the query-cpus command
>> eg something like
>>
>>     query-cpus arch-specific=3Dfalse
>>
>> to turn off all this arch specific state, and just report the cheap
>> generic info. If it defaults to arch-specific=3Dtrue when omitted, the=
n
>> there's no compat problems.
>=20
> This would work, too.  I would name it "full-state",
> "extended-state" or something similar, though.  Not all
> arch-specific data is expensive to fetch, and not all
> non-arch-specific data is unexpensive.
>=20
> But I'd like to confirm if it's OK to make existing non-optional
> struct fields optional in the QAPI schema.  Markus, Eric?

If you add an optional bool/enum to opt-in to the command in order to
provide different levels of reporting on output, and the default remains
that when the new input field is absent, all information that was output
in earlier versions of qemu is still output, then you are backwards
compatible.  This is true even if you switched some fields from
mandatory output to optional output, because of the use of the new input
flag for opt-in semantics.  Newer callers that use the opt-in field get
what they want, older callers get what they always expected.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MDcYcpckcN2pXVs3AAgXm9rTifSplqGz8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0kGgACgkQp6FrSiUn
Q2pTiggAr8uMpM7pj82kh9ZDxf9jLvP6kgB8BGAt3WTsKFddwRXd64R80jJ+4/xk
MhQFNfaP4B29fVwJXVxWi8Q92SkOMLkSB5y05VdRTv32WKw8bQ5QpmZD+mXHHyuP
ABlxbdAp2ZF7S6MPJlONW8mOhm7x9WuqGvvXvHsTXNiQB0bow0PliC+/mGKzYccL
jVwCLgQlNo/Cc1XqCVuAO1zXrHe9fFQVxUzhen0yy/u+6/arncXQoK8BIwQYzcXH
QYbco7J7wfaAkEuOFLTMMFBmfOgrfGsVfGdjjaKyrE70T+3Kdx2Kjrzs5Alpnog9
zWJQkIEg2LYfnwOJRqtrOi2qxt3gKA==
=O8nS
-----END PGP SIGNATURE-----

--MDcYcpckcN2pXVs3AAgXm9rTifSplqGz8--

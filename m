Received: from eggs.gnu.org ([2001:4830:134:3::10]:57797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGvy-0007ID-Jd
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGvt-00056s-UA
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:25:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAGvt-000567-Ks
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:25:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3B3DC04B316
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:25:08 +0000 (UTC)
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-2-quintela@redhat.com>
	<0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com>
	<87pofafoek.fsf@secure.mitica> <20170515094655.GC2089@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ad3d1a1-ae63-b01d-b6a0-72a017b343aa@redhat.com>
Date: Mon, 15 May 2017 09:24:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170515094655.GC2089@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qdVrx6gEU5sb1BJHXXIUDcrEHjHiaaaf2"
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Create block capabilities
 for shared and enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qdVrx6gEU5sb1BJHXXIUDcrEHjHiaaaf2
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com
Message-ID: <6ad3d1a1-ae63-b01d-b6a0-72a017b343aa@redhat.com>
Subject: Re: [PATCH 1/3] migration: Create block capabilities for shared and
 enable
References: <20170511163228.6666-1-quintela@redhat.com>
 <20170511163228.6666-2-quintela@redhat.com>
 <0bbb5f93-83bb-47b9-e7dd-d0824f3d8b61@redhat.com>
 <87pofafoek.fsf@secure.mitica> <20170515094655.GC2089@work-vm>
In-Reply-To: <20170515094655.GC2089@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 04:46 AM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Eric Blake <eblake@redhat.com> wrote:
>>> On 05/11/2017 11:32 AM, Juan Quintela wrote:
>>>> Those two capabilities were added through the command line.  Notice =
that
>>>> we just created them.  This is just the boilerplate.
>>>>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>
>>>> --
>>>>
>>>> Make migrate_set_block_* take a boolean argument.
>>>
>>> Question - do we support the orthogonal selection of all 4 combinatio=
ns
>>> under HMP 'migrate' (no argument, -b alone, -i alone, -b and -i
>>> together), or are there only 3 actual states? If the latter, should w=
e
>>> represent this as a single enum-valued property, rather than as two
>>> independent boolean properties?
>>
>> { 'enum': 'MigrationCapability',
>>   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m'] }
>>
>>
>> My understanding is that we can only have boolean capabilities here.
>> Or, how could we put a non-boolean capability?

If we want a non-boolean, then we make it a migration parameter rather
than a migration capability.  There may be other advantages to using
MigrationParameter instead of MigrationCapability (such as making it
easier to figure out whether the parameter settings are persistent or
apply per-migration).

>=20
> Lets keep this simple and stick with the booleans.
>=20
> Dave
>=20
>> There are three states as far as I can see.

I'll leave it up to you as maintainers which way you prefer, I'm just
offering the potential design tradeoffs for simplicity of booleans (but
complexity in an unused state) vs. simplicity of design (but complexity
in code).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qdVrx6gEU5sb1BJHXXIUDcrEHjHiaaaf2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGbo5AAoJEKeha0olJ0NqVm4H/0PsOE6XxJ5cv3wUW9HYEEcj
SJFyG+S9Uwj81GCbuEafCaAxuJZmFNVhiNwQA6/APgmZ/pE5wL1blP2bhBPxkTGV
u4ggqnMeK6hC49QbfxGLipsa7vfUX9vRHKCkpg7CxKdxL/LW1rLqn6mZD6oCAorJ
5vWKLhSKYQP5fjq9wjYmiS+ED6jckmhLW8Qtvtimxz9W25klWqeyPue3oHFGs4mA
SPKm+ioVdthRuXL3GRa48XWsIPK9H65rDTYBLJDAZ4UM7+aDJv45TtilVCL93LlT
1U0WlMAoB4T/O8tyfKNtZuN9q9H+qx6E7ALICsypAZ3xAzWtjOh00AE7f1XUMPc=
=S3t9
-----END PGP SIGNATURE-----

--qdVrx6gEU5sb1BJHXXIUDcrEHjHiaaaf2--

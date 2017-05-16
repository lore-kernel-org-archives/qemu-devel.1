Received: from eggs.gnu.org ([2001:4830:134:3::10]:35754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAfdv-00019E-Bk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAfds-00084H-8i
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAfdr-00083l-W2
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:48:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C61ED87649
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 16:48:05 +0000 (UTC)
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-3-quintela@redhat.com>
	<87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
	<87h90kbxmd.fsf@dusky.pond.sub.org>
	<09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com>
	<87k25g92i8.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24a363d9-a395-325c-ff6c-f79211c773fb@redhat.com>
Date: Tue, 16 May 2017 11:48:01 -0500
MIME-Version: 1.0
In-Reply-To: <87k25g92i8.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BotlMr0aTaFgtkimNlDJvkFUfIt5HgpAX"
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BotlMr0aTaFgtkimNlDJvkFUfIt5HgpAX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, lvivier@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com
Message-ID: <24a363d9-a395-325c-ff6c-f79211c773fb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
References: <20170516111123.17692-1-quintela@redhat.com>
 <20170516111123.17692-3-quintela@redhat.com>
 <87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
 <87h90kbxmd.fsf@dusky.pond.sub.org>
 <09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com>
 <87k25g92i8.fsf@dusky.pond.sub.org>
In-Reply-To: <87k25g92i8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 11:42 AM, Markus Armbruster wrote:

>>> Well, to suggest something, I'd first have to figure out WTF incremen=
tal
>>> block migration does.  Your text helps me some, but not enough.  What=

>>> exactly is being migrated, and what exactly is assumed to be shared
>>> between source and destination?
>>>
>>> Block migration is scandalously underdocumented.
>>

> Can you draft a documentation comment for @block-incremental?

How about:

@block-incremental: Affects how much storage is migrated when the block
migration capability is enabled.  When false, the entire storage backing
chain is migrated into a flattened image at the destination; when true,
only the active qcow2 layer is migrated and the destination must already
have access to the same backing chain as was used on the source.
(since 2.10)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BotlMr0aTaFgtkimNlDJvkFUfIt5HgpAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGy1CAAoJEKeha0olJ0Nq6RoH/RgNAW1o+q8ny4nt9b/Ao7QN
oA7Qa3KZfeGv5bTLmVSZ0a5KIKAW1GEd3yExYIBDTr2CzazbqV+/CFA8QpqddKF6
V4ZN2tCey/0iRaeuy+Vl5mQK2Spf7ARndRKuYhraOd7s7tYhoJAF+Kmz9q60c+Wa
WLquUGXZrikWEg4VHylA1sLBtwmh2anUGtV5MDOG8E0PGCMxd/U0V/8l6juHP4zd
DOqhG274RgEsiwsc6EXLnZ4fuR1Oc8fFF0V0OdM3dMrLcgOWzDqxLqvs5NPzx7fi
yjSnZknZAWo/JTfvvF6/nwpT9e9uh8nMPErkbSxhoOQFXIXz+MWnI3Bw0nyL6rw=
=cHwB
-----END PGP SIGNATURE-----

--BotlMr0aTaFgtkimNlDJvkFUfIt5HgpAX--

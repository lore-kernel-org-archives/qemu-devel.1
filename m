Received: from eggs.gnu.org ([2001:4830:134:3::10]:43524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHzO-00026i-DH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHzK-0003G6-Cf
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:08:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZHzK-0003F4-4F
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:08:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FDDEC059755
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:08:21 +0000 (UTC)
References: <20180110142515.13242-1-pbonzini@redhat.com>
	<20180110143742.GD2450@work-vm> <20180110150413.GE2450@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e741e13-1922-17ff-ec18-d3efa39805d7@redhat.com>
Date: Wed, 10 Jan 2018 09:08:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180110150413.GE2450@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XP5hK8EccDpCohvVKZK3lr9uFEKJYaQo0"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] find_ram_offset cleanups and
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XP5hK8EccDpCohvVKZK3lr9uFEKJYaQo0
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Message-ID: <0e741e13-1922-17ff-ec18-d3efa39805d7@redhat.com>
Subject: Re: [PATCH v2 0/2] find_ram_offset cleanups and alignment
References: <20180110142515.13242-1-pbonzini@redhat.com>
 <20180110143742.GD2450@work-vm> <20180110150413.GE2450@work-vm>
In-Reply-To: <20180110150413.GE2450@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 09:04 AM, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>> These are basically David's patches, with a couple changes for clarit=
y
>>> and robustness.
>>
>> Yes, those look fine to me.
>> (Patchew seems to be annoyed at the Tracing - I can't see why)
>=20
> Stefan has explained this to me; we need to remove the spaces after the=

> PRIx64 macro calls in the first patch.

> +find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offse=
t, uint64_t next, uint64_t mingap) "trying size: 0x%"PRIx64 " @ 0x%"PRIx6=
4 ," offset: 0x%"PRIx64" next: 0x%"PRIx64 " mingap: 0x%"PRIx64

You have a misplaced ','; s/," offset/", offset/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XP5hK8EccDpCohvVKZK3lr9uFEKJYaQo0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWLGAACgkQp6FrSiUn
Q2r4bgf/SZj/dvh7UfgDUSS9aptbA8PsuJWRGm3AjoR8U3lGSXH4h2ZREQFBt0bH
nlKa00vh30IuaQNhj+rxhMcP7VtaS10HNzjnNAPyaJbzccn3xJqN95AchXcPHTW9
xX+psZXdwXmPLsRVEFgvp77Fri8hWwg5zgldTaPCzfWqbchWuixu5W7b3ZnlKpWI
76lrH5mUxYQN5I85N2MJZC3vgMwi9k9ELfe0O4Z6UZIDcJmgk+1TLGDC6hmxVEB/
bn6muhCuzqpb59CUlsfm22p1YPGjE1FoiyRGC3EPDSo/ZQGx9CnF/P6csFgxDzyD
vSXG0GQ3cj31soZTnMIajG7M9u0PxA==
=JDnt
-----END PGP SIGNATURE-----

--XP5hK8EccDpCohvVKZK3lr9uFEKJYaQo0--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhmN-0005NO-5C
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhmJ-0003CK-Tz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:21:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37698 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBhmJ-0003Bq-NQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:21:43 -0400
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-2-git-send-email-ian.jackson@eu.citrix.com>
	<23265.45771.760936.993507@mariner.uk.xensource.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b6d4152-f949-6c7a-6855-baa8e7124407@redhat.com>
Date: Thu, 26 Apr 2018 09:21:40 -0500
MIME-Version: 1.0
In-Reply-To: <23265.45771.760936.993507@mariner.uk.xensource.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lmyUUm0ZaacsFGyYKsFAJfFuW70UXRhPY"
Subject: Re: [Qemu-devel] [PATCH 01/16] checkpatch: Add
 xendevicemodel_handle to the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lmyUUm0ZaacsFGyYKsFAJfFuW70UXRhPY
From: Eric Blake <eblake@redhat.com>
To: Ian Jackson <ian.jackson@citrix.com>, qemu-devel@nongnu.org,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0b6d4152-f949-6c7a-6855-baa8e7124407@redhat.com>
Subject: Re: [PATCH 01/16] checkpatch: Add xendevicemodel_handle to the list
 of types
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
 <1524592709-6553-2-git-send-email-ian.jackson@eu.citrix.com>
 <23265.45771.760936.993507@mariner.uk.xensource.com>
In-Reply-To: <23265.45771.760936.993507@mariner.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 06:06 AM, Ian Jackson wrote:
> (expanding the CC to include everyone that get_maintainer suggests)
>=20
> Ian Jackson writes ("[PATCH 01/16] checkpatch: Add xendevicemodel_handl=
e to the list of types"):
>> This avoids checkpatch misparsing (as statements) long function
>> definitions or declarations, which sometimes start with constructs
>> like this:
>>
>>   static inline int xendevicemodel_relocate_memory(
>>       xendevicemodel_handle *dmod, domid_t domid, ...
>>
>> The type xendevicemodel_handle does not conform to Qemu CODING_STYLE,
>> which would suggest CamelCase.  However, it is a type defined by the
>> Xen Project in xen.git.  It would be possible to introduce a typedef
>> to allow the qemu code to refer to it by a differently-spelled name,
>> but that would obfuscate more than it would clarify.
>=20
> This patch has been posted in substantially similar form quite a few
> times now.  Paolo Bonzini understandably suggested that renaming the
> variable would be better but that's not within qemu's bailiwick as I
> say above.
>=20
> I think everything else in this series has a review and/or an ack.
> So I would like to send a pull request.
>=20
> Does someone want to review this patch ?  Should I drop it and just
> let checkpatch complain ?  Shold I include it in my pull request
> anyway ?

If no one has commented on what seems pretty trivial (especially since
checkpatch.pl has no official maintainer, but is more of a
"whoever-touched-it-last" file at the moment), then including the patch
in your pull request is perfectly acceptable.  As a maintainer, it is
also perfectly acceptable for you to ignore false positives from
checkpatch (although documenting it in the commit message and/or cover
letter never hurts, when you are intentionally ignoring a false positive)=
=2E

But, as there has also been a recent patch to teach checkpatch about
glib types [1], your patch makes sense (any merge conflict between your
patch and that one will be obvious to resolve).  So on that grounds,

Reviewed-by: Eric Blake <eblake@redhat.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04179.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lmyUUm0ZaacsFGyYKsFAJfFuW70UXRhPY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrh4HQACgkQp6FrSiUn
Q2o9Pgf/QD1GCLDjXRIcYdVkE1tpfzvGQJcBYkBcSdxDXD0r3pJr8s0AsaiHiay+
mPCJiuLasUaIsvCdorbqcS3ycTxIOerDrRb5yy32UTKYk39GPUOnzi7V9OL5pYhx
oswr365Pdm+zBkaAvcbzqh8XLYk1sfVvI4SN+8EYqpPUKmTAWxG7aW2Hrub78aBZ
NRUN2QH5yureliDU63z6TVLYGGzE2dNtiEpTdMUWDcRtXO/EuQVh9kV+xgSMEA0f
PkKM+0GuPEPkHv9vElpZWO3Y08vm2BSnyssv6lY7K2Ig6FJ68FjHB1WJkmub7HUc
rno2pHqsQ0S0s1kzvAYRys7+wNNQOg==
=sg5w
-----END PGP SIGNATURE-----

--lmyUUm0ZaacsFGyYKsFAJfFuW70UXRhPY--

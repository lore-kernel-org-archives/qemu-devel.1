Received: from eggsout.gnu.org ([209.51.188.92]:43385 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfZA9-00020X-8G
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfZA8-0002sz-FJ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:46:01 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-4-eblake@redhat.com>
	<1ab7fd0f-fc28-6ff0-286e-27b966f85404@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <719a11ad-7d01-e401-14c3-3bc4e9f88b54@redhat.com>
Date: Fri, 4 Jan 2019 17:45:51 -0600
MIME-Version: 1.0
In-Reply-To: <1ab7fd0f-fc28-6ff0-286e-27b966f85404@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="12uPwV58ZLgFisTSsvAirTGwMBCXlaKye"
Subject: Re: [Qemu-devel] [PATCH v2 03/22] maint: Allow for EXAMPLES in
 texi2pod
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--12uPwV58ZLgFisTSsvAirTGwMBCXlaKye
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com"
 <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <719a11ad-7d01-e401-14c3-3bc4e9f88b54@redhat.com>
Subject: Re: [PATCH v2 03/22] maint: Allow for EXAMPLES in texi2pod
References: <20181215135324.152629-1-eblake@redhat.com>
 <20181215135324.152629-4-eblake@redhat.com>
 <1ab7fd0f-fc28-6ff0-286e-27b966f85404@virtuozzo.com>
In-Reply-To: <1ab7fd0f-fc28-6ff0-286e-27b966f85404@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/18/18 7:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.12.2018 16:53, Eric Blake wrote:
>> The next commit will add an EXAMPLES section to qemu-nbd.8;
>> for that to work, we need to recognize EXAMPLES in texi2pod,
>> and we need to make all man pages be regenerated since the
>> output of texi2pod can be different.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi \
>> +	qemu-monitor-info.texi scripts/texi2pod.pl
>> +qemu.1: qemu-option-trace.texi scripts/texi2pod.pl
>=20
> I think, no needs to add scripts/texi2pod.pl to both qemu.1: lines, as =
they should be
> merged anyway. And if you want to add line breaking anyway, it looks be=
tter to use one qemu.1:
> dependency line.

Easy to fix.

>=20
> On the other hand, it may be better to add MANS variable as subset of D=
OCS to combine all man page targets,
> and than do like $(MANS): scripts/texi2pod.pl.. (and recombine DOCS, us=
ing MANS ofcourse)
> Hm, and I don't see here docs/interop/qemu-ga-ref.7 and docs/interop/qe=
mu-qmp-ref.7,
> which exist in DOCS.

Oh, good point. The .txt files should also have the dependency - in
general, ALL generated documentation should depend on the generator, not
just the man pages.  I'll have to think about respinning this patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--12uPwV58ZLgFisTSsvAirTGwMBCXlaKye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwv8C8ACgkQ3g5py3or
ov2wMgf/UcO7fm8nr+JsVaLzGNIYcRkUM7kE0NAla0eLbX0uopcf8EhPaWPbyUgl
Dv6WWFht7dZVkexTGFsiMBF7O47Nz5uahqruFUZ9Oo1hpqQ9xIHzWUxQrAxhASRg
ij1aG8TYnbPjXuSeXRbDDrq2gMkAk8exYD/IIxkoC4t1uV5sdFuqEm2HBP9c7P/8
HMqidvaCi70d/lR2m+MAoAs6PNt89fLY/KGsK9o/PcDs07emWBwEN635OCaxIZy/
ioCCoH3YXIuWAkV9AAgafc7MrgjLC6lnSpaNWAvaGJIigFzw66/WjEGtxBFjxri1
i+OgJvK8GQVKFcQv8biECQJmCsOSqA==
=4PKp
-----END PGP SIGNATURE-----

--12uPwV58ZLgFisTSsvAirTGwMBCXlaKye--

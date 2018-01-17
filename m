Received: from eggs.gnu.org ([2001:4830:134:3::10]:34315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqCA-0003gp-1d
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqC6-0007QO-2x
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:04:10 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
	<eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
Date: Wed, 17 Jan 2018 10:03:36 -0600
MIME-Version: 1.0
In-Reply-To: <eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ug2MDbTfaIj2m2EUxwiYufa02fjBcSfwi"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ug2MDbTfaIj2m2EUxwiYufa02fjBcSfwi
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
Subject: Re: [PATCH v2 3/6] qapi: add nbd-server-remove
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-4-vsementsov@virtuozzo.com>
 <74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
 <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
 <d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
 <4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
 <79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
 <1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
 <eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
In-Reply-To: <eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> I have a script (for managing libvirt guest, but it can be adopted fo=
r
>>> qemu or even used for qemu monitor), which allows
>>> me run qmp commands on vms as easy as:
>>>
>>> |qmp VMNAME query-block-jobs or qmp VMNAME nbd-server-remove name exp=
1
>>> mode hard or even |
>>>
>>> |qmp VMNAME blockdev-add id disk driver qcow2 cache {writeback true
>>> direct true} aio native discard unmap file {driver file filename
>>> /tmp/somedisk} |||
>> Yeah, there are various scripting solutions around QMP that can make i=
t
>> easier; but HMP is often still an easy front-line interface for
>> experiments.
>>
>=20
> isn't it because these solutions are not available directly in monitor,=

> when HMP is?

QMP can be directly accessed in a monitor; it just requires more typing.
 If you are developing QMP commands, it may be easier to use
=2E/scripts/qmp/qmp-shell (couple it with a readline wrapper, and you can=

even get tab-completion and history across sessions).  There's also
things like libvirt's 'virsh qmp-monitor-command' for shell-scripting
access to arbitrary QMP commands, provided your guest is run by libvirt.

> may be, we need third type of monitor HQMP which is QMP with simplified=

> syntax? Or
> allow qmp commands in simplified syntax directly in HMP?

No, I don't think we need either thing.  Wrappers around existing
monitors is better than bloating qemu proper with a third flavor of
monitor.  And HMP is for humans, with no restrictions on back-compat
changes, so if it doesn't do something you want for quick-and-dirty
testing, you can either add a new HMP command, or just use QMP (or one
of its wrappers, like qmp-shell) in the first place.  Ultimately, our
long-term concern is only about the QMP interface; HMP is supposed to be
convenient.  So if it starts costing too much time to port a QMP
interface to HMP, then don't worry about it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ug2MDbTfaIj2m2EUxwiYufa02fjBcSfwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfc9gACgkQp6FrSiUn
Q2qUDgf/Y+1dDbAAnDs993FsgyZVrH4vpUQayUklikqw7EGcRb5psnl9HKry2co2
CGKC+ZM7kPW9aNbBy9+0Owlwcqok/lhx663YencZgLJ44KvaaZTYMwIPE3iyT/US
BjeIDIXrb5lcfFFCOu8amKvPYqcCIq0Y+2tSxDEJ2hzq6/2qLpKJGZ343IKXhqmw
1DtKgG21RKP1toQ4y6L6DM8NLr/AfAnk0/r6HB0P+rQ4uJ3OAOjWzevMctNSNoyR
QUEODpE6Oy1B+4jVsVat55L7eW96JKURBdSFmklkQCMd2Qi6adogYqxmFTP9x+lW
S8E9VuUT2n1fKg0lpCDvQYzHnqIBDw==
=J8fT
-----END PGP SIGNATURE-----

--Ug2MDbTfaIj2m2EUxwiYufa02fjBcSfwi--

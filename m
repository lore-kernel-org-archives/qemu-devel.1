Received: from eggs.gnu.org ([2001:4830:134:3::10]:49753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNHs2-0006LL-03
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNHs0-0008EQ-KA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:07:29 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-43-kwolf@redhat.com>
	<49ee7d19-779d-cc1b-12a4-e4be14dc0a0f@redhat.com>
	<20180517135049.GC4080@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d4df86c9-31ed-915e-aaa1-73445d23178f@redhat.com>
Date: Mon, 28 May 2018 15:07:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180517135049.GC4080@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JI1KScsUkqVtlHXJY3SayfLf2U4xPPJ7Y"
Subject: Re: [Qemu-devel] [PATCH 42/42] qemu-iotests: Test job-* with block
 jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JI1KScsUkqVtlHXJY3SayfLf2U4xPPJ7Y
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org
Message-ID: <d4df86c9-31ed-915e-aaa1-73445d23178f@redhat.com>
Subject: Re: [PATCH 42/42] qemu-iotests: Test job-* with block jobs
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-43-kwolf@redhat.com>
 <49ee7d19-779d-cc1b-12a4-e4be14dc0a0f@redhat.com>
 <20180517135049.GC4080@localhost.localdomain>
In-Reply-To: <20180517135049.GC4080@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-17 15:50, Kevin Wolf wrote:
> Am 15.05.2018 um 01:44 hat Max Reitz geschrieben:
>> On 2018-05-09 18:26, Kevin Wolf wrote:
>>> This adds a test case that tests the new job-* QMP commands with
>>> mirror and backup block jobs.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/219     | 201 ++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/219.out | 327 +++++++++++++++++++++++++++++++++++=
++++++++++
>>>  tests/qemu-iotests/group   |   1 +
>>>  3 files changed, 529 insertions(+)
>>>  create mode 100755 tests/qemu-iotests/219
>>>  create mode 100644 tests/qemu-iotests/219.out
>=20
>>> +Pause/resume in READY
>>> +=3D=3D=3D Testing block-job-pause/block-job-resume =3D=3D=3D
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
>>> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u=
'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
>>> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +=3D=3D=3D Testing block-job-pause/job-resume =3D=3D=3D
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
>>> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u=
'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
>>> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +=3D=3D=3D Testing job-pause/block-job-resume =3D=3D=3D
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
>>> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u=
'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
>>> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +=3D=3D=3D Testing job-pause/job-resume =3D=3D=3D
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
>>> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u=
'total-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>> +{u'return': {}}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
>>> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>>
>> This is really, really mean.  Don't you have any compassion with the
>> poor little job that just wants to have Feierabend?
>>
>> It worked so hard and it's always on standby and instantly ready when
>> you need it.  Yet, you keep it hanging.  That's not nice.
>=20
> If you just mean that I do some testing with the poor job before I
> complete it, then I'm afraid the job will have to suffer this.
>=20
> But if you have a more serious concern, I don't see it. Isn't the job
> properly completed in the end, as the following lines show?

No, I was just making fun of the standby <-> ready transition. :-)

Max

>>> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in stat=
e 'ready' cannot accept command verb 'finalize'"}}
>>> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in stat=
e 'ready' cannot accept command verb 'dismiss'"}}
>>> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in stat=
e 'ready' cannot accept command verb 'finalize'"}}
>>> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in stat=
e 'ready' cannot accept command verb 'dismiss'"}}
>>> +{u'return': {}}
>>> +
>>> +Waiting for PENDING state...
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHA=
NGE'}
>>> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'dat=
a': {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}=

>>> +{u'return': []}
>=20
> Kevin
>=20



--JI1KScsUkqVtlHXJY3SayfLf2U4xPPJ7Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsL/wAACgkQ9AfbAGHV
z0Aczwf/eZb6BpYuRrbu11Ved+80MzYd06uFtPRo+pQKpnDDeG6F+QJobRkQMMSj
OB8CQZIVWOTG5qQeuKEfgrp0jnXm8vpeSrv2qFhXDOKbiJ0x0TVde9GBICh/2yFg
G50z0z+jR1G6cKEMLsUAGWMSs/ZFdiTqZspgwVJ8B8VqYT009FhbDfuZo1fxZ4U0
/FQEcshsHVFViTwnB1/cyCfZKWfRdPs9ERe2D8V5QfcWOVbND3tv3uvS2fAUXtZR
c6vGrkUrxXJ9EYccBniCFgFefpR3Zhoto0IQd/2hV7RGi9GCLlHD314iAyf7Nb5x
Iz4D9hZc7Pk9mkY21eqYNgMdzD/kkQ==
=oOaU
-----END PGP SIGNATURE-----

--JI1KScsUkqVtlHXJY3SayfLf2U4xPPJ7Y--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgDBT-0002AP-MW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgDBN-00088K-Qt
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:20:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgDBN-000887-Hy
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:20:53 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8760k3zteg.fsf@dusky.pond.sub.org>
	<3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
	<87fuj7r61e.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f72d07f6-e00d-8a9c-0e15-e2bab5b83ee2@redhat.com>
Date: Tue, 21 Feb 2017 10:20:50 -0600
MIME-Version: 1.0
In-Reply-To: <87fuj7r61e.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nmx9uJTmioONh5scc0bNjkd6uTl2nSGFg"
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nmx9uJTmioONh5scc0bNjkd6uTl2nSGFg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "eddie . dong" <eddie.dong@intel.com>, qemu devel <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>
Message-ID: <f72d07f6-e00d-8a9c-0e15-e2bab5b83ee2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <8760k3zteg.fsf@dusky.pond.sub.org>
 <3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
 <87fuj7r61e.fsf@dusky.pond.sub.org>
In-Reply-To: <87fuj7r61e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:07 AM, Markus Armbruster wrote:
> Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:
>=20
>> On 02/21/2017 07:15 PM, Markus Armbruster wrote:
>>> Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:
>>>
>>>> We can call this qmp command to do checkpoint outside of qemu.
>>>> Xen colo will need this function.
>>> I know nothing about "Xen colo", but I'll try anyway.
>>>
>>> I *guess* "Xen colo" is a long-running activity, and the new commands=

>>> interact with it.  Correct?
>>
>> Yes, you are right.
>=20
> We need to build a generic framework for interacting with long-running
> activities.  But asking you to wait for it wouldn't be fair.
>=20
>> By the way this patch has been reviewed by Eric black.
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03435.html=


Blake, but you're not the first to mis-type it.

>>>> +{
>>>> +    Error *err =3D NULL;
>>>> +    ReplicationResult *result =3D g_new0(ReplicationResult, 1);
>>>> +    replication_get_error_all(&err);
>>>> +    result->status =3D err ?
>>>> +                     REPLICATION_STATUS_ERROR :
>>>> +                     REPLICATION_STATUS_NORMAL;
>>> Reports only that there is an error, throws away the actual error
>>> message.  Naive question: could the error message be good to know for=

>>> the QMP user?
>>
>> Yes, Xen colo will handle it.
>=20
> Is that "yes, the QMP user could use the error message, but we're not
> giving it to him regardless", or "no, the QMP user does not need to
> know, and that's because we don't give it to him"?
>=20
> Even if we want QMP clients to treat all errors the same, transmitting
> the error message can still be useful for troubleshooting.

Ah, as in:

if (err) {
  result->status =3D REPLICATION_STATUS_ERROR;
  result->has_desc =3D true;
  result->desc =3D ...extract string from err
} else {
  result->status =3D REPLICATION_STATUS_NORMAL;
}

by modifying the JSON [1]

>>>> +##
>>>> +{ 'enum': 'ReplicationStatus',
>>>> +  'data': [ 'error', 'normal' ] }
>>> Do you expect more status values in the future?
>>>
>>> If yes, what should clients do when they see a status value they don'=
t
>>> know?
>>
>> We will add other status for it, now, that's enough.
>=20
> What should a QMP client do when it sees a ReplicationStatus value othe=
r
> than 'error' and 'normal'?
>=20
> You need to provide some guidance, or else you won't be able to add
> status values without breaking clients!
>=20
>>> If no, why not simply use bool?

Off-hand, what other states do you envision adding?

>>>
>>>> +
>>>> +##
>>>> +# @ReplicationResult:
>>>> +#
>>>> +# The result format for 'query-xen-replication-status'.
>>>> +#
>>>> +# @status: enum of @ReplicationStatus, which shows current
>>>> +#          replication error status
>>>> +#
>>>> +# Since: 2.9
>>>> +##
>>>> +{ 'struct': 'ReplicationResult',
>>>> +  'data': { 'status': 'ReplicationStatus'} }

[1] the modification would be:

'data': { 'status': 'ReplicationStatus', '*desc': 'str' }

with documentation that @desc is #optional, is only for human
consumption, and is only present when @status indicates an error.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nmx9uJTmioONh5scc0bNjkd6uTl2nSGFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGjiAAoJEKeha0olJ0NqmrgH/RsGgjbs68qpzEtXOYins27M
/NhzVbzig4MmvP2eAvIV9DqI+u/zlazlFpQkmzzBUV7+joaYsQOVl5i8FZnSscYC
jYoUaEiCwHK8O2ttdFj4rIu+3sQ8Sa0XcqRig28sLUCATTGry/equ+hbTqPdYLkO
2+7rdLKB+b1Hj7yL9kAeBtDeVfuDDW66TK/0Yq3E2JL5gBZ2qq59bpPf2rV/xYQb
2zvL6Sg06BQi6SLhgEoOpT7qE4+JhQmuGAd7PTDLghSzafX6RwDiZR1lY7QYrHjd
monFwqat9EUsG1it0uJIlW84UHF5HXJIJTORk2USc0saSWkcTFK3aLmlYm5BwPY=
=G+Jt
-----END PGP SIGNATURE-----

--nmx9uJTmioONh5scc0bNjkd6uTl2nSGFg--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6IXh-0007sj-1p
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6IXd-0005TS-Pi
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6IXd-0005Su-Fl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:19:41 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
	<25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
	<c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
	<04bf2bd9-54af-161f-6fc6-e0fcd5c05406@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34550398-7d98-cc5c-8646-f6399f3833a6@redhat.com>
Date: Thu, 4 May 2017 10:19:37 -0500
MIME-Version: 1.0
In-Reply-To: <04bf2bd9-54af-161f-6fc6-e0fcd5c05406@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IBRb76onE63xffwiNMdhTmL6q5ntdxTf1"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IBRb76onE63xffwiNMdhTmL6q5ntdxTf1
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <34550398-7d98-cc5c-8646-f6399f3833a6@redhat.com>
Subject: Re: [PATCH v3 2/4] fsdev: QMP interface for throttling
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
 <4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
 <25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
 <c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
 <04bf2bd9-54af-161f-6fc6-e0fcd5c05406@huawei.com>
In-Reply-To: <04bf2bd9-54af-161f-6fc6-e0fcd5c05406@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 10:12 AM, Pradeep Jagadeesh wrote:

>>>>> +    IOThrottle throttle =3D {
>>>>> +        .has_id =3D true,
>>>>> +        .id =3D (char *) qdict_get_str(qdict, "id"),
>>>>> +        .bps =3D qdict_get_int(qdict, "bps"),
>>>>> +        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
>>>>> +        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
>>>>> +        .iops =3D qdict_get_int(qdict, "iops"),
>>>>> +        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
>>>>> +        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
>>>>
>>>> Again, don't you need to be setting .has_bps=3Dtrue and so on?
>>> Same as above. I have not set any max burst values here, because I
>>> wanted to keep it in line with the block device.
>>> May be there is a room to enable these max values in both in future.
>>
>> I don't think you were getting the point of my question. Since 'bps' i=
s
>> an optional member of struct IOThrottle, you have to set 'has_bps' at
>> the same time to make it obvious that 'bps' should affect things.
>>
> I need some more clarifications here.
> I did not understand what do you mean by an optional parameter?
> You mean I need to set "has_*" for all the parameters?

Yes, any optional parameter (one named '*foo' in the .json file) has a
counterpart has_foo boolean, which should be set to true when the
parameter is in use (and thus making it obvious when it is set to false
that it is not in use).

>> I understand that you aren't setting 'bps_max', nor it's counterpart
>> 'has_bps_max', and that's not what I was asking about.
>>
>>
>>>>> +++ b/qapi/iothrottle.json
>>>>> @@ -3,6 +3,7 @@
>>>>>  ##
>>>>>  # =3D=3D QAPI IOThrottle definitions
>>>>>  ##
>>>>> +##
>>>>>  # @IOThrottle:
>>>>
>>>> This looks like a spurious change
>>> You mean the below sentence is not required?
>>
>> No, the above addition of a second ## is not required.
> If I remove that I will get the compilation error.
> I think the parser needs that.

If the parser chokes without it, then that implies patch 1 is broken,
and the fix should be squashed there for full bisectability.  Either
way, it looks like a spurious change when it is occurring in patch 3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IBRb76onE63xffwiNMdhTmL6q5ntdxTf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC0aJAAoJEKeha0olJ0NqZ8AH/1KbiC47tRUeCe6UfOZIPkaa
nfrvt8wjo0jKaqJVnIKSeBzJkrJgu+PEch+CsvB8o9YRC5ra7hPl4eT+JFs2IPF+
+WFyMTR3WxZZop/6jDriLYsAYoASBpYfjfr6qb5QFaRvKhT/zWwEAMRpa8J47OSf
NDypkFJv+wEGmlNK3QGIVEAdISYgL8tkvban5HE+RdGtbeiwksHc1rySztdRFu8F
7Txh10BRFjaavcG02ZUxiu51cE8wavZ8Q+IvOVQUgvMj8Tmb+hsNiMNj2f+PI6ag
rgHuwcr+unHeiWoPjA4zFkUC2Et66U9el28hedX8ScN23b5D2l9h2+6qYEzhT9w=
=8J0/
-----END PGP SIGNATURE-----

--IBRb76onE63xffwiNMdhTmL6q5ntdxTf1--

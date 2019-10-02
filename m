Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0AC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0C720659
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0C720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdwQ-0001HQ-B1
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFdvd-0000nQ-Ot
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFdvc-0000eU-EZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFdvZ-0000ap-DD; Wed, 02 Oct 2019 08:40:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A90D307C826;
 Wed,  2 Oct 2019 12:40:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC627196B2;
 Wed,  2 Oct 2019 12:40:18 +0000 (UTC)
Subject: Re: [PATCH 17/22] iotests: Add VM.assert_block_path()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-18-mreitz@redhat.com>
 <de0a9fe2-ea84-7be9-6911-b806f032cfff@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <b977e9f8-53f0-290e-5eb5-73c02469779b@redhat.com>
Date: Wed, 2 Oct 2019 14:40:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <de0a9fe2-ea84-7be9-6911-b806f032cfff@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RdFQ80n6QeHWfvZXZVdfHBbDJzYuPu36o"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 02 Oct 2019 12:40:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RdFQ80n6QeHWfvZXZVdfHBbDJzYuPu36o
Content-Type: multipart/mixed; boundary="2oYAA26s1UPMNEsnP29t6yJIdQPM3j8XK"

--2oYAA26s1UPMNEsnP29t6yJIdQPM3j8XK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.09.19 16:07, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:27, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 48 +++++++++++++++++++++++++++++++++=
++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index daed4ee013..e6fb46287d 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -670,6 +670,54 @@ class VM(qtest.QEMUQtestMachine):
>>  =20
>>           return fields.items() <=3D ret.items()
>>  =20
>> +    '''
>> +    @path is a string whose components are separated by slashes.
>> +    The first component is a node name, the rest are child names.
>> +    Examples:
>> +      - "qcow2-node/backing/file"
>> +      - "quorum-node/children.2/file"
>=20
> Possibly, separting node-name to first parameter and keeping child-path=
 as
> a second will simplify code a bit, and be more useful for cases when on=
 caller
> part node-name is in variable.

Sounds good.

>> +
>> +    @expected_node may be None.
>> +
>> +    @graph may be None or the result of an x-debug-query-block-graph
>> +    call that has already been performed.
>> +    '''
>> +    def assert_block_path(self, path, expected_node, graph=3DNone):
>> +        if graph is None:
>> +            graph =3D self.qmp('x-debug-query-block-graph')['return']=

>=20
> Yay! I'm happy to see that it's useful.

:-)

It=E2=80=99s probably the best query function we have.

>> +
>> +        iter_path =3D iter(path.split('/'))
>> +        root =3D next(iter_path)
>> +        try:
>> +            node =3D next(node for node in graph['nodes'] if node['na=
me'] =3D=3D root)
>> +        except StopIteration:
>> +            node =3D None
>=20
> for such usage next has second optional argument: next(iterator[, defau=
lt])

Great!

> (don't think I teach you Python, actually you teach me, as before I did=
n't know
> correct way to search first element with condition)

We learn from one another, which is the best case.

>> +
>> +        for path_node in iter_path:
>> +            assert node is not None, 'Cannot follow path %s' % path
>> +
>> +            try:
>> +                node_id =3D next(edge['child'] for edge in graph['edg=
es'] \
>> +                                             if edge['parent'] =3D=3D=
 node['id'] and
>> +                                                edge['name'] =3D=3D p=
ath_node)
>=20
> Hmm here you allow default StopIteration exception [1]
>=20
>=20
>> +
>> +                node =3D next(node for node in graph['nodes'] \
>> +                                 if node['id'] =3D=3D node_id)
>> +            except StopIteration:
>> +                node =3D None
>=20
> actually, I think this will never happen, so we may simplify code and a=
llow it to
> throw StopIteration exception in this impossible case..

This is for a use case where the next child simply doesn=E2=80=99t exist,=
 so you
can do:

assert_block_path('qcow2-node/backing', None)

To verify that the qcow2 node has no backing file.

>> +
>> +        assert node is not None or expected_node is None, \
>> +               'No node found under %s (but expected %s)' % \
>> +               (path, expected_node)
>=20
> node may be None here only from last iteration, but it can't happen: if=
 we have edge
> with child, we'll for sure have node with such node-name in graph

node will always be set by the try-except block, won=E2=80=99t it?

>> +
>> +        assert expected_node is not None or node is None, \
>> +               'Found node %s under %s (but expected none)' % \
>> +               (node['name'], path)
>=20
> hmm, so expected_node=3DNone means we want to prove that there is no su=
ch node? It should
> be mentioned in comment above the function. But this don't work due to =
[1]

Hm, I seem to remember I tested all cases locally and they all worked.

Max

>> +
>> +        if node is not None and expected_node is not None:
>> +            assert node['name'] =3D=3D expected_node, \
>> +                   'Found node %s under %s (but expected %s)' % \
>> +                   (node['name'], path, expected_node)
>>  =20
>>   index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>>  =20
>>
>=20
>=20



--2oYAA26s1UPMNEsnP29t6yJIdQPM3j8XK--

--RdFQ80n6QeHWfvZXZVdfHBbDJzYuPu36o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UmrEACgkQ9AfbAGHV
z0BniAgAtDr3hLIeR3XjAlaelmoSZv90Oo3d1R9tQmm2WattY0y1mELPWNFMbnZe
kFDfo7a8AL+6N3fsBQP+NXOFcDdc4MD7QVONa6DecFJ+fQTXOrjtxgi2b16qBGtt
JGSXs0B5c5FOLesnOndKNo2XbO342TG9IN0TTll23vds0zXeDAAKn+W37rZho0qQ
KlKReXxeQVE4TT9/FUjFnVEN/kHFCanL1j9KHe/5hkeEO5qompbA/kwkMFzaHSVx
Srvt2FnPOgZNc0Z6/bCvtapMAD3cdA7Qk7ig2RfHecznCPfpROmlgS/nasOtBtET
6TRjE8Qouq5VgX2Jmxho+Zz7E1VX5A==
=7RB5
-----END PGP SIGNATURE-----

--RdFQ80n6QeHWfvZXZVdfHBbDJzYuPu36o--


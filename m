Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE78C04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994612077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSShsaRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994612077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKke-0001Bx-5q
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ieKgY-000507-UM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ieKgV-0002hB-Ff
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:10:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ieKgV-0002gw-7n
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575904250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ntErCLuWdVYTlhCfpxHzq3YbNwT+dO+0Z2GL10MVMBs=;
 b=FSShsaRbVA3IfLbegJgh2W3JcOgGGft4UnkJloUtelt1nn8NZHft6VDeHFqX2BS6GeVrOy
 ILZseUgSEsod4rf9zfCU3+fowiO7fkZOipaeTz9+sKvBcAzP/INex2oLVPCQSNFbNJRsOk
 OGWY+5gY7xcpGda7rbVBqbutdARYWAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-9GfCdNoVMjOJeqj6uHhm1Q-1; Mon, 09 Dec 2019 10:10:46 -0500
X-MC-Unique: 9GfCdNoVMjOJeqj6uHhm1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B78593A2;
 Mon,  9 Dec 2019 15:10:45 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0A8D5D6C5;
 Mon,  9 Dec 2019 15:10:43 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-19-mreitz@redhat.com>
 <12688028-7bce-228a-4046-f886ac32cf4d@virtuozzo.com>
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
Message-ID: <9c1e5973-aef5-20f3-86fd-1515e2977316@redhat.com>
Date: Mon, 9 Dec 2019 16:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <12688028-7bce-228a-4046-f886ac32cf4d@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="usCWNJVCeUSZfZhvDSD23tMmTmOqDFYa7"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
--usCWNJVCeUSZfZhvDSD23tMmTmOqDFYa7
Content-Type: multipart/mixed; boundary="A7LlWobqL23kSzQhUFh7qjQBSYGdu5Qgj"

--A7LlWobqL23kSzQhUFh7qjQBSYGdu5Qgj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.12.19 13:59, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:02, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 59 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.=
py
>> index d34305ce69..3e03320ce3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -681,6 +681,65 @@ class VM(qtest.QEMUQtestMachine):
>>  =20
>>           return fields.items() <=3D ret.items()
>>  =20
>> +    """
>> +    Check whether the node under the given path in the block graph is
>> +    @expected_node.
>> +
>> +    @root is the node name of the node where the @path is rooted.
>> +
>> +    @path is a string that consists of child names separated by
>> +    slashes.  It must begin with a slash.
>=20
> Why do you need this slash?

I don=92t.  It just looked better to me.

(One reason would be so it could be empty to refer to @root, but as I
said that isn=92t very useful.)

> To stress that we are starting from root?
> But root is not global, it's selected by previous argument, so for me the
> path is more like relative than absolute..
>=20
>> +
>> +    Examples for @root + @path:
>> +      - root=3D"qcow2-node", path=3D"/backing/file"
>> +      - root=3D"quorum-node", path=3D"/children.2/file"
>> +
>> +    Hypothetically, @path could be empty, in which case it would point
>> +    to @root.  However, in practice this case is not useful and hence
>> +    not allowed.
>=20
> 1. path can't be empty, as accordingly to previous point, it must start w=
ith '/'

Hence =93hypothetically=94.

> 2. path can be '/', which does exactly what you don't allow, and I don't =
see,
> where it is restricted in code

No, it doesn=92t.  That refers to a child of @root with an empty name.

>> +
>> +    @expected_node may be None.
>=20
> Which means that, we assert existence of the path except its last element=
,
> yes? Worth mention this behavior here.

=93(All elements of the path but the leaf must still exist.)=94?  OK.

>> +
>> +    @graph may be None or the result of an x-debug-query-block-graph
>> +    call that has already been performed.
>> +    """
>> +    def assert_block_path(self, root, path, expected_node, graph=3DNone=
):
>> +        if graph is None:
>> +            graph =3D self.qmp('x-debug-query-block-graph')['return']
>> +
>> +        iter_path =3D iter(path.split('/'))
>> +
>> +        # Must start with a /
>> +        assert next(iter_path) =3D=3D ''
>> +
>> +        node =3D next((node for node in graph['nodes'] if node['name'] =
=3D=3D root),
>> +                    None)
>> +
>> +        for path_node in iter_path:
>> +            assert node is not None, 'Cannot follow path %s' % path
>> +
>> +            try:
>> +                node_id =3D next(edge['child'] for edge in graph['edges=
'] \
>> +                                             if edge['parent'] =3D=3D n=
ode['id'] and
>> +                                                edge['name'] =3D=3D pat=
h_node)
>> +
>> +                node =3D next(node for node in graph['nodes'] \
>> +                                 if node['id'] =3D=3D node_id)
>=20
> this line cant fail. If it fail, it means a bug in x-debug-query-block-gr=
aph, so,
> I'd prefer to move it out of try:except block.

But that makes the code uglier, in my opinion.  We=92d then have to set
node_id to e.g. None in the except branch (or rather just abolish the
try-except then) and check whether it=92s None before assigning node.
Like this:

node_id =3D next(..., None)

if node_id is not None:
    node =3D next(...)
else:
    node =3D None

I prefer the current try-except construct over that.

>> +            except StopIteration:
>> +                node =3D None
>> +
>> +        assert node is not None or expected_node is None, \
>> +               'No node found under %s (but expected %s)' % \
>> +               (path, expected_node)
>> +
>> +        assert expected_node is not None or node is None, \
>> +               'Found node %s under %s (but expected none)' % \
>> +               (node['name'], path)
>> +
>> +        if node is not None and expected_node is not None:
>=20
> [1]
> second part of condition already asserted by previous assertion

Yes, but I wanted to cover all four cases explicitly.  (In the usual 00,
01, 10, 11 manner.  Well, except it=92s 10, 01, 11, 00.)

>> +            assert node['name'] =3D=3D expected_node, \
>> +                   'Found node %s under %s (but expected %s)' % \
>> +                   (node['name'], path, expected_node)
>=20
> IMHO, it would be easier to read like:
>=20
>            if node is None:
>                assert  expected_node is None, \
>                   'No node found under %s (but expected %s)' % \
>                   (path, expected_node)
>            else:
>                assert expected_node is not None, \
>                   'Found node %s under %s (but expected none)' % \
>                   (node['name'], path)
>=20
>                assert node['name'] =3D=3D expected_node, \
>                       'Found node %s under %s (but expected %s)' % \
>                       (node['name'], path, expected_node)
>=20
> Or even just
>=20
>            if node is None:
>                assert expected_node is None, \
>                   'No node found under %s (but expected %s)' % \
>                   (path, expected_node)
>            else:
>                assert node['name'] =3D=3D expected_node, \
>                       'Found node %s under %s (but expected %s)' % \
>                       (node['name'], path, expected_node)

Works for me, too.

> (I've checked:
>  >>> 'erger %s erg' % None
> 'erger None erg'
>=20
> Also, %-style formatting is old, as I understand it's better always use .=
format()
> )

OK.

Max

>>  =20
>>   index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
>>  =20
>>



--A7LlWobqL23kSzQhUFh7qjQBSYGdu5Qgj--

--usCWNJVCeUSZfZhvDSD23tMmTmOqDFYa7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3uY/EACgkQ9AfbAGHV
z0CMPggAtNQ48VtSdYl/9Zz5NS7gaVeb6TC/s+QGptvU0T0ND0x8mCdf0eWD/TSW
1bcNxhSOtksdg8Whc6H/XNnpuF5dHTgGrHsMYtr+bD0StuD9oCeuiLDAqOwdOumI
/yU1SkYucBbGLq3hfB4GXBSGARfrw8ZQli8uQnfZw3wsH8f0rUyExdwcNqGFuiyV
dpIdt3vMCZbtsmZ91r1l98pemUJjSqT2j0kGci8hnK862nezC2lhboyD1EoZ2RMG
lm9Uv8g9MS7oxpdoCuOEL60MkazsLAGESDMZdj1jqAAAOJiQflEwVy2SRTEDxqff
cPTwX0lUDEiBgkFHMlaARZCoB7SB3Q==
=Irh8
-----END PGP SIGNATURE-----

--usCWNJVCeUSZfZhvDSD23tMmTmOqDFYa7--



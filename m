Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33586C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088B2206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088B2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzi1-0008Sj-2G
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAzgZ-0006ze-07
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAzgX-0002pX-QK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAzeZ-0001uV-15; Thu, 19 Sep 2019 12:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56246315C030;
 Thu, 19 Sep 2019 16:51:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 184B41001947;
 Thu, 19 Sep 2019 16:51:29 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-5-mreitz@redhat.com>
 <19f8eac0-7722-4894-72bb-df7501ca20ef@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <737afcda-cbfd-2699-72f1-6775ff0f3169@redhat.com>
Date: Thu, 19 Sep 2019 18:51:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <19f8eac0-7722-4894-72bb-df7501ca20ef@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2lNDZeKlvC08ZJHdTAWm2NLzYvinuIfco"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 19 Sep 2019 16:51:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lNDZeKlvC08ZJHdTAWm2NLzYvinuIfco
Content-Type: multipart/mixed; boundary="W87L3RQSMP4SxpT88nYEJcjCXBJL1olZC";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <737afcda-cbfd-2699-72f1-6775ff0f3169@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-5-mreitz@redhat.com>
 <19f8eac0-7722-4894-72bb-df7501ca20ef@virtuozzo.com>
In-Reply-To: <19f8eac0-7722-4894-72bb-df7501ca20ef@virtuozzo.com>

--W87L3RQSMP4SxpT88nYEJcjCXBJL1olZC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 18:30, Vladimir Sementsov-Ogievskiy wrote:
> 12.09.2019 16:56, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/041     | 44 ++++++++++++++++++++++++++++++++++++=
++
>>   tests/qemu-iotests/041.out |  4 ++--
>>   2 files changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index 8568426311..84bc6d6581 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -1121,6 +1121,50 @@ class TestOrphanedSource(iotests.QMPTestCase):
>>                                target=3D'dest-ro')
>>           self.assert_qmp(result, 'error/class', 'GenericError')
>>  =20
>> +    def test_failing_permission_in_complete(self):
>> +        self.assert_no_active_block_jobs()
>> +
>> +        # Unshare consistent-read on the target
>> +        # (The mirror job does not care)
>> +        result =3D self.vm.qmp('blockdev-add',
>> +                             driver=3D'blkdebug',
>> +                             node_name=3D'dest-perm',
>> +                             image=3D'dest',
>> +                             unshare_child_perms=3D['consistent-read'=
])
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'job', dev=
ice=3D'src',
>> +                             sync=3D'full', target=3D'dest',
>> +                             filter_node_name=3D'mirror-filter')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # Require consistent-read on the source
>> +        # (We can only add this node once the job has started, or it
>> +        # will complain that it does not want to run on non-root node=
s)
>> +        result =3D self.vm.qmp('blockdev-add',
>> +                             driver=3D'blkdebug',
>> +                             node_name=3D'src-perm',
>> +                             image=3D'src',
>> +                             take_child_perms=3D['consistent-read'])
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # While completing, mirror will attempt to replace src by
>> +        # dest, which must fail because src-perm requires
>> +        # consistent-read but dest-perm does not share it; thus
>> +        # aborting the job when it is supposed to complete
>> +        self.complete_and_wait('job',
>> +                               completion_error=3D'Operation not perm=
itted')
>> +
>> +        # Assert that all of our nodes are still there (except for th=
e
>> +        # mirror filter, which should be gone despite the failure)
>> +        nodes =3D self.vm.qmp('query-named-block-nodes')['return']
>> +        nodes =3D list(map(lambda image: image['node-name'], nodes))
>=20
> using list comprehension is a bit more pythonic:
> nodes =3D [node['node-name'] for node in nodes]

OK.  I can never remember, so I rarely bother using list/dict
comprehensions and instead use what I would do in any other language.
(Hence the =E2=80=9CSadly=E2=80=9D from John.)

(And then wait for some kind reviewer to tell me how to do it right. :-))=


Max


--W87L3RQSMP4SxpT88nYEJcjCXBJL1olZC--

--2lNDZeKlvC08ZJHdTAWm2NLzYvinuIfco
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2DshAACgkQ9AfbAGHV
z0ADogf8CZX9vVSKJvh99pDyP28dNTi67M1FQ88+YEm1EoMI3ekxaM1bnvuo8XY5
BK/ZhhsCeuTuw3cA80jWgWW8t37qut44o9yWgN41116XsPEI02DdgN+pIBdj5zLD
4xAIVAVpuy0GDA39kR9qt5F+t6TWUZg6msp6LoTae8xzYkVaO/7Gs9WzWbt3HfBL
zlOf2zDSNyhdRtOQz2FGAOgIArGKoEwMh5dEJHRT5he31EVbkQHQg3BVgberu2En
j6Ui7UO1CJTnQ1NeI04iV06/haMWBbhSgBxC/lSdXxJ3xuKnpUWpv0NMM/UEvku9
j55MTwQ1TwcnlG21moYgvlxoa/MVHw==
=31il
-----END PGP SIGNATURE-----

--2lNDZeKlvC08ZJHdTAWm2NLzYvinuIfco--


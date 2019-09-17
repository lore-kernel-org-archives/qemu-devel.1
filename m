Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DEDC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09EA214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09EA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABLZ-00087W-Ut
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iABKF-0006iM-8Z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iABKD-00009H-VN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iABKA-00007j-TF; Tue, 17 Sep 2019 07:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2984A18CB8E8;
 Tue, 17 Sep 2019 11:07:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-130.ams2.redhat.com
 [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B412260BEC;
 Tue, 17 Sep 2019 11:07:03 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <44f97011-4a02-7832-c253-d43474f79d44@redhat.com>
 <a829185c-7c09-5afe-1479-15054ad59807@redhat.com>
 <33f60f4e-8156-e46f-8500-79b0982348b2@redhat.com>
 <c38acedf-d3db-384f-4aea-967ef3f87fdd@redhat.com>
 <20190917084012.GA4824@localhost.localdomain>
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
Message-ID: <e9c8a9f5-80d9-b003-8036-0ba8df352ec3@redhat.com>
Date: Tue, 17 Sep 2019 13:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917084012.GA4824@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IxHe2Xgu81VyP4J42d6DTiCxZkA0gg7jB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 17 Sep 2019 11:07:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] iotests: Test driver whitelisting
 in 093
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IxHe2Xgu81VyP4J42d6DTiCxZkA0gg7jB
Content-Type: multipart/mixed; boundary="fbPMqeG4CcdtLEmuaLLmChdoUp6haTHGx";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e9c8a9f5-80d9-b003-8036-0ba8df352ec3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/8] iotests: Test driver whitelisting in
 093
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <44f97011-4a02-7832-c253-d43474f79d44@redhat.com>
 <a829185c-7c09-5afe-1479-15054ad59807@redhat.com>
 <33f60f4e-8156-e46f-8500-79b0982348b2@redhat.com>
 <c38acedf-d3db-384f-4aea-967ef3f87fdd@redhat.com>
 <20190917084012.GA4824@localhost.localdomain>
In-Reply-To: <20190917084012.GA4824@localhost.localdomain>

--fbPMqeG4CcdtLEmuaLLmChdoUp6haTHGx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.09.19 10:40, Kevin Wolf wrote:
> Am 17.09.2019 um 10:18 hat Max Reitz geschrieben:
>> On 13.09.19 20:30, John Snow wrote:
>>>
>>>
>>> On 9/13/19 8:47 AM, Max Reitz wrote:
>>>> On 20.08.19 23:32, John Snow wrote:
>>>>>
>>>>>
>>>>> On 8/19/19 4:18 PM, Max Reitz wrote:
>>>>>> null-aio may not be whitelisted.  Skip all test cases that require=
 it.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>  tests/qemu-iotests/093 | 12 +++++++++---
>>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
>>>>>> index 50c1e7f2ec..f03fa24a07 100755
>>>>>> --- a/tests/qemu-iotests/093
>>>>>> +++ b/tests/qemu-iotests/093
>>>>>> @@ -24,7 +24,7 @@ import iotests
>>>>>>  nsec_per_sec =3D 1000000000
>>>>>> =20
>>>>>>  class ThrottleTestCase(iotests.QMPTestCase):
>>>>>> -    test_img =3D "null-aio://"
>>>>>> +    test_driver =3D "null-aio"
>>>>>>      max_drives =3D 3
>>>>>> =20
>>>>>>      def blockstats(self, device):
>>>>>> @@ -35,10 +35,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
>>>>>>                  return stat['rd_bytes'], stat['rd_operations'], s=
tat['wr_bytes'], stat['wr_operations']
>>>>>>          raise Exception("Device not found for blockstats: %s" % d=
evice)
>>>>>> =20
>>>>>> +    def required_drivers(self):
>>>>>> +        return [self.test_driver]
>>>>>> +
>>>>>> +    @iotests.skip_if_unsupported(required_drivers)
>>>>>
>>>>> Oh, I see why you're passing args[0] back to the callback now. Why =
not
>>>>> just pass self.required_drivers and call it with no arguments inste=
ad?
>>>>>
>>>>> You can get a bound version that way that doesn't need additional
>>>>> arguments, and then the callback is free to take generic callables =
of
>>>>> any kind.
>>>>
>>>> Am I doing something wrong?
>>>>
>>>> I just get
>>>>
>>>> +Traceback (most recent call last):
>>>> +  File "093", line 26, in <module>
>>>> +    class ThrottleTestCase(iotests.QMPTestCase):
>>>> +  File "093", line 41, in ThrottleTestCase
>>>> +    @iotests.skip_if_unsupported(self.required_drivers)
>>>> +NameError: name 'self' is not defined
>>>>
>>>> this way.
>>>>
>>>> Max
>>>>
>>> What was I even talking about? :\ Well.
>>>
>>> I'd still like to define func_wrapper with a nod to the type constrai=
nt
>>> it has:
>>>
>>> def func_wrapper(instance: iotests.QMPTestCase, *args, **kwargs):
>>>     [...]
>>>
>>>
>>> Then, you'd write:
>>>
>>> if callable(required_formats):
>>>     fmts =3D required_formats(instance)
>>> else:
>>>     fmts =3D required_formats
>>
>> Yep, that anyway.  (Although I didn=E2=80=99t know about the =E2=80=9C=
param: type=E2=80=9D
>> syntax and put that constraint in a comment instead.  Thanks again :-)=
)
>=20
> Note that function annotations are Python 3 only, so we can't use that
> syntax yet anyway. If you want to use type hints that are understood by=

> tools (like mypy) and compatible with Python 2, you have to use
> something like this (feel free to be more specific than Any):

Do we really feel like staying compatible with Python 2, though?

Max


--fbPMqeG4CcdtLEmuaLLmChdoUp6haTHGx--

--IxHe2Xgu81VyP4J42d6DTiCxZkA0gg7jB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2AvlYACgkQ9AfbAGHV
z0Cfcwf/UDTZRGAjPTLJTYVgUoP66G3ljPNjGT0Fn285OR9SfzikZXmqb57RwyzR
fsxZUszKR16EkkvxUCS2Pz4psfZ4IOIDcxxJPJV+zNisxbwuRb3ajSidnCHq2qwS
REX7vnfqgdNjEF1dblOfanr4bmM7B4hYjjA7Qh68IdcTXlkwNKwGc/lpC/Ya8OAC
kGGjqhgOYMMWxOSrNdSLhzoNb4orU9Z8zI/XQvOodhwBkLvXwAIC7mIlgr8XsY7O
NXRh7ahO3dCuZxowwUL/0nce/8q48vqqKGMMtrVtI3mO5505EJQQFoxGMRZoiXv1
M2GsDCz+EDjX7KigRcxS8IPUZx4scw==
=p5Fy
-----END PGP SIGNATURE-----

--IxHe2Xgu81VyP4J42d6DTiCxZkA0gg7jB--


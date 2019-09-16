Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B87C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC2D20650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC2D20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ltF-0004Mj-SK
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9lry-0003Od-VH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9lrx-0004Tm-GU
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9lru-0004SD-Kh; Mon, 16 Sep 2019 03:56:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 13DFD308FB82;
 Mon, 16 Sep 2019 07:56:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B1E319C69;
 Mon, 16 Sep 2019 07:56:12 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-4-mreitz@redhat.com>
 <d5231f69-9c50-c1d8-6680-5e835b907861@redhat.com>
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
Message-ID: <b90d6736-0f55-e0af-4969-a800f391c8b7@redhat.com>
Date: Mon, 16 Sep 2019 09:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d5231f69-9c50-c1d8-6680-5e835b907861@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Voh4Zbb0nAQrUJg74US17TxP6LjTEAq5"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 16 Sep 2019 07:56:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] iotests: Add @error to
 wait_until_completed
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Voh4Zbb0nAQrUJg74US17TxP6LjTEAq5
Content-Type: multipart/mixed; boundary="6l7OmEkOtp2WY7FYLOJEiIpYMujnsh3Xc";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <b90d6736-0f55-e0af-4969-a800f391c8b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] iotests: Add @error to
 wait_until_completed
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-4-mreitz@redhat.com>
 <d5231f69-9c50-c1d8-6680-5e835b907861@redhat.com>
In-Reply-To: <d5231f69-9c50-c1d8-6680-5e835b907861@redhat.com>

--6l7OmEkOtp2WY7FYLOJEiIpYMujnsh3Xc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.09.19 00:53, John Snow wrote:
>=20
>=20
> On 9/12/19 9:56 AM, Max Reitz wrote:
>> Callers can use this new parameter to expect failure during the
>> completion process.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index b26271187c..300347c7c8 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -745,15 +745,20 @@ class QMPTestCase(unittest.TestCase):
>>          self.assert_no_active_block_jobs()
>>          return result
>> =20
>> -    def wait_until_completed(self, drive=3D'drive0', check_offset=3DT=
rue, wait=3D60.0):
>> +    def wait_until_completed(self, drive=3D'drive0', check_offset=3DT=
rue, wait=3D60.0,
>> +                             error=3DNone):
>>          '''Wait for a block job to finish, returning the event'''
>>          while True:
>>              for event in self.vm.get_qmp_events(wait=3Dwait):
>>                  if event['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
>>                      self.assert_qmp(event, 'data/device', drive)
>> -                    self.assert_qmp_absent(event, 'data/error')
>> -                    if check_offset:
>> -                        self.assert_qmp(event, 'data/offset', event['=
data']['len'])
>> +                    if error is None:
>> +                        self.assert_qmp_absent(event, 'data/error')
>> +                        if check_offset:
>> +                            self.assert_qmp(event, 'data/offset',
>> +                                            event['data']['len'])
>> +                    else:
>> +                        self.assert_qmp(event, 'data/error', error)
>>                      self.assert_no_active_block_jobs()
>>                      return event
>>                  elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
>> @@ -771,7 +776,8 @@ class QMPTestCase(unittest.TestCase):
>>          self.assert_qmp(event, 'data/type', 'mirror')
>>          self.assert_qmp(event, 'data/offset', event['data']['len'])
>> =20
>> -    def complete_and_wait(self, drive=3D'drive0', wait_ready=3DTrue):=

>> +    def complete_and_wait(self, drive=3D'drive0', wait_ready=3DTrue,
>> +                          completion_error=3DNone):
>>          '''Complete a block job and wait for it to finish'''
>>          if wait_ready:
>>              self.wait_ready(drive=3Ddrive)
>> @@ -779,7 +785,7 @@ class QMPTestCase(unittest.TestCase):
>>          result =3D self.vm.qmp('block-job-complete', device=3Ddrive)
>>          self.assert_qmp(result, 'return', {})
>> =20
>> -        event =3D self.wait_until_completed(drive=3Ddrive)
>> +        event =3D self.wait_until_completed(drive=3Ddrive, error=3Dco=
mpletion_error)
>>          self.assert_qmp(event, 'data/type', 'mirror')
>> =20
>>      def pause_wait(self, job_id=3D'job0'):
>>
>=20
> toot toot more optional parameters. lay them at the altar of
> noncommittal python design.
>=20
> I completely forget what the difference between unittest.TestCase and
> qtest.QEMUQtestMachine is and why they each have job management methods=
=2E
>=20
> Well, OK: the VM one is a simple subclass of the general-purpose VM
> machine to add some more useful stuff. the unittest one implements some=

> general-purpose behavior with asserts that only work in the unittest wo=
rld.

Yes.  run_job doesn=E2=80=99t assert anything (well, I could check the re=
turned
error, but that=E2=80=99s it), it=E2=80=99s just based on comparison to t=
he reference
output.  That=E2=80=99s not so useful for unittest-style tests, so it=E2=80=
=99s better
to use complete_and_wait() etc. there.

> Still,
>=20
> It's a little fun that we've got run_job as well as cancel_and_wait,
> wait_until_completed, wait_ready, wait_ready_and_cancel, pause_wait and=

> pause_job and they all seem to implement job run-state logic management=

> a little differently.

At the end of the day, it=E2=80=99s all just test code.  It doesn=E2=80=99=
t hurt too
much for it to have duplicated code and be generally messy.

> Probably no bugs there, I bet.

Hm.  The functions are not that complex.

> *cough* Not your fault, anyway, so please take this accolade:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

> (it's probably my fault)

I can only imagine by nonassistance of code in danger.

Max


--6l7OmEkOtp2WY7FYLOJEiIpYMujnsh3Xc--

--8Voh4Zbb0nAQrUJg74US17TxP6LjTEAq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1/QBkACgkQ9AfbAGHV
z0D+awgAqN2U9gKf0LxXPY44gvh1/iLAkohq5VVsMckE5WTaP1zfMh2B4281vsl7
ME3tRiJ5cNDHwbvRa+7L2Tma+VFRND6lIGE1NjhGjeoY+IdE9qeWoApbp6/QnZH0
+RsjbPPcyLyKmlv8F/oz+6PppNqdG8b0E2xd9eNYZMDFQjq8s66OR2n3EsXwT4Ds
pi1mP0IJfiht7zMcyEY0YW1MH/Xd/PI8lceedcul9t4KFQUjOTrgj5gAOPSbDv//
+fHtFcMceVDn/diMp7GffYd9Shpz8ld8AcB7yrUzMqpE07ZDCimNSrlR1GzTMkYQ
EDHayFJzGsS2G5j7Fd6YBYZjQrxUzQ==
=YSfM
-----END PGP SIGNATURE-----

--8Voh4Zbb0nAQrUJg74US17TxP6LjTEAq5--


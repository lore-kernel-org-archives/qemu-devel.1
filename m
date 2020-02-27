Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC8C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B2724690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF96ur5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B2724690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HbH-0000FZ-JA
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j7HaS-00081G-7O
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j7HaQ-0008EJ-ST
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:44:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j7HaQ-0008DW-Mc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582803853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mVAijbFMH7tp+OZflEQdz9v2BTV+r6r+3eM1lKQyZ78=;
 b=gF96ur5ram/b95quhzIzxrZYV7bNuZn85RTMx4c230DVFo+RaAAQmUZ5ck/R1IQOP7B1gG
 ivz2ZqdxDs2FvtuZRFlwQ/P4SwLs9J3iIr+5iZsE//NcPjiJZK5g1FA9MkZjBXfUrfSawi
 j+WV3ZwOdX1KCMQo4OsECBeLYYsbDKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-tu-TDkykMESv8mWim3Oyrg-1; Thu, 27 Feb 2020 06:44:10 -0500
X-MC-Unique: tu-TDkykMESv8mWim3Oyrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA74A8017CC;
 Thu, 27 Feb 2020 11:44:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7A98C09E;
 Thu, 27 Feb 2020 11:44:08 +0000 (UTC)
Subject: Re: [PATCH 1/2] iotests: add JobRunner class
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200226004425.1303-1-jsnow@redhat.com>
 <20200226004425.1303-2-jsnow@redhat.com>
 <689f4a10-b1f2-14f9-c759-13e7447bd5b3@redhat.com>
 <92f0a28b-8fb9-13d1-7fd4-27f36c977902@redhat.com>
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
Message-ID: <8b6281dd-c218-1cdb-6370-f49e8d92a4d8@redhat.com>
Date: Thu, 27 Feb 2020 12:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <92f0a28b-8fb9-13d1-7fd4-27f36c977902@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JTVonAiUtg3chHhgJNh59X4M00hfAZtLr"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JTVonAiUtg3chHhgJNh59X4M00hfAZtLr
Content-Type: multipart/mixed; boundary="jS23NDVrHtuauffieqljpgD9zvJcnk6M4"

--jS23NDVrHtuauffieqljpgD9zvJcnk6M4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.02.20 18:58, John Snow wrote:
>=20
>=20
> On 2/26/20 6:18 AM, Max Reitz wrote:
>> On 26.02.20 01:44, John Snow wrote:
>>> The idea is that instead of increasing the arguments to job_run all the
>>> time, create a more general-purpose job runner that can be subclassed t=
o
>>> do interesting things with.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/255        |   9 +-
>>>  tests/qemu-iotests/257        |  12 ++-
>>>  tests/qemu-iotests/287        |  19 +++-
>>>  tests/qemu-iotests/iotests.py | 176 ++++++++++++++++++++++++----------
>>>  4 files changed, 158 insertions(+), 58 deletions(-)
>>
>> I like it!
>>
>=20
> High praise!
>=20
>> [...]
>>
>>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>>> index 0ab58dc011..f06e6ff084 100755
>>> --- a/tests/qemu-iotests/287
>>> +++ b/tests/qemu-iotests/287
>>> @@ -165,13 +165,22 @@ def test_bitmap_populate(config):
>>>                  if not config.disabled:
>>>                      ebitmap.dirty_group(2)
>>> =20
>>> +
>>> +        class TestJobRunner(iotests.JobRunner):
>>> +            def on_pending(self, event):
>>> +                if config.mid_writes:
>>> +                    perform_writes(drive0, 2)
>>> +                    if not config.disabled:
>>> +                        ebitmap.dirty_group(2)
>>
>> I actually prefer inlining the pre_finalize() functions (over calling
>> the existing one), but then we can also remove the original function. :)
>>
>=20
> Not sure I understand you correctly. You're saying you prefer this
> strategy where I inline the logic vs others where I call out to a functio=
n?

Yes.

> If so, I agree if only for purity -- the function looks and acts like a
> callback instead of a callback-that-calls-another-callback.

That was my thinking.

>>> +                super().on_pending(event)
>>> +
>>>          job =3D populate(drive0, 'target', 'bitpop0')
>>>          assert job['return'] =3D=3D {'return': {}}
>>> -        vm.run_job(job['id'],
>>> -                   auto_dismiss=3Djob['auto-dismiss'],
>>> -                   auto_finalize=3Djob['auto-finalize'],
>>> -                   pre_finalize=3Dpre_finalize,
>>> -                   cancel=3Dconfig.cancel)
>>> +        job_runner =3D TestJobRunner(vm, job['id'],
>>> +                                   auto_dismiss=3Djob['auto-dismiss'],
>>> +                                   auto_finalize=3Djob['auto-finalize'=
],
>>> +                                   cancel=3Dconfig.cancel)
>>> +        job_runner.run()
>>>          log('')
>>> =20
>>> =20
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
>>> index 3390fab021..37a8b4d649 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -460,6 +460,130 @@ def remote_filename(path):
>>>      else:
>>>          raise Exception("Protocol %s not supported" % (imgproto))
>>> =20
>>> +
>>> +class JobRunner:
>>
>> [...]
>>
>>> +    def on_ready(self, event):
>>> +        if self.logging:
>>> +            self._vm.qmp_log('job-complete', id=3Dself._id)
>>> +        else:
>>> +            self._vm.qmp('job-complete', id=3Dself._id)
>>
>> I suppose this is a bug fix.  (The old version always called qmp_log.)
>>
>=20
> Technically yes. It was needed for 040.
>=20
>> But what about adding a do_qmp method to JobRunner that does the
>> =E2=80=9Cif self.logging { self._vm.qmp_log() } else { self._vm.qmp }=E2=
=80=9D part so
>> we don=E2=80=99t have to inline that everywhere?
>>
>> Max
>>
>=20
> I'll just clean up the logging series I had to do it at a more
> fundamental level.

OK.  So you=E2=80=99re looking to basically get VM.qmp() to log automatical=
ly if
necessary?  (or maybe qmp_log() to not log unless necessary)

Max


--jS23NDVrHtuauffieqljpgD9zvJcnk6M4--

--JTVonAiUtg3chHhgJNh59X4M00hfAZtLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5Xq4YACgkQ9AfbAGHV
z0DCsQf8DYANl6fitOngx5fqNkfr6gBdy8DTyOtM8f22O622T7v0y0KObJz5/6up
gEje7qrO6t2sD9r2pypnDeRGkVa7IAWPYRHQDriQkeQ6cZmM0mN70r5ZGTSWFj2I
yd6Xt2vXvDfiZm7wo+xrTxhXZhpRdIqcAsMWBqO9JK/pt4mEszEMaRl9YvcvvgT/
cEltXKTP0UqyS4AhJks7mEBfN1Oa/jBAX1KJjIs7TaTNpHrkxfXdjzxueWkB3GMC
Fjptrz4BGJgyKgAALyp07qz348e7LYScFtViWI+VMSL9A7ccTnKqvzcZmd/PW6E1
kowpAD92VtbyPqYxvo4lBeccZxeCcg==
=XEz1
-----END PGP SIGNATURE-----

--JTVonAiUtg3chHhgJNh59X4M00hfAZtLr--



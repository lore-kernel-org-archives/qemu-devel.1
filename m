Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF4C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4CD207F7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 07:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXJEvLh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4CD207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtDJ-0003Zo-MS
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 03:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kNtCh-00034X-UA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 03:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kNtCf-00053D-P6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 03:40:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601538036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cXL0I/fRYR1Peco1QZ92XUhHYwy7y7PdBg9VZK97YMc=;
 b=gXJEvLh3NmEzNlxTbQEu++V/4Xv0G7mpbkMSToci1x6/O/c/fUZkJiRWE5GbcX0PMhZQGW
 raniBWIRtGe07iBRnoIBW2fF2gKqWYd3Ds5xfYAh7UNh+8jd196LfwATYtKB7jkVxR4i4T
 sTAVMtqXlsxgr8YhdpKUAqyCpK7R8rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-6XGPYG5HOQOF3mcnpcHB0Q-1; Thu, 01 Oct 2020 03:40:32 -0400
X-MC-Unique: 6XGPYG5HOQOF3mcnpcHB0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86EAA1868414;
 Thu,  1 Oct 2020 07:40:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-181.ams2.redhat.com
 [10.36.113.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 720185C1CF;
 Thu,  1 Oct 2020 07:40:25 +0000 (UTC)
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
 <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
 <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
 <d36a27c8-0f2c-ede5-6f97-e134093dcf6e@redhat.com>
 <9d324820-cb15-84a6-574d-f92846e16928@virtuozzo.com>
 <09045b49-f4e8-8989-09b5-aa3538b507fc@virtuozzo.com>
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
Message-ID: <2efb10c1-8863-b3e5-3f6e-d57644fc2d2a@redhat.com>
Date: Thu, 1 Oct 2020 09:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <09045b49-f4e8-8989-09b5-aa3538b507fc@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NY4RQMEWn4xmY72U0f5FYjOqb8g7i92M0"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NY4RQMEWn4xmY72U0f5FYjOqb8g7i92M0
Content-Type: multipart/mixed; boundary="VxplUW2AznbQ7u45BYhbOV4wsLeHUHaFh"

--VxplUW2AznbQ7u45BYhbOV4wsLeHUHaFh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.20 17:32, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 18:11, Vladimir Sementsov-Ogievskiy wrote:
>> 25.09.2020 12:11, Max Reitz wrote:
>>> On 25.09.20 10:49, Vladimir Sementsov-Ogievskiy wrote:
>>>> 25.09.2020 11:26, Max Reitz wrote:
>>>>> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy
>>>>>> <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 tests/qemu-iotests/298=C2=A0=C2=A0=C2=A0=C2=A0 | 186
>>>>>> +++++++++++++++++++++++++++++++++++++
>>>>>> =C2=A0=C2=A0 tests/qemu-iotests/298.out |=C2=A0=C2=A0 5 +
>>>>>> =C2=A0=C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>> =C2=A0=C2=A0 3 files changed, 192 insertions(+)
>>>>>> =C2=A0=C2=A0 create mode 100644 tests/qemu-iotests/298
>>>>>> =C2=A0=C2=A0 create mode 100644 tests/qemu-iotests/298.out
>>>
>>> [...]
>>>
>>>>>> +class TestTruncate(iotests.QMPTestCase):
>>>>>
>>>>> The same decorator could be placed here, although this class doesn=E2=
=80=99t
>>>>> start a VM, and so is unaffected by the allowlist.=C2=A0 Still may be
>>>>> relevant in case of block modules, I don=E2=80=99t know.
>>>>
>>>> Or just global test skip at file top
>>>
>>> Hm.=C2=A0 Like verify_quorum()?=C2=A0 Is there a generic function for t=
hat
>>> already?
>>>
>>> [...]
>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Probably we'll want pr=
eallocate filter to keep align to
>>>>>> cluster when
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # shrink preallocation, =
so, ignore small differece
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertLess(abs(stat=
.st_size - refstat.st_size), 64 *
>>>>>> 1024)
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Preallocate filter may=
 leak some internal clusters (for
>>>>>> example, if
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # guest write far over E=
OF, skipping some clusters - they
>>>>>> will remain
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # fallocated, preallocat=
e filter don't care about such
>>>>>> leaks, it drops
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # only trailing prealloc=
ation.
>>>>>
>>>>> True, but that isn=E2=80=99t what=E2=80=99s happening here.=C2=A0 (We=
 only write 10M at
>>>>> 0, so
>>>>> there are no gaps.)=C2=A0 Why do we need this 1M margin?
>>>>
>>>> We write 10M, but qcow2 also writes metadata as it wants
>>>
>>> Ah, yes, sure.=C2=A0 Shouldn=E2=80=99t result in 1M, but why not.
>>>
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertLess(abs(stat=
.st_blocks - refstat.st_blocks) *
>>>>>> 512,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10=
24 * 1024)
>>>>>
>>>>> [...]
>>>>>
>>>>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>>>>> index ff59cfd2d4..15d5f9619b 100644
>>>>>> --- a/tests/qemu-iotests/group
>>>>>> +++ b/tests/qemu-iotests/group
>>>>>> @@ -307,6 +307,7 @@
>>>>>> =C2=A0=C2=A0 295 rw
>>>>>> =C2=A0=C2=A0 296 rw
>>>>>> =C2=A0=C2=A0 297 meta
>>>>>> +298 auto quick
>>>>>
>>>>> I wouldn=E2=80=99t mark it as quick, there is at least one preallocat=
e=3Dfull of
>>>>> 140M, and one of 40M, plus multiple 10M data writes and falloc
>>>>> preallocations.
>>>>>
>>>>> Also, since you mark it as =E2=80=9Cauto=E2=80=9D, have you run this =
test on all
>>>>> CI-relevant hosts?=C2=A0 (Among other things I can=E2=80=99t predict)=
 I wonder how
>>>>> preallocation behaves on macOS.=C2=A0 Just because that one was alway=
s a
>>>>> bit
>>>>> weird about not-really-data areas.
>>>>>
>>>>
>>>> Ofcourse, I didn't run on all hosts. I'm a bit out of sync about this.=
.
>=20
> Sorry, I see now that it sounds rude.

I found it completely understandable, because I share the same
sentiment.  It=E2=80=99s the reason I=E2=80=99m so hesitant adding tests to=
 auto.

>>> Well, someone has to do it.=C2=A0 The background story is that tests ar=
e
>>> added to auto all the time (because =E2=80=9Cwhy not=E2=80=9D), and the=
n they fail on
>>> BSD or macOS.=C2=A0 We have BSD docker test build targets at least, so =
they
>>> can be easily tested.=C2=A0 (Well, it takes like half an hour, but you =
know.)
>>>
>>> (We don=E2=80=99t have macOS builds, as far as I can tell, but I person=
ally
>>> don=E2=80=99t even know why we run the iotests on macOS at all.=C2=A0 (=
Well, I also
>>> wonder about the BSDs, but given the test build targets, I shouldn=E2=
=80=99t
>>> complain, I suppose.))
>>>
>>> (Though macOS isn=E2=80=99t part of the gating CI, is it?=C2=A0 I seem =
to remember
>>> macOS errors are generally only reported to me half a week after the
>>> pull request is merged, which is even worse.)
>>>
>>> Anyway.=C2=A0 I just ran the test for OpenBSD
>>> (EXTRA_CONFIGURE_OPTS=3D'--target-list=3Dx86_64-softmmu' \
>>> =C2=A0=C2=A0=C2=A0 make vm-build-openbsd)
>>
>> Oh, I didn't know that it's so simple.

It kind of is simple, but it still takes so long that I don=E2=80=99t consi=
der
it simple.

>> What another things you are
>> running before sending a PULL?

Actually, I=E2=80=99m not running any of the vm-build-* targets.  (If I did=
, I
wouldn=E2=80=99t have to ask you whether you did, because I=E2=80=99d just =
run them
anyway and then tell you about any potential failures.)

I compile everything on Fedora and Arch (x86-64), -m32 and -m64, clang
and gcc, and one time with mingw.  I run make check on everything but
mingw, and then run the following iotests on Fedora gcc-m64 and Arch
clang-m32 (on tmpfs):

-qcow2 -x auto, -qcow2 -o compat=3D0.10, -qcow2 -o refcount_bits=3D1,
-qcow2 -o data_file=3D'$TEST_IMG.ext_data_file', -nbd, -raw, -luks, -vmdk,
-vhdx, -qcow, -vdi, -vpc, -qed, -cloop, -parallels, -bochs

And on non-tmpfs: -c none -qcow2 142 199

(At some point that meant that all iotests that don=E2=80=99t require root =
are
at least run once.  I should check whether that=E2=80=99s still the case, I
suppose...)

>>> and got some failures:
>>>
>>> --- /home/qemu/qemu-test.PGo2ls/src/tests/qemu-iotests/298.out=C2=A0 Fr=
i Sep
>>> 25 07:10:31 2020
>>> +++ /home/qemu/qemu-test.PGo2ls/build/tests/qemu-iotests/298.out.bad
>>> Fri Sep 25 08:57:56 2020
>>> @@ -1,5 +1,67 @@
>>> -.............
>>> +qemu-io: Failed to resize underlying file: Unsupported preallocation
>>> mode: falloc
>=20
> [..]
>=20
>>> -OK
>>> +FAILED (failures=3D6)
>>>
>>>> If I don't put new test in "auto", is there any chance that test would
>>>> be automatically run somewhere?
>>>
>>> I run all tests before pull requests at least.
>>>
>=20
> OK, so it doesn't work on BSD at all. I don't really want to
> investigate, but seems it's because of absence of fallocate. So let's
> drop "auto" group.

I=E2=80=99d be OK with that.

> Another thing: maybe, add auto-linux test group for running only in
> linux-build? So, new tests will be added to it because why not, and we
> will not bother with BSD and MacOS?

We have _supported_os in bash tests and supported_platforms in Python
tests, so if you want a test in auto but run it only on Linux, you can
specify that there.

Max


--VxplUW2AznbQ7u45BYhbOV4wsLeHUHaFh--

--NY4RQMEWn4xmY72U0f5FYjOqb8g7i92M0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl91h+cACgkQ9AfbAGHV
z0AiAgf+NlfT+iO9X1SMrpkESetZk/oFL2sPB9ukW1R71PKwKFYfncxHvB13btTc
ATwA1CGkE7MnoOOV3nLJWLHMHPWkFsKVm8zl+JKanx5XoU072Uxkf3q5+WyqkgRR
DCEJntxE5HHwD8nfttzS2idEDthlJlj8+eO/KW5oXTBQIZ9azQyivL2e1RLUDADJ
yQtGQ4bNK4q1QsxRo+dV2xJEir/gXf942NZHCZxKbUvOsH/n2q6krSVWmhvkuAkQ
cjp3lceY+0gp8AO8omaOyNkHOxNDNDRSzhwavOw/dwvRH1OhJ98TEISNL08T4oqz
5Q1dcxOeeClco5rtMUkyagf3VnDOUA==
=hbHX
-----END PGP SIGNATURE-----

--NY4RQMEWn4xmY72U0f5FYjOqb8g7i92M0--



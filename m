Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F697C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB3B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuLK51J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB3B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjn4-0006qv-BS
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLjll-00057J-EF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLjlj-0007uw-C3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:11:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601025114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9ystAv+0v/nlnX9GNJ6gaDGICgwZ4J3YwxnSH82OSRg=;
 b=iuLK51J1tVw8zBNjl/0MnfnOsTVl/gNtepLvUmyQxqLenk3UmeHVmsP3kZdL01BRw52uc7
 XIFpQOhj7suis9GjZYiO6rUch4gZ+vnPXraAvTvmdHrJw9f1Zsph4Rwla9LgNzctExVhJk
 vEOZokGPHfRMXGXAW9VsaN11V17eISU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-R_24nVMaPtefeJ5yBuP2WA-1; Fri, 25 Sep 2020 05:11:52 -0400
X-MC-Unique: R_24nVMaPtefeJ5yBuP2WA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AB0C188C132;
 Fri, 25 Sep 2020 09:11:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-113.ams2.redhat.com
 [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 376635D9F1;
 Fri, 25 Sep 2020 09:11:46 +0000 (UTC)
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
 <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
 <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
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
Message-ID: <d36a27c8-0f2c-ede5-6f97-e134093dcf6e@redhat.com>
Date: Fri, 25 Sep 2020 11:11:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LT6oe7aTsO845J6aZMtPytF6V5XB5oPeu"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
--LT6oe7aTsO845J6aZMtPytF6V5XB5oPeu
Content-Type: multipart/mixed; boundary="jgT40TOTtdRRaaO4cTluHxTivqDJPxBDZ"

--jgT40TOTtdRRaaO4cTluHxTivqDJPxBDZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.20 10:49, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 11:26, Max Reitz wrote:
>> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 tests/qemu-iotests/298=C2=A0=C2=A0=C2=A0=C2=A0 | 186 +++++++++++=
++++++++++++++++++++++++++
>>> =C2=A0 tests/qemu-iotests/298.out |=C2=A0=C2=A0 5 +
>>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 3 files changed, 192 insertions(+)
>>> =C2=A0 create mode 100644 tests/qemu-iotests/298
>>> =C2=A0 create mode 100644 tests/qemu-iotests/298.out

[...]

>>> +class TestTruncate(iotests.QMPTestCase):
>>
>> The same decorator could be placed here, although this class doesn=E2=80=
=99t
>> start a VM, and so is unaffected by the allowlist.=C2=A0 Still may be
>> relevant in case of block modules, I don=E2=80=99t know.
>=20
> Or just global test skip at file top

Hm.  Like verify_quorum()?  Is there a generic function for that already?

[...]

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Probably we'll want preal=
locate filter to keep align to
>>> cluster when
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # shrink preallocation, so,=
 ignore small differece
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertLess(abs(stat.st=
_size - refstat.st_size), 64 * 1024)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Preallocate filter may le=
ak some internal clusters (for
>>> example, if
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # guest write far over EOF,=
 skipping some clusters - they
>>> will remain
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # fallocated, preallocate f=
ilter don't care about such
>>> leaks, it drops
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # only trailing preallocati=
on.
>>
>> True, but that isn=E2=80=99t what=E2=80=99s happening here.=C2=A0 (We on=
ly write 10M at 0, so
>> there are no gaps.)=C2=A0 Why do we need this 1M margin?
>=20
> We write 10M, but qcow2 also writes metadata as it wants

Ah, yes, sure.  Shouldn=E2=80=99t result in 1M, but why not.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertLess(abs(stat.st=
_blocks - refstat.st_blocks) * 512,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1024 =
* 1024)
>>
>> [...]
>>
>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>> index ff59cfd2d4..15d5f9619b 100644
>>> --- a/tests/qemu-iotests/group
>>> +++ b/tests/qemu-iotests/group
>>> @@ -307,6 +307,7 @@
>>> =C2=A0 295 rw
>>> =C2=A0 296 rw
>>> =C2=A0 297 meta
>>> +298 auto quick
>>
>> I wouldn=E2=80=99t mark it as quick, there is at least one preallocate=
=3Dfull of
>> 140M, and one of 40M, plus multiple 10M data writes and falloc
>> preallocations.
>>
>> Also, since you mark it as =E2=80=9Cauto=E2=80=9D, have you run this tes=
t on all
>> CI-relevant hosts?=C2=A0 (Among other things I can=E2=80=99t predict) I =
wonder how
>> preallocation behaves on macOS.=C2=A0 Just because that one was always a=
 bit
>> weird about not-really-data areas.
>>
>=20
> Ofcourse, I didn't run on all hosts. I'm a bit out of sync about this..

Well, someone has to do it.  The background story is that tests are
added to auto all the time (because =E2=80=9Cwhy not=E2=80=9D), and then th=
ey fail on
BSD or macOS.  We have BSD docker test build targets at least, so they
can be easily tested.  (Well, it takes like half an hour, but you know.)

(We don=E2=80=99t have macOS builds, as far as I can tell, but I personally
don=E2=80=99t even know why we run the iotests on macOS at all.  (Well, I a=
lso
wonder about the BSDs, but given the test build targets, I shouldn=E2=80=99=
t
complain, I suppose.))

(Though macOS isn=E2=80=99t part of the gating CI, is it?  I seem to rememb=
er
macOS errors are generally only reported to me half a week after the
pull request is merged, which is even worse.)

Anyway.  I just ran the test for OpenBSD
(EXTRA_CONFIGURE_OPTS=3D'--target-list=3Dx86_64-softmmu' \
   make vm-build-openbsd)
and got some failures:

--- /home/qemu/qemu-test.PGo2ls/src/tests/qemu-iotests/298.out  Fri Sep
25 07:10:31 2020
+++ /home/qemu/qemu-test.PGo2ls/build/tests/qemu-iotests/298.out.bad
Fri Sep 25 08:57:56 2020
@@ -1,5 +1,67 @@
-.............
+qemu-io: Failed to resize underlying file: Unsupported preallocation
mode: falloc
+qemu-io: Failed to resize underlying file: Unsupported preallocation
mode: falloc
+FFFF.F...F...
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_external_snapshot (__main__.TestPreallocateFilter)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "298", line 81, in test_external_snapshot
+    self.test_prealloc()
+  File "298", line 78, in test_prealloc
+    self.check_big()
+  File "298", line 48, in check_big
+    self.assertTrue(os.path.getsize(disk) > 100 * MiB)
+AssertionError: False is not true
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_prealloc (__main__.TestPreallocateFilter)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "298", line 78, in test_prealloc
+    self.check_big()
+  File "298", line 48, in check_big
+    self.assertTrue(os.path.getsize(disk) > 100 * MiB)
+AssertionError: False is not true
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_reopen_opts (__main__.TestPreallocateFilter)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "298", line 119, in test_reopen_opts
+    self.assertTrue(os.path.getsize(disk) =3D=3D 25 * MiB)
+AssertionError: False is not true
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_qemu_img (__main__.TestQemuImg)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "298", line 61, in test_qemu_img
+    self.check_big()
+  File "298", line 48, in check_big
+    self.assertTrue(os.path.getsize(disk) > 100 * MiB)
+AssertionError: False is not true
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_truncate_inside_preallocated_area__falloc
(__main__.TestTruncate)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "298", line 161, in test_truncate_inside_preallocated_area__falloc
+    self.do_test('falloc', '50M')
+  File "298", line 135, in do_test
+    self.assertEqual(ret, 0)
+AssertionError: 1 !=3D 0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_truncate_over_preallocated_area__falloc (__main__.TestTruncate)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "298", line 173, in test_truncate_over_preallocated_area__falloc
+    self.do_test('falloc', '150M')
+  File "298", line 135, in do_test
+    self.assertEqual(ret, 0)
+AssertionError: 1 !=3D 0
+
+----------------------------------------------------------------------
 Ran 13 tests

-OK
+FAILED (failures=3D6)

> If I don't put new test in "auto", is there any chance that test would
> be automatically run somewhere?

I run all tests before pull requests at least.

Max


--jgT40TOTtdRRaaO4cTluHxTivqDJPxBDZ--

--LT6oe7aTsO845J6aZMtPytF6V5XB5oPeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9ttFAACgkQ9AfbAGHV
z0DbNAgAqv+7kmKKnnNU+aCAmRMqOJrMevf9XeDUNbDBy3mj0EUxRwE8F1e5pL5B
NtBs7R+oQCzMPhD37SxHtvwl2gf/adPOedLNhdYFboVn7yVNk9RFGKiZkVXOz4Kt
yyhYJ7NflI2Lz/a/94NWDWsSKkl3KKXNbq5bbFQpOabhc0sIokZ1o0LcK1AaV0gQ
z0/aHImpTqvDvzxGstBvVgCDEYtcTz9GUMxmnL7/pQuNMIXN5M2AwYx0/JS/brCM
3U1RYdPY2zGkgMc2EOEnbJOykMN9P+AsWsUTpBT5xc2ir+dwW5Tv6VGguGiys7jU
16cgERQzTD7KY8AzjmKKVFjMUedn0A==
=MySr
-----END PGP SIGNATURE-----

--LT6oe7aTsO845J6aZMtPytF6V5XB5oPeu--



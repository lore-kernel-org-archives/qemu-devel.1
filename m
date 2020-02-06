Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA7C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D5220838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmtjJ0Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D5220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkYC-0002Ys-UU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izkVR-0008SQ-4r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izkVP-0001WP-63
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:59:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izkVP-0001W8-2g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581008394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oewBH/LhA5VoOQ5ylG31ANqoNUJmBZXkOWH6/UtIf8E=;
 b=GmtjJ0Y+W9zy4qpkdzeR9nQEXhJhN7zfx/PIWDYz5GZgFGNRnVP7N1Um75TZjlqcv8Fl5z
 RuNBsyJP8zEr2sP22Yz+j5dGoMHeCfqJt07/4TEVTSbisVWeYpY3IktD51Qum3EhBKtUzc
 T/kG+s3telvj4GJY6y27KkmW/DrBB70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-_JGj2rfhO-2cHLycGU6-wg-1; Thu, 06 Feb 2020 11:59:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08771005513;
 Thu,  6 Feb 2020 16:59:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E25AF1091ED3;
 Thu,  6 Feb 2020 16:59:33 +0000 (UTC)
Subject: Re: [PATCH] tests/qemu_iotests: Minimize usage of used ports
To: Eric Blake <eblake@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, qemu-block@nongnu.org
References: <20200203075955.28861-1-ldoktor@redhat.com>
 <fe6a7eb5-352a-3cb5-4e75-bd99baf6d54e@redhat.com>
 <595ffedf-4213-f000-96e1-3216e272b1c1@redhat.com>
 <726ca911-be83-c2d5-ff3f-efa32bc2233e@redhat.com>
 <797578d5-bfab-5eb7-8921-0fcf1f3ee40e@redhat.com>
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
Message-ID: <6dcc60d8-3f3f-46bc-e3ca-c0569f9b0e23@redhat.com>
Date: Thu, 6 Feb 2020 17:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <797578d5-bfab-5eb7-8921-0fcf1f3ee40e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _JGj2rfhO-2cHLycGU6-wg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.02.20 17:48, Eric Blake wrote:
> On 2/6/20 10:37 AM, Max Reitz wrote:
>=20
>>>
>>> thank you and I am sorry for not digging deep enough. This week my CI
>>> failed with:
>>>
>>> 01:24:06 DEBUG| [stdout] +ERROR: test_inet (__main__.QemuNBD)
>>> 01:24:06 DEBUG| [stdout]
>>> +----------------------------------------------------------------------
>>> 01:24:06 DEBUG| [stdout] +Traceback (most recent call last):
>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File "147", line 85, in setUp
>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self.vm.launch()
>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qemu=
/machine.py",
>>> line 302, in launch
>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self._launch()
>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qemu=
/machine.py",
>>> line 319, in _launch
>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self._pre_launch()
>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qemu=
/qtest.py",
>>> line 106, in _pre_launch
>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 super(QEMUQtestMachine,
>>> self)._pre_launch()
>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qemu=
/machine.py",
>>> line 270, in _pre_launch
>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self._qmp =3D
>>> qmp.QEMUMonitorProtocol(self._vm_monitor, server=3DTrue)
>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qemu=
/qmp.py",
>>> line 60, in __init__
>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self.__sock.bind(self.__ad=
dress)
>>> 01:24:06 DEBUG| [stdout] +OSError: [Errno 98] Address already in use
>=20
> Was this test 147?=C2=A0 If so, see:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg01469.html
>=20
> because that failure matches what I was seeing.
>=20
>>>
>>> I made the mistake of reproducing this on my home system using the
>>> qemu revision that I had and assuming it's caused by a used port. So
>>> I limited the port range and used nc to occupy the port. It sort-of
>>> reproduced but instead of Address already in use it hanged until I
>>> kill the nc process. Then it failed with:
>>>
>>> +Traceback (most recent call last):
>>> +=C2=A0 File "147", line 124, in test_inet
>>> +=C2=A0=C2=A0=C2=A0 flatten_sock_addr(address))
>>> +=C2=A0 File "147", line 59, in client_test
>>> +=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'return', {})
>>> +=C2=A0 File
>>> "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", line
>>> 821, in assert_qmp
>>> +=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
>>> +=C2=A0 File
>>> "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", line
>>> 797, in dictpath
>>> +=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s"' =
% (path,
>>> str(d)))
>>> +AssertionError: failed path traversal for "return" in "{'error':
>>> {'class': 'GenericError', 'desc': 'Failed to read initial magic:
>>> Unexpected end-of-file before all bytes were read'}}"
>>>
>=20
> That's a secondary failure, I assume if the initial bug is fixed we are
> less likely to hit the secondary one; but the secondary one may still be
> worth fixing.
>=20
>>> After a brief study I thought qemu is not doing the job well enough
>>> and wanted to add a protection. Anyway after a more thorough overview
>>> I came to a different conclusion and that is that we are facing the
>>> same issue as with incoming migration about a year ago. What happened
>>> is that I started "nc -l localhost 32789" which results in:
>>>
>>> COMMAND=C2=A0=C2=A0 PID=C2=A0 USER=C2=A0=C2=A0 FD=C2=A0=C2=A0 TYPE=C2=
=A0 DEVICE SIZE/OFF NODE NAME
>>> nc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26758 medic=C2=A0=C2=A0=C2=A0 3u=C2=A0=
 IPv6 9579487=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0t0=C2=A0 TCP localhost:32789
>>> (LISTEN)
>>>
>>> Then we start the server by "_try_server_up" where qemu-nbd detects
>>> the port is occupied on IPv6 but available on IPv4, so it claims it:
>>> COMMAND=C2=A0=C2=A0 PID=C2=A0 USER=C2=A0=C2=A0 FD=C2=A0=C2=A0 TYPE=C2=
=A0 DEVICE SIZE/OFF NODE NAME
>>> nc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26758 medic=C2=A0=C2=A0=C2=
=A0 3u=C2=A0 IPv6 9579487=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0t0=C2=A0 TCP
>>> localhost:32789 (LISTEN)
>>> qemu-nbd=C2=A0 26927 medic=C2=A0=C2=A0=C2=A0 4u=C2=A0 IPv4 9591857=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0t0=C2=A0 TCP
>>> localhost:32789 (LISTEN)
>>>
>>> and reports success. Then we try to connect but the hotplugged VM
>>> first attempts to connect on the IPv6 address and hangs for infinity.
>>>
>>> Now is this an expected behavior? If so then we need the
>>> find_free_address (but preferably directly in _try_server_up just
>>> before starting the qemu-nbd) to leave as little time-frame for
>>> collision as possible. Otherwise the test is alright and qemu-nbd
>>> needs a fix to bail out in case some address is already used (IIRC
>>> this is what incoming migration does).
>>
>> Ah, OK.
>>
>> Well, expected behavior...=C2=A0 It=E2=80=99s a shame, that=E2=80=99s wh=
at it is.
>=20
> In libnbd, we recently improved the testsuite by switching over to
> systemd-style fd passing: instead of asking qemu-nbd to open a random
> port (and hoping it is available), we instead pre-open the port (where
> failure is under our control) and then pass in that fd with environment
> variables to qemu-nbd, which in turn guarantees that qemu-nbd won't hit
> failures in trying to use the port.=C2=A0 Maybe we should utilize that mo=
re
> in qemu's own testsuite.

I suppose you=E2=80=99re welcome, but it sounds a bit like overkill for now=
. :-)

> Also, I need to revisit my proposed patches for letting qemu-nbd support
> TLS over Unix sockets, as that's another way to avoid TCP contention
> (right now, qemu has an anachronistic prohibition against the
> combination of TLS and Unix sockets).

147 specifically wants to test inet, though (among other things).
Support for TLS over Unix sockets won=E2=80=99t change that.  (I suppose it=
 will
reduce the number of inet NBD sockets in other tests, though.)

>>> My second mistake was testing this on the old code-base and rebasing
>>> it only before sending the patch (without testing after the rebase).
>>> If I were to test it first, I would have found out that the real
>>> reproducer is simply running the test as the commit
>>> 8dff69b9415b4287e900358744b732195e1ab2e2 broke it.
>>>
>>>
>>> So basically there are 2 actions:
>>>
>>> 1. fix the test as on my system it fails in 100% of cases, bisect
>>> says the first bad commit is
>>> 8dff69b9415b4287e900358744b732195e1ab2e2. Would anyone have time in
>>> digging into this? I already spent way too much time on this and
>>> don't really know what that commit is trying to do.
>>
>> Yep, I=E2=80=99ve sent a patch:
>>
>> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00294.html
>=20
> Ah, so we did notice the same problem.
>=20
>>
>>> 2. decide on the behavior when IPv4/6 is already in use (bail-out or
>>> start).
>>> 2a. In case it should bail-out than the test is correct and there is
>>> no need for my patch. On the other hand qemu-nbd has to be fixed
>>
>> I don=E2=80=99t think it makes much sense to let qemu=E2=80=99s NBD serv=
er ensure that
>> it claims both IPv4 and IPv6 in case the user specifies a
>> non-descriptive hostname.
>>
>>> 2b. Otherwise I can send a v2 that will check the port in the
>>> _try_server_up just before starting qemu-nbd to minimize the risk of
>>> using a utilized port (or should you decide it's not worth checking,
>>> I can simply forget about this)
>>
>> Hm.=C2=A0 It wouldn=E2=80=99t be fully reliable, but, well...=C2=A0 The =
risk would be
>> minimal.
>>
>> OTOH, would it work if we just did a %s/localhost/127.0.0.1/ in the
>> test?=C2=A0 We have specific cases for IPv6, so I think it makes sense t=
o
>> force IPv4 in all other cases.
>=20
> Except then it will fail on machines configured for IPv6-only.

So we=E2=80=99ll just have to test whether IPv4 works, just like we already=
 do
for IPv6, no?

Max



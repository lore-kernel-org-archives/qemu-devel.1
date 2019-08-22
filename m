Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531AA233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531AA233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oz7-0005HT-He
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0oxm-0004Cn-3q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0oxk-0007da-Gl
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0oxh-0007Y0-EV; Thu, 22 Aug 2019 11:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31BFA307D84B;
 Thu, 22 Aug 2019 15:25:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53C9360F9F;
 Thu, 22 Aug 2019 15:25:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
 <b0b27c5c-c07a-527b-294a-c4e7ec6d4204@redhat.com>
 <84dd318a-28d4-b2f3-b03b-d870a5f618d5@redhat.com>
 <80341376-ecbd-cbf4-8800-022fdd65c04d@redhat.com>
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
Message-ID: <8e42ea8e-0629-2645-d14d-785722df6466@redhat.com>
Date: Thu, 22 Aug 2019 17:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80341376-ecbd-cbf4-8800-022fdd65c04d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 22 Aug 2019 15:25:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Broken aarch64 by qcow2: skip writing zero buffers
 to empty COW areas [v2]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.08.19 14:09, Max Reitz wrote:
> (CC-ing Paolo because of the XFS connection, and Stefan because why not=
.)
>=20
> On 22.08.19 13:27, Luk=C3=A1=C5=A1 Doktor wrote:
>> Dne 21. 08. 19 v 19:51 Max Reitz napsal(a):
>>> On 21.08.19 16:14, Luk=C3=A1=C5=A1 Doktor wrote:
>>>> Hello guys,
>>>>
>>>> First attempt was rejected due to zip attachment, let's try it again=
 with just Avocado-vt debug.log and serial console log files attached.
>>>>
>>>> I bisected a regression on aarch64 all the way to this commit: "qcow=
2: skip writing zero buffers to empty COW areas" c8bb23cbdbe32f5c326365e0=
a82e1b0e68cdcd8a. Would you please have a look at it?
>>>
>>> I think I can see the issue on my x64 system (I don=E2=80=99t see the=
 XFS
>>> corruption, but the installation fails because of some segfaults).
>>>
>>> I haven=E2=80=99t found a simpler way to reproduce the problem yet, t=
hough,
>>> which is a pain... :-/
>>>
>>> It looks like the problem disappears when I configure qemu with
>>> =E2=80=9C--disable-xfsctl=E2=80=9D.  Can you try that?
>>>
>>> Max
>>>
>>
>> Hello Max,
>>
>> yes, I'm getting the same behavior. With "--disable-xfsctl" it works w=
ell. Also looking at the option I understand why it only failed on aarch6=
4 for me, I don't have libs installed on the other machines, therefor it =
was disabled by "./configure" there. Anyway I guess disabling it in my bu=
ilds won't really fix the issue, right? :-)
>=20
> Thanks!
>=20
> No, it won=E2=80=99t, but it means the actual root of the problem is pr=
obably
> rather in some XFS-related code (be it because qemu uses it the wrong
> way or because of XFS kernel code) than in the pure qcow2 commit that
> made the problem surface by exercising it heavily.  (Or in an
> interaction between the two.)

OK, I got a simpler reproducer now:

$ ./qemu-img create -f qcow2 test.qcow2 1M
$ (for i in $(seq 15 -1 0); do \
       echo "aio_write -P 42 $((i * 64 + 1))k 62k"; \
   done) \
  | ./qemu-io test.qcow2
$ for i in $(seq 0 15); do \
      echo $i; \
      ofs=3D$((i * 64)); \
      ./qemu-io -c "read -P 0 ${ofs}k 1k" \
                -c "read -P 42 $((ofs + 1))k 62k" \
                -c "read -P 0 $((ofs + 63))k 1k" \
                test.qcow2 \
          | grep 'verification'; \
  done

On XFS with --enable-xfsctl, this basically always gives me some
verification failure somewhere.  (On tmpfs or with --disable-xfsctl, it
never fails.)

So it seems to be related to I/O from back to front.

(You can also reproduce it with a plain =E2=80=9Cqemu-img bench=E2=80=9D =
invocation,
like =E2=80=9C./qemu-img bench -w --pattern=3D42 -o 1k -S 64k -s 62k test=
.qcow2=E2=80=9D
(on, say, a 4 GB image), but then the failure appears much later in the
image, because you have to wait from some requests to come in reverse
(by chance) first.)

Max


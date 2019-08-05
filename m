Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39AAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C910720B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C910720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huhcz-0001j0-5J
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 14:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1huhcP-0001E8-JE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1huhcO-0000Ij-7z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:22:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1huhcK-0000HC-Fp; Mon, 05 Aug 2019 14:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AC2D81F13;
 Mon,  5 Aug 2019 18:21:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F77B5DE5B;
 Mon,  5 Aug 2019 18:21:54 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190805163740.23616-1-mreitz@redhat.com>
 <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
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
Message-ID: <18e1fec2-00b7-1a00-df41-8d818524a875@redhat.com>
Date: Mon, 5 Aug 2019 20:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kp1bOCQEhs0eLFpSbcVMSSlEloS8NmA8l"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 05 Aug 2019 18:21:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kp1bOCQEhs0eLFpSbcVMSSlEloS8NmA8l
Content-Type: multipart/mixed; boundary="m7iT0l9EvJaIGayG9geTyYbQ6c6Efe4vk";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <18e1fec2-00b7-1a00-df41-8d818524a875@redhat.com>
Subject: Re: [PULL 0/7] Block patches for 4.1.0-rc4
References: <20190805163740.23616-1-mreitz@redhat.com>
 <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
In-Reply-To: <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>

--m7iT0l9EvJaIGayG9geTyYbQ6c6Efe4vk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.08.19 20:05, Peter Maydell wrote:
> On Mon, 5 Aug 2019 at 17:37, Max Reitz <mreitz@redhat.com> wrote:
>>
>> The following changes since commit 9bb68d34dda9be60335e73e65c8fb61bca0=
35362:
>>
>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2=
0190803' into staging (2019-08-05 11:05:36 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/XanClic/qemu.git tags/pull-block-2019-08-05
>>
>> for you to fetch changes up to 07b0851c592efe188a87259adbda26a63c61dc9=
2:
>>
>>   block/backup: disable copy_range for compressed backup (2019-08-05 1=
8:05:05 +0200)
>>
>> ----------------------------------------------------------------
>> Block patches for 4.1.0-rc4:
>> - Fix the backup block job when using copy offloading
>> - Fix the mirror block job when using the write-blocking copy mode
>> - Fix incremental backups after the image has been grown with the
>>   respective bitmap attached to it
>>
>> ----------------------------------------------------------------
>> Max Reitz (5):
>>   backup: Copy only dirty areas
>>   iotests: Test backup job with two guest writes
>>   iotests: Test incremental backup after truncation
>>   mirror: Only mirror granularity-aligned chunks
>>   iotests: Test unaligned blocking mirror write
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>   util/hbitmap: update orig_size on truncate
>>   block/backup: disable copy_range for compressed backup
>>
>>  block/backup.c             | 15 ++++++++++++---
>>  block/mirror.c             | 29 ++++++++++++++++++++++++++++
>>  util/hbitmap.c             |  6 +++++-
>>  tests/qemu-iotests/056     | 39 +++++++++++++++++++++++++++++++++++++=
+
>>  tests/qemu-iotests/056.out |  4 ++--
>>  tests/qemu-iotests/124     | 38 +++++++++++++++++++++++++++++++++----=

>>  tests/qemu-iotests/124.out |  4 ++--
>>  tests/qemu-iotests/151     | 25 ++++++++++++++++++++++++
>>  tests/qemu-iotests/151.out |  4 ++--
>>  9 files changed, 150 insertions(+), 14 deletions(-)
>=20
> This is quite a lot of changes for rc4 -- how confident are
> you about them ? I suppose 3 out of 4 commits are updating
> the test suite...

Would dropping the test patches make it better? :-)

I am reasonably (i.e., rc4-levels of) confident that the patches don=E2=80=
=99t
break anything that wasn=E2=80=99t broken before.

(I=E2=80=99m least confident about the test patches working for everyone =
and
everywhere, as with all new test cases.  But it was my impression that
it=E2=80=99s always fine to include test case additions.)

Patch 1 is very important.  I=E2=80=99m very confident about it.
It fixes a silent corruption in the backup job, so I=E2=80=99m not too su=
rprised
people haven=E2=80=99t noticed.  I would be surprised if really noone was=

affected so far.

Patch 3 is not that important, but it is sufficiently simple, so I think
we should take it, even into rc4.

Patch 5 is very important for a specific mirror copying mode.  It can be
argued that nobody really uses this mode because otherwise somebody
should have noticed the corruption, because if you hit it, you will
simply lose data (as opposed to the backup case, where you will simply
get the wrong version of the data in the output image).
But that is why it=E2=80=99s so important.  I really don=E2=80=99t want a=
nyone to hit it.
It is probably the most complicated patch here, but at any other point,
it would still be considered a simple patch.  (Just not quite trivial.)
I think it is worth taking it.

Patch 7 is actually not important.  But it=E2=80=99s an obvious trivial
one-liner.  I thought I might as well.

Max


--m7iT0l9EvJaIGayG9geTyYbQ6c6Efe4vk--

--kp1bOCQEhs0eLFpSbcVMSSlEloS8NmA8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Ic8AACgkQ9AfbAGHV
z0Auzgf/VR+BcJxiPw6NjvROzp4zjZ1x36iXSuclWy61qL8TNYDuUzJfTBxvXYrB
JdvoSTPd7s9JfFeYrVQ+Q9aYyf8wGdNf7V/AYtnYjraJv1QL9BRAtyTig6h3jdp5
EH1Ybvuq7bvpkP8eYfj6BN228kP9N2Q4VZyA2ZlNHZ09/q9xDuxpsj+JVdwCHtHL
yCxWhxohpKg29RvqK7RzcQmEb7zW6aSffQj5pyUoqAP4FotdCpknjwFvYD67klu3
P2098qyaXw04cNXcD/9lJg1e6Qtnai9RcrMmWSXMD9jQ/5B1U07jKmsQ2kROtHU4
2QvW4Hv6lABxyTEAyjhYtkp3hjvqXw==
=S/tT
-----END PGP SIGNATURE-----

--kp1bOCQEhs0eLFpSbcVMSSlEloS8NmA8l--


Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F46C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2374D20659
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2374D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGOmQ-0003uA-83
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 10:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGOkn-0003GZ-HY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGOkm-00045o-7z
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGOkj-00042a-9D; Fri, 04 Oct 2019 10:40:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 885B53C93E;
 Fri,  4 Oct 2019 14:40:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97DDE60C18;
 Fri,  4 Oct 2019 14:40:12 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <CAFEAcA-4-ttpQ5S-HuEtv86TeNjBnFzp77D5ML1D9CZMYGR5Ow@mail.gmail.com>
 <2873f340-cac2-c168-d46a-e22c0571e83d@redhat.com>
 <CAFEAcA99ezCejkZi9+yVYK-SRpNOvPng9vrkF+kcuS12LQBmuQ@mail.gmail.com>
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
Message-ID: <77909bda-ebcc-41be-2547-c81870db79ab@redhat.com>
Date: Fri, 4 Oct 2019 16:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99ezCejkZi9+yVYK-SRpNOvPng9vrkF+kcuS12LQBmuQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sot3Lu3Pdqn2YIRfDu62j2StjS8B7NzsU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 04 Oct 2019 14:40:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sot3Lu3Pdqn2YIRfDu62j2StjS8B7NzsU
Content-Type: multipart/mixed; boundary="6njDLKAZxWjUv3h0tNTHJ8o9mKW6ayVHW"

--6njDLKAZxWjUv3h0tNTHJ8o9mKW6ayVHW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.10.19 16:05, Peter Maydell wrote:
> On Fri, 4 Oct 2019 at 14:50, Max Reitz <mreitz@redhat.com> wrote:
>> On 04.10.19 15:16, Peter Maydell wrote:
>>> 'make check' does have the restriction
>>> that we don't want the tests to take too long to run, but in
>>> general the block layer should be running some reasonable subset
>>> of tests in the project's standard "run the tests please" command.
>>> (I have no opinion on exactly what that subset ought to be, beyond
>>> that it would be good if that subset doesn't have known intermittent
>>> failures in it.)
>>
>> Deciding the subset is difficult.  My stance was that it=E2=80=99s bet=
ter to not
>> choose an arbitrary subset here but ensure that really everything gets=

>> run as part of CI, that is asynchronously so it doesn=E2=80=99t block =
anyone and
>> can take as long as it wants.
>=20
> I wonder if we have a terminology difference confusion here.
> To me "CI" means "we have tests which we automatically run
> before pushing commits to master, and if they fail then we
> don't push". So (a) they have to run synchronously and (b) there
> is a need for them to run in a reasonable period of time because
> otherwise it takes too long to run the tests before pushing
> to master and we get a backlog of unprocessed pullrequests
> and annoying delays.

Hm, yes.  In that case, there=E2=80=99s of course no point in moving it.

I meant moving the tests to somewhere where they run asynchronously.

>> If we decide to get pull requests based on that, then that=E2=80=99d b=
ring even
>> more pain, but at least it=E2=80=99d be honest.  But just running half=
 of the
>> qcow2 tests to me seems only like we want to pretend we ran the iotest=
s.
>>  So for me, iotests still break, and we need to deal with make check
>> failures on top.  I=E2=80=99d at least prefer one or the other.
>=20
> I think the ideal we're aiming for here is:
>  (1) people doing active work in the block subsystem are probably
> often going to want to run all the iotests, and certainly the
> subsystem maintainers will want to do that as they put together
> pull requests.
>  (2) but people who *don't* do active work in the block subsystem
> still sometimes touch it in passing as part of things like global
> refactorings or other changes that touch big parts of the tree,
> or accidentally break it with a change to some other bit of QEMU
> entirely. These people won't run the full iotests, but it is
> reasonable to expect them to run 'make check', and it would be good
> if that caught "whoops you broke the block subsystem".
>=20
> Similarly, "make check" has incredibly spotty coverage of
> various arm boards and devices, but it does do some basic
> checks which do catch accidental breakage.

Yes, it has its use, but at the same time it means that intermittent
failure can appear in make check because some iotest is broken.  (The
past has shown that it=E2=80=99s hard to predict which tests will at some=
 point
start to exhibit such behavior.)

This then requires immediate attention, and I simply want help with that
from someone who really cares about having the test be part of make
check, as I wrote in my reply to Thomas=E2=80=99s patch =E2=80=9Ciotests:=
 Do not run the
iotests during "make check" anymore=E2=80=9D.

The issues are just half as pressing when it isn=E2=80=99t make check tha=
t=E2=80=99s
intermittently failing.  (I hope nobody takes this as =E2=80=9CHe doesn=E2=
=80=99t want
to fix intermittent failures=E2=80=9D, because I do really try to do that=
=2E  So I
don=E2=80=99t consider this a good kind of pressure.)


I suppose my main problem is that I=E2=80=99m just lucky that I can=E2=80=
=99t remember a
case where the block subsystem was really broken and iotests in make
check would have caught it; and that I=E2=80=99m na=C3=AFve enough to exp=
ect this to
continue into the future.

Max


--6njDLKAZxWjUv3h0tNTHJ8o9mKW6ayVHW--

--sot3Lu3Pdqn2YIRfDu62j2StjS8B7NzsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XWcsACgkQ9AfbAGHV
z0BHwwf7BVEibAmsYSWfrD1kYsomh9Ye1/rJKB1YdBLU1Ntj9qXFBCHZ/hx8WIw/
AysXNOVIQATjj/mV7hO/T0l/LVVxo7Pa5SWzsUtnqzVlnU7Qd6sGsdEorp44RJWH
4wBgqQ0eZ5Y2c0PCP7Z8SN8+KsgT6e80JyYMOcmQ4CAZcZp66G7e6aE09kxrDTYQ
sVqzXLTRWgLG75c8sLelDEHeubRJktmvmMStOqyYps/8ePAL6UcPRBtQfTAvUcXX
EmqTydusm1f5fOFt6x0JsjriRfgohWaWn/MxXyca8XokiIi57AYsfg614LeINxaZ
6icAdTV4XsrXiUaj/iJ7bdcAZ1j3Aw==
=3MUd
-----END PGP SIGNATURE-----

--sot3Lu3Pdqn2YIRfDu62j2StjS8B7NzsU--


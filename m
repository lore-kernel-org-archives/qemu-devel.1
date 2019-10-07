Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70CAECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E942070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E942070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHShW-0004PP-TO
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHSgP-0003sh-Q7
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHSgO-0001m7-6X
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:04:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHSgF-0001jl-Ch; Mon, 07 Oct 2019 09:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53608883851;
 Mon,  7 Oct 2019 13:04:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ABD41001B11;
 Mon,  7 Oct 2019 13:03:58 +0000 (UTC)
Subject: Re: [PATCH] iotests: Do not run the iotests during "make check"
 anymore
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191002142146.6124-1-thuth@redhat.com>
 <20191002150329.GA30342@redhat.com>
 <1b6616ed-bb06-332e-6451-b2acd748e891@redhat.com>
 <1bf47905-9237-eff6-9a3e-d1693a3d597a@redhat.com>
 <e2463f58-f5f0-7391-0e70-bc2f9970bdfa@redhat.com>
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
Message-ID: <40541b4f-047e-20d9-ded2-7c8679e3de72@redhat.com>
Date: Mon, 7 Oct 2019 15:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e2463f58-f5f0-7391-0e70-bc2f9970bdfa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sQbAGE3jtgi7gmo2EO1LckTtI4FunTCHE"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 07 Oct 2019 13:04:02 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sQbAGE3jtgi7gmo2EO1LckTtI4FunTCHE
Content-Type: multipart/mixed; boundary="bubaw3gm22mVPm17F51wbQZU0zrS2q2yj"

--bubaw3gm22mVPm17F51wbQZU0zrS2q2yj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.10.19 01:51, John Snow wrote:
>=20
>=20
> On 10/2/19 11:50 AM, Max Reitz wrote:
>> On 02.10.19 17:10, Thomas Huth wrote:
>>> On 02/10/2019 17.03, Daniel P. Berrang=C3=A9 wrote:
>>>> On Wed, Oct 02, 2019 at 04:21:46PM +0200, Thomas Huth wrote:
>>>>> Running the iotests during "make check" is causing more headaches t=
han
>>>>> benefits for the block layer maintainers, so let's disable the iote=
sts
>>>>> during "make check" again.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  tests/Makefile.include   | 2 +-
>>>>>  tests/qemu-iotests/group | 2 +-
>>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> I don't have any objection to removing from 'make check', but I feel=

>>>> like this commit should be modifying the travis.yml config so that
>>>> it explicitly runs the block tests, otherwise we're loosing automate=
d
>>>> CI and the block tests will increase their rate of bitrot again.
>>>
>>> I was planning to send a separate patch for that (once my Travis buil=
ds
>>> are through...), but if it is preferred, I can also send a v2 of this=

>>> patch here where I include that change.
>>>
>>> Max, any preferences?
>>
>> I don=E2=80=99t mind either way.  I don=E2=80=99t think we=E2=80=99re =
in danger of you
>> forgetting to send the Travis patch.
>>
>> As for running the tests on macOS: Good question.  I=E2=80=99d just le=
t them run
>> now and maybe see later whether that decision hurts.  macOS has its ow=
n
>> filesystem, so it may be worth testing there.
>>
>> Max
>>
>=20
> There are absolutely known bugs and problems using APFS that we have no=
t
> fixed.

Sorry, somehow missed your reply. :-/

Yes, that was the idea why I said that maybe running the tests there
would be worth it, because it=E2=80=99s a different FS that produces, wel=
l,
interesting results.

But on second thought, who=E2=80=99s going to address those problems?  So=
, yeah,
that wouldn=E2=80=99t really help.

Max


--bubaw3gm22mVPm17F51wbQZU0zrS2q2yj--

--sQbAGE3jtgi7gmo2EO1LckTtI4FunTCHE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bN7wACgkQ9AfbAGHV
z0Cttwf+PdM3Qgs0gqzpyEqKGgpm3FpSK2DdHUJchTmRI+0O59beJep6hZ+ARwPz
gw6NR3+zqAHWm3xkdhaFX0Qd/0HZ/mawEPVP2kUPhwGclBNqjsdvh5sePrhOmJJN
91LZBlCA0sF3tUEGbaJfo74YYnNqwV9EmY8uc7wmaiSBX3txQxj+4mr6Wvc4n2Tg
Lg5ajGWSp19HngIR9xPsbEsm2HMBUlMPOMvgPn88nCzOYgXqKvxUDeoqjg9HtZxc
v/s74EU/ZHhW3B2CRB7JhHL1k3UBDf3+sMcFvIikCcOX5uwvNvNxRRhtyBwekAyV
Tlkdv2JS+mqEUM/VdSFIbDGewcQGDw==
=Y/G1
-----END PGP SIGNATURE-----

--sQbAGE3jtgi7gmo2EO1LckTtI4FunTCHE--


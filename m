Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A891C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B54D206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B54D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxFsH-00009R-Hm
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 15:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxFrq-00085i-Od
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxFrp-0007Mw-PG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:20:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxFrk-0007Hc-Ga; Mon, 12 Aug 2019 15:20:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DCD83CA1D;
 Mon, 12 Aug 2019 19:20:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C92560872;
 Mon, 12 Aug 2019 19:20:16 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
References: <c293e99d-331a-f3aa-eecb-d562554350f9@redhat.com>
 <ac5a6d46-99ee-ef1f-9fa0-8ebeab0f4485@redhat.com>
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
Message-ID: <fdb15508-4cb8-4295-af34-63d402e58ccd@redhat.com>
Date: Mon, 12 Aug 2019 21:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ac5a6d46-99ee-ef1f-9fa0-8ebeab0f4485@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rN4M0qnFYLv2zsOJfZ47Ju3tTomVU1hNS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 12 Aug 2019 19:20:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] qemu-iotest 059 fails with vmdk
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rN4M0qnFYLv2zsOJfZ47Ju3tTomVU1hNS
Content-Type: multipart/mixed; boundary="qy2B316llwOjffRXP0xBsqFa6glIhytEs";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <fdb15508-4cb8-4295-af34-63d402e58ccd@redhat.com>
Subject: Re: [Qemu-block] qemu-iotest 059 fails with vmdk
References: <c293e99d-331a-f3aa-eecb-d562554350f9@redhat.com>
 <ac5a6d46-99ee-ef1f-9fa0-8ebeab0f4485@redhat.com>
In-Reply-To: <ac5a6d46-99ee-ef1f-9fa0-8ebeab0f4485@redhat.com>

--qy2B316llwOjffRXP0xBsqFa6glIhytEs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 21:14, John Snow wrote:
>=20
>=20
> On 7/22/19 8:58 AM, Thomas Huth wrote:
>> Not sure if it has been reported before, but test 059 currently fails:=

>>
>> 059      fail       [14:55:21] [14:55:26]                    output
>> mismatch (see 059.out.bad)
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/059.out	2019-07-19
>> 10:19:18.000000000 +0200
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/059.out.bad	2019-07-=
22
>> 14:55:26.000000000 +0200
>> @@ -27,7 +27,7 @@
>>  image: TEST_DIR/t.vmdk
>>  file format: vmdk
>>  virtual size: 0.977 TiB (1073741824000 bytes)
>> -disk size: 16 KiB
>> +disk size: 517 KiB
>>  Format specific information:
>>      cid: XXXXXXXX
>>      parent cid: XXXXXXXX
>> Failures: 059
>> Failed 1 of 1 tests
>>
>> ... I think this was working fine for me a couple of weeks ago, so I
>> assume this is a rather new bug?
>>
>>  Thomas
>>
>=20
> I know this is a pretty late response, but "worksforme" -- did someone
> address this in the meantime? I don't see any commits to 059 in some
> time. (Not since March.)

I didn=E2=80=99t because I could never reproduce this failure.  (XFS/tmpf=
s here.)

I have =E2=80=9Cvmdk: Misc fixes=E2=80=9D on list which came from running=
 the iotests
with all possible subformats (which broke many things, but not 059 in
this way).

Max


--qy2B316llwOjffRXP0xBsqFa6glIhytEs--

--rN4M0qnFYLv2zsOJfZ47Ju3tTomVU1hNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Ru+8ACgkQ9AfbAGHV
z0AGtAgAqh9FBmKVt9vxrPlSG7H9YvkQGmBzMfSuLaKB9o+Swfl/JouM8EYkYKUe
zLDZuZuPSFY2LItJ7W558iKsJufdIBmm5Lo/4vCq+Rp/wJgiue14OV/ky3ev6fRz
BeWegkq16b3KKwpdp0HdY7/bo0/meyZOOFF446O3E6Zakclceq44hNysGCxlRHnG
2oLVUhNnr/y8Mm0dxyr/xMeoC6wVftYnFtJ/Sc4Wm+egF+yrKwagPgnHcmvHRBtM
o1xnNP3zrUP3Glg61wo9PyQOLk+gM2p9Z0gghMO/6GV5D+Psi8NqLWfkIFD2w1Zg
9GI3rUn/QqYi3Z4xDLOobun51ZXC3g==
=2Nx+
-----END PGP SIGNATURE-----

--rN4M0qnFYLv2zsOJfZ47Ju3tTomVU1hNS--


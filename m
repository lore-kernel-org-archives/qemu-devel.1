Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C09CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5256F20684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIccvc5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5256F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMv2K-00039n-32
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMuOD-0004Zs-5n
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMuO9-0003wa-Ug
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:39:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMuO8-0003vR-23
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571751589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6SRV+Mpnhv3z+Om1pNCATXglDUtLD57sseRA3Ougm9c=;
 b=iIccvc5qB+G/S2DlbC3WP284dHYWdPpBJOhDZhp5E5m7s0XeVLuqgD4oNELC6Ddz5Uf0AM
 +xez7+JZ6dwMmKXIj/fahS/2u1q4GcWxIBk7zUBI0orEqAlnKNcGLwpfIAuw6ntGbFCCBa
 GvZKE+VdRNWyOH6ah9d9myFCM8OD6aM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-AcXC4-98PsqafSbDAIRCtQ-1; Tue, 22 Oct 2019 09:39:45 -0400
X-MC-Unique: AcXC4-98PsqafSbDAIRCtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF3A1107AD35;
 Tue, 22 Oct 2019 13:39:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 901BB52CD;
 Tue, 22 Oct 2019 13:39:40 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] Enable more iotests during "make check-block"
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191022072135.11188-1-thuth@redhat.com>
 <87a79sx6uc.fsf@linaro.org>
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
Message-ID: <123b2e94-3f43-1a8e-2420-12ae09483e2f@redhat.com>
Date: Tue, 22 Oct 2019 15:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87a79sx6uc.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YxcntaNPeOxoFfrgmP2P5OApgSq2yQU06"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YxcntaNPeOxoFfrgmP2P5OApgSq2yQU06
Content-Type: multipart/mixed; boundary="5Ut9mTq8xYUNMjmBMGDfcHHbz5wH4Faaj"

--5Ut9mTq8xYUNMjmBMGDfcHHbz5wH4Faaj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.10.19 15:11, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> As discussed here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html
>>
>> and here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html
>=20
> Queued to testing/next, thanks.

It should be noted that this series depends on my SOCK_DIR series (which
I have in my block branch), or the newly added tests are likely to fail
in the CI environment.

Max

>>
>> it would be good to have some more valuable iotests enabled in the
>> "auto" group to get better iotest coverage during "make check".
>>
>> And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
>> merged, we can indeed enable these Python-based tests, too.
>>
>> There is just one small downside: Since these tests require a QEMU
>> that features a 'virtio-blk' device, we cannot run the iotests
>> with binaries like qemu-system-tricore anymore. But since the iotests
>> were not very useful with such binaries anyway, I think it's ok now
>> if we skip them there.
>>
>> I've also added a patch that removes test 130 from the "auto" group
>> instead. Test 130 has been reported to fail intermittently, so we
>> should not use it in "make check" block until it is fixed.
>>
>> Based-on: 20191010152457.17713-1-mreitz@redhat.com
>>
>> v3:
>>  - Test 183 fails on Patchew, so I removed it from the "auto" group
>>    again
>>
>> v2:
>>  - Checked the iotests with NetBSD, too (now that Eduardo has
>>    re-activated Gerd's patches for creating NetBSD VM images)
>>  - Use 'openbsd' instead of 'openbsd6'
>>  - Use 'grep -q' instead of 'grep' for grep'ing silently
>>  - Added the patch to disable 130 from the "auto" group
>>
>> John Snow (1):
>>   iotests: remove 'linux' from default supported platforms
>>
>> Thomas Huth (5):
>>   iotests: Test 041 only works on certain systems
>>   iotests: Test 183 does not work on macOS and OpenBSD
>>   iotests: Skip "make check-block" if QEMU does not support virtio-blk
>>   iotests: Enable more tests in the 'auto' group to improve test
>>     coverage
>>   iotests: Remove 130 from the "auto" group
>>
>>  tests/check-block.sh          | 16 +++++++++++++++-
>>  tests/qemu-iotests/041        |  3 ++-
>>  tests/qemu-iotests/183        |  1 +
>>  tests/qemu-iotests/group      | 18 +++++++++---------
>>  tests/qemu-iotests/iotests.py | 16 +++++++++++-----
>>  5 files changed, 38 insertions(+), 16 deletions(-)
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20



--5Ut9mTq8xYUNMjmBMGDfcHHbz5wH4Faaj--

--YxcntaNPeOxoFfrgmP2P5OApgSq2yQU06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2vBpsACgkQ9AfbAGHV
z0B8aAf/dDq13AYyvVZGJE/uHIxVIzWkU7IlTodunbC7NvE0XiV52TXNL2rS1SSG
ns2ytwQ3Pc/xiF2H5hOTbQtZD+MHB9J9TM25yKGKZKSGBi5z+/8z/6yjRM3wDHw8
hMh/KBcXiA5lgFqmDJsG/yrjLwOBoOMHAGVltKFewbpc73EH3kJ/sIXoIm9lBkqV
hu/vzhgvc/kkVgtJHswlEVDZ5BUOnE5dOGekhKQD54VXb8U6gxKGZ4QtgeRyqCmf
4F6CW0r3qzpoLO5CdrBO38YSusbNgB9TN+edOgIGrA5HqzYDGylMhAcULtRRKuFf
ttiTze+hfO6eOzU/6lrc2m3OZSt3OQ==
=uhry
-----END PGP SIGNATURE-----

--YxcntaNPeOxoFfrgmP2P5OApgSq2yQU06--



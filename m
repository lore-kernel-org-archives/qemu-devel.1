Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C320C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C763F206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU0AY1q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C763F206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqC4d-0008Aw-4T
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqC42-0007gl-SV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:56:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqC40-0001iH-Rz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8OksBx7SJ6MdlcrmH+710y1yp7KcjXyyeZx7UJKvGjE=;
 b=EU0AY1q39NKDvuJC/fK0ugLJYU90D3i7uWOOQ5GH2FSZ66Kaxtm4+Y8stEiWO4gosZ5hUM
 iEp+hu5yoHoJciBILKILigAVOKDYbBYf6aZ2HWXqpBvzsOTbARaKA6ABzwb0rG84cm7CIr
 er+4EGGP00URh9WKaFJvcWIXE1eBUr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-anlkdBJSPR2QQ_ijhjiNng-1; Tue, 30 Jun 2020 04:56:21 -0400
X-MC-Unique: anlkdBJSPR2QQ_ijhjiNng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D4F1005512;
 Tue, 30 Jun 2020 08:56:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-102.ams2.redhat.com
 [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 752FC1C4;
 Tue, 30 Jun 2020 08:56:19 +0000 (UTC)
Subject: Re: [PATCH 15/19] iotests: qemu-img tests for luks key management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20200625125548.870061-1-mreitz@redhat.com>
 <20200625125548.870061-16-mreitz@redhat.com>
 <10a4f572b6276a99fdc925b11ff6aa137e0ea50a.camel@redhat.com>
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
Message-ID: <0c8a96b3-9204-b138-d141-aaa9e0d02ac0@redhat.com>
Date: Tue, 30 Jun 2020 10:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <10a4f572b6276a99fdc925b11ff6aa137e0ea50a.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rhBEqhFBkBx6yKArv8zdYYlEK5OYoH6cA"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rhBEqhFBkBx6yKArv8zdYYlEK5OYoH6cA
Content-Type: multipart/mixed; boundary="zxigOrSLNLoEuuf1H12iRHBi4VNwkZJFb"

--zxigOrSLNLoEuuf1H12iRHBi4VNwkZJFb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.06.20 14:05, Maxim Levitsky wrote:
> On Thu, 2020-06-25 at 14:55 +0200, Max Reitz wrote:
>> From: Maxim Levitsky <mlevitsk@redhat.com>
>>
>> This commit adds two tests, which test the new amend interface
>> of both luks raw images and qcow2 luks encrypted images.
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> [mreitz: Let 293 verify that LUKS works; drop $(seq) usage from 293;
>>          drop 293 and 294 from the auto group]
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/293     | 208 +++++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/293.out |  99 ++++++++++++++++++
>>  tests/qemu-iotests/294     |  90 ++++++++++++++++
>>  tests/qemu-iotests/294.out |  30 ++++++
>>  tests/qemu-iotests/group   |   2 +
>>  5 files changed, 429 insertions(+)
>>  create mode 100755 tests/qemu-iotests/293
>>  create mode 100644 tests/qemu-iotests/293.out
>>  create mode 100755 tests/qemu-iotests/294
>>  create mode 100644 tests/qemu-iotests/294.out

[...]

>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index d886fa0cb3..b945dd4f20 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -301,4 +301,6 @@
>>  290 rw auto quick
>>  291 rw quick
>>  292 rw auto quick
>> +293 rw
>> +294 rw quick
>>  297 meta
>=20
> I guess now we can add these to 'auto' group?

Have you run them on all platforms?  I haven=E2=80=99t.

(I have run the openbsd build, but I=E2=80=99m not even sure I had these te=
sts
in auto at that point.  And that build takes a really long time.)

All in all, I don=E2=80=99t think I ever want to add a test to auto again,
unless it=E2=80=99s done in a specific patch where the author guarantees th=
ey
tested it everywhere.

Max


--zxigOrSLNLoEuuf1H12iRHBi4VNwkZJFb--

--rhBEqhFBkBx6yKArv8zdYYlEK5OYoH6cA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl76/jIACgkQ9AfbAGHV
z0AkLwgAjMC9jFw18pBPAdfdWZenGxYnKH1YRMOpwyM34/dD91+0R337+J/INCk/
yIBffIv7/FFp5nD7T+JgD0L/+0v3GBbO8A6aVIsNSZnRgNMooUOL/Jap8XLuemNu
73sC+LYKA+OlV1++jdze9FqoluwV59aX5B+HLLFCt2wyl6foBMNsFMMDwl6CcgCu
Z8Utfyjagxh4NqFdbW/G17NOxaFwKww9dSdrKk+5ozYLhfqyfBZpMTbCJeSrUjay
pbPDmUHTetzSfHYzoSDsvHpZMYJYPBZXg/eYmBk580u6P+xYvTsM7U03YYoQe08F
mxVPzZ3xkTuql2Hi1arfziJZlVuvpg==
=6+i+
-----END PGP SIGNATURE-----

--rhBEqhFBkBx6yKArv8zdYYlEK5OYoH6cA--



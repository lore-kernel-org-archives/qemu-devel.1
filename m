Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103FFC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF672084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ckc7fTx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF672084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdid-0008Fp-Vl
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSddd-0005qZ-7q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSddb-00021s-5P
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:59:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSddb-0001jI-1J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573117168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qte9HWBii3JLBhBSPQn/ui821bxtUgrJgSt8lfToRW4=;
 b=Ckc7fTx8pJqgxMgAy1qoiQJt+FozPnDEWSLVRc5nEMaAX4Q4/T4taW0MdzXtW98U0VlPSE
 A4fUwFuPywjSLgJDMK/3toGdRkHRmMt7lC8liMUcNK7SJl37BDiIHEicDXwhVkFruCXXiZ
 I9oqNZB76uTAWDPFd793t1YW0kupMoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-ud_UvMjyNFSFH5N-HPmpkA-1; Thu, 07 Nov 2019 03:59:24 -0500
X-MC-Unique: ud_UvMjyNFSFH5N-HPmpkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A50C88017E0;
 Thu,  7 Nov 2019 08:59:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-202.ams2.redhat.com
 [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B84C15C290;
 Thu,  7 Nov 2019 08:59:22 +0000 (UTC)
Subject: Re: [PATCH v2 03/21] iotests: Add _filter_json_filename
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-4-mreitz@redhat.com>
 <f3822494defad291fa70000487c339f3f73317ca.camel@redhat.com>
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
Message-ID: <5defb1b6-7e1d-8be1-ec4c-ed8378d3ed9b@redhat.com>
Date: Thu, 7 Nov 2019 09:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f3822494defad291fa70000487c339f3f73317ca.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="41VfJPPorrKeBgl2EnNhVCVjW0gDiskK1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
--41VfJPPorrKeBgl2EnNhVCVjW0gDiskK1
Content-Type: multipart/mixed; boundary="r869Y1L9hg3Vww1gAXPGZkeicmGczbwjn"

--r869Y1L9hg3Vww1gAXPGZkeicmGczbwjn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 16:44, Maxim Levitsky wrote:
> On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.filter | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/commo=
n.filter
>> index 9f418b4881..63bc6f6f26 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -227,5 +227,29 @@ _filter_qmp_empty_return()
>>      grep -v '{"return": {}}'
>>  }
>> =20
>> +_filter_json_filename()
>> +{
>> +    $PYTHON -c 'import sys
>> +result, *fnames =3D sys.stdin.read().split("json:{")
>=20
> Very minor nitpick, maybe I would give 'fnames' a more generic name,
> since its is just result of a split, thus not really a list of filenames.
> Feel free to ignore that though.

Hm...  It is a list of filenames, namely of all nested json:{}
filenames.  I could call it fname_split, but I actually think fnames is
not too wrong.

In any case, thanks for reviewing again!

Max


--r869Y1L9hg3Vww1gAXPGZkeicmGczbwjn--

--41VfJPPorrKeBgl2EnNhVCVjW0gDiskK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3D3OgACgkQ9AfbAGHV
z0CT+Af/RZS6kgeOAWMwXqm/nOXQgApzc5MATkp/Lvx2aGZTuDuHOHDQwI1uTMx+
oUzd1twFtFYMOokFRCRPxrjwfENTtr6OecYQyD+KU+QkA8yTIN5k2muv1/B63Bkd
ADMdaeq2YkPHwsC+FnL42vPeGEYlrfHQY+azmi976R8tSqdOi1nNZNhF1BA6hvmB
EAfv4WkBRxKRf3TP2SKi/8Ua3YyztpMGuQ9+hG9IoS/xTWQ5f4g4pJh3mx6Y0tPV
KPJ7S2GeC1JUtGgmSIg1RP8s6WqDfkg+ejtsq5KrW9ixgKrdG3u6qymr88iP3oeP
XVlEwbfde2XYwXJHxB2gtvsq1alWWg==
=ekBz
-----END PGP SIGNATURE-----

--41VfJPPorrKeBgl2EnNhVCVjW0gDiskK1--



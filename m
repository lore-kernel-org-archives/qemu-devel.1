Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88971C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F04206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4BeYR8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F04206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80A6-0005gm-JK
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k809N-000589-9W
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 07:51:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k809L-00060i-GW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 07:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597751490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5BGIwsCGFbYa1XvukHh8i85q1nJ0BTnETyHu8Uayppg=;
 b=c4BeYR8fi0U9HrXH1HH6QJ9BIZ3ZzaVH3n2GAbSWep+Ym9DwSHjGylwbXQw1LXDjAHbE58
 hwsrx4HuqmcSbYuZysHO6nFO6rQyp/ynbiQ1B/U5n6piGQrs+QBLglvPj2ZTcYbRkvlNd8
 653yvHtWE9NB8NTkrawMELt7DEx4aog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-EeyBlE0IMD2swlahKAsSkA-1; Tue, 18 Aug 2020 07:51:28 -0400
X-MC-Unique: EeyBlE0IMD2swlahKAsSkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3D4185E536;
 Tue, 18 Aug 2020 11:51:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-119.ams2.redhat.com
 [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB20F1A92A;
 Tue, 18 Aug 2020 11:51:25 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Explicit number replaced by a constant
To: Stefano Garzarella <sgarzare@redhat.com>, Yi Li <yili@winhong.com>
References: <20200817110113.1552683-1-yili@winhong.com>
 <20200818071918.vzdhdlndxuviq3ue@steredhat>
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
Message-ID: <0107e40a-1d96-fa3d-bd15-019c004d0353@redhat.com>
Date: Tue, 18 Aug 2020 13:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818071918.vzdhdlndxuviq3ue@steredhat>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qd7OiDajSp6a28x9rZAi6QFgQNUQgdBHP"
Received-SPF: none client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, yilikernel@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qd7OiDajSp6a28x9rZAi6QFgQNUQgdBHP
Content-Type: multipart/mixed; boundary="zrddXTvJDWUt9cNQQeRsu3RhkZBsZuH7E"

--zrddXTvJDWUt9cNQQeRsu3RhkZBsZuH7E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.08.20 09:19, Stefano Garzarella wrote:
> Hi Yi Li,
> thanks for this patch! Just a comment below:
>=20
> On Mon, Aug 17, 2020 at 07:01:13PM +0800, Yi Li wrote:
>> Signed-off-by: Yi Li <yili@winhong.com>
>> ---
>>  qemu-img.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 5308773811..a0fbc2757c 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1181,7 +1181,7 @@ static int64_t find_nonzero(const uint8_t *buf, in=
t64_t n)
>>  }
>> =20
>>  /*
>> - * Returns true iff the first sector pointed to by 'buf' contains at le=
ast
>> + * Returns true if the first sector pointed to by 'buf' contains at lea=
st
>=20
> This change seems unrelated, please can you put this in a separate patch?

It=E2=80=99s also just not a correct change, as =E2=80=9Ciff=E2=80=9D means=
 =E2=80=9Cif and only if=E2=80=9D.

Max


--zrddXTvJDWUt9cNQQeRsu3RhkZBsZuH7E--

--Qd7OiDajSp6a28x9rZAi6QFgQNUQgdBHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl87wLsACgkQ9AfbAGHV
z0D5owgAqWB4LDq/ApY2S+UhnIQ5dYA2brUoONsS6LE3+l61Yz8fgZ2ZsvKN3f2V
85GYjJAyL5u8IQqXYir8WT4WCACLoVPURJcsB4iCLRIwXHptv7XljflMR2FIZRcF
g+bvHI6xveQ2OKtOpvol1nAKYUv1IgD0ZZg2Wta9UHxZrFtLBwuqyRWKBR4iNPv/
lJWtNkYSEmlyPJ1zVxcW59zjz+xN41c0uM95u7ROHEFn/lJN4eJmJfK/5EMMAXSl
nXKPMmgnSIf37Hhb/Sv6mRSjFlvZ3NYYYAoGr1T+o/k8S+RzD80gTNn72aub+nfM
Z1lCd6hTaZCf080+GKJMiJXVxfGH3w==
=UdN1
-----END PGP SIGNATURE-----

--Qd7OiDajSp6a28x9rZAi6QFgQNUQgdBHP--



Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C27C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E076C2088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVUFfAAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E076C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrFxh-0006he-79
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrFx3-0006I2-15
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:17:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrFx0-0005W7-Ld
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593760653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5lrrollar6lgLjxazgMh+0YgXPZhVCf3fmHsLN2BoQk=;
 b=DVUFfAANHmsJ46bHNkXTYzJyHWKhUtStKjMwSBsjeTnZTHy5RJE5TwDIBghazslGpRTRTM
 x2eV1oWK60ctVcp/2Qnj1altuHjgvXvKjPa7rwnTmTl25GUJME1Wk+x9Y0MCfOvdYOho/y
 1sO7FL+D7h3k3OBLXtTZDSTfX/vAf7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-Ka9v2ePfO6-9R12Ujt8gRw-1; Fri, 03 Jul 2020 03:17:30 -0400
X-MC-Unique: Ka9v2ePfO6-9R12Ujt8gRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD6B800400;
 Fri,  3 Jul 2020 07:17:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC155D9CA;
 Fri,  3 Jul 2020 07:17:26 +0000 (UTC)
Subject: Re: [PATCH v9 14/34] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <6ee75696d3eaed56b46e91fe242fdfab51feb066.1593342067.git.berto@igalia.com>
 <fae77394-92fd-d170-0ae6-051c0a024d04@redhat.com>
 <w51mu4jurqe.fsf@maestria.local.igalia.com>
 <6c06d36e-c074-fff0-fad8-fa96962b4906@redhat.com>
 <w51a70htw66.fsf@maestria.local.igalia.com>
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
Message-ID: <8c520aa6-593a-9559-dccc-d600ebb8bc9d@redhat.com>
Date: Fri, 3 Jul 2020 09:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <w51a70htw66.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hjaOr5kRsISk9UuLiEXKnIIT0JMJPrNq8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hjaOr5kRsISk9UuLiEXKnIIT0JMJPrNq8
Content-Type: multipart/mixed; boundary="SkwgHgeRClf9ii82Ewkwm9LgMthipa34N"

--SkwgHgeRClf9ii82Ewkwm9LgMthipa34N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.20 00:00, Alberto Garcia wrote:
> On Thu 02 Jul 2020 11:57:46 AM CEST, Max Reitz wrote:
>>> The reason why we would want to check it is, of course, because that
>>> bit does have a meaning in regular L2 entries.
>>>
>>> But that bit is ignored in images with subclusters so the only reason
>>> why we would check it is to report corruption, not because we need to
>>> know its value.
>>
>> Sure.  But isn=E2=80=99t that the whole point of having
>> QCOW2_SUBCLUSTER_INVALID in the first place?
>=20
> At the moment we're only returning QCOW2_SUBCLUSTER_INVALID in cases
> where there is no way to interpret the entry correctly: a) the
> allocation and zero bits are set for the same subcluster, and b) the
> allocation bit is set but the entry has no valid offset.
>=20
> It doesn't mean that we cannot use _SUBCLUSTER_INVALID for cases like
> the one we're discussing, but this one is different from the other two.

OK, that makes sense.

Max


--SkwgHgeRClf9ii82Ewkwm9LgMthipa34N--

--hjaOr5kRsISk9UuLiEXKnIIT0JMJPrNq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7+24QACgkQ9AfbAGHV
z0DXcwf/YqOXv0DM9tC3Nw4VV3FxXtq6m4WAz9VpstV+7EAmDkqKMnzQsmFaWUsd
gOEbGTxSN2afk0oU0s4ZFJCMCY3TCPuKCVcM0cjHOpcxj79KImxnCd6zyHCgbSgm
GtGduXyNrFCwXxClNiYZKY6Hr7oHTS0as4DQJnTjK7FfSWoskkkx9P0VFaB0J78o
Xf5BFVjaFogUSviKm7HWrA8OHORd0cpgRwukZWPC0hAEElPKzP0rS3SKg1BYF0zY
3mBEk2pV9RiRpscSdBdeeNvJ9gj5YQGxickrfYUZDQTnkwlNGD39WY5/XTRAJFsv
wje2dLzIdbD+DFLQ4I7tU0G0fLterw==
=rqc7
-----END PGP SIGNATURE-----

--hjaOr5kRsISk9UuLiEXKnIIT0JMJPrNq8--



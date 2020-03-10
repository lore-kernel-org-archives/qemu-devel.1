Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50F8C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40C821D56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVTFtORT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40C821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiWt-00071y-Sw
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBiVu-0006TM-2O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBiVt-0006ur-45
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:17:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBiVs-0006tD-W1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583860672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hmlhxZOkXzRRgKFoF8ho8DT41ecnwElXcSZluR60VH8=;
 b=YVTFtORTUphTWkKA9Emqrsk5DfUeQk4SSCqaB6wUpmQzGfVLvltusahBTF3ZPyaARmylq3
 Hdd1HASXHQgoSEkNq9CN//nygmHw7eA9GHPcZsVf9NmATPK7b1yKHI7F70N7z7rvhtjri6
 Ovk8SK3Br2253gQRxAUu+y/fZA/+UoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Mm27ozA3PfKrxCj-1tqShA-1; Tue, 10 Mar 2020 13:17:50 -0400
X-MC-Unique: Mm27ozA3PfKrxCj-1tqShA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E27A8017CC;
 Tue, 10 Mar 2020 17:17:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B2F909FA;
 Tue, 10 Mar 2020 17:17:44 +0000 (UTC)
Subject: Re: [PATCH v4 00/10] Further bitmaps improvements
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <4cf33f31-cdbb-cee4-a1b4-4053c88a002e@redhat.com>
 <6b570584-100b-248f-5412-98a5d91f62f5@virtuozzo.com>
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
Message-ID: <ca6f95ef-d51f-130a-8ad1-4eba5e0a3528@redhat.com>
Date: Tue, 10 Mar 2020 18:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6b570584-100b-248f-5412-98a5d91f62f5@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vCIbabGswxFKbxqBTW7FHWRYHn0k2DMxf"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vCIbabGswxFKbxqBTW7FHWRYHn0k2DMxf
Content-Type: multipart/mixed; boundary="07QkFx7l6d8sQKYNwpSVwJI9d3lPL9q4A"

--07QkFx7l6d8sQKYNwpSVwJI9d3lPL9q4A
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.03.20 08:45, Vladimir Sementsov-Ogievskiy wrote:
> 26.02.2020 16:13, Max Reitz wrote:
>> On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi!
>>>
>>> The main feature here is improvement of _next_dirty_area API, which I'm
>>> going to use then for backup / block-copy.
>>>
>>> Somehow, I thought that it was merged, but seems I even forgot to send
>>> v4.
>>
>> The changes from v3 look good to me, but I=92d prefer a review from Eric
>> on patch 8.
>>
>=20
> Hi!
>=20
> Could you take it now, or do you prefer me to resend?

I understand that you agreed to drop the comment above
bd_extent_array_convert_to_be(), then do the
=93s/further call/so further calls/=94 replacement, and finally replace the
whole four lines Eric has quoted by =93(this ensures that after a failure,
no further extents can accidentally change the bounds of the last extent
in the array)=94?

Max


--07QkFx7l6d8sQKYNwpSVwJI9d3lPL9q4A--

--vCIbabGswxFKbxqBTW7FHWRYHn0k2DMxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5ny7cACgkQ9AfbAGHV
z0DPXggAvYSqJsg/T8YFWw3Lb2CzghkWqJZT6L9p9BkriBfzb06TVTHcLiJ0R8ki
v+OGJbdsnSuCOB1o1s5zsrov/2G7W1tDL+8+RUZKb1QYwPASDFXcrXtd0LE1VCBR
gM1vDltDlEBo+Kr84VasxBsUxOJikcaUW+xOjZtYS5PrbdLpOdeFsAMuFB1ZLM7h
8WUNCnpGlG7pvUR2roY0DNhgtJ9rMetxjAV7GS+Ehb+QuBZ9trD8qjFvMiRXIBzJ
fIiYpKyzY7Y8zNLH1HBxnKWpFEA+jGKWfhE5K+MoxqBONiyveObbjwUSpLSutwRD
FBb5Wf83/G2nHlIHLQLqHXqt7alzng==
=H0oD
-----END PGP SIGNATURE-----

--vCIbabGswxFKbxqBTW7FHWRYHn0k2DMxf--



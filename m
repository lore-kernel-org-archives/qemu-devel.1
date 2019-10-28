Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447FCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44D12086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC5TVxpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44D12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3qh-0003gd-Q4
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3pc-00017W-Da
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3pa-0007Jl-7n
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:09:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3pZ-0007JL-VB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j7ilWBBoBaYqqAcI9trl0XHytPmCclNtf+NN9nyl60c=;
 b=PC5TVxpSQikq+BJ06WJhFSDfrBi98sMrYMTFbtmRsP+x70FwmcdScFSxtWDIDfNA+KQ/PR
 76DzpF1W87o6lDX9b8iaTNHOGFyAFsjZ0C9Kc7YzMMtXxCNKPMoBhnv6FGZQeF+sVv01R0
 MqKcgAZ+4bFjDASvuKs7zWRHOkqEZ6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-5Nrk8gtfN9G8uMOErRuTjQ-1; Mon, 28 Oct 2019 08:09:01 -0400
X-MC-Unique: 5Nrk8gtfN9G8uMOErRuTjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9815980183E;
 Mon, 28 Oct 2019 12:09:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B78AF26186;
 Mon, 28 Oct 2019 12:08:59 +0000 (UTC)
Subject: Re: [PATCH] qemu-iotests: restrict 264 to qcow2 only
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191025145023.6182-1-vsementsov@virtuozzo.com>
 <6284b05a-192b-0a63-6767-145a4a832424@redhat.com>
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
Message-ID: <0188acea-2709-b243-22d0-3e1ee2546bb6@redhat.com>
Date: Mon, 28 Oct 2019 13:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6284b05a-192b-0a63-6767-145a4a832424@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="88ZMGiK8WXMRMEE3t2YD1np4xlvUN9phm"
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--88ZMGiK8WXMRMEE3t2YD1np4xlvUN9phm
Content-Type: multipart/mixed; boundary="Mai0XHLuvbHiVALPPA7Uhu2rdLt70pI7m"

--Mai0XHLuvbHiVALPPA7Uhu2rdLt70pI7m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.19 17:38, Eric Blake wrote:
> On 10/25/19 9:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 264 is unprepared to run with different formats, for example luks needs
>> handling keys, cloop doesn't support image creation, vpc creates image
>> larger than requested (which breaks "Backup completed: 5242880" in test
>> output).
>>
>> The test is here to check nbd-reconnect feature and we actually don't
>> need it for all formats. Let's restrict it to qcow2 only.
>>
>> Reported-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/264 | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I will queue through my NBD tree; it may miss soft freeze (due to my
> travel schedule for KVM Forum), but is definite 4.2 material, so it will
> be in by rc1.

Hm, well.  I need this patch anyway or my pre-pull-request tests won=E2=80=
=99t
pass.  So I suppose there is no reason for me not to take it. O:-)

Max


--Mai0XHLuvbHiVALPPA7Uhu2rdLt70pI7m--

--88ZMGiK8WXMRMEE3t2YD1np4xlvUN9phm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl222loACgkQ9AfbAGHV
z0AWKggAu8pM2RjegfrOls3Z2MVER9tU01C2zKJexTcvfFUMoxjjG2GzseJGb5Dw
0EQ6pfHE+SVPr4ZpKDOWRz76qkwGW6nApqXtpmcswctmGm7ZYWIepptLdONKyhMk
auKxUH60TA+G9Tq1MLaZXTrR361oudzCMmepb4VpBIPQ4WH0+iBPcXzX9jKFsmzC
xGnlnB2vjMw0hdwuDYI58MSp9wl5fFJDzyz8dMQZG5jsNw9DBUXOXm8nSHMehWu5
9MLMJGhvc1amMxjEnie2UUB4Ebfdqcryt0aYGkzbT1cDY45SNS+UXaamWhiU4wMy
kbXgfPApKqTEKuQigoCzqsjDailWvg==
=koQ4
-----END PGP SIGNATURE-----

--88ZMGiK8WXMRMEE3t2YD1np4xlvUN9phm--



Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB54C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45822051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXRhACLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45822051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgjl-00033l-Vt
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBgab-0005i9-Ba
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBgaZ-0001nE-S9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:14:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31341
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBgaZ-0001iv-M7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583853274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VFXndVEcrrcJoj9rsE1Gsu7mPRy/UFGeBBhOuluBo4E=;
 b=EXRhACLoQSMGdOoiiAUcygIUc5Zb9/b+KClTEwSgwrSOvaEZTLztzWIf/Wjwybtim9wk2J
 qyyFOUUBz8Wgcmtm2W73xEcNtDSWQHmjw9dFNANISroHBVKDoL6HkcNhApNOdxEuW2WlN2
 ZsLe8YK+T0aGBqpzCP2VkuE1ETz5Xok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-AWeFPntMP22tAtheb3kvtg-1; Tue, 10 Mar 2020 11:14:30 -0400
X-MC-Unique: AWeFPntMP22tAtheb3kvtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 966BB106E5BC;
 Tue, 10 Mar 2020 15:14:29 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81CF5100164D;
 Tue, 10 Mar 2020 15:14:27 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] block/block-copy: rename start to offset in
 interfaces
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-8-vsementsov@virtuozzo.com>
 <826a06c1-49d0-24a0-4098-fc0ec8f9f5a0@redhat.com>
 <5b30a84f-3b03-d894-f908-b0fae89615d5@virtuozzo.com>
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
Message-ID: <7d19fbd3-29ee-c414-38ec-1dc67735043c@redhat.com>
Date: Tue, 10 Mar 2020 16:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5b30a84f-3b03-d894-f908-b0fae89615d5@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xLrOXYOjf19MWF3DGjJSfIT0MsRxH69of"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xLrOXYOjf19MWF3DGjJSfIT0MsRxH69of
Content-Type: multipart/mixed; boundary="mnTayVElV6tli8cFZHYsfZ2lo3XTYZVmA"

--mnTayVElV6tli8cFZHYsfZ2lo3XTYZVmA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.03.20 15:55, Andrey Shinkevich wrote:
>=20
>=20
> On 10/03/2020 17:50, Max Reitz wrote:
>> On 06.03.20 08:38, Vladimir Sementsov-Ogievskiy wrote:
>>> offset/bytes pair is more usual naming in block layer, let's use it.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>> =A0 include/block/block-copy.h |=A0 4 +-
>>> =A0 block/block-copy.c=A0=A0=A0=A0=A0=A0=A0=A0 | 84 +++++++++++++++++++=
-------------------
>>> =A0 2 files changed, 44 insertions(+), 44 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 4c947e548b..2b29131653 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>> @@ -25,13 +25,13 @@
>>> =A0 #define BLOCK_COPY_MAX_MEM (128 * MiB)
>>> =A0 =A0 static BlockCopyInFlightReq
>>> *find_conflicting_inflight_req(BlockCopyState *s,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>> start,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>> bytes)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>> offset,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t
>>> bytes)
>>
>> The alignment=92s off now.
>>
>> Max
>>
>=20
> After applying the patch, it looks aligned in my vim editor.

I did apply it and it wasn=92t aligned for me.

Now we (Red Hat) have some mailing agent for a couple of months now that
for some reason likes to change incoming mails=92 encodings (in this case
from, I presume, 8bit to quoted-printable), so I have to use a script to
translate it back.  But judging from what I can see in the archive:

https://lists.nongnu.org/archive/html/qemu-block/2020-03/msg00196.html

the alignment is indeed off.  Otherwise, the second line (with the
@bytes parameter) would not be changed.

Max


--mnTayVElV6tli8cFZHYsfZ2lo3XTYZVmA--

--xLrOXYOjf19MWF3DGjJSfIT0MsRxH69of
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5nrtEACgkQ9AfbAGHV
z0Bmswf+KwWP+D4IOu2dp9+s4Kykt9xCzBQS8TjNlPhRgxDCmSoCrAQMAe9uJze9
S8oWm0L/3nURvACGpyZcADo/Fg2/l7hx97cbQebJQNcuBPqMyZx9/UYTS7BpLIAB
801GM7ujiO+IcHmVc4eP5+l8s9HfgbMLNyiAggwXCPEfmHsMu+JYMuvGbyBPHtnl
kG/s4uXvgjK5/tNqoTNHoEdMF96R2bAN/KSuIsYgLKruLsuLBsQo0pKHgvSBHHl/
TAvc6RFm5gyyOYggWpapyvPhHR4CLeLUfX6Ossh5SLqgooxzFXcPEtmPPkkDatM2
AWtQg4zxnP8wETX+qkp6ZfFfHD5iLg==
=BI31
-----END PGP SIGNATURE-----

--xLrOXYOjf19MWF3DGjJSfIT0MsRxH69of--



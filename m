Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50B1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D9422314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/dSMaZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D9422314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itaaD-0001F7-Sa
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itaV1-00043N-Dh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itaUx-0000q7-OS
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:06:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52332
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itaUx-0000pM-Ip
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579539958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UsTY9vMgh+jd0j21GhQ17UWX6Ri2GiL8aqCzIiDf18Q=;
 b=F/dSMaZstzwA1F3IDAyeMecq1m9eM9/mHwlwER2+tKAkXT9eZKLdmgamNrJcneOAE3BKED
 LyAHk82lFZw2pGUHhhInBpT0pYGhD2Hv5lLB+sfiOR+5Cbx3aabxR5QKp9gcdMeRnPlFHW
 y0iPhzpquqlE1Dv60dCmHyld5oZc31U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-FdOPfMqKM-KnYKJB3B1vkQ-1; Mon, 20 Jan 2020 12:05:55 -0500
X-MC-Unique: FdOPfMqKM-KnYKJB3B1vkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC9E3100550E;
 Mon, 20 Jan 2020 17:05:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BB177C3D9;
 Mon, 20 Jan 2020 17:05:48 +0000 (UTC)
Subject: Re: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-5-vsementsov@virtuozzo.com>
 <a42037d5-0d62-d916-a814-ba755b6ad9a4@redhat.com>
 <e6d654fb-7c04-c709-6b2a-3801ae1008d6@virtuozzo.com>
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
Message-ID: <0cf94b1f-e7cb-081a-34ab-63a7d9ba80ce@redhat.com>
Date: Mon, 20 Jan 2020 18:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e6d654fb-7c04-c709-6b2a-3801ae1008d6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0vqcSQG8UDIJd0eIba8BjAyht4cqVYVgc"
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0vqcSQG8UDIJd0eIba8BjAyht4cqVYVgc
Content-Type: multipart/mixed; boundary="lSda3tWI8tm1KuANMSJRgxO4rEgWSAxev"

--lSda3tWI8tm1KuANMSJRgxO4rEgWSAxev
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.01.20 17:20, Vladimir Sementsov-Ogievskiy wrote:
> 20.01.2020 14:13, Max Reitz wrote:
>> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   include/qemu/hbitmap.h |  21 --------
>>>   tests/test-hbitmap.c   | 115 ----------------------------------------=
-
>>>   util/hbitmap.c         |  16 ------
>>>   3 files changed, 152 deletions(-)
>>
>> Er, hrm, well.
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> git log me the only commits that touched anything to the regard of
>> '*create_meta*' were the ones that introduced it and your commit that
>> dropped it.
>>
>> Soo, er, well, okay.  Why did we introduce these again?  (I suppose I
>> should know since they have my S-o-b on them.  But I actually don=92t.)
>>
>> Max
>>
>=20
> I'm a bit not follow what you mean. I can just note, that dirty-bitmap.c
> part of meta bitmaps was recently removed, and hbitmap.c part I forgot to
> remove...

Yes, but who used that dirty-bitmap.c interface?  As far as I can tell,
nobody.

> Meta bitmaps were intended to control live migration of bitmaps and to
> implement something like partial sync of bitmaps (write to qcow2 only
> changed part of bitmap), but migration implemented in other way
> (postcopy) and the second thing was not implemented.

OK.  I was wondering why they were implemented without ever having been
used (as far as I can tell).

Max


--lSda3tWI8tm1KuANMSJRgxO4rEgWSAxev--

--0vqcSQG8UDIJd0eIba8BjAyht4cqVYVgc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4l3esACgkQ9AfbAGHV
z0C4Hwf/U4B/eUQidBiL1oKNDkhCiYMN39GKV8FIPnARuqkAGRAvI4ylnhAmu5S0
ZOl1/kBENsiTFXiFcM1uyusUxGCGviFnqXaU8RNfhw8rok0OQf53dnKGaLnZrgnA
xt74oeNYtfN479G6kUYtmA0fcrGae4TIjiyH+Fc2ekmZYgBLLMOhPaRiix7mWS9r
m05sWfTOptL5dau/L48Zhhr08Lpv0/JYvkaY+uCTs41Z5l3IaIbmfK21nWjZuPuq
ZmVMEDlrMZFJhl8oCLOhri2OSGFUHe2xfU6w5zF6MRH83h6Ej2kjaIRTC567KSFT
ag5/Xg+l+cdiwAano4rgiRPE6BgyuQ==
=0xzF
-----END PGP SIGNATURE-----

--0vqcSQG8UDIJd0eIba8BjAyht4cqVYVgc--



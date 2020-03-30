Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFA8C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189BF20578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWiwMlmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189BF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItXm-0005QF-9D
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jItX9-00050s-A4
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jItX8-0001g9-8a
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:28:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jItX8-0001fD-42
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585571329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ky762nRkJDW6TArlgpK+VStkZShIjizRWGVtmFTDN0w=;
 b=jWiwMlmLXQ6WxZwpZ1SFJfL/W4E5eQaeXrHnEAhJ23Jr4a22652mTkJpsJZzwnu1dh8bvB
 qu5wSRJFDytd5WB5OA2Zq6nEj90QzDZbEWV5K4+n7Rl9YUkGW3p+LD38ktFqnXVIH8wOhk
 p3RdJcq3T9eoKWOv/sAltBVpVDu1Rfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-e6xgHH7gN1uwF6zYeAJ8Cw-1; Mon, 30 Mar 2020 08:28:45 -0400
X-MC-Unique: e6xgHH7gN1uwF6zYeAJ8Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C83192EDD;
 Mon, 30 Mar 2020 12:28:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-93.ams2.redhat.com
 [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BF8499DE5;
 Mon, 30 Mar 2020 12:28:38 +0000 (UTC)
Subject: Re: [PATCH v9 08/14] iotests: touch up log function signature
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-9-jsnow@redhat.com>
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
Message-ID: <7b3f5027-150f-6c3b-42c5-3a579c735192@redhat.com>
Date: Mon, 30 Mar 2020 14:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-9-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zZCfIn6PWwhZy0DJtmhzLGNbUeGJalg6A"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zZCfIn6PWwhZy0DJtmhzLGNbUeGJalg6A
Content-Type: multipart/mixed; boundary="b4nENU2L0WzecodcoFi5d1q8zEAKuv0SN"

--b4nENU2L0WzecodcoFi5d1q8zEAKuv0SN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 00:20, John Snow wrote:
> Representing nested, recursive data structures in mypy is notoriously
> difficult; the best we can reliably do right now is denote the atom
> types as "Any" while describing the general shape of the data.
>=20
> Regardless, this fully annotates the log() function.
>=20
> Typing notes:
>=20
> TypeVar is a Type variable that can optionally be constrained by a
> sequence of possible types. This variable is bound per-invocation such
> that the signature for filter=3D() requires that its callables take e.g. =
a
> str and return a str.

So it works like a generic, except that its declaration isn=E2=80=99t part =
of
and thus local to the function.  Interesting.  Not sure if I like it,
but, well, it=E2=80=99s Python.  (Seems to me on the same level of =E2=80=
=9CInteresting=E2=80=9D
as the =E2=80=9CDon=E2=80=99t use an empty list as a default argument=E2=80=
=9D thing.[1])

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Haha.  I can=E2=80=99t help but find it funny how my =E2=80=9CI won=E2=80=
=99t complain, but I
feel like some people might want this to be two patches=E2=80=9D led to thi=
s =E2=80=9CIf
I=E2=80=99m going to make a dedicated patch for this, I might as well go al=
l the
way=E2=80=9D patch.  It=E2=80=99s quite cool.

Reviewed-by: Max Reitz <mreitz@redhat.com>

[1] I just read an article on that thing again (empty lists as default
argument), which claims that this is in fact a very useful feature of
Python.  This makes me want to go on another rant, but I=E2=80=99ve learned
enough restraint by now not to.


--b4nENU2L0WzecodcoFi5d1q8zEAKuv0SN--

--zZCfIn6PWwhZy0DJtmhzLGNbUeGJalg6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6B5fUACgkQ9AfbAGHV
z0ChWwf+Odxwd5LkjKjEy5wL9AUaQhAIIN8yrFZXR23tzKsQFfe0mBb1IHRo3f6B
oJ50oRTHT9w27Ie3lGTj+f/bHKJvDpqcdNRmsjQ7K7DeAoxWrNzZhEoskUXWVBuA
c1MwH8ZEO68BsW7leLGAfvADtxNBIfZayRNV++NUozS/xfWt0cZUs0lqCw7gdvI0
hPaWzTv8gdZ0Zd/79ffKjZoCN5yDkjRKGpZuN/GbrcrspvyV2Te06LCLBgjX9ivy
Yhh5nN5aQTLt+s2JXhNHxy6hAT8YOTpDThu8pWchc5k0A9xGqMCoWFv8BDRsaKUU
2XASMwrLFnP0qO7ko2mJqO4Sgzrqkg==
=taUt
-----END PGP SIGNATURE-----

--zZCfIn6PWwhZy0DJtmhzLGNbUeGJalg6A--



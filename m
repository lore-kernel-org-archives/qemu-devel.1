Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C086C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77FB206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77FB206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGQ9-0002ez-1J
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1htGPh-0002AC-Ny
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1htGPg-0001Q5-Mp
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:06:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1htGPc-0001Lw-Ha; Thu, 01 Aug 2019 15:06:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED1DBADAE8;
 Thu,  1 Aug 2019 19:06:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-187.brq.redhat.com
 [10.40.204.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCA815D9D3;
 Thu,  1 Aug 2019 19:06:44 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
 <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
 <db90d600-3336-5791-659b-518e88919014@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <e4011bd5-7b6b-2bc7-4739-699980abdad6@redhat.com>
Date: Thu, 1 Aug 2019 21:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <db90d600-3336-5791-659b-518e88919014@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JuRKQC7MvTWMuu1hJ2IpBMrWdlgdtFK2v"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 01 Aug 2019 19:06:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JuRKQC7MvTWMuu1hJ2IpBMrWdlgdtFK2v
Content-Type: multipart/mixed; boundary="j8bFQKcnsDXTVYWLZ2JmcvlZ7hDrLSdgf";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <e4011bd5-7b6b-2bc7-4739-699980abdad6@redhat.com>
Subject: Re: [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
 <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
 <db90d600-3336-5791-659b-518e88919014@virtuozzo.com>
In-Reply-To: <db90d600-3336-5791-659b-518e88919014@virtuozzo.com>

--j8bFQKcnsDXTVYWLZ2JmcvlZ7hDrLSdgf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.08.19 16:02, Vladimir Sementsov-Ogievskiy wrote:
> 31.07.2019 15:09, Max Reitz wrote:

[...]

>> So -- without having tried, of course -- I think a better design would=

>> be to look for bs->file->bs in the ReopenQueue, recursively all of its=

>> children, and move all of those entries into a new queue, and then
>> invoke bdrv_reopen_multiple() on that one first.
>=20
> Why all children recursively? Shouldn't we instead only follow defined
> dependencies?
> Or it just seems bad to put not full subtree into bdrv_reopen multiple(=
) ?

For example, making a node RW without opening its children RW seems
wrong.  Whenever we reopen a node, we should reopen all of its children,
if they are in the queue.

>> The question then becomes how to roll back those changes...  I don=E2=80=
=99t
>> know whether just having bdrv_reopen() partially succeed is so bad.
>> Otherwise, we=E2=80=99d need a function to translate an existing node'=
s state
>> into a BdrvReopenQueueEntry so we can thus return to the old state.
>=20
> And this rollback may fail too and we are still in partial success stat=
e.
>=20
> But if we roll-back simple ro->rw reopen it's safe enough: in worst cas=
e
> file will be rw, but marked ro, so Qemu may have more access rights tha=
n
> needed but will not use them, this is why I was concentrating around
> only ro->rw case..

In practice, this is always so.  The =E2=80=9Cchildren need to be reopene=
d
before parent=E2=80=9D case is always a sign of more permissions being ta=
ken;
whereas =E2=80=9Cchildren need to be reopened after parent=E2=80=9D is a =
sign of
permissions being released.

What we want to fix now is the former =E2=80=9Creopen children before par=
ent=E2=80=9D
case.  Because this is always a sign of taking more permissions, a
partial success/failure state means we always have taken more
permissions than we need to.

> So, what about go similar way to this patch, i.e. only reopen ro->rw ch=
ildren
> which we need to be rw, not touching other flags, but check, that in re=
open
> queue we have this child, and it is going to be reopened RW, and if not=
,
> return error immediately?

If the RO -> RW change for the child is accompanied by other options
being changed, the user may find it vital to change these flags along
with the RO/RW access.  We shouldn=E2=80=99t ignore them.

Max


--j8bFQKcnsDXTVYWLZ2JmcvlZ7hDrLSdgf--

--JuRKQC7MvTWMuu1hJ2IpBMrWdlgdtFK2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1DOEMACgkQ9AfbAGHV
z0DOVQf7BMRXeZUlHcHlOt2mwNmzTWjqsu6mIA1a+gmibZncECxsz3XR0JEyF5iR
4zZScArk4AAjNvF4npLKCR4bWwq6ubMjspJmt0MAg06+Gn05iNh7RgsWUheTT49L
TcYn+xcS4nSbBcPOm82WCuO2EtXJy48cysynTPq8jhcUJ2stG0F1MM2hSB0dEav+
Vdu50MONRvZiEdxgGlCQCVz/nzo1/6oYyK4U+BtLE9yOgN0EGCUsfQ5gycdl3U8A
SeJUf7bHd6ju8/eBjy/MosJku/sC3UOLCUiMPQn6TuZPBGnxEmMfq0n+O1LJcdY8
gQXeQ1ZaPZjAfGA994jGZ4n+ZeIjaQ==
=dw3h
-----END PGP SIGNATURE-----

--JuRKQC7MvTWMuu1hJ2IpBMrWdlgdtFK2v--


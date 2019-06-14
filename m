Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85BAC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770EA2183F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770EA2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpRe-000472-GD
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39194)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbowf-0000nr-2C
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbowe-0001tn-3G
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbowa-0001qS-GR; Fri, 14 Jun 2019 12:20:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 534443091753;
 Fri, 14 Jun 2019 16:20:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DD375D9D2;
 Fri, 14 Jun 2019 16:20:35 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-24-mreitz@redhat.com>
 <112404e2-7172-865c-d888-6a5cddcc40ec@virtuozzo.com>
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
Message-ID: <b875c83b-c3a8-3a2c-2e92-716f5dc4411a@redhat.com>
Date: Fri, 14 Jun 2019 18:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <112404e2-7172-865c-d888-6a5cddcc40ec@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h25BM4vX1gPZdo2nXDB4lUa9nWejHvTVm"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 14 Jun 2019 16:20:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 23/42] blockdev: Use CAF in
 external_snapshot_prepare()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h25BM4vX1gPZdo2nXDB4lUa9nWejHvTVm
Content-Type: multipart/mixed; boundary="VEvUOPgC60sSQnGcsmicAht7c0zIUlogt";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <b875c83b-c3a8-3a2c-2e92-716f5dc4411a@redhat.com>
Subject: Re: [PATCH v5 23/42] blockdev: Use CAF in external_snapshot_prepare()
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-24-mreitz@redhat.com>
 <112404e2-7172-865c-d888-6a5cddcc40ec@virtuozzo.com>
In-Reply-To: <112404e2-7172-865c-d888-6a5cddcc40ec@virtuozzo.com>

--VEvUOPgC60sSQnGcsmicAht7c0zIUlogt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> This allows us to differentiate between filters and nodes with COW
>> backing files: Filters cannot be used as overlays at all (for this
>> function).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Overlay created in snapshot operation assumed to consume following writ=
es
> and it's filtered child becomes readonly.. And filter works in complete=
ly another
> way.
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> [hmm, I start to like using "filtered child" collocation when I say abo=
ut this thing.
>   didn't you think about renaming backing chain to filtered chain?]

Hm.  There are backing chains and there are backing chains.  There are
qemu-internal backing chains that consist of a healthy mix of filters
and COW overlays, and then there are the more high-level backing chains
the user actually manages, where only the overlays are important.

I think it would make sense to rename the =E2=80=9Cqemu-internal backing =
chains"
to =E2=80=9Cfilter chains=E2=80=9D or something.  But that makes it sound=
 a bit like it
would only mean R/W filters...  Maybe just =E2=80=9Cchain=E2=80=9D?

Actually, the only functions I find are is_backing_chain_frozen & Co,
and they could simply become is_chain_frozen.  Is there anything else?

Max


--VEvUOPgC60sSQnGcsmicAht7c0zIUlogt--

--h25BM4vX1gPZdo2nXDB4lUa9nWejHvTVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DyVIACgkQ9AfbAGHV
z0CcOgf/U7VLnHaEaio1ibSs7Ygccs9Mb5AKSVYyeFr+QGvnKapcVyyaVj/v9SvX
oGKjYMLR1rvcWXGwaEM/gO0CjggqV5eU8RCFzWULvW48iaKFyvhV17LEfPcblGl7
nh8wAw+ugVYfgDPdCKjD533VvjAPqB8BfT4onFOECJNGELgWO8a/gkrD8rW0SD0f
mQafgiTUHIN+uHEa/jpdCRhLENHhkSlxY6ZSbpaQILq/m58P2k9zVNNaieqvS0Cz
5CmuuX5NXGOO+wGS/l/GeNVm1aMdgIcaWhZLsVjJ7UABFKyP4oBc5RjdExk5jEJ2
qgYM76Z8eunuEuVdH1Y9kz4NldpWiA==
=7gf+
-----END PGP SIGNATURE-----

--h25BM4vX1gPZdo2nXDB4lUa9nWejHvTVm--


Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D943C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4B6207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3VVYGn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4B6207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rZ4-0006Kl-3L
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5rXY-000521-5M
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5rXW-0001l2-1f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597241736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=40zAcI1Sx5Nc4Uxkno+VNJ+Zje731TnvYJ81IPT+5M4=;
 b=D3VVYGn/sbSjo44ufJxGrZWXLw/FjJWHnqjPmXTDATJvz/0kBKKalSiol7plZb/ToV1qkw
 VXfbJgjynchNGrcVjLV26v7phlktQap5MVXJVFB5aKZUGgrLkXf0+KIRaJoUH5xT7ZodFC
 IkU4LACYWKy18j29/t/4P4xj0H4XBew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-lYfBRArtMwCE6uOV1VK3YQ-1; Wed, 12 Aug 2020 10:15:21 -0400
X-MC-Unique: lYfBRArtMwCE6uOV1VK3YQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E36F58;
 Wed, 12 Aug 2020 14:15:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-161.ams2.redhat.com
 [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 698FC5D733;
 Wed, 12 Aug 2020 14:15:18 +0000 (UTC)
Subject: Re: [PATCH for-5.2 v3 0/3] migration: Add block-bitmap-mapping
 parameter
To: qemu-block@nongnu.org
References: <20200722080516.126147-1-mreitz@redhat.com>
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
Message-ID: <9fb447d8-acc8-2338-630f-1e33e08aacd8@redhat.com>
Date: Wed, 12 Aug 2020 16:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722080516.126147-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DbjAbJZgCgoqIUJ7QPeG8cwOspOjugcv1"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:15:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DbjAbJZgCgoqIUJ7QPeG8cwOspOjugcv1
Content-Type: multipart/mixed; boundary="rf2xw9Q6qeuIirxvNpLYgsFLrkrNGfwRz"

--rf2xw9Q6qeuIirxvNpLYgsFLrkrNGfwRz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping =E2=80=93 seems like everyone found v2 more or less acceptable bar the
failing assertion in patch 1, and some aspects of the test.  How about
v3, are there any objections?

On 22.07.20 10:05, Max Reitz wrote:
> RFC v1: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00912=
.html
> RFC v2: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00915=
.html
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09792.htm=
l
> v2: https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01179.htm=
l
>=20
> Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v3
> Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping=
-v3
>=20
> Hi,
>=20
> This new migration parameter allows mapping block node names and bitmap
> names to aliases for the purpose of block dirty bitmap migration.
>=20
> This way, management tools can use different node names on the source
> and destination and pass the mapping of how bitmaps are to be
> transferred to qemu (on the source, the destination, or even both with
> arbitrary aliases in the migration stream).
>=20
>=20
> v3:
> - Patch 1:
>   - Add notes on the fact that the destination won=E2=80=99t ever know ab=
out any
>     bitmaps that aren=E2=80=99t sent, so you can freely drop what you wan=
t, and
>     you=E2=80=99re completely free in renaming bitmaps and putting them o=
n
>     =E2=80=9Cother=E2=80=9D nodes (whatever =E2=80=9Cother=E2=80=9D node =
means in the context of
>     migration, because that=E2=80=99s kind of one of the problems this se=
ries is
>     trying to solve: The fact that you can=E2=80=99t trivially match node=
s
>     between source and destination)
>   - Fix an assertion
>=20
> - Patch 2: s/pass/time.sleep(0.2)/
>=20
> - Patch 3:
>   - Add copyright line
>   - Use format string instead of %
>   - s/pass/time.sleep(0.1)/
>   - s/wait_for_runstate/wait_migration/ on the destination to wait for
>     the migration to actually complete
>   - Replace the =E2=80=9Cinfo migrate_parameters=E2=80=9D parsing code by=
 a multiline
>     regex
>   - Test what happens when the destination has a mapping that isn=E2=80=
=99t used
>     because there are not bitmaps to be transferred (which breaks the
>     assertion in patch 1 as it was in v2)
>   - Let verify_dest_has_all_bitmaps() actually verify the bitmaps on the
>     destination instead of the source
>=20
>=20
> git-backport-diff against v2:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/3:[0014] [FC] 'migration: Add block-bitmap-mapping parameter'
> 002/3:[0003] [FC] 'iotests.py: Add wait_for_runstate()'
> 003/3:[0046] [FC] 'iotests: Test node/bitmap aliases during migration'
>=20
>=20
> Max Reitz (3):
>   migration: Add block-bitmap-mapping parameter
>   iotests.py: Add wait_for_runstate()
>   iotests: Test node/bitmap aliases during migration
>=20
>  qapi/migration.json            | 104 ++++++-
>  migration/migration.h          |   3 +
>  migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++----
>  migration/migration.c          |  30 ++
>  monitor/hmp-cmds.c             |  30 ++
>  tests/qemu-iotests/300         | 515 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/300.out     |   5 +
>  tests/qemu-iotests/group       |   1 +
>  tests/qemu-iotests/iotests.py  |   5 +
>  9 files changed, 1011 insertions(+), 55 deletions(-)
>  create mode 100755 tests/qemu-iotests/300
>  create mode 100644 tests/qemu-iotests/300.out
>=20



--rf2xw9Q6qeuIirxvNpLYgsFLrkrNGfwRz--

--DbjAbJZgCgoqIUJ7QPeG8cwOspOjugcv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8z+XQACgkQ9AfbAGHV
z0C58AgAjKB+8jxNtxXBTDm63Gam9fkf4ArgSI63nlmj/9iRZo/M3X70V8OUaFsZ
53jaSXMao1rmr01t4E4GAY2YZTt0kE54fTjp//U02JiAKKYn7nZqUBrl8uByBWkj
CoJ/2zW0Q9S95Jp3qFJ4qAH5S4dmy6uUPDWv4GxJRmaiHhRy380Np+mn4PUkwfMl
ICl3qKqegZn4KoPBMkDGCXuQwtR2zz4pAQAn2ivg0QoPALZIgeFmjial/X08lmGE
0FhCvuu8lLF/xU0Ej3Wxei8yNDaXfpUuUtLnhwGZzcVAR+l8DAEBbNxXAAoqJYlb
0bIqM5LttRuGIyw+dbgjlS71gtJXQw==
=Kw3C
-----END PGP SIGNATURE-----

--DbjAbJZgCgoqIUJ7QPeG8cwOspOjugcv1--



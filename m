Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF21C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A7D2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A7D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn0y1-00069y-7H
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hn0xp-0005jX-N5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hn0xo-0005W0-Cg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hn0xl-0005KJ-ET; Mon, 15 Jul 2019 09:24:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 199DD368E6;
 Mon, 15 Jul 2019 13:24:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F845D71B;
 Mon, 15 Jul 2019 13:24:11 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190619152603.5937-1-mreitz@redhat.com>
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
Message-ID: <61036af7-c4b4-6737-450c-6fc5907223a7@redhat.com>
Date: Mon, 15 Jul 2019 15:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h8eQc92HoYqCO7FrW0H4RDchgLNnetUNd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 15 Jul 2019 13:24:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Delay poll when ending
 drained sections
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h8eQc92HoYqCO7FrW0H4RDchgLNnetUNd
Content-Type: multipart/mixed; boundary="00b6NmIkRcHxEaRCNYdGfviIkwjoW1iMI";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <61036af7-c4b4-6737-450c-6fc5907223a7@redhat.com>
Subject: Re: [PATCH v2 0/9] block: Delay poll when ending drained sections
References: <20190619152603.5937-1-mreitz@redhat.com>
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>

--00b6NmIkRcHxEaRCNYdGfviIkwjoW1iMI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping =E2=80=93 as this series fixes an abort and a segfault, I would appr=
eciate
reviews.

(Head over to =E2=80=9CFixes for concurrent block jobs=E2=80=9D for even =
more fixes for
aborts and segfaults.)

On 19.06.19 17:25, Max Reitz wrote:
> Hi,
>=20
> This is v2 to =E2=80=9Cblock: Keep track of parent quiescing=E2=80=9D.
>=20
> Please read this cover letter, because I=E2=80=99m very unsure about th=
e design
> in this series and I=E2=80=99d appreciate some comments.
>=20
> As Kevin wrote in his reply to that series, the actual problem is that
> bdrv_drain_invoke() polls on every node whenever ending a drain.  This
> may cause graph changes, which is actually forbidden.
>=20
> To solve that problem, this series makes the drain code construct a lis=
t
> of undrain operations that have been initiated, and then polls all of
> them on the root level once graph changes are acceptable.
>=20
> Note that I don=E2=80=99t like this list concept very much, so I=E2=80=99=
m open to
> alternatives.
>=20
> Furthermore, all BdrvChildRoles with BDS parents have a broken
> .drained_end() implementation.  The documentation clearly states that
> this function is not allowed to poll, but it does.  So this series
> changes it to a variant (using the new code) that does not poll.
>=20
> There is a catch, which may actually be a problem, I don=E2=80=99t know=
: The new
> variant of that .drained_end() does not poll at all, never.  As
> described above, now every bdrv_drain_invoke() returns an object that
> describes when it will be done and which can thus be polled for.  These=

> objects are just discarded when using BdrvChildRole.drained_end().  Tha=
t
> does not feel quite right.  It would probably be more correct to let
> BdrvChildRole.drained_end() return these objects so the top level
> bdrv_drained_end() can poll for their completion.
>=20
> I decided not to do this, for two reasons:
> (1) Doing so would spill the =E2=80=9Clist of objects to poll for=E2=80=
=9D design to
>     places outside of block/io.c.  I don=E2=80=99t like the design very=
 much as
>     it is, but I can live with it as long as it=E2=80=99s constrained t=
o the
>     core drain code in block/io.c.
>     This is made worse by the fact that currently, those objects are of=

>     type BdrvCoDrainData.  But it shouldn=E2=80=99t be a problem to add=
 a new
>     type that is externally visible (we only need the AioContext and
>     whether bdrv_drain_invoke_entry() is done).
>=20
> (2) It seems to work as it is.
>=20
> The alternative would be to add the same GSList ** parameter to
> BdrvChildRole.drained_end() that I added in the core drain code in patc=
h
> 2, and then let the .drained_end() implementation fill that with object=
s
> to poll for.  (Which would be accomplished by adding a frontend to
> bdrv_do_drained_end() that lets bdrv_child_cb_drained_poll() pass the
> parameter through.)
>=20
> Opinions?
>=20
>=20
> And then we have bdrv_replace_child_noperm(), which actually wants a
> polling BdrvChildRole.drained_end().  So this series adds
> BdrvChildRole.drained_end_unquiesce(), which takes that role (if there
> is any polling to do).
>=20
> Note that if I implemented the alternative described above
> (.drained_end() gets said GSList ** parameter), a
> .drained_end_unquiesce() wouldn=E2=80=99t be necessary.
> bdrv_parent_drained_end_single() could just poll the list returned by
> .drained_end() by itself.
>=20
>=20
> Finally, patches 1, 8, and 9 are unmodified from v1.
>=20
>=20
> git backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/9:[----] [--] 'block: Introduce BdrvChild.parent_quiesce_counter'
> 002/9:[down] 'block: Add @data_objs to bdrv_drain_invoke()'
> 003/9:[down] 'block: Add bdrv_poll_drain_data_objs()'
> 004/9:[down] 'block: Move polling out of bdrv_drain_invoke()'
> 005/9:[down] 'block: Add @poll to bdrv_parent_drained_end_single()'
> 006/9:[down] 'block: Add bdrv_drained_end_no_poll()'
> 007/9:[down] 'block: Fix BDS children's .drained_end()'
> 008/9:[----] [--] 'iotests: Add @has_quit to vm.shutdown()'
> 009/9:[----] [--] 'iotests: Test commit with a filter on the chain'
>=20
>=20
> Max Reitz (9):
>   block: Introduce BdrvChild.parent_quiesce_counter
>   block: Add @data_objs to bdrv_drain_invoke()
>   block: Add bdrv_poll_drain_data_objs()
>   block: Move polling out of bdrv_drain_invoke()
>   block: Add @poll to bdrv_parent_drained_end_single()
>   block: Add bdrv_drained_end_no_poll()
>   block: Fix BDS children's .drained_end()
>   iotests: Add @has_quit to vm.shutdown()
>   iotests: Test commit with a filter on the chain
>=20
>  include/block/block.h      |  22 +++++-
>  include/block/block_int.h  |  23 ++++++
>  block.c                    |  24 +++---
>  block/io.c                 | 155 ++++++++++++++++++++++++++++++-------=

>  python/qemu/__init__.py    |   5 +-
>  tests/qemu-iotests/040     |  40 +++++++++-
>  tests/qemu-iotests/040.out |   4 +-
>  tests/qemu-iotests/255     |   2 +-
>  8 files changed, 231 insertions(+), 44 deletions(-)
>=20



--00b6NmIkRcHxEaRCNYdGfviIkwjoW1iMI--

--h8eQc92HoYqCO7FrW0H4RDchgLNnetUNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0sfnkACgkQ9AfbAGHV
z0DBygf/Ud2iZGuljTpXLm6DwWv4G7DDOI1UQvzLbUUhbLXzYIxLn3lJyy5nce9m
HncSfAsE2SS8JVT+dvSae70Jg/xF0l/UApptyE+LREeXKT72T86COCbFPSUpspGg
m9vcJ2Fk9CMFWxhOUPX2GCqAEEvnsbDGIPLdTuEHUrQ6OmS9W1ZlsAH8iikFqN53
3qzR26J+K7r+K8Wq/N0pWYJPuG6KPq+T8Bno63vE2kpwYW/GiNmWfgFTqr61RW7z
u9z3CSGOpe82R2RIeOqPq4Kg0r2XLrWxmkLzkH1nCliZhQdMG2ktT4X+g73s/VL4
oeGWOjAwRs9NsglIlRw1yAavjH+uPw==
=NKNi
-----END PGP SIGNATURE-----

--h8eQc92HoYqCO7FrW0H4RDchgLNnetUNd--


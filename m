Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F48B20684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F48B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxFdM-00071p-CH
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxFcf-0006WB-Ug
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxFce-0008GC-9j
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:04:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxFcZ-0008DN-Ew; Mon, 12 Aug 2019 15:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02CB661B22;
 Mon, 12 Aug 2019 19:04:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D57C1001B20;
 Mon, 12 Aug 2019 19:04:36 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
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
Message-ID: <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
Date: Mon, 12 Aug 2019 21:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fWGR9RUu7qW3P59MWRSFz9V0qRaR3pYaN"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 12 Aug 2019 19:04:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fWGR9RUu7qW3P59MWRSFz9V0qRaR3pYaN
Content-Type: multipart/mixed; boundary="yLagptrLR6M7iImuFmKTWPwsZuWW6s1uN";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com,
 vsementsov@virtuozzo.com
Message-ID: <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
Subject: Re: [PATCH v8 9/9] qapi: query-blockstat: add driver specific
 file-posix stats
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516143314.81302-10-anton.nefedov@virtuozzo.com>

--yLagptrLR6M7iImuFmKTWPwsZuWW6s1uN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:33, Anton Nefedov wrote:
> A block driver can provide a callback to report driver-specific
> statistics.
>=20
> file-posix driver now reports discard statistics
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json      | 38 ++++++++++++++++++++++++++++++++++++++
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  1 +
>  block.c                   |  9 +++++++++
>  block/file-posix.c        | 38 +++++++++++++++++++++++++++++++++++---
>  block/qapi.c              |  5 +++++
>  6 files changed, 89 insertions(+), 3 deletions(-)


> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 55194f84ce..368e09ae37 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -956,6 +956,41 @@
>             '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
>             '*flush_latency_histogram': 'BlockLatencyHistogramInfo' } }=

> =20
> +##
> +# @BlockStatsSpecificFile:
> +#
> +# File driver statistics
> +#
> +# @discard-nb-ok: The number of successful discard operations performe=
d by
> +#                 the driver.
> +#
> +# @discard-nb-failed: The number of failed discard operations performe=
d by
> +#                     the driver.
> +#
> +# @discard-bytes-ok: The number of bytes discarded by the driver.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'BlockStatsSpecificFile',
> +  'data': {
> +      'discard-nb-ok': 'uint64',
> +      'discard-nb-failed': 'uint64',
> +      'discard-bytes-ok': 'uint64' } }
> +
> +##
> +# @BlockStatsSpecific:
> +#
> +# Block driver specific statistics
> +#
> +# Since: 4.1
> +##
> +{ 'union': 'BlockStatsSpecific',
> +  'base': { 'driver': 'BlockdevDriver' },
> +  'discriminator': 'driver',
> +  'data': {
> +      'file': 'BlockStatsSpecificFile',
> +      'host_device': 'BlockStatsSpecificFile' } }

I would like to use these chance to complain that I find this awkward.
My problem is that I don=E2=80=99t know how any management application is=

supposed to reasonably consume this.  It feels weird to potentially have
to recognize the result for every block driver.

I would now like to note that I=E2=80=99m clearly not in a position to bl=
ock
this at this point, because I=E2=80=99ve had a year to do so, I didn=E2=80=
=99t, so it
would be unfair to do it now.

(Still, I feel like if I have a concern, I should raise it, even if it=E2=
=80=99s
too late.)

I know Markus has proposed this, but I don=E2=80=99t understand why.  He =
set
ImageInfoSpecific as a precedence, but that has a different reasoning
behind it.  The point for that is that it simply doesn=E2=80=99t work any=
 other
way, because it is clearly format-specific information that cannot be
shared between drivers.  Anything that can be shared is put into
ImageInfo (like the cluster size).

We have the same constellation here, BlockStats contains common stuff,
and BlockStatsSpecific would contain driver-specific stuff.  But to me,
BlockStatsSpecificFile doesn=E2=80=99t look very special.  It looks like =
it just
duplicates fields that already exist in BlockDeviceStats.


(Furthermore, most of ImageInfoSpecific is actually not useful to
management software, but only as an information for humans (and having
such a structure for that is perfectly fine).  But these stats don=E2=80=99=
t
really look like something for immediate human consumption.)


So I wonder why you don=E2=80=99t just put this information into
BlockDeviceStats.  From what I can tell looking at
bdrv_query_bds_stats() and qmp_query_blockstats(), the @stats field is
currently completely 0 if @query-nodes is true.

(Furthermore, I wonder whether it would make sense to re-add
BlockAcctStats to each BDS and then let the generic block code do the
accounting on it.  I moved it to the BB in 7f0e9da6f13 because we didn=E2=
=80=99t
care about node-level information at the time, but maybe it=E2=80=99s tim=
e to
reconsider.)


Anyway, as I=E2=80=99ve said, I fully understand that complaining about a=
 design
decision is just unfair at this point, so this is not a veto.

> +
>  ##
>  # @BlockStats:
>  #
> @@ -971,6 +1006,8 @@
>  #
>  # @stats:  A @BlockDeviceStats for the device.
>  #
> +# @driver-specific: Optional driver-specific stats. (Since 4.1)
> +#
>  # @parent: This describes the file block device if it has one.
>  #          Contains recursively the statistics of the underlying
>  #          protocol (e.g. the host file for a qcow2 image). If there i=
s
> @@ -984,6 +1021,7 @@
>  { 'struct': 'BlockStats',
>    'data': {'*device': 'str', '*qdev': 'str', '*node-name': 'str',
>             'stats': 'BlockDeviceStats',
> +           '*driver-specific': 'BlockStatsSpecific',
>             '*parent': 'BlockStats',
>             '*backing': 'BlockStats'} }
> =20

[...]

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 76d54b3a85..a2f01cfe10 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -160,9 +160,9 @@ typedef struct BDRVRawState {
>      bool drop_cache;
>      bool check_cache_dropped;
>      struct {
> -        int64_t discard_nb_ok;
> -        int64_t discard_nb_failed;
> -        int64_t discard_bytes_ok;
> +        uint64_t discard_nb_ok;
> +        uint64_t discard_nb_failed;
> +        uint64_t discard_bytes_ok;

(I don=E2=80=99t know why you didn=E2=80=99t introduce these fields with =
these types in
the previous patch then.)

Max

>      } stats;
> =20
>      PRManager *pr_mgr;


--yLagptrLR6M7iImuFmKTWPwsZuWW6s1uN--

--fWGR9RUu7qW3P59MWRSFz9V0qRaR3pYaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RuEMACgkQ9AfbAGHV
z0Cr+wgAiRwYiZaxuJUOqs40vgl08cuMyMzv7aUMtfBPkAXWbBHrIFc0KvIM0aG4
Z82ADm1CJGE/tK4/byGvv+f7GmQU63n3yr36G3o4WEkr/ADHajMjUijuiEwNjgj6
ZDOIRV5ZpCmafs3lob2YplhtoCfl02PjTJ+/ntem3N6S4FRW3rZEznB5jdnnLFFE
+VvpIuGjRmRxMBvd4x2ZjvCtXJlrOh5TQGzZ5r2QXpE0iEaHx/b1Ndww7t62WL8V
TLM9ettYlOkKkfJp5MraPTYsCedwPkLJSjKVtWfBHiwC7btpdKN+/wYqqckt1CBY
NH9btDy7uA3Qmt8g28KHWZoTIsqMpg==
=PAIE
-----END PGP SIGNATURE-----

--fWGR9RUu7qW3P59MWRSFz9V0qRaR3pYaN--


Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E50C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BAD20679
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BAD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxwf-0006Gv-U2
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hdxo8-0000Kk-4T
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hdxlg-0005uS-FW
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:11:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hdxej-0006ad-2p; Thu, 20 Jun 2019 10:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CAA63086268;
 Thu, 20 Jun 2019 14:03:03 +0000 (UTC)
Received: from [10.3.116.44] (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B88E19C4F;
 Thu, 20 Jun 2019 14:03:01 +0000 (UTC)
To: zhenwei pi <pizhenwei@bytedance.com>, kwolf@redhat.com, mreitz@redhat.com
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
 <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <cdb81887-5d68-9de5-e72b-3df8a45e52b4@redhat.com>
Date: Thu, 20 Jun 2019 09:03:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pf8gkemO36K68wJkUNmYP6TAE5TZa9SA6"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 20 Jun 2019 14:03:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] qapi: add block size histogram
 interface
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
Cc: fam@euphon.net, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pf8gkemO36K68wJkUNmYP6TAE5TZa9SA6
Content-Type: multipart/mixed; boundary="ALqSs5PbiYQpPRmHYlRQ0CMeyFg6xtgso";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: fam@euphon.net, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org
Message-ID: <cdb81887-5d68-9de5-e72b-3df8a45e52b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qapi: add block size histogram interface
References: <1561020872-6214-1-git-send-email-pizhenwei@bytedance.com>
 <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>
In-Reply-To: <1561020872-6214-4-git-send-email-pizhenwei@bytedance.com>

--ALqSs5PbiYQpPRmHYlRQ0CMeyFg6xtgso
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/20/19 3:54 AM, zhenwei pi wrote:
> Set/Clear block size histograms through new command
> x-block-size-histogram-set and show new statistics in
> query-blockstats results.
>=20

I'm guessing this is modeled after the existing
block-latency-histogram-set command?

> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  block/qapi.c         |  24 ++++++++++++
>  blockdev.c           |  56 +++++++++++++++++++++++++++
>  qapi/block-core.json | 105 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  3 files changed, 184 insertions(+), 1 deletion(-)

> +++ b/qapi/block-core.json
> @@ -633,6 +633,100 @@
>             '*boundaries-flush': ['uint64'] } }
> =20
>  ##
> +# @BlockSizeHistogramInfo:
> +#
> +# Block size histogram.
> +#
> +# @boundaries: list of interval boundary values in nanoseconds, all gr=
eater
> +#              than zero and in ascending order.
> +#              For example, the list [8193, 32769, 131073] produces th=
e
> +#              following histogram intervals:
> +#              [0, 8193), [8193, 32769), [32769, 131073), [131073, +in=
f).
> +#
> +# @bins: list of io request counts corresponding to histogram interval=
s.
> +#        len(@bins) =3D len(@boundaries) + 1
> +#        For the example above, @bins may be something like [6, 3, 7, =
9],
> +#        and corresponding histogram looks like:
> +#
> +# Since: 4.0

You've missed 4.0; the next release is 4.1.

> +##
> +{ 'struct': 'BlockSizeHistogramInfo',
> +  'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }

This is identical to struct BlockLatencyHistogramInfo; can we instead
rename the type (which does not affect API) and share it between both
implementations, instead of duplicating it?

> +
> +##
> +# @x-block-size-histogram-set:

Does this need to be experimental from the get-go? Or can it be stable
by dropping 'x-' since it matches the fact that
block-latency-histogram-set is stable?

> +#
> +# Manage read, write and flush size histograms for the device.
> +#
> +# If only @id parameter is specified, remove all present size histogra=
ms
> +# for the device. Otherwise, add/reset some of (or all) size histogram=
s.
> +#
> +# @id: The name or QOM path of the guest device.
> +#
> +# @boundaries: list of interval boundary values (see description in
> +#              BlockSizeHistogramInfo definition). If specified, all
> +#              size histograms are removed, and empty ones created for=
 all
> +#              io types with intervals corresponding to @boundaries (e=
xcept for
> +#              io types, for which specific boundaries are set through=
 the
> +#              following parameters).
> +#
> +# @boundaries-read: list of interval boundary values for read size
> +#                   histogram. If specified, old read size histogram i=
s
> +#                   removed, and empty one created with intervals
> +#                   corresponding to @boundaries-read. The parameter h=
as higher
> +#                   priority then @boundaries.
> +#
> +# @boundaries-write: list of interval boundary values for write size
> +#                    histogram.
> +#
> +# @boundaries-flush: list of interval boundary values for flush size
> +#                    histogram.
> +#
> +# Returns: error if device is not found or any boundary arrays are inv=
alid.
> +#
> +# Since: 4.0

4.1

> +#
> +# Example: set new histograms for all io types with intervals
> +# [0, 8193), [8193, 32769), [32769, 131073), [131073, +inf):
> +#
> +# -> { "execute": "x-block-size-histogram-set",
> +#      "arguments": { "id": "drive0",
> +#                     "boundaries": [8193, 32769, 131073] } }
> +# <- { "return": {} }
> +#
> +# Example: set new histogram only for write, other histograms will rem=
ain
> +# not changed (or not created):
> +#
> +# -> { "execute": "x-block-size-histogram-set",
> +#      "arguments": { "id": "drive0",
> +#                     "boundaries-write": [8193, 32769, 131073] } }
> +# <- { "return": {} }
> +#
> +# Example: set new histograms with the following intervals:
> +#   read, flush: [0, 8193), [8193, 32769), [32769, 131073), [131073, +=
inf)
> +#   write: [0, 4097), [4097, 8193), [8193, 32769), [32769, +inf)
> +#
> +# -> { "execute": "x-block-size-histogram-set",
> +#      "arguments": { "id": "drive0",
> +#                     "boundaries": [8193, 32769, 131073],
> +#                     "boundaries-write": [4097, 8193, 32769] } }
> +# <- { "return": {} }
> +#
> +# Example: remove all size histograms:
> +#
> +# -> { "execute": "x-block-size-histogram-set",
> +#      "arguments": { "id": "drive0" } }
> +# <- { "return": {} }
> +##
> +{ 'command': 'x-block-size-histogram-set',
> +  'data': {'id': 'str',
> +           '*boundaries': ['uint64'],
> +           '*boundaries-read': ['uint64'],
> +           '*boundaries-write': ['uint64'],
> +           '*boundaries-flush': ['uint64'] } }

Again, this copies heavily from block-latency-histogram-set.  But
changing the command name is not API compatible.  Should we have a
single new command 'block-histogram-set' which takes an enum choosing
between 'latency' and 'size', and start the deprecation clock on
'block-latency-histogram-set'?
 (and defaulting to 'latency' for back-compat

> +
> +
> +##
>  # @BlockInfo:
>  #
>  # Block device information.  This structure describes a virtual device=
 and
> @@ -918,6 +1012,12 @@
>  #
>  # @flush_latency_histogram: @BlockLatencyHistogramInfo. (Since 4.0)
>  #
> +# @x_rd_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
> +#
> +# @x_wr_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)
> +#
> +# @x_flush_size_histogram: @BlockSizeHistogramInfo. (Since 4.0)

since 4.1 on all of these additions.

> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'BlockDeviceStats',
> @@ -933,7 +1033,10 @@
>             'timed_stats': ['BlockDeviceTimedStats'],
>             '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
>             '*wr_latency_histogram': 'BlockLatencyHistogramInfo',
> -           '*flush_latency_histogram': 'BlockLatencyHistogramInfo' } }=

> +           '*flush_latency_histogram': 'BlockLatencyHistogramInfo',
> +           '*x_rd_size_histogram': 'BlockSizeHistogramInfo',
> +           '*x_wr_size_histogram': 'BlockSizeHistogramInfo',
> +           '*x_flush_size_histogram': 'BlockSizeHistogramInfo' } }
> =20
>  ##
>  # @BlockStats:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ALqSs5PbiYQpPRmHYlRQ0CMeyFg6xtgso--

--pf8gkemO36K68wJkUNmYP6TAE5TZa9SA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0LkhQACgkQp6FrSiUn
Q2oYsAf9Ex+OOLDcypEyAkscasi4ddl+sW2EmmRgVeyMHC9Tb0w0MNZj+WWF67LU
yZOlCxyp9idK2rTVHytzA7K6wnaEh5eQOA7ZMLCpCyRhu/W0qyg2+RoXDpkZVISo
nMHXaVjduwLo+G3PmvUI6jgOcpuZ1a0IMmKolnr7uVQxB9r0vm1EpQBFKI/Pn8LM
Z8Xa9tNY3HUm9LtSXf1gluou5ljA+DDhk//K1WmwgjTAWKO2EUe6LWwc1uDy473a
jMNkko6vw9RDNpgU9o6mNYNRmQGZiixx+e7/mXDoowWS0WYufBciLn43P+0pNgay
6VyA5trg87pQ1zP/D2P1YHUfQm2HGw==
=PDco
-----END PGP SIGNATURE-----

--pf8gkemO36K68wJkUNmYP6TAE5TZa9SA6--


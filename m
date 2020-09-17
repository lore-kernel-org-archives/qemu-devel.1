Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33318C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F882078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/Er/50Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F882078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIumB-000200-DY
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIuUY-0002qm-Ap
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:02:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIuUU-0000la-EK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600351344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3JEO6XWRHDi67u+VueyL2txLF/BIrDw2REVizc0Y4N4=;
 b=E/Er/50YNxb2QdpR9dLlhbszCTbigb3fvlrLP70KM2EtutrefMjm4omMQaQ3I7fzjRXg18
 eRznV6CNfeTeyClJ9/WISygJbQzM9a4hHL6HYDMukU93yNfoouuvU7MNXKtEyW9zbuatzD
 jXiC7Ty5G4ogdZ+lvowk3S6M+Z/d5sA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-eGbTei20PoOK3DbZR4geZQ-1; Thu, 17 Sep 2020 10:02:18 -0400
X-MC-Unique: eGbTei20PoOK3DbZR4geZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744998F5FC3;
 Thu, 17 Sep 2020 14:02:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-65.ams2.redhat.com
 [10.36.113.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 000BC68874;
 Thu, 17 Sep 2020 14:02:09 +0000 (UTC)
Subject: Re: [PATCH 1/3] block/block-backend: add converter from
 BlockAcctStats to BlockBackend
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200810101447.7380-1-den@openvz.org>
 <20200810101447.7380-2-den@openvz.org>
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
Message-ID: <9aa6f66e-c51f-1167-ac49-e05e10347cd6@redhat.com>
Date: Thu, 17 Sep 2020 16:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810101447.7380-2-den@openvz.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ApWA1HXjulWEBXnq4s9wWwMHl4SKYroMM"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ApWA1HXjulWEBXnq4s9wWwMHl4SKYroMM
Content-Type: multipart/mixed; boundary="F9evUS5VyUM55cmm5yK5A3PsK4lVFWpli"

--F9evUS5VyUM55cmm5yK5A3PsK4lVFWpli
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.20 12:14, Denis V. Lunev wrote:
> Right now BlockAcctStats is always reside on BlockBackend. This structure
> is not used in any other place. Thus we are able to create a converter
> from one pointer to another.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  block/block-backend.c          | 5 +++++
>  include/sysemu/block-backend.h | 1 +
>  2 files changed, 6 insertions(+)

(Note: I=E2=80=99m just writing this mail because I already responded to pa=
tch
2.  I wouldn=E2=80=99t have if I didn=E2=80=99t have anything to say regard=
ing the other
patches in this series, so nothing I say here is backed by a strong
opinion from me.)

> diff --git a/block/block-backend.c b/block/block-backend.c
> index 3a13cb5f0b..88e531df98 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2153,6 +2153,11 @@ BlockAcctStats *blk_get_stats(BlockBackend *blk)
>      return &blk->stats;
>  }
> =20
> +BlockBackend *blk_stats2blk(BlockAcctStats *s)

(Extreme bikeshedding: I=E2=80=99d prefer something like blk_from_stats().)

> +{
> +    return container_of(s, BlockBackend, stats);
> +}

Works, but I get all itchy, especially given the reasoning in the commit
message, which is basically =E2=80=9CRight now this works=E2=80=9D.

That sounds to me like maybe in the future someone could get the idea of
moving BlockAcctStats somewhere else and then this is something that we
absolutely must not forget about, lest horrible accidents occur.

Would a back pointer from BlockAcctStats to the BlockBackend work or do
you find that just too ugly and unnecessary?  (I think it would help at
least so that we do not forget this place here.)

Or maybe just a comment above BlockAcctStats would help quench my itch,
too, like =E2=80=9CNote: blk_stats2blk() expects objects of this type only =
to
occur as part of a BlockBackend=E2=80=9D.

Max


--F9evUS5VyUM55cmm5yK5A3PsK4lVFWpli--

--ApWA1HXjulWEBXnq4s9wWwMHl4SKYroMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9jbGAACgkQ9AfbAGHV
z0BtSQf+LZjyciUNUipJnCYfLXoU4ZzSHK2V6TO2g6bvwQLRYEmYPFQ9f7OFYZi4
yPZmQl/vFPL1aKm5mtXvgocv5+BTDqnWD0hlkhC9wPIsgeuGZPebtiRn3MuEiFSq
DkS/d+xGi0w5m3XfcwE058WYY+DbraQIRLkjUl9L3QTuGkas2OkxQIkmnNo8j+M/
yelFCqTRNQPH73iajrBGXI3rMLQFPSo0YvJ+Bqi7BJfzl/k1L4iMMj9qE9cZapQI
+jXysXru8IvXSnXIcHeA8WbTzH7xYytCVwGAjdtZUGSr6lbrCZLA6wEb5a0qbFOP
OlbBzcUWjaf3SaD969fYh9pqLt6YLQ==
=QbPB
-----END PGP SIGNATURE-----

--ApWA1HXjulWEBXnq4s9wWwMHl4SKYroMM--



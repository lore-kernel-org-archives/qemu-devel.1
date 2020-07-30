Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE246C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF662074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8A71tc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF662074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18MP-0000WJ-0b
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k18LG-0007so-Sz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:11:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k18LF-0004C3-8p
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596114683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jE50pP3uw5mcXwP1HwRPUklSDPvfTV1prV8axQd/eGw=;
 b=M8A71tc/CmmiGwDOwUmMUMWcVLbMCuEtGKNI6hHRtO4+IyscJyrvSi+sfjgh3d3/rZ4zKS
 PxiXGCH1q2W2+bwgJ/UEQfKveT25hIsFOGmwSbHLh9zLdUIusjsE7JHqnwPjSmqNz4cDkb
 ofcUwpsvxKzmMNzvIYB6RhVaIuEaVbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-t24bmzZKNvO-zWOclxs3cA-1; Thu, 30 Jul 2020 09:11:21 -0400
X-MC-Unique: t24bmzZKNvO-zWOclxs3cA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2178880183C;
 Thu, 30 Jul 2020 13:11:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-153.ams2.redhat.com
 [10.36.113.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A84C7193D;
 Thu, 30 Jul 2020 13:11:15 +0000 (UTC)
Subject: Re: [PATCH] qapi: Delete unwanted indentation of top-level expressions
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200730091656.2633334-1-armbru@redhat.com>
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
Message-ID: <28f91ce9-2f7d-d4b9-a300-c778c6c20992@redhat.com>
Date: Thu, 30 Jul 2020 15:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730091656.2633334-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WUHSWuV231NFktH0AWuionWXC8E3NmJvj"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WUHSWuV231NFktH0AWuionWXC8E3NmJvj
Content-Type: multipart/mixed; boundary="Qut9TeoQtaI7F1D5EECR1Gddgq6gwPksK"

--Qut9TeoQtaI7F1D5EECR1Gddgq6gwPksK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.20 11:16, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 24 ++++++++++++------------
>  qapi/ui.json         |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ab7bf3c612..bdcc8e5f9f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1847,8 +1847,8 @@
>  #
>  # Since: 4.0
>  ##
> -  { 'enum': 'BlockPermission',
> -    'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
> +{ 'enum': 'BlockPermission',
> +  'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
>                'graph-mod' ] }

Do we want to keep the alignment at the opening parenthesis here?

Max


--Qut9TeoQtaI7F1D5EECR1Gddgq6gwPksK--

--WUHSWuV231NFktH0AWuionWXC8E3NmJvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8ixvEACgkQ9AfbAGHV
z0C/2gf/bgsw9jSIRXItUiUZo4yAy6ru8rLmHBH99yn+tM5zA5WScCkxJtA5dr9G
3kUzphSZ9/p1Dts/drR30hZU4yxHvN1PnHYY6uPdNB1L/QQ6N2oQlEsqmmjHSan6
pLO81jSfnGyyQxkn/awvPU7qvYR4KQuDxu+pLCIiXzqKd87X6xCO5ulH0aV6upce
V5xnO6FRyAwqpm4N/FuDHWPIowwL9DI+qo5etqh3tURvTLkJeH/U1qvL37r/cSbs
6pO7MLdB6Of+OmfYJdVx3JzJaxqu79A1ICGtIdNT6p7EVlxvM9+QH1kq9/HPEAmr
/BH7lBfwhMT2kAXZ9O4wNyz5ZEN8vg==
=2RFy
-----END PGP SIGNATURE-----

--WUHSWuV231NFktH0AWuionWXC8E3NmJvj--



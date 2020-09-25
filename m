Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D956AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E1C421D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMClOsxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1C421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLl44-0003FC-0U
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLkuV-0002Vy-9v
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLkuS-0008DL-Dk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:25:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601029498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4yBQXnj3i65WgMObCqYuxf1RQWtbAVN5MrMTBtSVKo=;
 b=QMClOsxYm3EErqpWeU2oc05PcpD/c76mAQQLX2dJ9T+bw9PXzywjLz/Of1ROBtdyN0wty5
 VkXY0CmKKgt6r03cTeIi4kEQk9KWlY1GcCniGLd2/K+KO9s1RVI9wt7PAnoCBWktXHTewo
 7yMG+YwEWg/GeemO0Duhm06NfhiWezc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-02nSEIBEPd-J29n-AP46Hw-1; Fri, 25 Sep 2020 06:24:53 -0400
X-MC-Unique: 02nSEIBEPd-J29n-AP46Hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5BD800597;
 Fri, 25 Sep 2020 10:24:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-113.ams2.redhat.com
 [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1578027BAF;
 Fri, 25 Sep 2020 10:24:46 +0000 (UTC)
Subject: Re: [PATCH v6 14/15] scripts/simplebench: improve ascii table: add
 difference line
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-15-vsementsov@virtuozzo.com>
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
Message-ID: <6b808a3b-735b-45b4-79bf-6e73000de5bb@redhat.com>
Date: Fri, 25 Sep 2020 12:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918181951.21752-15-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1NZ7NQJO2U3wX96ANgwubygS7Ugovhh3v"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1NZ7NQJO2U3wX96ANgwubygS7Ugovhh3v
Content-Type: multipart/mixed; boundary="Ss19TXkUmDwy9wMIYZVnzpHikH8EO3XLE"

--Ss19TXkUmDwy9wMIYZVnzpHikH8EO3XLE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
> Performance improvements / degradations are usually discussed in
> percentage. Let's make the script calculate it for us.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/simplebench/simplebench.py | 46 +++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/sim=
plebench.py
> index 56d3a91ea2..0ff05a38b8 100644
> --- a/scripts/simplebench/simplebench.py
> +++ b/scripts/simplebench/simplebench.py

[...]

> +            for j in range(0, i):
> +                env_j =3D results['envs'][j]
> +                res_j =3D case_results[env_j['id']]
> +
> +                if 'average' not in res_j:
> +                    # Failed result
> +                    cell +=3D ' --'
> +                    continue
> +
> +                col_j =3D chr(ord('A') + j)
> +                avg_j =3D res_j['average']
> +                delta =3D (res['average'] - avg_j) / avg_j * 100

I was wondering why you=E2=80=99d subtract, when percentage differences usu=
ally
mean a quotient.  Then I realized that this would usually be written as:

(res['average'] / avg_j - 1) * 100

> +                delta_delta =3D (res['delta'] + res_j['delta']) / avg_j =
* 100

Why not use the new format_percent for both cases?

> +                cell +=3D f' {col_j}{round(delta):+}=C2=B1{round(delta_d=
elta)}%'

I don=E2=80=99t know what I should think about =C2=B1delta_delta.  If I saw=
 =E2=80=9CCompared
to run A, this is +42.1%=C2=B12.0%=E2=80=9D, I would think that you calcula=
ted the
difference between each run result, and then based on that array
calculated average and standard deviation.

Furthermore, I don=E2=80=99t even know what the delta_delta is supposed to =
tell
you.  It isn=E2=80=99t even a delta_delta, it=E2=80=99s an average_delta.

The delta_delta would be (res['delta'] / res_j['delta'] - 1) * 100.0.
And that might be presented perhaps like =E2=80=9C+42.1% =CE=94=C2=B1 +2.0%=
=E2=80=9D (if delta
were the SD, =E2=80=9C=CE=94x=CC=85=3D+42.1% =CE=94=CF=83=3D+2.0%=E2=80=9D =
would also work; although, again, I do
interpret =C2=B1 as the SD anyway).

Max


--Ss19TXkUmDwy9wMIYZVnzpHikH8EO3XLE--

--1NZ7NQJO2U3wX96ANgwubygS7Ugovhh3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9txW0ACgkQ9AfbAGHV
z0D2pAgAt6GfUNqdRMTQ68rwtHV7xShXMsjzdHCk7Tux0jsJeLvveXvwlLQAW4y/
lbvEgCLiDHolLJSHV3Ggbj6d73c8ysP+ruxDdN0vEaRpSuDi5A+yZu9j+uHkg7x/
WRAnijtP0SYtZVrT5Ft1nrAEI4ZVHnhHj51c2adnSN/yERh2Y5oNQ8MUYHV1A/xk
aFf7JZXn+JfOt2aG0WaGgMm5HDTeL9+U8y+a5WmPzFp6JaNqlpwe0/CfBy78XuFB
bKWq2lNFqad9hxMK929vjEiQprk9F1aO2Z5krVf8rUKeOxY2K3TKuLm5nQJ+yBZo
Eubhz7IpFJ5O2/6J4KF8h/ixiep/tA==
=wZTE
-----END PGP SIGNATURE-----

--1NZ7NQJO2U3wX96ANgwubygS7Ugovhh3v--



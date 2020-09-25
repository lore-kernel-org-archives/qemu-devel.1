Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B86C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D1920678
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0l4VIoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D1920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLk5r-0007eJ-W9
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLk4k-000782-1s
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLk4h-0001vR-GE
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:31:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601026290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xVvaG2PvsHNI6su8qHq0bpwvos4v+Z1AbhFDBSUqeIA=;
 b=e0l4VIoa2MmmJtOsETRLIc//ov6pgxpVNyFXmFeBcQFOL6STqSSVnjBTpv3bsvTZtxzQTI
 hh+wnmsMoipye9Trz7ReTVFTsB8hAotRQpNnqQ9zxWSz/R0srCVO+8lGcetlsu+Oc87YlL
 7bh1PXUacg7fsMk3jLewHDgvvRULntQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-nUcEhHxEM8mwqb9bscpucw-1; Fri, 25 Sep 2020 05:31:27 -0400
X-MC-Unique: nUcEhHxEM8mwqb9bscpucw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60A27800E23;
 Fri, 25 Sep 2020 09:31:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-113.ams2.redhat.com
 [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5775710013DB;
 Fri, 25 Sep 2020 09:31:21 +0000 (UTC)
Subject: Re: [PATCH v6 13/15] scripts/simplebench: improve view of ascii table
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-14-vsementsov@virtuozzo.com>
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
Message-ID: <ce8df484-251f-dac5-1f46-eb8eeff3a3c9@redhat.com>
Date: Fri, 25 Sep 2020 11:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918181951.21752-14-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xUdJU9DI3sw1HReMTyy3WdRdfggp9vBf5"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xUdJU9DI3sw1HReMTyy3WdRdfggp9vBf5
Content-Type: multipart/mixed; boundary="eVRGnA66zM1DgGkuN5uDfPbgw2PejIr5M"

--eVRGnA66zM1DgGkuN5uDfPbgw2PejIr5M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
> Introduce dynamic float precision and use percentage to show delta.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/simplebench/simplebench.py | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/sim=
plebench.py
> index 716d7fe9b2..56d3a91ea2 100644
> --- a/scripts/simplebench/simplebench.py
> +++ b/scripts/simplebench/simplebench.py
> @@ -79,10 +79,34 @@ def bench_one(test_func, test_env, test_case, count=
=3D5, initial_run=3DTrue):
>      return result
> =20
> =20
> +def format_float(x):
> +    res =3D round(x)
> +    if res >=3D 100:
> +        return str(res)
> +
> +    res =3D f'{x:.1f}'
> +    if len(res) >=3D 4:
> +        return res
> +
> +    return f'{x:.2f}'

This itches me to ask for some log() calculation.

Like:

%.*f' % (math.ceil(math.log10(99.95 / x)), x)

(For three significant digits)

> +def format_percent(x):
> +    x *=3D 100
> +
> +    res =3D round(x)
> +    if res >=3D 10:
> +        return str(res)
> +
> +    return f'{x:.1f}' if res >=3D 1 else f'{x:.2f}'

Same here.  (Also, why not append a % sign in this function?)

>  def ascii_one(result):
>      """Return ASCII representation of bench_one() returned dict."""
>      if 'average' in result:
> -        s =3D '{:.2f} +- {:.2f}'.format(result['average'], result['delta=
'])
> +        avg =3D result['average']
> +        delta_pr =3D result['delta'] / avg
> +        s =3D f'{format_float(avg)}=C2=B1{format_percent(delta_pr)}%'

Pre-existing, but isn=E2=80=99t the =C2=B1 range generally assumed to be th=
e standard
deviation?

Max

>          if 'n-failed' in result:
>              s +=3D '\n({} failed)'.format(result['n-failed'])
>          return s
>=20



--eVRGnA66zM1DgGkuN5uDfPbgw2PejIr5M--

--xUdJU9DI3sw1HReMTyy3WdRdfggp9vBf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9tuOcACgkQ9AfbAGHV
z0A/KggAm+hdSIjCD/w2SrgELujbgkd9O4ByE+TaPifvG7TEvfhg/H21nYim7RCG
YobE0aYnUGhbCbU+tytGU5G7E1G/GxSicrGd90/oeVyhUpKSn4x2mq9wx5YFRp5p
4prydHY9enbXmMn8H/sXZylADENwcWcYA+RhQ4Gd5yPGWix6zY3ADc6o6wYuaTnk
lBPFKTXRw+wOgVCZlpBzk3WPNB9y7zNw9Af7WokarjOjHyjpnCFz9V3DJne9iud4
H2CbhPMR36rSjKZfwto3KO/Gxd+909Nuew/0NFLIUYvoFwqomuj/z3UPkPKonn3O
b0ewWXfelmuQ7VOOb+9/J7wTY1cEFA==
=HAkD
-----END PGP SIGNATURE-----

--xUdJU9DI3sw1HReMTyy3WdRdfggp9vBf5--



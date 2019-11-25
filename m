Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485922082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bphewxi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485922082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJOY-0003hc-O6
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZJMV-00033U-9P
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZJMS-0008E9-GQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:45:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZJMS-0008Dd-77
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574707522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tbwiJYsACcFZSkPp+m6du0CaKVuPJV7HPCwb6FkiWUw=;
 b=bphewxi15gL8ZsLmxwaQ2HCq8uV00Z4MdMRahz9Ff5bd2YeDMwj0upykPjZE3LmnpZZyly
 iaKSoLGlJ16WGmirAodhQIZZYby3Va3lJoMoo9c6an9DrHEgZRG/jzZ1z58qqOXjSR/xnj
 yh7Nkx/aVXCEHBM+O3QxRNBzuXCAhMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-oLLhptanOZyVB9GvHc9aHQ-1; Mon, 25 Nov 2019 13:45:21 -0500
X-MC-Unique: oLLhptanOZyVB9GvHc9aHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC81F104ED23;
 Mon, 25 Nov 2019 18:45:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3B4A5D9CA;
 Mon, 25 Nov 2019 18:45:13 +0000 (UTC)
Subject: Re: API definition for LUKS key management [V2]
To: Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191112100253.GM2366658@redhat.com>
 <d6ead0c3f9758b5def21dd690217bc9deeace2a9.camel@redhat.com>
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
Message-ID: <0b5fec2a-1d93-7e31-55d2-1a80bde89f0b@redhat.com>
Date: Mon, 25 Nov 2019 19:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d6ead0c3f9758b5def21dd690217bc9deeace2a9.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yqo3NUHajiJOhyaFo4NNppudY8tynKeoR"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yqo3NUHajiJOhyaFo4NNppudY8tynKeoR
Content-Type: multipart/mixed; boundary="7rM1a7plrNGIQIKs7mx7LCd8gZPYhlaMr"

--7rM1a7plrNGIQIKs7mx7LCd8gZPYhlaMr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.11.19 15:22, Maxim Levitsky wrote:
> Hi!
>=20
> This is the second version of the proposed QMP API for key management,
> after discussion with Keven and Max.
>=20
> Will this work?
>=20
> Adding Peter Krempa to CC, to hear his opinion from the=20
> libvirt side.
>=20
> Best regards,
> =09Maxim Levitsky

Looks good to me overall.  I don=E2=80=99t think we need to overly push hav=
ing
the same interface for create and amend, because I don=E2=80=99t see much t=
o be
gained from it.

[...]

> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683..019db682cd 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -309,3 +309,56 @@
>    'base': 'QCryptoBlockInfoBase',
>    'discriminator': 'format',
>    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> +
> +
> +##
> +# @LUKSKeyslotUpdate:
> +#
> +# @keyslot:         If specified, will update only keyslot with this ind=
ex
> +#
> +# @old-secret:      If specified, will only update keyslots that
> +#                   can be opened with password which is contained in
> +#                   QCryptoSecret with @old-secret ID
> +#
> +#                   If neither @keyslot nor @old-secret is specified,
> +#                   first empty keyslot is selected for the update
> +#
> +# @new-secret:      The ID of a QCryptoSecret object providing a new dec=
ryption
> +#                   key to place in all matching keyslots. Empty string =
erases the
> +#                   keyslot.

Hm...  Can=E2=80=99t we make this some string-or-null alternate type so tha=
t
null will erase the keyslot?  That would make more sense to me.

Max

> +# @iter-time:       number of milliseconds to spend in
> +#                   PBKDF passphrase processing
> +##
> +{ 'struct': 'LUKSKeyslotUpdate',
> +  'data': {
> +         '*keyslot': 'int',
> +         '*old-secret': 'str',
> +         'new-secret' : 'str',
> +         '*iter-time' : 'int' } }


--7rM1a7plrNGIQIKs7mx7LCd8gZPYhlaMr--

--yqo3NUHajiJOhyaFo4NNppudY8tynKeoR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3cITcACgkQ9AfbAGHV
z0AGNQf9Ges51BiEM0ctwApSHnRNvUqmrvTUjbMoC4WLZicloGrSzliYSSxcxG7A
tklXxz7+ai4DKdc3nnQrH0QtuF6mHP3l1xxD/jWltBDFFsKez5hpunEIPZBFRGKH
ZgTmiWdh5zZO74SHloQ7gaaICz3d6Ok4dnAMlaDCI+wmsuZqE+xRSPoghJVEOj05
pZjAloX3KDvEfmF3R4E9otyNf+eKDWqrFh+0UaGsUgQiYJANeHpmG1T/rj8lEdNp
UuaJjbpesEqVGaODjh8i8V8oBk2k6RJvfOCdCd24BPUuXm0/hiErDnQfY1CFUlOW
IrkX27frEs96l53nfMMHRV2dJNAuZQ==
=hlfH
-----END PGP SIGNATURE-----

--yqo3NUHajiJOhyaFo4NNppudY8tynKeoR--



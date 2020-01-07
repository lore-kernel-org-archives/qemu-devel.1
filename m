Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A157C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C05206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQUAfdMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C05206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolYz-0003zg-O8
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iolOU-00037I-1t
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iolOS-0003E8-O6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:43:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iolOS-0003Dl-Iv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578390200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wwe+Al0UA3gvOo5vmrdfV05trfwMxUtyU4/mAx4+OMA=;
 b=gQUAfdMFmjZ0qGH+56D0e9GAV0dfasVtL6a6TdS4qhCffjJpxWc7zYOVbr7ry2DEUW8AGE
 y8ZU8/SkErZt4da8dRb/sQ+000/NhHuo79xUaJk8WyDldZb7MWCOLK1jgyY/vjA/ZkE8QO
 sRxhvSszDO6lvkhJM6QuMzL1aySS6ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-1qqrJZr6Mu-mX8oKgA5rQA-1; Tue, 07 Jan 2020 04:43:15 -0500
X-MC-Unique: 1qqrJZr6Mu-mX8oKgA5rQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA1E8024DA;
 Tue,  7 Jan 2020 09:43:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-1.ams2.redhat.com
 [10.36.117.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF34360BE2;
 Tue,  7 Jan 2020 09:43:12 +0000 (UTC)
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
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
Message-ID: <d9e8e203-b529-1d1a-d8b9-5fd0fbe49e6b@redhat.com>
Date: Tue, 7 Jan 2020 10:43:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yeemFV6yw3gZg4wyqV76NOcbhykcd03i5"
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yeemFV6yw3gZg4wyqV76NOcbhykcd03i5
Content-Type: multipart/mixed; boundary="aRUSOiLNpVhiPxYelpXmi9QyENeaBuzv9"

--aRUSOiLNpVhiPxYelpXmi9QyENeaBuzv9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.01.20 19:23, Daniel Henrique Barboza wrote:
> Hello,
>=20
> This is the type of cleanup I've contributed to Libvirt
> during the last year. Figured QEMU also deserves the same
> care.
>=20
> The idea here is remove unneeded labels. By 'unneeded' I
> mean labels that does nothing but a 'return' call. One
> common case is something like this:
>=20
> if ()
>     goto cleanup;
> [...]
>  cleanup:
>     return 0;
>=20
> This code can be simplified to:
>=20
> if ()
>     return 0;
>=20
>=20
> Which is cleaner and requires less brain cycles to wonder
> whether the 'cleanup' label does anything special, such
> as a heap memory cleanup.

For me, it doesn=E2=80=99t require any brain cycles, because I generally ju=
st
assume the cleanup label will do the right thing.  OTOH, a return
statement may make me invest some some brain cycles, because maybe there
is something to be cleaned up and it isn=E2=80=99t done here.

> Another common case uses a variable to set a return value,
> generally an error, then return:
>=20
> if () {
>     ret =3D -ENOENT;
>     goto out;
> }
> [..]
>  out:
>     return ret;
>=20
> Likewise, it is clearer to just 'return -ENOENT' instead of
> jumping to a label. There are other cases being handled in
> these patches, but these are the most common.

I find it clearer from the perspective of =E2=80=9Cless LoC=E2=80=9D, but I=
 find it less
clear from the perspective of =E2=80=9CIs this the right way to clean up?=
=E2=80=9D.

Even on patch 15 (which you say isn=E2=80=99t too much of a debate), I don=
=E2=80=99t
find the change to make things any clearer.  Just less verbose.

I suppose none of this would matter if we used __attribute__((cleanup))
everywhere and simply never had to clean up anything manually.  But as
long as we don=E2=80=99t and require cleanup paths in many places, I disagr=
ee
that they require more brain cycles than plain return statements.

Max


--aRUSOiLNpVhiPxYelpXmi9QyENeaBuzv9--

--yeemFV6yw3gZg4wyqV76NOcbhykcd03i5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4UUq4ACgkQ9AfbAGHV
z0BnjwgAsAOGsDeksjE+XhOuNJmoFdN5teK96YEqA76RJ8P9nM8aiNt1jyAGMnvK
5n8drgqKk3Wkgaig8dKKOfqIlDBkKCI0v4Koae1hZbQmXQlDo/eugEv85e+ABsp2
my+GHGe26UXH/LJK81FRM695GKiB3v7Yg9K9txnqnMV1zBmilCsF/mBIylKKpSGJ
Vsj8gAZRNDM7pDkgoQehkNlhcCvQldQTBt0eFn7vWt/u8WQDB4KEXw2VLqq2Za/6
P8ciSkg9Ttd0giHvVcJ0uOud636TaLho6SIiVXz6e1EfkNW500Hq1JqzZ9MTgxVJ
EorJ0zCBNaipIrqh7jYadh5OSqsEUQ==
=W0pp
-----END PGP SIGNATURE-----

--yeemFV6yw3gZg4wyqV76NOcbhykcd03i5--



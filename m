Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3DC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75402087E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxdBkfRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75402087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0s6-0002tW-Nn
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT0qP-0001yy-OU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT0qN-0001Cn-S8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:46:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT0qN-0001Bo-OZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573206375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B1wU6aOUopoztZqN9nB9kWtmt3C1i1IKwSOE2J4vWlg=;
 b=YxdBkfRo/AIEAG5E0keVIoLfo/SvgsIcA7MgC5PAkAGRaYbbyqAWrjBH7YFEU+ZuwY4yx4
 hulKqgiDuFEAmQcxfRJOFbW8oDdlASXo7PPKrB4OBQNcl2logfWOxyYSY+Jv6Ftk9gnbx/
 EwDitQIj1D5FB5BI7Bo+8IJpQhSWCkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-VfTj6A26PJ6pIS2JlgxuJQ-1; Fri, 08 Nov 2019 04:46:11 -0500
X-MC-Unique: VfTj6A26PJ6pIS2JlgxuJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96EA3477;
 Fri,  8 Nov 2019 09:46:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCA67600CA;
 Fri,  8 Nov 2019 09:46:09 +0000 (UTC)
Subject: Re: [PATCH 00/55] Patch Round-up for stable 4.1.1, freeze on
 2019-11-12
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
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
Message-ID: <433f8cff-74d0-0b63-1a6a-9b6f290465b7@redhat.com>
Date: Fri, 8 Nov 2019 10:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tRCBtZ4CMWaXZO0yZXA269DQBNM8yVaTc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tRCBtZ4CMWaXZO0yZXA269DQBNM8yVaTc
Content-Type: multipart/mixed; boundary="leRA5n3dYioioCR3NpSWFqerO5s2VF5BD"

--leRA5n3dYioioCR3NpSWFqerO5s2VF5BD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.11.19 21:51, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v4.1.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-4.1-staging
>=20
> The release is tentatively planned for 2019-11-14:
>=20
>   https://wiki.qemu.org/Planning/4.1
>=20
> Please note that the original release date was planned for 2019-11-21,
> but was moved up to address a number of qcow2 corruption issues:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07144.html
>=20
> Fixes for the XFS issues noted in the thread are still pending, but will
> hopefully be qemu.git master in time for 4.1.1 freeze and the
> currently-scheduled release date for 4.2.0-rc1.
>=20
> The list of still-pending patchsets being tracked for inclusion are:
>=20
>   qcow2: Fix data corruption on XFS
>     https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00073.html
>     (PULL pending)
>   qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
>     https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07718.html
>   qcow2-bitmap: Fix uint64_t left-shift overflow
>     https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07989.html

Thanks for tracking these, all of these are in master now.  (So they
should be in time.)

Max


--leRA5n3dYioioCR3NpSWFqerO5s2VF5BD--

--tRCBtZ4CMWaXZO0yZXA269DQBNM8yVaTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3FOWAACgkQ9AfbAGHV
z0BYzQf9HzclYw/KCB3XkqeCAWUak6DCZ5lI238cSSwUycC8copR5ZBukY9LsPq5
GCh5tNa+IuzM0K39pK4MKZE8yd1Qxv7UI460IeT2cPf9soORDfB84wTZE5IxDQJR
92Sx/jYhBewb4mcvepmDzCr9hDxaRcSdnUoSw/c/jAjtpxOYWHWZ1ryiiVlFdkZw
i0yoxm5bMXTj3+b4zyBSDJH4tytssR/Gu3+6DWqEpmO0khGNlkRODQ4tQZN6o3tp
G1xuTf+eFnMMlWhDzu5zpCzn67qzRFojHdjdKaLZv4TA+OEpt7iCq1UYAL3fDl1W
RVJO+aIhA7vsiHEIDpi5rq2ZlmgDIw==
=ogBh
-----END PGP SIGNATURE-----

--tRCBtZ4CMWaXZO0yZXA269DQBNM8yVaTc--



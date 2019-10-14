Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6C7ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA162054F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA162054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJw1E-0003lc-7F
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iJvzG-000389-DZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iJvzD-0008EN-0f
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iJvz6-00084e-EB; Mon, 14 Oct 2019 04:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 441133082145;
 Mon, 14 Oct 2019 08:45:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-165.ams2.redhat.com
 [10.36.117.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A295D6A7;
 Mon, 14 Oct 2019 08:45:40 +0000 (UTC)
Subject: Re: [PATCH v3 07/16] qcow2: Write v3-compliant snapshot list on
 upgrade
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20191011152814.14791-1-mreitz@redhat.com>
 <20191011152814.14791-8-mreitz@redhat.com>
 <a9263c74-f958-5859-9db3-a67aefe73ff5@redhat.com>
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
Message-ID: <085c7aec-edd7-79bd-136f-5a3785a5d430@redhat.com>
Date: Mon, 14 Oct 2019 10:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a9263c74-f958-5859-9db3-a67aefe73ff5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D1fQ9ySsE0UKa7gZMEVjONSHmYPtQz3WM"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 14 Oct 2019 08:45:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D1fQ9ySsE0UKa7gZMEVjONSHmYPtQz3WM
Content-Type: multipart/mixed; boundary="I1YuivWm28i89R4YYbgp2TwXGOd6mvkPq"

--I1YuivWm28i89R4YYbgp2TwXGOd6mvkPq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 18:23, Eric Blake wrote:
> On 10/11/19 10:28 AM, Max Reitz wrote:
>> qcow2 v3 requires every snapshot table entry to have two extra data
>> fields: The 64-bit VM state size, and the virtual disk size.=C2=A0 Bot=
h are
>> optional for v2 images, so they may not be present.
>>
>> qcow2_upgrade() therefore should update the snapshot table to ensure a=
ll
>> entries have these extra data fields.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1727347
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 block/qcow2.c | 32 ++++++++++++++++++++++++++++++--
>> =C2=A0 1 file changed, 30 insertions(+), 2 deletions(-)
>>
>=20
>> +=C2=A0=C2=A0=C2=A0 need_snapshot_update =3D false;
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->nb_snapshots; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->snapshots[i].extra_=
data_size <
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
zeof_field(QCowSnapshotExtraData, vm_state_size_large) +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
zeof_field(QCowSnapshotExtraData, disk_size))
>=20
> Shorter as:
> if (s->snapshots[i].extra_data_size < sizeof(QCowSnapshotExtraData))
>=20
> but that's stylistic, so R-b still stands.

Yes, but if we ever add fields to QCowSnapshotExtraData, we shouldn=E2=80=
=99t
count them here.  Therefore, I think we need to count exactly the fields
that the standard says are mandatory in v3.

Max


--I1YuivWm28i89R4YYbgp2TwXGOd6mvkPq--

--D1fQ9ySsE0UKa7gZMEVjONSHmYPtQz3WM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2kNbMACgkQ9AfbAGHV
z0CZzQgAqbxjYpPmOpwWDEUQ9nsArRtKDXRdT1iV+Yr+1BO/c1iaVb87dcn4EFhL
W2lAaTTRjaIs7Bu06/pJtacAvtWR/clCKZHKl1sa9ok+F5HFVxe3GR+nSsysatgs
6jkz3yx+pWZ7443yaV1nzYCe9gzpFLfVVUgiwxNb43FQ6fiWnQh23FYSxDLnW/eb
G0qHq+tFQSvcuKyync5XA38jDOqbH3bugMdQ42NKZX7i5/Y3xM1YVJpOLZB+TdS0
CGtj3ubM0gshl6TTu37ugYDKQlebrM1Gy0p2MYqqr5Kek8StneHooSdH4TjFHKWV
Xz5D6wni0FMwuxKuM7WnukwrNgdZqg==
=Npe/
-----END PGP SIGNATURE-----

--D1fQ9ySsE0UKa7gZMEVjONSHmYPtQz3WM--


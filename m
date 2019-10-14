Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB0ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DFE2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DFE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJw2U-0004iL-9O
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iJw08-0003Re-Fl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iJw06-0000La-H3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iJvzq-000089-KK; Mon, 14 Oct 2019 04:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4A6F73A60;
 Mon, 14 Oct 2019 08:46:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-165.ams2.redhat.com
 [10.36.117.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77EE25D6A3;
 Mon, 14 Oct 2019 08:46:26 +0000 (UTC)
Subject: Re: [PATCH v3 04/16] qcow2: Keep unknown extra snapshot data
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20191011152814.14791-1-mreitz@redhat.com>
 <20191011152814.14791-5-mreitz@redhat.com>
 <8ecf3ce6-51e4-63ee-8fdc-945ca3e1f397@redhat.com>
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
Message-ID: <2831d94c-eb4f-00c8-a462-029a3403d79a@redhat.com>
Date: Mon, 14 Oct 2019 10:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8ecf3ce6-51e4-63ee-8fdc-945ca3e1f397@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="80XB02Yt97pbqeLeHdnDUOhEyyEbGhmOg"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 14 Oct 2019 08:46:27 +0000 (UTC)
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
--80XB02Yt97pbqeLeHdnDUOhEyyEbGhmOg
Content-Type: multipart/mixed; boundary="rrfdYa9YyO9DpYuJ39xTnO08K9ByfQf02"

--rrfdYa9YyO9DpYuJ39xTnO08K9ByfQf02
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 18:20, Eric Blake wrote:
> On 10/11/19 10:28 AM, Max Reitz wrote:
>> The qcow2 specification says to ignore unknown extra data fields in
>> snapshot table entries.=C2=A0 Currently, we discard it whenever we upd=
ate the
>> image, which is a bit different from "ignore".
>>
>> This patch makes the qcow2 driver keep all unknown extra data fields
>> when updating an image's snapshot table.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>=20
>> =C2=A0 /* Bitmap header extension constraints */
>> =C2=A0 #define QCOW2_MAX_BITMAPS 65535
>> =C2=A0 #define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMA=
PS)
>> @@ -181,6 +184,8 @@ typedef struct QCowSnapshot {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t date_sec;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t date_nsec;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t vm_clock_nsec;
>> +=C2=A0=C2=A0=C2=A0 uint32_t extra_data_size;
>> +=C2=A0=C2=A0=C2=A0 void *unknown_extra_data; /* Extra data past
>> QCowSnapshotExtraData */
>=20
> Would it be worth a comment change:
>=20
> uint32_t extra_data_size; /* Size of all extra data, including
> QCowSnapshotExtraData */
> void *unknown_extra_data; /* Data beyond QCowSnapshotExtraData, if any =
*/
>=20
> Either way, R-b stands.

Can=E2=80=99t hurt.  Well, except that extra_data_size may or may not inc=
lude
QCowSnapshotExtraData, because maybe it isn=E2=80=99t fully present in th=
e image.

Max


--rrfdYa9YyO9DpYuJ39xTnO08K9ByfQf02--

--80XB02Yt97pbqeLeHdnDUOhEyyEbGhmOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2kNeEACgkQ9AfbAGHV
z0AhVwf/aRILN31uxs7BAqNTeNGwca+Cgymm5OlqgyOAT5jfYKghYAkZH9PWwrjQ
Urxg/nJd1v0zmem7uLd2DKKY2J5i90mEdcwwq2DBN/bMvNBbSQHUOAyRzlRCwmwX
WWdGB0CLUK3U/se73dftIKNIQnOvm06MnqV0KVo5XeDFYlWU9T181tnjPuSC8aH2
/9OMYbLg5CqBg8bk7A0qDIK/whMksT23/pQrSxMVD73IUEIeQBcJ9VpxBbjLPC7l
it0EcASjGUHpyNFQ288r2QrIAre4PLijCoq7rRjrgfGVRJRhfJ0f8x/2y8A5S76M
Wt5+KiYhnudcjfpqUbLfmthKR/Wi/w==
=cU0z
-----END PGP SIGNATURE-----

--80XB02Yt97pbqeLeHdnDUOhEyyEbGhmOg--


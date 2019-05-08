Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96582C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D65C205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMcY-0002Lc-L1
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:28:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOMXu-0005K6-TK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOMXt-0002N0-RE
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOMXr-0002IP-Cc; Wed, 08 May 2019 09:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF8745D61E;
	Wed,  8 May 2019 13:23:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-94.brq.redhat.com
	[10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 781FF608E4;
	Wed,  8 May 2019 13:23:32 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
	<20190506194753.12464-2-mreitz@redhat.com>
	<20190508130611.GE15525@dhcp-200-226.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <4f771d69-2489-bf88-cc1e-a9a4facc9485@redhat.com>
Date: Wed, 8 May 2019 15:23:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508130611.GE15525@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mlupj7iWjjhCISQHApExDxFsP4zAtGVrR"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 08 May 2019 13:23:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/7] file-posix: Update open_flags in
 raw_set_perm()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mlupj7iWjjhCISQHApExDxFsP4zAtGVrR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Message-ID: <4f771d69-2489-bf88-cc1e-a9a4facc9485@redhat.com>
Subject: Re: [PATCH 1/7] file-posix: Update open_flags in raw_set_perm()
References: <20190506194753.12464-1-mreitz@redhat.com>
 <20190506194753.12464-2-mreitz@redhat.com>
 <20190508130611.GE15525@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190508130611.GE15525@dhcp-200-226.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 15:06, Kevin Wolf wrote:
> Am 06.05.2019 um 21:47 hat Max Reitz geschrieben:
>> raw_check_perm() + raw_set_perm() can change the flags associated with=

>> the current FD.  If so, we have to update BDRVRawState.open_flags
>> accordingly.  Otherwise, we may keep reopening the FD even though the
>> current one already has the correct flags.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/file-posix.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 1cf4ee49eb..66b46ec0eb 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -145,6 +145,7 @@ typedef struct BDRVRawState {
>>      uint64_t locked_shared_perm;
>> =20
>>      int perm_change_fd;
>> +    int perm_change_flags;
>>      BDRVReopenState *reopen_state;
>> =20
>>  #ifdef CONFIG_XFS
>> @@ -2762,6 +2763,7 @@ static int raw_check_perm(BlockDriverState *bs, =
uint64_t perm, uint64_t shared,
>=20
> Adding some context before this hunk:
>=20
>     if (s->reopen_state) {
>         /* We already have a new file descriptor to set permissions for=
 */
>         assert(s->reopen_state->perm =3D=3D perm);
>         assert(s->reopen_state->shared_perm =3D=3D shared);
>         rs =3D s->reopen_state->opaque;
>         s->perm_change_fd =3D rs->fd;
>     } else {
>         /* We may need a new fd if auto-read-only switches the mode */
>         ret =3D raw_reconfigure_getfd(bs, bs->open_flags, &open_flags, =
perm,
>                                     false, errp);
>         if (ret < 0) {
>>              return ret;
>>          } else if (ret !=3D s->fd) {
>>              s->perm_change_fd =3D ret;
>> +            s->perm_change_flags =3D open_flags;
>>          }
>>      }
>=20
> s->perm_change_flags is set in the else branch. According to the commen=
t
> in raw_set_perm(), not setting it in the then branch is actually correc=
t
> because .bdrv_reopen_commit will run first, so s->perm_change_flags
> isn't accessed, but wouldn't it be nicer to have a valid value in it
> anyway? Who knows where we'll add accesses later.

Why not, it can=E2=80=99t hurt.

Max


--mlupj7iWjjhCISQHApExDxFsP4zAtGVrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzS2FMACgkQ9AfbAGHV
z0CKIQf9E6g9h30fuqGQ3sgkR4ukYmrId8JmVFlwtQJN/tVbsCnee8rSOZmDM6EM
2GGf2OAyxNk/h7/it+31QoyCKrbSMPbYcm0zP9JCoQecPfWY6YM9k3tDVw/mMZVm
Ib1GZaIPAFVa5/nsrK17m8FkqSARuaOr0W5EQvOLc0Xb1iPFYZ1say8AgrJdnnPR
K9dIjJLMKLwh9Qvvc2auISl3nkK/7LkVAx7zZrnTeCm3GIb7WMIxogQGOPIwgYfx
xOwDdc2q0yJbGccDSlK6A2BcqoxcvCi/TDjFsUhFay9KhuLR8hUxIZCbFl+qtmMp
iZq99+0TvAj/P4mCNseiyHh7wcjc6A==
=3bbR
-----END PGP SIGNATURE-----

--mlupj7iWjjhCISQHApExDxFsP4zAtGVrR--


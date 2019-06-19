Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA75C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 17:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA94720645
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 17:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA94720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdeWT-0000ju-Bl
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 13:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdeBw-0008Qv-26
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdeBg-0007CM-GC
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdeBB-0005ji-5I; Wed, 19 Jun 2019 13:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE65D309267B;
 Wed, 19 Jun 2019 17:12:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51F601001E67;
 Wed, 19 Jun 2019 17:12:35 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
 <20190605121721.29815-4-shmuel.eiderman@oracle.com>
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
Message-ID: <8d8af1b9-426a-780c-6240-9e20603e9008@redhat.com>
Date: Wed, 19 Jun 2019 19:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605121721.29815-4-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="npxPC504qHxaoDuJjmC6xfBoCsEBEeTqR"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 19 Jun 2019 17:12:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] vmdk: Add read-only support for
 seSparse snapshots
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
Cc: arbel.moshe@oracle.com, liran.alon@oracle.com, eyal.moscovici@oracle.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--npxPC504qHxaoDuJjmC6xfBoCsEBEeTqR
Content-Type: multipart/mixed; boundary="7AyE5hRSRlYlXXXAedgCRlHSb9TGJtuHt";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eyal.moscovici@oracle.com, karl.heubaum@oracle.com,
 liran.alon@oracle.com, arbel.moshe@oracle.com
Message-ID: <8d8af1b9-426a-780c-6240-9e20603e9008@redhat.com>
Subject: Re: [PATCH v2 3/3] vmdk: Add read-only support for seSparse snapshots
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
 <20190605121721.29815-4-shmuel.eiderman@oracle.com>
In-Reply-To: <20190605121721.29815-4-shmuel.eiderman@oracle.com>

--7AyE5hRSRlYlXXXAedgCRlHSb9TGJtuHt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.06.19 14:17, Sam Eiderman wrote:
> Until ESXi 6.5 VMware used the vmfsSparse format for snapshots (VMDK3 i=
n
> QEMU).
>=20
> This format was lacking in the following:
>=20
>     * Grain directory (L1) and grain table (L2) entries were 32-bit,
>       allowing access to only 2TB (slightly less) of data.
>     * The grain size (default) was 512 bytes - leading to data
>       fragmentation and many grain tables.
>     * For space reclamation purposes, it was necessary to find all the
>       grains which are not pointed to by any grain table - so a reverse=

>       mapping of "offset of grain in vmdk" to "grain table" must be
>       constructed - which takes large amounts of CPU/RAM.
>=20
> The format specification can be found in VMware's documentation:
> https://www.vmware.com/support/developer/vddk/vmdk_50_technote.pdf
>=20
> In ESXi 6.5, to support snapshot files larger than 2TB, a new format wa=
s
> introduced: SESparse (Space Efficient).
>=20
> This format fixes the above issues:
>=20
>     * All entries are now 64-bit.
>     * The grain size (default) is 4KB.
>     * Grain directory and grain tables are now located at the beginning=

>       of the file.
>       + seSparse format reserves space for all grain tables.
>       + Grain tables can be addressed using an index.
>       + Grains are located in the end of the file and can also be
>         addressed with an index.
>       - seSparse vmdks of large disks (64TB) have huge preallocated
>         headers - mainly due to L2 tables, even for empty snapshots.
>     * The header contains a reverse mapping ("backmap") of "offset of
>       grain in vmdk" to "grain table" and a bitmap ("free bitmap") whic=
h
>       specifies for each grain - whether it is allocated or not.
>       Using these data structures we can implement space reclamation
>       efficiently.
>     * Due to the fact that the header now maintains two mappings:
>         * The regular one (grain directory & grain tables)
>         * A reverse one (backmap and free bitmap)
>       These data structures can lose consistency upon crash and result
>       in a corrupted VMDK.
>       Therefore, a journal is also added to the VMDK and is replayed
>       when the VMware reopens the file after a crash.
>=20
> Since ESXi 6.7 - SESparse is the only snapshot format available.
>=20
> Unfortunately, VMware does not provide documentation regarding the new
> seSparse format.
>=20
> This commit is based on black-box research of the seSparse format.
> Various in-guest block operations and their effect on the snapshot file=

> were tested.
>=20
> The only VMware provided source of information (regarding the underlyin=
g
> implementation) was a log file on the ESXi:
>=20
>     /var/log/hostd.log
>=20
> Whenever an seSparse snapshot is created - the log is being populated
> with seSparse records.
>=20
> Relevant log records are of the form:
>=20
> [...] Const Header:
> [...]  constMagic     =3D 0xcafebabe
> [...]  version        =3D 2.1
> [...]  capacity       =3D 204800
> [...]  grainSize      =3D 8
> [...]  grainTableSize =3D 64
> [...]  flags          =3D 0
> [...] Extents:
> [...]  Header         : <1 : 1>
> [...]  JournalHdr     : <2 : 2>
> [...]  Journal        : <2048 : 2048>
> [...]  GrainDirectory : <4096 : 2048>
> [...]  GrainTables    : <6144 : 2048>
> [...]  FreeBitmap     : <8192 : 2048>
> [...]  BackMap        : <10240 : 2048>
> [...]  Grain          : <12288 : 204800>
> [...] Volatile Header:
> [...] volatileMagic     =3D 0xcafecafe
> [...] FreeGTNumber      =3D 0
> [...] nextTxnSeqNumber  =3D 0
> [...] replayJournal     =3D 0
>=20
> The sizes that are seen in the log file are in sectors.
> Extents are of the following format: <offset : size>
>=20
> This commit is a strict implementation which enforces:
>     * magics
>     * version number 2.1
>     * grain size of 8 sectors  (4KB)
>     * grain table size of 64 sectors
>     * zero flags
>     * extent locations
>=20
> Additionally, this commit proivdes only a subset of the functionality
> offered by seSparse's format:
>     * Read-only
>     * No journal replay
>     * No space reclamation
>     * No unmap support
>=20
> Hence, journal header, journal, free bitmap and backmap extents are
> unused, only the "classic" (L1 -> L2 -> data) grain access is
> implemented.
>=20
> However there are several differences in the grain access itself.
> Grain directory (L1):
>     * Grain directory entries are indexes (not offsets) to grain
>       tables.
>     * Valid grain directory entries have their highest nibble set to
>       0x1.
>     * Since grain tables are always located in the beginning of the
>       file - the index can fit into 32 bits - so we can use its low
>       part if it's valid.
> Grain table (L2):
>     * Grain table entries are indexes (not offsets) to grains.
>     * If the highest nibble of the entry is:
>         0x0:
>             The grain in not allocated.
>             The rest of the bytes are 0.
>         0x1:
>             The grain is unmapped - guest sees a zero grain.
>             The rest of the bits point to the previously mapped grain,
>             see 0x3 case.
>         0x2:
>             The grain is zero.
>         0x3:
>             The grain is allocated - to get the index calculate:
>             ((entry & 0x0fff000000000000) >> 48) |
>             ((entry & 0x0000ffffffffffff) << 12)
>     * The difference between 0x1 and 0x2 is that 0x1 is an unallocated
>       grain which results from the guest using sg_unmap to unmap the
>       grain - but the grain itself still exists in the grain extent - a=

>       space reclamation procedure should delete it.
>       Unmapping a zero grain has no effect (0x2 will not change to 0x1)=

>       but unmapping an unallocated grain will (0x0 to 0x1) - naturally.=

>=20
> In order to implement seSparse some fields had to be changed to support=

> both 32-bit and 64-bit entry sizes.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  block/vmdk.c | 357 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
>  1 file changed, 341 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 931eb2759c..4377779635 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c

[...]

> +static int vmdk_open_se_sparse(BlockDriverState *bs,
> +                               BdrvChild *file,
> +                               int flags, Error **errp)
> +{
> +    int ret;
> +    VMDKSESparseConstHeader const_header;
> +    VMDKSESparseVolatileHeader volatile_header;
> +    VmdkExtent *extent;
> +
> +    if (flags & BDRV_O_RDWR) {
> +        error_setg(errp, "No write support for seSparse images availab=
le");
> +        return -ENOTSUP;
> +    }
Kind of works for me, but why not bdrv_apply_auto_read_only() like I had
proposed?  The advantage is that this would make the node read-only if
the user has specified auto-read-only=3Don instead of failing.

Max


--7AyE5hRSRlYlXXXAedgCRlHSb9TGJtuHt--

--npxPC504qHxaoDuJjmC6xfBoCsEBEeTqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KbQEACgkQ9AfbAGHV
z0DIbwf/eIXL1wGV4omNXDJDULZQvcD9kjdzRvbAuulwvi4xdgFxj5/uVVzm6x6i
GwnvRUcK/4dr6Q59w1BwumXuXlsn6/Zt3kpsBcYXfo5gK5A5HElH6FjZK7hr4S0V
V66adFv7KdiAxvBMCUSiTghTiIuuTuTKtSOEP0u1GRgz5UzORn+nPTbTroH2qz4B
0FfdlqHjBP80jievHdGFDqxGseznDBdWQICBln45lDWhtsBhrW/jY+94+l7T4VHB
75+rQ9rm/O+BV5YoJ/TiDQHyZToMhLM0+ayQPRL2T1JBcKv1hlhXn9N+CwPKzjN5
icrpkSv9P5gTd+IaztyEEW24Cpx1rQ==
=5ECd
-----END PGP SIGNATURE-----

--npxPC504qHxaoDuJjmC6xfBoCsEBEeTqR--


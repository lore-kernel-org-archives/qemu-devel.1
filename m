Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D40C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 17:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613D3208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 17:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613D3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVJcK-0002Go-EW
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 13:41:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVJb7-0001c3-C8
	for qemu-devel@nongnu.org; Mon, 27 May 2019 13:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVJb3-0002My-EN
	for qemu-devel@nongnu.org; Mon, 27 May 2019 13:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVJas-000294-4E; Mon, 27 May 2019 13:39:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0CABAC2E2;
	Mon, 27 May 2019 17:39:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 565322E19B;
	Mon, 27 May 2019 17:39:18 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, fam@euphon.net,
	kwolf@redhat.com, qemu-block@nongnu.org
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
	<20190424074901.31430-3-shmuel.eiderman@oracle.com>
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
Message-ID: <8a27479f-3948-df17-5abc-0c22811ae4b2@redhat.com>
Date: Mon, 27 May 2019 19:39:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424074901.31430-3-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3dDvRZCOe3GllzjeVNSI4FTkOwNhWAkbe"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 27 May 2019 17:39:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] vmdk: Add read-only support for
 seSparse snapshots
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
Cc: eyal.moscovici@oracle.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
	karl.heubaum@oracle.com, arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3dDvRZCOe3GllzjeVNSI4FTkOwNhWAkbe
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, fam@euphon.net,
 kwolf@redhat.com, qemu-block@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com,
 eyal.moscovici@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Message-ID: <8a27479f-3948-df17-5abc-0c22811ae4b2@redhat.com>
Subject: Re: [PATCH 2/2] vmdk: Add read-only support for seSparse snapshots
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
 <20190424074901.31430-3-shmuel.eiderman@oracle.com>
In-Reply-To: <20190424074901.31430-3-shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.04.19 09:49, Sam Eiderman wrote:
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
> Read-only is implemented by failing on pwrite since qemu-img opens the
> vmdk with read-write flags for "convert" (which is a read-only)
> operation.

Does it?  The code doesn=E2=80=99t look like it (in img_convert(), src_fl=
ags is
never set to anything with BDRV_O_RDWR).

In theory, we have bdrv_apply_auto_read_only() for this case.  More on
that below. [1]

> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  block/vmdk.c | 475 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 459 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/vmdk.c b/block/vmdk.c
> index fc7378da78..e599c08b95 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c

First, a general observation: BDRV_SECTOR_SIZE is indeed equal to VMDK=E2=
=80=99s
sector size (both are 512), but I=E2=80=99d consider that a coincidence. =
 This
file defines a SECTOR_SIZE macro.  I think you should use that instead
of BDRV_SECTOR_SIZE whenever referring to VMDK=E2=80=99s sector size.

(BDRV_SECTOR_SIZE is actually the sector size the qemu block layer uses.
 Yes, I know, there are plenty of places in vmdk.c that use it.  I still
think it isn=E2=80=99t entirely correct to use it.)

> @@ -91,6 +91,44 @@ typedef struct {
>      uint16_t compressAlgorithm;
>  } QEMU_PACKED VMDK4Header;
> =20
> +typedef struct VMDKSESparseConstHeader {
> +    uint64_t magic;
> +    uint64_t version;
> +    uint64_t capacity;
> +    uint64_t grain_size;
> +    uint64_t grain_table_size;
> +    uint64_t flags;
> +    uint64_t reserved1;
> +    uint64_t reserved2;
> +    uint64_t reserved3;
> +    uint64_t reserved4;
> +    uint64_t volatile_header_offset;
> +    uint64_t volatile_header_size;
> +    uint64_t journal_header_offset;
> +    uint64_t journal_header_size;
> +    uint64_t journal_offset;
> +    uint64_t journal_size;
> +    uint64_t grain_dir_offset;
> +    uint64_t grain_dir_size;
> +    uint64_t grain_tables_offset;
> +    uint64_t grain_tables_size;
> +    uint64_t free_bitmap_offset;
> +    uint64_t free_bitmap_size;
> +    uint64_t backmap_offset;
> +    uint64_t backmap_size;
> +    uint64_t grains_offset;
> +    uint64_t grains_size;
> +    uint8_t pad[304];
> +} QEMU_PACKED VMDKSESparseConstHeader;
> +
> +typedef struct VMDKSESparseVolatileHeader {

Is this the official name?  (I know you don=E2=80=99t have a specificatio=
n, but
maybe you do have some half-official information, I don=E2=80=99t know.)
Generally, I=E2=80=99d call the opposite of =E2=80=9Cconst=E2=80=9D =E2=80=
=9Cmutable=E2=80=9D.

> +    uint64_t magic;
> +    uint64_t free_gt_number;
> +    uint64_t next_txn_seq_number;
> +    uint64_t replay_journal;
> +    uint8_t pad[480];
> +} QEMU_PACKED VMDKSESparseVolatileHeader;
> +
>  #define L2_CACHE_SIZE 16
> =20
>  typedef struct VmdkExtent {
> @@ -99,19 +137,23 @@ typedef struct VmdkExtent {
>      bool compressed;
>      bool has_marker;
>      bool has_zero_grain;
> +    bool sesparse;
> +    uint64_t sesparse_l2_tables_offset;
> +    uint64_t sesparse_clusters_offset;
> +    int32_t entry_size;
>      int version;
>      int64_t sectors;
>      int64_t end_sector;
>      int64_t flat_start_offset;
>      int64_t l1_table_offset;
>      int64_t l1_backup_table_offset;
> -    uint32_t *l1_table;
> +    void *l1_table;
>      uint32_t *l1_backup_table;
>      unsigned int l1_size;
>      uint32_t l1_entry_sectors;
> =20
>      unsigned int l2_size;
> -    uint32_t *l2_cache;
> +    void *l2_cache;
>      uint32_t l2_cache_offsets[L2_CACHE_SIZE];
>      uint32_t l2_cache_counts[L2_CACHE_SIZE];
> =20
> @@ -434,6 +476,8 @@ static int vmdk_add_extent(BlockDriverState *bs,
>           *            cluster size: 64KB, L2 table size: 512 entries
>           *     1PB  - for default "ESXi Host Sparse Extent" (VMDK3/vmf=
sSparse)
>           *            cluster size: 512B, L2 table size: 4096 entries
> +         *     8PB  - for default "ESXI seSparse Extent"
> +         *            cluster size: 4KB,  L2 table size: 4096 entries
>           */
>          error_setg(errp, "L1 size too big");
>          return -EFBIG;

Hm, now I wonder about this limit.  With this new format, it=E2=80=99d be=
 512M *
8 =3D 4 GB of RAM usage.  That seems an awful lot, and I don=E2=80=99t th=
ink we
really need to support 8 PB images.  Like, if we want to prevent
unbounded allocations, 4 GB is far above the limit of what I=E2=80=99d co=
nsider
sane.  (And I don=E2=80=99t know too much above vmdk, but can=E2=80=99t a=
 user also
specify multiple extents with a single descriptor file, and thus make
qemu allocate these 4 GB multiple times?)

Some comment in this file says the maximum supported size is 64 TB
anyway.  Shouldn=E2=80=99t we just limit the L1 size accordingly, then?

> @@ -459,6 +503,7 @@ static int vmdk_add_extent(BlockDriverState *bs,
>      extent->l2_size =3D l2_size;
>      extent->cluster_sectors =3D flat ? sectors : cluster_sectors;
>      extent->next_cluster_sector =3D ROUND_UP(nb_sectors, cluster_secto=
rs);
> +    extent->entry_size =3D sizeof(uint32_t);
> =20
>      if (s->num_extents > 1) {
>          extent->end_sector =3D (*(extent - 1)).end_sector + extent->se=
ctors;
> @@ -480,7 +525,7 @@ static int vmdk_init_tables(BlockDriverState *bs, V=
mdkExtent *extent,
>      int i;
> =20
>      /* read the L1 table */
> -    l1_size =3D extent->l1_size * sizeof(uint32_t);
> +    l1_size =3D extent->l1_size * extent->entry_size;

Related to the above: This can overflow.  (512M * 8 =3D=3D 4G)

>      extent->l1_table =3D g_try_malloc(l1_size);
>      if (l1_size && extent->l1_table =3D=3D NULL) {
>          return -ENOMEM;
> @@ -498,10 +543,15 @@ static int vmdk_init_tables(BlockDriverState *bs,=
 VmdkExtent *extent,
>          goto fail_l1;
>      }
>      for (i =3D 0; i < extent->l1_size; i++) {
> -        le32_to_cpus(&extent->l1_table[i]);
> +        if (extent->sesparse) {

Shouldn=E2=80=99t matter in practice, but I think evaluating extent->entr=
y_size
would be more natural.

> +            le64_to_cpus((uint64_t *)extent->l1_table + i);
> +        } else {
> +            le32_to_cpus((uint32_t *)extent->l1_table + i);
> +        }
>      }
> =20
>      if (extent->l1_backup_table_offset) {
> +        assert(!extent->sesparse);
>          extent->l1_backup_table =3D g_try_malloc(l1_size);
>          if (l1_size && extent->l1_backup_table =3D=3D NULL) {
>              ret =3D -ENOMEM;
> @@ -524,7 +574,7 @@ static int vmdk_init_tables(BlockDriverState *bs, V=
mdkExtent *extent,
>      }
> =20
>      extent->l2_cache =3D
> -        g_new(uint32_t, extent->l2_size * L2_CACHE_SIZE);
> +        g_malloc(extent->entry_size * extent->l2_size * L2_CACHE_SIZE)=
;
>      return 0;
>   fail_l1b:
>      g_free(extent->l1_backup_table);
> @@ -570,6 +620,331 @@ static int vmdk_open_vmfs_sparse(BlockDriverState=
 *bs,
>      return ret;
>  }
> =20
> +#define SESPARSE_CONST_HEADER_MAGIC 0x00000000cafebabe
> +#define SESPARSE_VOLATILE_HEADER_MAGIC 0x00000000cafecafe

The upper 32 bit are 0, so it doesn=E2=80=99t really matter, but still, i=
f these
are 64-bit constants (which they are), they should have a 64-bit type
(e.g. UINT64_C(0x00000000cafebabe)).  (According to my very personal
taste at least.)

> +
> +static const char zero_pad[BDRV_SECTOR_SIZE];
> +
> +/* Strict checks - format not officially documented */
> +static int check_se_sparse_const_header(VMDKSESparseConstHeader *heade=
r,
> +                                        Error **errp)
> +{
> +    uint64_t grain_table_coverage;
> +    uint64_t needed_grain_tables;
> +    uint64_t needed_grain_dir_size;
> +    uint64_t needed_grain_tables_size;
> +    uint64_t needed_free_bitmap_size;
> +
> +    header->magic =3D le64_to_cpu(header->magic);
> +    header->version =3D le64_to_cpu(header->version);
> +    header->grain_size =3D le64_to_cpu(header->grain_size);
> +    header->grain_table_size =3D le64_to_cpu(header->grain_table_size)=
;
> +    header->flags =3D le64_to_cpu(header->flags);
> +    header->reserved1 =3D le64_to_cpu(header->reserved1);
> +    header->reserved2 =3D le64_to_cpu(header->reserved2);
> +    header->reserved3 =3D le64_to_cpu(header->reserved3);
> +    header->reserved4 =3D le64_to_cpu(header->reserved4);
> +
> +    header->volatile_header_offset =3D
> +        le64_to_cpu(header->volatile_header_offset);
> +    header->volatile_header_size =3D le64_to_cpu(header->volatile_head=
er_size);
> +
> +    header->journal_header_offset =3D le64_to_cpu(header->journal_head=
er_offset);
> +    header->journal_header_size =3D le64_to_cpu(header->journal_header=
_size);
> +
> +    header->journal_offset =3D le64_to_cpu(header->journal_offset);
> +    header->journal_size =3D le64_to_cpu(header->journal_size);
> +
> +    header->grain_dir_offset =3D le64_to_cpu(header->grain_dir_offset)=
;
> +    header->grain_dir_size =3D le64_to_cpu(header->grain_dir_size);
> +
> +    header->grain_tables_offset =3D le64_to_cpu(header->grain_tables_o=
ffset);
> +    header->grain_tables_size =3D le64_to_cpu(header->grain_tables_siz=
e);
> +
> +    header->free_bitmap_offset =3D le64_to_cpu(header->free_bitmap_off=
set);
> +    header->free_bitmap_size =3D le64_to_cpu(header->free_bitmap_size)=
;
> +
> +    header->backmap_offset =3D le64_to_cpu(header->backmap_offset);
> +    header->backmap_size =3D le64_to_cpu(header->backmap_size);
> +
> +    header->grains_offset =3D le64_to_cpu(header->grains_offset);
> +    header->grains_size =3D le64_to_cpu(header->grains_size);
> +
> +    if (header->magic !=3D SESPARSE_CONST_HEADER_MAGIC) {
> +        error_setg(errp, "Bad const header magic: 0x%016" PRIx64,
> +                   header->magic);
> +        return -EINVAL;
> +    }
> +
> +    if (header->version !=3D 0x0000000200000001) {
> +        error_setg(errp, "Unsupported version: 0x%016" PRIx64,
> +                   header->version);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->grain_size !=3D 8) {
> +        error_setg(errp, "Unsupported grain size: %" PRIu64,
> +                   header->grain_size);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->grain_table_size !=3D 64) {
> +        error_setg(errp, "Unsupported grain table size: %" PRIu64,
> +                   header->grain_table_size);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->flags !=3D 0) {
> +        error_setg(errp, "Unsupported flags: 0x%016" PRIx64,
> +                   header->flags);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->reserved1 !=3D 0 || header->reserved2 !=3D 0 ||
> +        header->reserved3 !=3D 0 || header->reserved4 !=3D 0) {
> +        error_setg(errp, "Unsupported reserved bits:"
> +                   " 0x%016" PRIx64 " 0x%016" PRIx64
> +                   " 0x%016" PRIx64 " 0x%016" PRIx64,
> +                   header->reserved1, header->reserved2,
> +                   header->reserved3, header->reserved4);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->volatile_header_offset !=3D 1) {
> +        error_setg(errp, "Unsupported volatile header offset: %" PRIu6=
4,
> +                   header->volatile_header_offset);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->volatile_header_size !=3D 1) {
> +        error_setg(errp, "Unsupported volatile header size: %" PRIu64,=

> +                   header->volatile_header_size);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->journal_header_offset !=3D 2) {
> +        error_setg(errp, "Unsupported journal header offset: %" PRIu64=
,
> +                   header->journal_header_offset);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->journal_header_size !=3D 2) {
> +        error_setg(errp, "Unsupported journal header size: %" PRIu64,
> +                   header->journal_header_size);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->journal_offset !=3D 2048) {
> +        error_setg(errp, "Unsupported journal offset: %" PRIu64,
> +                   header->journal_offset);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->journal_size !=3D 2048) {
> +        error_setg(errp, "Unsupported journal size: %" PRIu64,
> +                   header->journal_size);
> +        return -ENOTSUP;
> +    }
> +
> +    if (header->grain_dir_offset !=3D 4096) {
> +        error_setg(errp, "Unsupported grain directory offset: %" PRIu6=
4,
> +                   header->grain_dir_offset);
> +        return -ENOTSUP;
> +    }

Do these values (metadata structure offsets and sizes) really matter?

> +    /* in sectors */
> +    grain_table_coverage =3D ((header->grain_table_size *

Hm, if header->grain_table_size is measured in sectors, it=E2=80=99d prob=
ably be
better to rename it to grain_table_sectors or something.

(=E2=80=9Csize=E2=80=9D is usually in bytes; sometimes it=E2=80=99s the n=
umber of entries, but
that=E2=80=99s already kind of weird, I think)

> +                             BDRV_SECTOR_SIZE / sizeof(uint64_t)) *
> +                            header->grain_size);
> +    needed_grain_tables =3D header->capacity / grain_table_coverage;
> +    needed_grain_dir_size =3D DIV_ROUND_UP(needed_grain_tables * sizeo=
f(uint64_t),
> +                                         BDRV_SECTOR_SIZE);
> +    needed_grain_dir_size =3D ROUND_UP(needed_grain_dir_size, 2048);
> +
> +    if (header->grain_dir_size !=3D needed_grain_dir_size) {

Wouldn=E2=80=99t it suffice to check that header->grain_dir_size >=3D
needed_grain_dir_size?  (The ROUND_UP() would become unnecessary, then.)

(And also, maybe s/grain_dir_size/grain_dir_sectors/)

> +        error_setg(errp, "Invalid grain directory size: %" PRIu64
> +                   ", needed: %" PRIu64,
> +                   header->grain_dir_size, needed_grain_dir_size);
> +        return -EINVAL;
> +    }
> +
> +    if (header->grain_tables_offset !=3D
> +        header->grain_dir_offset + header->grain_dir_size) {
> +        error_setg(errp, "Grain directory must be followed by grain ta=
bles");
> +        return -EINVAL;
> +    }
> +
> +    needed_grain_tables_size =3D needed_grain_tables * header->grain_t=
able_size;
> +    needed_grain_tables_size =3D ROUND_UP(needed_grain_tables_size, 20=
48);
> +
> +    if (header->grain_tables_size !=3D needed_grain_tables_size) {
> +        error_setg(errp, "Invalid grain tables size: %" PRIu64
> +                   ", needed: %" PRIu64,
> +                   header->grain_tables_size, needed_grain_tables_size=
);
> +        return -EINVAL;
> +    }
> +
> +    if (header->free_bitmap_offset !=3D
> +        header->grain_tables_offset + header->grain_tables_size) {
> +        error_setg(errp, "Grain tables must be followed by free bitmap=
");
> +        return -EINVAL;
> +    }
> +
> +    /* in bits */
> +    needed_free_bitmap_size =3D DIV_ROUND_UP(header->capacity,
> +                                           header->grain_size);
> +    /* in bytes */
> +    needed_free_bitmap_size =3D DIV_ROUND_UP(needed_free_bitmap_size,
> +                                           BITS_PER_BYTE);
> +    /* in sectors */
> +    needed_free_bitmap_size =3D DIV_ROUND_UP(needed_free_bitmap_size,
> +                                           BDRV_SECTOR_SIZE);
> +    needed_free_bitmap_size =3D ROUND_UP(needed_free_bitmap_size, 2048=
);

Er, now this is really confusing.  I=E2=80=99d start with the size in byt=
es:

> needed_free_bitmap_size =3D DIV_ROUND_UP(header->capacity,
>                                        header->grain_size * BITS_PER_BY=
TE);

and then translate it to sectors, but use a new variable for it
(needed_free_bitmap_sectors).

> +
> +    if (header->free_bitmap_size !=3D needed_free_bitmap_size) {

Again, I suppose just checking that header->free_bitmap_size >=3D
needed_free_bitmap_size should be enough, I think.

> +        error_setg(errp, "Invalid free bitmap size: %" PRIu64
> +                   ", needed: %" PRIu64,
> +                   header->free_bitmap_size, needed_free_bitmap_size);=

> +        return -EINVAL;
> +    }
> +
> +    if (header->backmap_offset !=3D
> +        header->free_bitmap_offset + header->free_bitmap_size) {
> +        error_setg(errp, "Free bitmap must be followed by backmap");
> +        return -EINVAL;
> +    }
> +
> +    if (header->backmap_size !=3D header->grain_tables_size) {
> +        error_setg(errp, "Invalid backmap size: %" PRIu64
> +                   ", needed: %" PRIu64,
> +                   header->backmap_size, header->grain_tables_size);
> +        return -EINVAL;
> +    }
> +
> +    if (header->grains_offset !=3D
> +        header->backmap_offset + header->backmap_size) {
> +        error_setg(errp, "Backmap must be followed by grains");
> +        return -EINVAL;
> +    }
> +
> +    if (header->grains_size !=3D header->capacity) {
> +        error_setg(errp, "Invalid grains size: %" PRIu64
> +                   ", needed: %" PRIu64,
> +                   header->grains_size, header->capacity);
> +        return -EINVAL;
> +    }
> +
> +    /* check that padding is 0 */
> +    if (memcmp(header->pad, zero_pad, sizeof(header->pad))) {

buffer_is_zero() should be sufficient.

> +        error_setg(errp, "Unsupported non-zero const header padding");=

> +        return -ENOTSUP;
> +    }
> +
> +    return 0;
> +}
> +
> +static int check_se_sparse_volatile_header(VMDKSESparseVolatileHeader =
*header,
> +                                           Error **errp)
> +{
> +    header->magic =3D le64_to_cpu(header->magic);
> +    header->free_gt_number =3D le64_to_cpu(header->free_gt_number);
> +    header->next_txn_seq_number =3D le64_to_cpu(header->next_txn_seq_n=
umber);
> +    header->replay_journal =3D le64_to_cpu(header->replay_journal);
> +
> +    if (header->magic !=3D SESPARSE_VOLATILE_HEADER_MAGIC) {
> +        error_setg(errp, "Bad volatile header magic: 0x%016" PRIx64,
> +                   header->magic);
> +        return -EINVAL;
> +    }
> +
> +    if (header->replay_journal) {
> +        error_setg(errp, "Replaying journal not supported");

Hmmm, maybe "Image is dirty, replaying journal not supported"?

> +        return -ENOTSUP;
> +    }
> +
> +    /* check that padding is 0 */
> +    if (memcmp(header->pad, zero_pad, sizeof(header->pad))) {
> +        error_setg(errp, "Unsupported non-zero volatile header padding=
");
> +        return -ENOTSUP;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vmdk_open_se_sparse(BlockDriverState *bs,
> +                               BdrvChild *file,
> +                               int flags, Error **errp)
> +{
> +    int ret;
> +    VMDKSESparseConstHeader const_header;
> +    VMDKSESparseVolatileHeader volatile_header;
> +    VmdkExtent *extent;
> +
> +    assert(sizeof(const_header) =3D=3D BDRV_SECTOR_SIZE);
> +

[1] I think if you put a

ret =3D bdrv_apply_auto_read_only(bs,
    "No write support for seSparse images available", errp);
if (ret < 0) {
    return ret;
}

here, that should do the trick.

> +    ret =3D bdrv_pread(file, 0, &const_header, sizeof(const_header));
> +    if (ret < 0) {
> +        bdrv_refresh_filename(file->bs);
> +        error_setg_errno(errp, -ret,
> +                         "Could not read const header from file '%s'",=

> +                         file->bs->filename);
> +        return ret;
> +    }
> +
> +    /* check const header */
> +    ret =3D check_se_sparse_const_header(&const_header, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    assert(sizeof(volatile_header) =3D=3D BDRV_SECTOR_SIZE);
> +
> +    ret =3D bdrv_pread(file,
> +                     const_header.volatile_header_offset * BDRV_SECTOR=
_SIZE,
> +                     &volatile_header, sizeof(volatile_header));
> +    if (ret < 0) {
> +        bdrv_refresh_filename(file->bs);
> +        error_setg_errno(errp, -ret,
> +                         "Could not read volatile header from file '%s=
'",
> +                         file->bs->filename);
> +        return ret;
> +    }
> +
> +    /* check volatile header */
> +    ret =3D check_se_sparse_volatile_header(&volatile_header, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D vmdk_add_extent(bs, file, false,
> +                          const_header.capacity,
> +                          const_header.grain_dir_offset * BDRV_SECTOR_=
SIZE,
> +                          0,
> +                          const_header.grain_dir_size *
> +                          BDRV_SECTOR_SIZE / sizeof(uint64_t),
> +                          const_header.grain_table_size *
> +                          BDRV_SECTOR_SIZE / sizeof(uint64_t),
> +                          const_header.grain_size,
> +                          &extent,
> +                          errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    extent->sesparse =3D true;
> +    extent->sesparse_l2_tables_offset =3D const_header.grain_tables_of=
fset;
> +    extent->sesparse_clusters_offset =3D const_header.grains_offset;
> +    extent->entry_size =3D sizeof(uint64_t);
> +
> +    ret =3D vmdk_init_tables(bs, extent, errp);
> +    if (ret) {
> +        /* free extent allocated by vmdk_add_extent */
> +        vmdk_free_last_extent(bs);
> +    }
> +
> +    return ret;
> +}
> +
>  static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *=
buf,
>                                 QDict *options, Error **errp);
> =20
> @@ -847,6 +1222,7 @@ static int vmdk_parse_extents(const char *desc, Bl=
ockDriverState *bs,
>           * RW [size in sectors] SPARSE "file-name.vmdk"
>           * RW [size in sectors] VMFS "file-name.vmdk"
>           * RW [size in sectors] VMFSSPARSE "file-name.vmdk"
> +         * RW [size in sectors] SESPARSE "file-name.vmdk"
>           */
>          flat_offset =3D -1;
>          matches =3D sscanf(p, "%10s %" SCNd64 " %10s \"%511[^\n\r\"]\"=
 %" SCNd64,
> @@ -869,7 +1245,8 @@ static int vmdk_parse_extents(const char *desc, Bl=
ockDriverState *bs,
> =20
>          if (sectors <=3D 0 ||
>              (strcmp(type, "FLAT") && strcmp(type, "SPARSE") &&
> -             strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE")) ||
> +             strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE") &&
> +             strcmp(type, "SESPARSE")) ||
>              (strcmp(access, "RW"))) {
>              continue;
>          }
> @@ -922,6 +1299,13 @@ static int vmdk_parse_extents(const char *desc, B=
lockDriverState *bs,
>                  return ret;
>              }
>              extent =3D &s->extents[s->num_extents - 1];
> +        } else if (!strcmp(type, "SESPARSE")) {
> +            ret =3D vmdk_open_se_sparse(bs, extent_file, bs->open_flag=
s, errp);
> +            if (ret) {
> +                bdrv_unref_child(bs, extent_file);
> +                return ret;
> +            }
> +            extent =3D &s->extents[s->num_extents - 1];
>          } else {
>              error_setg(errp, "Unsupported extent type '%s'", type);
>              bdrv_unref_child(bs, extent_file);
> @@ -956,6 +1340,7 @@ static int vmdk_open_desc_file(BlockDriverState *b=
s, int flags, char *buf,
>      if (strcmp(ct, "monolithicFlat") &&
>          strcmp(ct, "vmfs") &&
>          strcmp(ct, "vmfsSparse") &&
> +        strcmp(ct, "seSparse") &&
>          strcmp(ct, "twoGbMaxExtentSparse") &&
>          strcmp(ct, "twoGbMaxExtentFlat")) {
>          error_setg(errp, "Unsupported image type '%s'", ct);
> @@ -1206,10 +1591,12 @@ static int get_cluster_offset(BlockDriverState =
*bs,
>  {
>      unsigned int l1_index, l2_offset, l2_index;
>      int min_index, i, j;
> -    uint32_t min_count, *l2_table;
> +    uint32_t min_count;
> +    void *l2_table;
>      bool zeroed =3D false;
>      int64_t ret;
>      int64_t cluster_sector;
> +    unsigned int l2_size_bytes =3D extent->l2_size * extent->entry_siz=
e;
> =20
>      if (m_data) {
>          m_data->valid =3D 0;
> @@ -1224,7 +1611,31 @@ static int get_cluster_offset(BlockDriverState *=
bs,
>      if (l1_index >=3D extent->l1_size) {
>          return VMDK_ERROR;
>      }
> -    l2_offset =3D extent->l1_table[l1_index];
> +    if (extent->sesparse) {

Maybe add assertions that extent->entry_size =3D=3D 8 here and... [2]

> +        uint64_t l2_offset_u64 =3D ((uint64_t *)extent->l1_table)[l1_i=
ndex];
> +        if (l2_offset_u64 =3D=3D 0) {
> +            l2_offset =3D 0;
> +        } else if ((l2_offset_u64 & 0xffffffff00000000) !=3D 0x1000000=
000000000) {
> +            /*
> +             * Top most nibble is 0x1 if grain table is allocated.
> +             * strict check - top most 4 bytes must be 0x10000000 sinc=
e max
> +             * supported size is 64TB for disk - so no more than 64TB =
/ 16MB
> +             * grain directories which is smaller than uint32,
> +             * where 16MB is the only supported default grain table co=
verage.
> +             */
> +            return VMDK_ERROR;
> +        } else {
> +            l2_offset_u64 =3D l2_offset_u64 & 0x00000000ffffffff;
> +            l2_offset_u64 =3D extent->sesparse_l2_tables_offset +
> +                l2_offset_u64 * l2_size_bytes / BDRV_SECTOR_SIZE;
> +            if (l2_offset_u64 > 0x00000000ffffffff) {
> +                return VMDK_ERROR;
> +            }
> +            l2_offset =3D (unsigned int)(l2_offset_u64);
> +        }
> +    } else {

[2] ...that extent->entry_size =3D=3D 4 here?

> +        l2_offset =3D ((uint32_t *)extent->l1_table)[l1_index];
> +    }
>      if (!l2_offset) {
>          return VMDK_UNALLOC;
>      }
> @@ -1236,7 +1647,7 @@ static int get_cluster_offset(BlockDriverState *b=
s,
>                      extent->l2_cache_counts[j] >>=3D 1;
>                  }
>              }
> -            l2_table =3D extent->l2_cache + (i * extent->l2_size);
> +            l2_table =3D (char *)extent->l2_cache + (i * l2_size_bytes=
);
>              goto found;
>          }
>      }
> @@ -1249,13 +1660,13 @@ static int get_cluster_offset(BlockDriverState =
*bs,
>              min_index =3D i;
>          }
>      }
> -    l2_table =3D extent->l2_cache + (min_index * extent->l2_size);
> +    l2_table =3D (char *)extent->l2_cache + (min_index * l2_size_bytes=
);
>      BLKDBG_EVENT(extent->file, BLKDBG_L2_LOAD);
>      if (bdrv_pread(extent->file,
>                  (int64_t)l2_offset * 512,
>                  l2_table,
> -                extent->l2_size * sizeof(uint32_t)
> -            ) !=3D extent->l2_size * sizeof(uint32_t)) {
> +                l2_size_bytes
> +            ) !=3D l2_size_bytes) {
>          return VMDK_ERROR;
>      }
> =20
> @@ -1263,16 +1674,45 @@ static int get_cluster_offset(BlockDriverState =
*bs,
>      extent->l2_cache_counts[min_index] =3D 1;
>   found:
>      l2_index =3D ((offset >> 9) / extent->cluster_sectors) % extent->l=
2_size;
> -    cluster_sector =3D le32_to_cpu(l2_table[l2_index]);
> =20
> -    if (extent->has_zero_grain && cluster_sector =3D=3D VMDK_GTE_ZEROE=
D) {
> -        zeroed =3D true;
> +    if (extent->sesparse) {
> +        cluster_sector =3D le64_to_cpu(((uint64_t *)l2_table)[l2_index=
]);
> +        switch (cluster_sector & 0xf000000000000000) {
> +        case 0x0000000000000000:
> +            /* unallocated grain */
> +            if (cluster_sector !=3D 0) {
> +                return VMDK_ERROR;
> +            }
> +            break;
> +        case 0x1000000000000000:
> +            /* scsi-unmapped grain - fallthrough */
> +        case 0x2000000000000000:
> +            /* zero grain */
> +            zeroed =3D true;
> +            break;
> +        case 0x3000000000000000:
> +            /* allocated grain */
> +            cluster_sector =3D (((cluster_sector & 0x0fff000000000000)=
 >> 48) |
> +                              ((cluster_sector & 0x0000ffffffffffff) <=
< 12));

That=E2=80=99s just insane.  I trust you, though.

> +            cluster_sector =3D extent->sesparse_clusters_offset +
> +                cluster_sector * extent->cluster_sectors;
> +            break;
> +        default:
> +            return VMDK_ERROR;
> +        }
> +    } else {
> +        cluster_sector =3D le32_to_cpu(((uint32_t *)l2_table)[l2_index=
]);
> +
> +        if (extent->has_zero_grain && cluster_sector =3D=3D VMDK_GTE_Z=
EROED) {
> +            zeroed =3D true;
> +        }
>      }
> =20
>      if (!cluster_sector || zeroed) {
>          if (!allocate) {
>              return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
>          }
> +        assert(!extent->sesparse);
> =20
>          if (extent->next_cluster_sector >=3D VMDK_EXTENT_MAX_SECTORS) =
{
>              return VMDK_ERROR;
> @@ -1296,7 +1736,7 @@ static int get_cluster_offset(BlockDriverState *b=
s,
>              m_data->l1_index =3D l1_index;
>              m_data->l2_index =3D l2_index;
>              m_data->l2_offset =3D l2_offset;
> -            m_data->l2_cache_entry =3D &l2_table[l2_index];
> +            m_data->l2_cache_entry =3D ((uint32_t *)l2_table) + l2_ind=
ex;
>          }
>      }
>      *cluster_offset =3D cluster_sector << BDRV_SECTOR_BITS;
> @@ -1622,6 +2062,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uin=
t64_t offset,
>          if (!extent) {
>              return -EIO;
>          }
> +        if (extent->sesparse) {
> +            return -ENOTSUP;
> +        }

([1] This should still stay here, even with bdrv_apply_auto_read_only()
above.)

>          offset_in_cluster =3D vmdk_find_offset_in_cluster(extent, offs=
et);
>          n_bytes =3D MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_S=
IZE
>                               - offset_in_cluster);
>=20

Overall, looks reasonable to me.  Then again, I have no clue of the
format and I trust you that it works.

Max


--3dDvRZCOe3GllzjeVNSI4FTkOwNhWAkbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzsIMQACgkQ9AfbAGHV
z0Cdvwf/S+QnxPeBHq1x78qRMkdIY2tqbLL0qcNp+nrBs+Fk5Rctu4/7RruKkqrz
1LcbjjcR7grMv1g60FcMF6NLuDOLDbVB5APYOouDEpytuGhcLjw9qBqHQ1+L+0KP
C++paCNpsXKxyF+N0BOYxOB+Q7NdEU544bYo/Zz+xLrW2jVHE9swEH4+yGFYKEHp
G/TWMbAoNK2VbZsK+WuCBxEWycsa0f1UQbeh0OXOmaFPgI0lrqtawo5QlqX34LfC
bJIe4CSkuuNzHR9hnwI3OGXFaV2/ssEKsOX+Y+1IVQ1TG/dJHDVuMUJETYYjQTjJ
gR7fEr6gYdGKXTPFfDux/IJFldmeZw==
=/RZd
-----END PGP SIGNATURE-----

--3dDvRZCOe3GllzjeVNSI4FTkOwNhWAkbe--


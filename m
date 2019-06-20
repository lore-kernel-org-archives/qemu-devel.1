Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538DAC48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A8B20675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A8B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyq6-0005iO-8B
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdyYy-0001Oq-EA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdyYw-0005V1-CO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdyYq-0004sF-Cs; Thu, 20 Jun 2019 11:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5800E307D914;
 Thu, 20 Jun 2019 15:00:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFEC60600;
 Thu, 20 Jun 2019 15:00:31 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-3-jsnow@redhat.com>
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
Message-ID: <e7143bb8-afb6-8326-6e93-49a7470b9b98@redhat.com>
Date: Thu, 20 Jun 2019 17:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZLWBDqa0DwN6KKzF2INJNT3PENhBV1llH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 20 Jun 2019 15:00:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/12] block/backup: Add mirror sync mode
 'bitmap'
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZLWBDqa0DwN6KKzF2INJNT3PENhBV1llH
Content-Type: multipart/mixed; boundary="vEiTXp88wo6BBN69fFovHmRk1UTlOcCuW";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <e7143bb8-afb6-8326-6e93-49a7470b9b98@redhat.com>
Subject: Re: [PATCH 02/12] block/backup: Add mirror sync mode 'bitmap'
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-3-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-3-jsnow@redhat.com>

--vEiTXp88wo6BBN69fFovHmRk1UTlOcCuW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
> We don't need or want a new sync mode for simple differences in
> semantics.  Create a new mode simply named "BITMAP" that is designed to=

> make use of the new Bitmap Sync Mode field.
>=20
> Because the only bitmap mode is 'conditional', this adds no new
> functionality to the backup job (yet). The old incremental backup mode
> is maintained as a syntactic sugar for sync=3Dbitmap, mode=3Dconditiona=
l.
>=20
> Add all of the plumbing necessary to support this new instruction.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json      | 30 ++++++++++++++++++++++--------
>  include/block/block_int.h |  6 +++++-
>  block/backup.c            | 35 ++++++++++++++++++++++++++++-------
>  block/mirror.c            |  6 ++++--
>  block/replication.c       |  2 +-
>  blockdev.c                |  8 ++++++--
>  6 files changed, 66 insertions(+), 21 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index caf28a71a0..6d05ad8f47 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1127,12 +1127,15 @@
>  #
>  # @none: only copy data written from now on
>  #
> -# @incremental: only copy data described by the dirty bitmap. Since: 2=
=2E4
> +# @incremental: only copy data described by the dirty bitmap. (since: =
2.4)

Why not deprecate this in the process and note that this is equal to
sync=3Dbitmap, bitmap-mode=3Dconditional?

(I don=E2=80=99t think there is a rule that forces us to actually remove
deprecated stuff after two releases if it doesn=E2=80=99t hurt to keep it=
=2E)

> +#
> +# @bitmap: only copy data described by the dirty bitmap. (since: 4.1)
> +#          Behavior on completion is determined by the BitmapSyncMode.=

>  #
>  # Since: 1.3
>  ##
>  { 'enum': 'MirrorSyncMode',
> -  'data': ['top', 'full', 'none', 'incremental'] }
> +  'data': ['top', 'full', 'none', 'incremental', 'bitmap'] }
> =20
>  ##
>  # @BitmapSyncMode:
> @@ -1352,10 +1355,14 @@
>  #
>  # @speed: the maximum speed, in bytes per second
>  #
> -# @bitmap: the name of dirty bitmap if sync is "incremental".
> -#          Must be present if sync is "incremental", must NOT be prese=
nt
> +# @bitmap: the name of dirty bitmap if sync is "bitmap".
> +#          Must be present if sync is "bitmap", must NOT be present
>  #          otherwise. (Since 2.4)

Er, well, now this is too fast of a deprecation. :-)  It must still also
be present if sync is =E2=80=9Cincremental=E2=80=9D.

>  #
> +# @bitmap-mode: Specifies the type of data the bitmap should contain a=
fter
> +#               the operation concludes. Must be present if sync is "b=
itmap".
> +#               Must NOT be present otherwise. (Since 4.1)

Do we have any rule that qemu must enforce =E2=80=9Cmust not=E2=80=9Ds? :=
-)

(No, I don=E2=80=99t think so.  I think it=E2=80=99s very reasonable that=
 you accept
bitmap-mode=3Dconditional for sync=3Dincremental.)

>  # @compress: true to compress data, if the target format supports it.
>  #            (default: false) (since 2.8)
>  #
> @@ -1390,7 +1397,8 @@
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*format': 'str', 'sync': 'MirrorSyncMode',
>              '*mode': 'NewImageMode', '*speed': 'int',
> -            '*bitmap': 'str', '*compress': 'bool',
> +            '*bitmap': 'str', '*bitmap-mode': 'BitmapSyncMode',
> +            '*compress': 'bool',
>              '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> @@ -1412,10 +1420,14 @@
>  # @speed: the maximum speed, in bytes per second. The default is 0,
>  #         for unlimited.
>  #
> -# @bitmap: the name of dirty bitmap if sync is "incremental".
> -#          Must be present if sync is "incremental", must NOT be prese=
nt
> +# @bitmap: the name of dirty bitmap if sync is "bitmap".
> +#          Must be present if sync is "bitmap", must NOT be present
>  #          otherwise. (Since 3.1)

Same as above.

> +# @bitmap-mode: Specifies the type of data the bitmap should contain a=
fter
> +#               the operation concludes. Must be present if sync is "b=
itmap".
> +#               Must NOT be present otherwise. (Since 4.1)
> +#
>  # @compress: true to compress data, if the target format supports it.
>  #            (default: false) (since 2.8)
>  #
> @@ -1449,7 +1461,9 @@
>  { 'struct': 'BlockdevBackup',
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              'sync': 'MirrorSyncMode', '*speed': 'int',
> -            '*bitmap': 'str', '*compress': 'bool',
> +            '*bitmap': 'str',
> +            '*bitmap-mode': 'BitmapSyncMode',
> +            '*compress': 'bool',
>              '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index d6415b53c1..89370c1b9b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1132,7 +1132,9 @@ void mirror_start(const char *job_id, BlockDriver=
State *bs,
>   * @target: Block device to write to.
>   * @speed: The maximum speed, in bytes per second, or 0 for unlimited.=

>   * @sync_mode: What parts of the disk image should be copied to the de=
stination.
> - * @sync_bitmap: The dirty bitmap if sync_mode is MIRROR_SYNC_MODE_INC=
REMENTAL.
> + * @sync_bitmap: The dirty bitmap if sync_mode is 'bitmap' or 'increme=
ntal'
> + * @has_bitmap_mode: true if @bitmap_sync carries a meaningful value.

Hmm...  If you moved the conversion of incremental/- =3D>
bitmap/conditional into blockdev.c, you could get rid of this parameter
because it would be equal to (sync_bitmap !=3D NULL).

(It itches me to get rid of this parameter because there is no other
has* parameter for this function yet.)

> + * @bitmap_mode: The bitmap synchronization policy to use.
>   * @on_source_error: The action to take upon error reading from the so=
urce.
>   * @on_target_error: The action to take upon error writing to the targ=
et.
>   * @creation_flags: Flags that control the behavior of the Job lifetim=
e.
> @@ -1148,6 +1150,8 @@ BlockJob *backup_job_create(const char *job_id, B=
lockDriverState *bs,
>                              BlockDriverState *target, int64_t speed,
>                              MirrorSyncMode sync_mode,
>                              BdrvDirtyBitmap *sync_bitmap,
> +                            bool has_bitmap_mode,
> +                            BitmapSyncMode bitmap_mode,
>                              bool compress,
>                              BlockdevOnError on_source_error,
>                              BlockdevOnError on_target_error,
> diff --git a/block/backup.c b/block/backup.c
> index 715e1d3be8..c4f83d4ef7 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -584,9 +586,28 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>      }
> =20
>      if (sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
> +        if (has_bitmap_mode &&
> +            bitmap_mode !=3D BITMAP_SYNC_MODE_CONDITIONAL) {
> +            error_setg(errp, "Bitmap sync mode must be 'conditional' "=

> +                       "when using sync mode '%s'",
> +                       MirrorSyncMode_str(sync_mode));
> +            return NULL;
> +        }
> +        has_bitmap_mode =3D true;
> +        bitmap_mode =3D BITMAP_SYNC_MODE_CONDITIONAL;
> +        effective_mode =3D MIRROR_SYNC_MODE_BITMAP;
> +    }
> +

I also just don=E2=80=99t quite feel like this is the correct place to pu=
t this.
 It=E2=80=99s a deprecated interface, so it should be translated in the
interface code, i.e. in blockdev.c.

(Sure, this gives you a central place for the translation, but you can
just as well add a function to the same effect to blockdev.c.)

Max


--vEiTXp88wo6BBN69fFovHmRk1UTlOcCuW--

--ZLWBDqa0DwN6KKzF2INJNT3PENhBV1llH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Ln40ACgkQ9AfbAGHV
z0D2pwf/fiKUeY0oS3xud0zGORDdZ1DuZ4tpmcWqPqrqhVROtcrhQn0PVhjIBsQH
pId6cNlLiiKfmJYOztHqmuGrCoMZXO5YJQAF+BFz1u2OY88vZz03whdXF+47TlA3
Nh+TkMQ9qIMvzvaUpS5BqtwYvwQfbk4D43abmmdqbFv3eIar06tuC+ne8f151zbm
FwT7SyAIYa2hcYtw2B8FyFAkGimOkW4r/ipTLJum21amZIS7PGfTs+Nt4N8k7IWz
eJYBX+KG0hpKDH5urD73pQIrt7VMBvT87OY+stdVMXjfxMe9A5HtPTRzSREb66oi
ko3LlBIrz6oKUsxeYCr5Yzvbj3jyHg==
=z1Vk
-----END PGP SIGNATURE-----

--ZLWBDqa0DwN6KKzF2INJNT3PENhBV1llH--


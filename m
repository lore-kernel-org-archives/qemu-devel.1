Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6AAC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F78B216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F78B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44205 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOUTd-0000sv-Ix
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 17:51:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOUSX-00081I-FO
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOUSW-0002FS-0P
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOUST-0002Cs-26; Wed, 08 May 2019 17:50:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 555B937EEB;
	Wed,  8 May 2019 21:50:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-96.brq.redhat.com
	[10.40.204.96])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C0EA9600CC;
	Wed,  8 May 2019 21:50:32 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190508182546.2239-1-mreitz@redhat.com>
	<20190508182546.2239-8-mreitz@redhat.com>
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
Message-ID: <124f90ab-08fb-99ea-e736-0c9d327868f6@redhat.com>
Date: Wed, 8 May 2019 23:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508182546.2239-8-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EIk3WOk63eRQzfiS59sI9aA10bA5hPhIN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 08 May 2019 21:50:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block: Ignore loosening perm
 restrictions failures
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EIk3WOk63eRQzfiS59sI9aA10bA5hPhIN
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <124f90ab-08fb-99ea-e736-0c9d327868f6@redhat.com>
Subject: Re: [PATCH v2 7/7] block: Ignore loosening perm restrictions failures
References: <20190508182546.2239-1-mreitz@redhat.com>
 <20190508182546.2239-8-mreitz@redhat.com>
In-Reply-To: <20190508182546.2239-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 20:25, Max Reitz wrote:
> We generally assume that loosening permission restrictions can never
> fail.  We have seen in the past that this assumption is wrong.  This ha=
s
> led to crashes because we generally pass &error_abort when loosening
> permissions.
>=20
> However, a failure in such a case should actually be handled in quite
> the opposite way: It is very much not fatal, so qemu may report it, but=

> still consider the operation successful.  The only realistic problem is=

> that qemu may then retain permissions and thus locks on images it
> actually does not require.  But again, that is not fatal.
>=20
> To implement this behavior, we make all functions that change
> permissions and that pass &error_abort to the initiating function
> (bdrv_check_perm() or bdrv_child_check_perm()) evaluate the
> @loosen_restrictions value introduced in the previous patch.  If it is
> true and an error did occur, we abort the permission update, report
> the error, and report success to the caller.

Hm, I just noticed that while make check passes, it emits two of these
warnings:

TEST: tests/i440fx-test... (pid=3D23021)
qemu-system-x86_64: warning: Failed to loosen restrictions: Could not
reopen file: No such file or directory
qemu-system-x86_64: warning: Failed to loosen restrictions: Could not
reopen file: No such file or directory
PASS: tests/i440fx-test

This is because the test creates temporary files which it unlinks after
qemu has opened them.  The bdrv_close_all() then attempts to drop the
WRITE permission, which requires reopening the file, which fails.

(Reproducer:

$ touch /tmp/foo; x86_64-softmmu/qemu-system-x86_64 -hda /tmp/foo &; \
  sleep 1; rm /tmp/foo; kill %1
[1] 23236
WARNING: Image format was not specified for '/tmp/foo' and probing
guessed raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
qemu-system-x86_64: terminating on signal 15 from pid 7922 (-zsh)



qemu-system-x86_64: warning: Failed to loosen restrictions: Could not
reopen file: No such file or directory
qemu-system-x86_64: warning: Failed to loosen restrictions: Could not
reopen file: No such file or directory
[1]  + 23236 done       x86_64-softmmu/qemu-system-x86_64 -hda /tmp/foo

)

Should I just drop the warning?

Max

> bdrv_child_try_set_perm() itself does not pass &error_abort, but it is
> the only public function to change permissions.  As such, callers may
> pass &error_abort to it, expecting dropping permission restrictions to
> never fail.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 8f517be5b4..a5a03906d0 100644
> --- a/block.c
> +++ b/block.c
> @@ -2088,11 +2088,20 @@ static void bdrv_child_abort_perm_update(BdrvCh=
ild *c)
>  int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shar=
ed,
>                              Error **errp)
>  {
> +    Error *local_err =3D NULL;
>      int ret;
> +    bool tighten_restrictions;
> =20
> -    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL, NULL, e=
rrp);
> +    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL,
> +                                &tighten_restrictions, &local_err);
>      if (ret < 0) {
>          bdrv_child_abort_perm_update(c);
> +        if (tighten_restrictions) {
> +            error_propagate(errp, local_err);
> +        } else {
> +            warn_reportf_err(local_err, "Failed to loosen restrictions=
: ");
> +            ret =3D 0;
> +        }
>          return ret;
>      }
> =20
> @@ -2275,10 +2284,20 @@ static void bdrv_replace_child(BdrvChild *child=
, BlockDriverState *new_bs)
>          /* Update permissions for old node. This is guaranteed to succ=
eed
>           * because we're just taking a parent away, so we're loosening=

>           * restrictions. */
> +        bool tighten_restrictions;
> +        Error *local_err =3D NULL;
> +        int ret;
> +
>          bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
> -        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
> -                        NULL, &error_abort);
> -        bdrv_set_perm(old_bs, perm, shared_perm);
> +        ret =3D bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,=

> +                              &tighten_restrictions, &local_err);
> +        assert(tighten_restrictions =3D=3D false);
> +        if (ret < 0) {
> +            warn_reportf_err(local_err, "Failed to loosen restrictions=
: ");
> +            bdrv_abort_perm_update(old_bs);
> +        } else {
> +            bdrv_set_perm(old_bs, perm, shared_perm);
> +        }
>      }
>  }
> =20
> @@ -5322,7 +5341,9 @@ static bool bdrv_has_bds_parent(BlockDriverState =
*bs, bool only_active)
>  static int bdrv_inactivate_recurse(BlockDriverState *bs)
>  {
>      BdrvChild *child, *parent;
> +    bool tighten_restrictions;
>      uint64_t perm, shared_perm;
> +    Error *local_err =3D NULL;
>      int ret;
> =20
>      if (!bs->drv) {
> @@ -5358,8 +5379,15 @@ static int bdrv_inactivate_recurse(BlockDriverSt=
ate *bs)
> =20
>      /* Update permissions, they may differ for inactive nodes */
>      bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
> -    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &error_ab=
ort);
> -    bdrv_set_perm(bs, perm, shared_perm);
> +    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL,
> +                          &tighten_restrictions, &local_err);
> +    assert(tighten_restrictions =3D=3D false);
> +    if (ret < 0) {
> +        warn_reportf_err(local_err, "Failed to loosen restrictions: ")=
;
> +        bdrv_abort_perm_update(bs);
> +    } else {
> +        bdrv_set_perm(bs, perm, shared_perm);
> +    }
> =20
> =20
>      /* Recursively inactivate children */
>=20



--EIk3WOk63eRQzfiS59sI9aA10bA5hPhIN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzTTyYACgkQ9AfbAGHV
z0A+pQf+OL6HVksc5WjIFv87SV28tTumT4OVHgJVADnyKPLlB75gROSWAcgkBrb3
AOnz6HWngm5mrYbelOKF1bdvE2zo0extRrW8w1vA0wpy2rUF2/r0hb5LW/KV4k0L
1N33C1e9MWS0rCByWoReUfolVGpaHjpEs7TLLN3xoMCYy9mUCOzxlG/OMc4U1JNq
T8+cDu9sm3J9/UtPLs5Z/8Hj85vu44eU0hL3x/dVNyUOTpP0YapubrIwwnS55yXa
T7CESS7Oo1sjlkx7swlZZBLr32QkTgCCtuAaYQEbVtfB6s05i59NbCfTNM7hJJZ4
2Vi/PirAW9XzlR3DcktU2pucpxzDew==
=UynX
-----END PGP SIGNATURE-----

--EIk3WOk63eRQzfiS59sI9aA10bA5hPhIN--


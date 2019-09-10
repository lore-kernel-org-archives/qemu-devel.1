Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E288DC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B568B208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B568B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7geZ-0004Cc-Do
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7gdd-0003JW-UF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7gdc-00072Q-Ld
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7gdY-0006yS-Vi; Tue, 10 Sep 2019 09:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 989613018ECE;
 Tue, 10 Sep 2019 13:56:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8193C5D6B2;
 Tue, 10 Sep 2019 13:56:43 +0000 (UTC)
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
References: <20190910133611.149421-1-slp@redhat.com>
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
Message-ID: <aef947c6-b1df-7700-809f-4c9917abb561@redhat.com>
Date: Tue, 10 Sep 2019 15:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910133611.149421-1-slp@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DP21KtyH7XZPNZBdy1raefn8R7pyvWlL0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 10 Sep 2019 13:56:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] blockjob: update nodes head while
 removing all bdrv
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DP21KtyH7XZPNZBdy1raefn8R7pyvWlL0
Content-Type: multipart/mixed; boundary="ExK8cqMuSUBtTAjSUZSvIjXCZvC68qzQE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com
Message-ID: <aef947c6-b1df-7700-809f-4c9917abb561@redhat.com>
Subject: Re: [PATCH v2] blockjob: update nodes head while removing all bdrv
References: <20190910133611.149421-1-slp@redhat.com>
In-Reply-To: <20190910133611.149421-1-slp@redhat.com>

--ExK8cqMuSUBtTAjSUZSvIjXCZvC68qzQE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 15:36, Sergio Lopez wrote:
> block_job_remove_all_bdrv() iterates through job->nodes, calling
> bdrv_root_unref_child() for each entry. The call to the latter may
> reach child_job_[can_]set_aio_ctx(), which will also attempt to
> traverse job->nodes, potentially finding entries that where freed
> on previous iterations.
>=20
> To avoid this situation, update job->nodes head on each iteration to
> ensure that already freed entries are no longer linked to the list.
>=20
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1746631
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changelog
>=20
> v2:
>  - Avoid leaking job->nodes (thanks Max Reitz)
> ---
>  blockjob.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> ---
> diff --git a/blockjob.c b/blockjob.c
> index 6e32d1a0c0..ffda6dd1e4 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -187,13 +187,21 @@ static const BdrvChildRole child_job =3D {
> =20
>  void block_job_remove_all_bdrv(BlockJob *job)
>  {
> -    GSList *l;
> +    GSList *l, *orig_nodes;
> +
> +    orig_nodes =3D job->nodes;
>      for (l =3D job->nodes; l; l =3D l->next) {
>          BdrvChild *c =3D l->data;
>          bdrv_op_unblock_all(c->bs, job->blocker);
>          bdrv_root_unref_child(c);
> +        /*
> +         * The call above may reach child_job_[can_]set_aio_ctx(), whi=
ch will
> +         * also traverse job->nodes, so update the head here to make s=
ure it
> +         * doesn't attempt to process an already freed BdrvChild.
> +         */
> +        job->nodes =3D l->next;
>      }
> -    g_slist_free(job->nodes);
> +    g_slist_free(orig_nodes);
>      job->nodes =3D NULL;

Hm, this assignment is now a no-op.

I think I=E2=80=99d just rewrite the whole function in the following fash=
ion:

orig_nodes =3D job->nodes;
while (job->nodes) {
    BdrvChild *c =3D job->nodes->data;
    [...]
    job->nodes =3D job->nodes->next;
}
g_slist_free(orig_nodes);

What do you think?

>  }
> =20
>=20



--ExK8cqMuSUBtTAjSUZSvIjXCZvC68qzQE--

--DP21KtyH7XZPNZBdy1raefn8R7pyvWlL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13q5oACgkQ9AfbAGHV
z0DRGAf/SaVK6IpDV36rSKUdlo/FKJPxOMK73pZYfsm0hYdSW0KFS/nXNhvA1/A5
QGDkx0z4jkvdQHHsSFvgHm5EjnOZ33w4BtkpKldIGHJtnMeg+f+OrvEY0He7GO/C
NhsQKuEtaqhHZKYLuIAcNonZaKI7nrk1a3Z4R/oI2TKxw7Om2e6Yz8E/iY+Y3W7F
oLXgkxIXTLHNs2MSdBiiD07nCSe3PJwFt/FKhv9oDa15jwGAjQ21zLbxgpJe1Wyu
FvJIaIxz0op5geHd5ovlsU24HceWTwWSY8lcpnlA9xubX/80xMYRJ5WKCYWmxcpp
F9EznmBlZlDUL1qpg+3dxodYeOjUDQ==
=ETx6
-----END PGP SIGNATURE-----

--DP21KtyH7XZPNZBdy1raefn8R7pyvWlL0--


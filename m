Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342EAC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A131207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A131207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i81vx-0001nh-7N
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i81uu-0001CQ-S9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i81ut-0003ee-NJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:40:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i81ut-0003cA-EN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:40:11 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0D7C3CA1B
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 12:40:09 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k67so1202031wmf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 05:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=pMXroBgw8/mA3rbKB9oPJfuzsrNoR7Ckyy9TQc1yuII=;
 b=pWKjYQnUvQ+UOZlGJxwkopwySzHCFSnwitNgIgTIq3sjt5iPVbzvffITNy4J+UEDT4
 /lWJyD8gAcHKzijwLixkRACoe7nwbzYvTnKIeFvUBxm9TVb1l8fCCtqGUZOYiWevwUCI
 3NePhxiCHHovy5wCk2MIqbbDExp7plUpWdALGWHalvJ+vFnf9TZhYXB+CTfV1IOOxAA0
 uW53ztDBeTB4iUvxNx5QEyicN7o0hWbQErQfQ3Hu8s0watlHhYqyccQKgkvObufuQ4NY
 Y529KOFR5kIQIdUkMkPyCwv3qCoNzjcIhdGJpgM+H9Id3SsxufPe06RaRE30xbPBJYCu
 6+qA==
X-Gm-Message-State: APjAAAVDm+8L4luoAHla/Nosu1+Xrk7d+o5FSliHLaPQF45DYS9QvFgl
 R1bgHzRmxo9pNqe6J4KUf5gUCv1QL07QL71gkK2Xg5o1utL7tf7tV3Fg92+nFcgWpSkLN8itC9J
 qHMxpFYCs5cX+sf0=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr4191122wma.153.1568205608472; 
 Wed, 11 Sep 2019 05:40:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMRS9pWx+iQXVzibWE/U3in8ZE1SP4s0bqL6AWdWJ3m0v7vEkA3x9CgW4KQV86sE/0MwardQ==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr4191106wma.153.1568205608280; 
 Wed, 11 Sep 2019 05:40:08 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id c74sm2602341wme.46.2019.09.11.05.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 05:40:07 -0700 (PDT)
References: <20190911100316.32282-1-mreitz@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <20190911100316.32282-1-mreitz@redhat.com>
Date: Wed, 11 Sep 2019 14:40:05 +0200
Message-ID: <87ftl3atwa.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: update nodes head while
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Max Reitz <mreitz@redhat.com> writes:

> From: Sergio Lopez <slp@redhat.com>
>
> block_job_remove_all_bdrv() iterates through job->nodes, calling
> bdrv_root_unref_child() for each entry. The call to the latter may
> reach child_job_[can_]set_aio_ctx(), which will also attempt to
> traverse job->nodes, potentially finding entries that where freed
> on previous iterations.
>
> To avoid this situation, update job->nodes head on each iteration to
> ensure that already freed entries are no longer linked to the list.
>
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1746631
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v3:
> - Rewrote the loop to make the whole function a bit simpler
>   (Also, remove the node from the job->nodes list before unref'ing it,
>   just to be extra-safe)
> ---
>  blockjob.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/blockjob.c b/blockjob.c
> index 2abed0f551..c6e20e2fcd 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -175,14 +175,23 @@ static const BdrvChildRole child_job =3D {
>=20=20
>  void block_job_remove_all_bdrv(BlockJob *job)
>  {
> -    GSList *l;
> -    for (l =3D job->nodes; l; l =3D l->next) {
> +    /*
> +     * bdrv_root_unref_child() may reach child_job_[can_]set_aio_ctx(),
> +     * which will also traverse job->nodes, so consume the list one by
> +     * one to make sure that such a concurrent access does not attempt
> +     * to process an already freed BdrvChild.
> +     */
> +    while (job->nodes) {
> +        GSList *l =3D job->nodes;
>          BdrvChild *c =3D l->data;
> +
> +        job->nodes =3D l->next;
> +
>          bdrv_op_unblock_all(c->bs, job->blocker);
>          bdrv_root_unref_child(c);
> +
> +        g_slist_free_1(l);
>      }
> -    g_slist_free(job->nodes);
> -    job->nodes =3D NULL;
>  }
>=20=20
>  bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl146yUACgkQ9GknjS8M
AjXLYw/+KbiRtRNnDVsyims/xFBmnvo3owl0AWoCTvGDZdZXan0kLHyMBxkwdsop
cgvjgYqN+6ob4sCOAXBMB3XzdpuBRcbEkxC+jUXNpfA7mqCkinlXzqZa8J5brRUY
jPpLNLdViyEYwKDWPtpv64mcI062qyYPv2wgY+wiwgAiCk1AN07z+uO/dbdFAatr
zQQnpU1kPyCp2sQV1xJVHqo+KYVfm61zqlKEx3ZWpzdc6FAGT9BG16G6W8lXh2v0
c9GIhmR1yEEqb3pVic4IBp+OUjwVskWVIgyh651DDoQUifl5Ywg4++nlQd5ufWGV
FijPa6t24j5mG4VHsVwlec4mSmCA69TOb3U16+9KHSOD9O3FrbZ0f9ZEZh+gsAeG
eO8/Gz7hMH1SGRuxCtm+u0a/ToOMUWTOrezx+9bcrkxVbmyWJ4+eaMBPXy51xvOK
Yr94CmtVRd1yuo/SsaLwuPi1sMtwIjvTsNPy2WBxymP79joSpki3RYkCWRTBs/0i
QH5y+3GmbIK98AdsLbeaELV8/5BbR/riNSFG0jn77fxAZ4QFG8rV9IdeqMVKM3h8
e9goTaZmqqhCoayKYhd2VD9BJjjEMUKjoT7kC9SyORLTHntw/3O9uEi3wNVS78dq
LA6mbc4YKkPC2P3toozlVHKk3Dah88N6j54AHTjbKUcRlZZZ2fY=
=h50E
-----END PGP SIGNATURE-----
--=-=-=--


Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D851C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8780D206BE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsF9j3Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8780D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpSi-0001mq-LC
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpRH-0001Fu-9S
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpRE-0001Oh-3n
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602238547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p3GdSYXv0E4aymilV9v3svZpj6LFzSM0GmYTUbwThBU=;
 b=dsF9j3IlTInjNKi5WoXKrfQbD80+gqKX/v3RIpky+3/poEfcv94+ldGA+NmuvZFn0JJOKB
 Pin9oCoEcidOxsUEfY1NwDYsoYwLJdvN3Kwq9i6J2OyyvyBTAlBC2B8s1MprwZ077W700E
 2tj8tEBRJbBI/GuwPWc0uz0EU4H6nQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-8HcLypB3MUmHHFlAndloYQ-1; Fri, 09 Oct 2020 06:15:43 -0400
X-MC-Unique: 8HcLypB3MUmHHFlAndloYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2C8B101FFA2;
 Fri,  9 Oct 2020 10:15:41 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F58110002A4;
 Fri,  9 Oct 2020 10:15:41 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:15:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 0/5] fix & merge block_status_above and
 is_allocated_above
Message-ID: <20201009101540.GA168921@stefanha-x1.localdomain>
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200924194003.22080-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 10:39:58PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> These series are here to address the following problem:
> block-status-above functions may consider space after EOF of
> intermediate backing files as unallocated, which is wrong, as these
> backing files are the reason of producing zeroes, we never go further by
> backing chain after a short backing file. So, if such short-backing file
> is _inside_ requested sub-chain of the backing chain, we should never
> report space after its EOF as unallocated.
>=20
> See patches 01,04,05 for details.
>=20
> Note, that this series leaves for another day the general problem
> around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
> vs go-to-backing.
> Audit for this problem is done here:
> "backing chain & block status & filters"
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
> And I'm going to prepare series to address this problem.
>=20
> Also, get_block_status func have same disease, but remains unfixed here:
> I want to make separate series for it.
>=20
> v7:
> - add Alberto's r-bs in all patchs
> - rebase to new backing-chain handling, bdrv_filter_or_cow_bs is used ins=
tead of backing_bs
>=20
>=20
> Based on series "[PATCH v9 0/7] coroutines: generate wrapper code" or
> in other words:
> Based-on: <20200924185414.28642-1-vsementsov@virtuozzo.com>
>=20
> Vladimir Sementsov-Ogievskiy (5):
>   block/io: fix bdrv_co_block_status_above
>   block/io: bdrv_common_block_status_above: support include_base
>   block/io: bdrv_common_block_status_above: support bs =3D=3D base
>   block/io: fix bdrv_is_allocated_above
>   iotests: add commit top->base cases to 274
>=20
>  block/coroutines.h         |   2 +
>  block/io.c                 | 132 +++++++++++++++++++++----------------
>  block/qcow2.c              |  16 ++++-
>  tests/qemu-iotests/274     |  20 ++++++
>  tests/qemu-iotests/274.out |  68 +++++++++++++++++++
>  5 files changed, 179 insertions(+), 59 deletions(-)
>=20
> --=20
> 2.21.3
>=20

Thanks, applied to my block tree with Eric's spelling fixes:
https://github.com/stefanha/qemu/commits/block

Stefan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+AOEwACgkQnKSrs4Gr
c8jD8Af+Ii3Z9/UqvQJhCmdcgkXU0odP6t7B27km20xyTcQlEgUAAkhrb25apPLj
UnYhTUS4VQFUTBx4aUQIADvG/9d+D64EIk8NoYhPoDCcFMHpwsuXUzI/p/Px/Et3
K0OCGj0K33fxblS6x1quizDtdNUh7V1ckhMFW4D4JwnknTCtmPXWIwKpYWVN5R8t
lEdCIfFVskvYHRsgbgJBeeaxuJo7H4WS2R3TKXZ2bsVzotj/6VMLa0mmFSeqkTC/
jWR5hEyOSpSvIiVrv61iAFzpQKF1/xxfsNLnk/zm2zJyQVPCbZMWSaxgVqFHL41j
dozfbRx9Lni+nVyGDVpwIuKXl0DmdQ==
=Sf1v
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--



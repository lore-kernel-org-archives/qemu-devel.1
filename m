Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB6CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94E9206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3PeOw4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94E9206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeM2z-00048k-Rp
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeM2N-0003VS-Bv
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:09:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47930
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeM2M-00086O-1L
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590685784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9jD6+teNUbYrXnBLV1OwuK4KBHWKoM8Y1npwYjBn5M=;
 b=H3PeOw4OhSiVfsPYuVff6DKfokFoRvhPKtmOg6uVG9Opvnyv3XU+YyrvU0riWgNBywsT9w
 cyxqyu/FIQUsIGxSg8zavwZV/DDNBw0lXQaDN3h+D++1wxZSuPDNBG7a1SWng348lHx0sb
 bEvbglKEUqw71bTXsYVf75izdZV/Wb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67--uO1F2I2OX66kkKG8M2IvQ-1; Thu, 28 May 2020 13:09:40 -0400
X-MC-Unique: -uO1F2I2OX66kkKG8M2IvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8EC9835B41;
 Thu, 28 May 2020 17:09:38 +0000 (UTC)
Received: from localhost (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41C8878905;
 Thu, 28 May 2020 17:09:36 +0000 (UTC)
Date: Thu, 28 May 2020 18:09:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 0/5] fix & merge block_status_above and
 is_allocated_above
Message-ID: <20200528170935.GA163714@stefanha-x1.localdomain>
References: <20200528101507.151161-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200528101507.151161-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 01:15:02PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Thanks to Eric, the whole series is reviewed now!
>=20
> v4:
> 01: fix grammar in comment, add Eric's r-b
> 02-05: add Eric's r-b
>=20
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
> I want to make separate series for it, as it need some more refactoring,
> which should be based on series
> "[PATCH v5 0/7] coroutines: generate wrapper code"
>=20
> Vladimir Sementsov-Ogievskiy (5):
>   block/io: fix bdrv_co_block_status_above
>   block/io: bdrv_common_block_status_above: support include_base
>   block/io: bdrv_common_block_status_above: support bs =3D=3D base
>   block/io: fix bdrv_is_allocated_above
>   iotests: add commit top->base cases to 274
>=20
>  block/io.c                 | 105 +++++++++++++++++++------------------
>  block/qcow2.c              |  16 +++++-
>  tests/qemu-iotests/274     |  20 +++++++
>  tests/qemu-iotests/274.out |  65 +++++++++++++++++++++++
>  4 files changed, 152 insertions(+), 54 deletions(-)

Hi Vladimir,
Which series is this based on? It does not apply. Is there a dependency
on the coroutine wrappers series?

Aside from the issue applying the patches this series looks good to me.

Thanks,
Stefan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7P8E4ACgkQnKSrs4Gr
c8hgLwf/bryaDDk5T/zMO5EUMg3YVQptYRIZXBY2DV7hEIs1sIlk8g+HsLvrTmdM
+eeh+oQmxAtSDI+S1Z1rAcfSy6MX3l7m1SPAdvXcA451Qk0R1RBQlnWD/ZGQ1+uY
N1xpCClm21Vep7JAcTCOiY5/bji0K//ngRSH1/mckYifb0VLaRMQt+WBphBb5LyZ
IuGnpZRNceUb840FQIFq7AorYqYJWgX2zmmV0Hk8/7rFWgHrOABh/Rq/WrOKXd4A
qmb/fgKg3S4DrA8ohWt4fmV4xGb+5gH15XUBkSjIW2sCz6gam7UGzPCs/Zrbc8Ri
7HKDivg0xgavQ1dF7GnVLTy5gR9Trw==
=7eEf
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--



Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0AAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760E4208D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVaCGg0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760E4208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6qs-0005OR-GK
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iX6pO-0004Md-Ug
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iX6pM-0004h9-HZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:58:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58454
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iX6pM-0004fn-4f
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574182687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1acIQa7tzP+AkZSH0ZdccxXcyelK2sq19FyalBYbti0=;
 b=GVaCGg0+J4HnUsbKfen4k+pmP/wRzvoxST+SuPhhMGskI4bTdBvp8iC9V0f1H07kExrk8U
 292Oz/J+PqW2yOzcrll8uSbFPPmT8Bf10xcX2cm1DFD5ZW9rb6VAMWkzdlo3vtQ+qIflbw
 Iv/NnLHYQTRb1nA5jbWX8pq1GBnBUm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Ll7-6Y3gN42M44Dv6AGGiw-1; Tue, 19 Nov 2019 11:58:05 -0500
X-MC-Unique: Ll7-6Y3gN42M44Dv6AGGiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E12A780268C;
 Tue, 19 Nov 2019 16:58:03 +0000 (UTC)
Received: from localhost (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 110F81001B2D;
 Tue, 19 Nov 2019 16:58:02 +0000 (UTC)
Date: Tue, 19 Nov 2019 16:58:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Message-ID: <20191119165801.GF229732@stefanha-x1.localdomain>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191116163410.12129-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2019 at 07:34:06PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> I wanted to understand, what is the real difference between bdrv_block_st=
atus_above
> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work thr=
ough
> bdrv_block_status_above..
>=20
> And I found the problem: bdrv_is_allocated_above considers space after EO=
F as
> UNALLOCATED for intermediate nodes..
>=20
> UNALLOCATED is not about allocation at fs level, but about should we go t=
o backing or
> not.. And it seems incorrect for me, as in case of short backing file, we=
'll read
> zeroes after EOF, instead of going further by backing chain.
>=20
> This leads to the following effect:
>=20
> ./qemu-img create -f qcow2 base.qcow2 2M
> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>=20
> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>=20
> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>=20
> But after commit guest visible state is changed, which seems wrong for me=
:
> ./qemu-img commit top.qcow2 -b mid.qcow2
>=20
> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
> Pattern verification failed at offset 1048576, 1048576 bytes
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>=20
> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>=20
>=20
> I don't know, is it a real bug, as I don't know, do we support backing fi=
le larger than
> its parent. Still, I'm not sure that this behavior of bdrv_is_allocated_a=
bove don't lead
> to other problems.

It seems correct that a backing file limits the virtual disk size of its
backing chain.

The "qemu-img commit" behavior seems counter-intuitive at first, but the
problem there is that the top-most image file is larger than its backing
file - not that the backing chain has differing sizes.  Committing
should not lose data, mid.qcow2 will be grown and then you get the
result you've observed.

I consider this a little weird but not a bug.  Does anyone else have
opinions?

Stefan

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3UHxkACgkQnKSrs4Gr
c8j33AgApf+7WE2HgG/uK8yjzXo0GayujfKeXT3FoTv8MgjiO//zzqQZCV66wohx
Oi/UGTjhklC5lEwHANHTUgT9AmEU1slcrUu8Yjbyb4r7ou6uI4v7qivP15z0ZrIu
VAI/kdfYPlSQRMzD3Rl1d3KD3VM/uR43y5Y1VOTxLc1QbCc0TSO0c7ua0vEJ2EDV
oB24IRLYaM8xyfz+YGHF7FOLzOsz0XFzYeoJoXdoeHp8f9YdwhyfvplAOjmtHaHP
ABc6zZ01SCoOHlKG6qs79T0f/QQy/ANCOkgz1huyvbO2NxEt2Ugt+TthdVfYIe80
8nMhbzt3D74hrge/cCZYbLBMAkhEHQ==
=IsDD
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--



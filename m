Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E393C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDAA222B8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTbnnZG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDAA222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpWx-00072R-H6
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpTl-0003Ch-VM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpTj-0001el-1j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602238701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fDm/w0P7bJBBRIlW890LJh6C74GR3eYHTFM79rGwcU=;
 b=OTbnnZG8fUEfgp6rHM4/sxBRot4LxQrbJXEIG8kfCCCo6iyW6y0+HyzSiL2zpCMisJ/QLK
 a+636yQtlW27doXn2Ocro8GUem1Yi+freaQfpGw2znrNU2W56ufdxOGm+nxbILWcC2x3s2
 UTk7jleZtvJVPF/no6imSAUEPwfDoIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-LzyMpfQzOyyhhQAPydaYZw-1; Fri, 09 Oct 2020 06:18:17 -0400
X-MC-Unique: LzyMpfQzOyyhhQAPydaYZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B4631084D64;
 Fri,  9 Oct 2020 10:18:16 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14EBC60CD0;
 Fri,  9 Oct 2020 10:18:15 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:18:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/13] block/export: convert vhost-user-blk-server to
 block exports API
Message-ID: <20201009101815.GD168921@stefanha-x1.localdomain>
References: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924151549.913737-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 04:15:36PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Replace unix-socket=3Dstr with addr=3DSocketAddress for consistency wi=
th NBD and
>    fd passing support. The new syntax is:
>    --export vhost-user-blk,addr.type=3Dunix,addr.path=3D/tmp/vhost-user-b=
lk.sock,...
>  * Make addr=3DSocketAddress mandatory instead of optional [Markus]
>  * Update test-vhost-user-blk.c to use new syntax
>  * Add patch moving vhost-user-server.h to include/
>  * Add patch to use libvhost-user.a instead of compiling it multiple time=
s
>=20
> This patch series converts Coiby Xu's vhost-user-blk-server from a QOM ob=
ject
> to the block exports API. The block exports API provides a standard QMP a=
nd
> command-line interface for managing block exports (NBD, FUSE, vhost-user-=
blk,
> etc). A fair amount of init/shutdown code is removed because the block ex=
ports
> API already takes care of that functionality.
>=20
> Most of the patches are vhost-user-blk-server cleanups.
>=20
> The syntax for launching qemu-storage-daemon is:
>=20
>   $ qemu-storage-daemon \
>       --blockdev file,node-name=3Ddrive0,filename=3Dtest.img \
>       --export vhost-user-blk,node-name=3Ddrive0,id=3Dexport0,writable=3D=
on,addr.type=3Dunix,addr.path=3D/tmp/vhost-user-blk.sock
>=20
> QEMU can connect to the vhost-user-blk export like this:
>=20
>   $ qemu-system-x86_64 \
>       -M accel=3Dkvm,memory-backend=3Dmem \
>       -m 1G \
>       -object memory-backend-memfd,size=3D1G,id=3Dmem \
>       -cpu host \
>       -chardev socket,path=3D/tmp/vhost-user-blk.sock,id=3Dchar0 \
>       -device vhost-user-blk-pci,chardev=3Dchar0
>=20
> Based-on: 20200918080912.321299-1-coiby.xu@gmail.com ("[PATCH v10 0/7] vh=
ost-user block device backend implementation")
> Based-on: 20200907182011.521007-1-kwolf@redhat.com ("[PATCH 00/29] block/=
export: Add infrastructure and QAPI for block exports")
>=20
> Stefan Hajnoczi (13):
>   block/export: shorten serial string to fit
>   util/vhost-user-server: s/fileds/fields/ typo fix
>   util/vhost-user-server: drop unnecessary QOM cast
>   util/vhost-user-server: drop unnecessary watch deletion
>   block/export: consolidate request structs into VuBlockReq
>   util/vhost-user-server: drop unused DevicePanicNotifier
>   util/vhost-user-server: fix memory leak in vu_message_read()
>   util/vhost-user-server: check EOF when reading payload
>   util/vhost-user-server: rework vu_client_trip() coroutine lifecycle
>   block/export: report flush errors
>   block/export: convert vhost-user-blk server to block export API
>   util/vhost-user-server: move header to include/
>   util/vhost-user-server: use static library in meson.build
>=20
>  MAINTAINERS                                |   4 +-
>  qapi/block-export.json                     |  21 +-
>  block/export/vhost-user-blk-server.h       |  23 +-
>  {util =3D> include/qemu}/vhost-user-server.h |  32 +-
>  block/export/export.c                      |   8 +-
>  block/export/vhost-user-blk-server.c       | 525 ++++++---------------
>  tests/qtest/vhost-user-blk-test.c          |   2 +-
>  util/vhost-user-server.c                   | 334 ++++++-------
>  block/export/meson.build                   |   1 +
>  block/meson.build                          |   1 -
>  contrib/libvhost-user/meson.build          |   1 +
>  meson.build                                |   6 +-
>  tests/qtest/meson.build                    |   2 +-
>  util/meson.build                           |   4 +-
>  14 files changed, 376 insertions(+), 588 deletions(-)
>  rename {util =3D> include/qemu}/vhost-user-server.h (72%)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree with a mention of the QAPI schema
situation regarding address families as suggested by Markus:
https://github.com/stefanha/qemu/commits/block

Stefan

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+AOOcACgkQnKSrs4Gr
c8hYyQf/TZIQH93RHNNX3LmusvYqFWe4rM32iYOPn9wooTI4kLhjNEmCYMnnpDVQ
Pkgsb89K2dNZ1/tXE2tXLCCsfnieKULJyDTorb5jLI1/+o33MPHv5KVk1Kdw2SSg
ejOzA6aGGuRQrmoJ0pozzDgPGSE175z6AFvpkQWbduI0Y9rDW8k2P8C85HJ/fkwB
7P7oQFKD/IDnfc0uLNdE7WgdGoKvl2wg4FeGnHIPZnuUsoT2sBD0pAlmnz17F4eu
2EPg7JDca0qteg5+MGl0Mkkc5hOhIKGpckIfq2uX5txoVIOSV+V+l7PMhMxTPiHj
qDh+oDuxX1Mq9dWRl9CoxJcFA3tpKg==
=zxRm
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--



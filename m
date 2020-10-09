Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96B1C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10AA222B8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnhogo01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10AA222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpUr-0004fp-RG
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpUB-0003dA-Gt
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpU9-0001gS-BP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602238728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Udb5XI/QY/ALxFOZbKpCcwBLxtEsBs2Tc3LmQsJoauU=;
 b=cnhogo01zHn/cS36Ey4buFJIAeGHkNTkF25W0OxX5O1TI0T/EzPa8R6D/qWPriale1gZiG
 S5d8wEt1K3hb863iH67v65tZuakOX+LinCvOWJS0D8Yl+iNsJfAC3FmA+rxKcUd9grImh7
 IxOOxibQydnAIOCHsecyq2oufgYXLPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-uvxQ2D_YMJ-HT1-q_EeIfA-1; Fri, 09 Oct 2020 06:18:46 -0400
X-MC-Unique: uvxQ2D_YMJ-HT1-q_EeIfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16605801FAE;
 Fri,  9 Oct 2020 10:18:45 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B40FE5D9F3;
 Fri,  9 Oct 2020 10:18:44 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:18:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 0/7] vhost-user block device backend implementation
Message-ID: <20201009101843.GE168921@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 04:09:05PM +0800, Coiby Xu wrote:
> v10
>  - Use a linked list of VuFdWatch objects to keep kick info [Stefan]
>  - Merge improvements and fixes from Stefan
>  - Rename libvhost-user's vu_message_read to vu_message_read_default [Kev=
in]
>  - When shutting down the client, wait for the coroutine of processing
>    vhost-user messages to be finished [Kevin]
>  - Allocate struct req_data on the heap [Kevin]
>  - Improve coding of qtest case [Thomas]
>  - Fix several memory leaks detected by ASAN
>=20
> v9
>  - move logical block size check function to a utility function
>  - fix issues regarding license, coding style, memory deallocation, etc.
>=20
> v8
>  - re-try connecting to socket server to fix asan error
>  - fix license naming issue
>=20
> v7
>  - fix docker-test-debug@fedora errors by freeing malloced memory
>=20
> v6
>  - add missing license header and include guard
>  - vhost-user server only serve one client one time
>  - fix a bug in custom vu_message_read
>  - using qemu-storage-daemon to start vhost-user-blk-server
>  - a bug fix to pass docker-test-clang@ubuntu
>=20
> v5:
>  * re-use vu_kick_cb in libvhost-user
>  * keeping processing VhostUserMsg in the same coroutine until there is
>    detachment/attachment of AIOContext
>  * Spawn separate coroutine for each VuVirtqElement
>  * Other changes including relocating vhost-user-blk-server.c, coding
>    style etc.
>=20
> v4:
>  * add object properties in class_init
>  * relocate vhost-user-blk-test
>  * other changes including using SocketAddress, coding style, etc.
>=20
> v3:
>  * separate generic vhost-user-server code from vhost-user-blk-server
>    code
>  * re-write vu_message_read and kick hander function as coroutines to
>    directly call blk_co_preadv, blk_co_pwritev, etc.
>  * add aio_context notifier functions to support multi-threading model
>  * other fixes regarding coding style, warning report, etc.
>=20
> v2:
>  * Only enable this feature for Linux because eventfd is a Linux-specific
>    feature
>=20
>=20
> This patch series is an implementation of vhost-user block device
> backend server, thanks to Stefan and Kevin's guidance.
>=20
> Vhost-user block device backend server is a UserCreatable object and can =
be
> started using object_add,
>=20
>  (qemu) object_add vhost-user-blk-server,id=3DID,unix-socket=3D/tmp/vhost=
-user-blk_vhost.socket,node-name=3DDRIVE_NAME,writable=3Doff,logical-block-=
size=3D512
>  (qemu) object_del ID
>=20
> or appending the "-object" option when starting QEMU,
>=20
>   $ -object vhost-user-blk-server,id=3Ddisk,unix-socket=3D/tmp/vhost-user=
-blk_vhost.socket,node-name=3DDRIVE_NAME,writable=3Doff,logical-block-size=
=3D512
>=20
> Then vhost-user client can connect to the server backend.
> For example, QEMU could act as a client,
>=20
>   $ -m 256 -object memory-backend-memfd,id=3Dmem,size=3D256M,share=3Don -=
numa node,memdev=3Dmem -chardev socket,id=3Dchar1,path=3D/tmp/vhost-user-bl=
k_vhost.socket -device vhost-user-blk-pci,id=3Dblk0,chardev=3Dchar1
>=20
> And guest OS could access this vhost-user block device after mounting it.
>=20
> Coiby Xu (7):
>   libvhost-user: Allow vu_message_read to be replaced
>   libvhost-user: remove watch for kick_fd when de-initialize vu-dev
>   util/vhost-user-server: generic vhost user server
>   block: move logical block size check function to a common utility
>     function
>   block/export: vhost-user block device backend server
>   test: new qTest case to test the vhost-user-blk-server
>   MAINTAINERS: Add vhost-user block device backend server maintainer
>=20
>  MAINTAINERS                                |   8 +
>  block/export/vhost-user-blk-server.c       | 661 ++++++++++++++++++
>  block/export/vhost-user-blk-server.h       |  36 +
>  block/meson.build                          |   1 +
>  contrib/libvhost-user/libvhost-user-glib.c |   2 +-
>  contrib/libvhost-user/libvhost-user.c      |  15 +-
>  contrib/libvhost-user/libvhost-user.h      |  21 +
>  hw/core/qdev-properties.c                  |  31 +-
>  softmmu/vl.c                               |   4 +
>  tests/qtest/libqos/libqtest.h              |  17 +
>  tests/qtest/libqos/meson.build             |   1 +
>  tests/qtest/libqos/vhost-user-blk.c        | 129 ++++
>  tests/qtest/libqos/vhost-user-blk.h        |  48 ++
>  tests/qtest/libqtest.c                     |  36 +-
>  tests/qtest/meson.build                    |   4 +-
>  tests/qtest/vhost-user-blk-test.c          | 751 +++++++++++++++++++++
>  tests/vhost-user-bridge.c                  |   2 +
>  tools/virtiofsd/fuse_virtio.c              |   4 +-
>  util/block-helpers.c                       |  46 ++
>  util/block-helpers.h                       |  19 +
>  util/meson.build                           |   2 +
>  util/vhost-user-server.c                   | 428 ++++++++++++
>  util/vhost-user-server.h                   |  65 ++
>  23 files changed, 2292 insertions(+), 39 deletions(-)
>  create mode 100644 block/export/vhost-user-blk-server.c
>  create mode 100644 block/export/vhost-user-blk-server.h
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>  create mode 100644 tests/qtest/vhost-user-blk-test.c
>  create mode 100644 util/block-helpers.c
>  create mode 100644 util/block-helpers.h
>  create mode 100644 util/vhost-user-server.c
>  create mode 100644 util/vhost-user-server.h
>=20
> --
> 2.28.0
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+AOQMACgkQnKSrs4Gr
c8giVQgAhsTXjhCSLYs3acT0NQN4zESwxOCliIY5OZ/2qRIeoCn4P3zpwNsJxo/c
Su5R0n2nh5ayBJrK3N/3m5FSC4blspmO5Om+bctqU6HsTPoVp2mJilhBRYq6IAqj
UFGyF7lQFa1PxLLqUFtck07EeFVr3ReLrKNinIzYU7sWGonvvEop4pZgriAoYX/n
Mlf6zjSfIpErUwiwHz+2TjrpC1B1HRGXSJUyhUlG5faOu1I7dvinFtF0Bom47NCr
VgiyNGdIdsGypWZDWzQCJyIrqKm+IJjqr4693ebg/YlXBjY34igscEcqqPjihkyR
7DBg8klFvEpQocbN9c4DmJVxxydp+w==
=/EOp
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--



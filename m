Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB4AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF9222276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvBfRfA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF9222276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpUe-0004KL-Qd
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpSn-0002Gp-7H
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpSk-0001ab-4p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602238640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O4AN4rcXNHINb1kNiSA05e5ECsOooN5FQWh/FUuRniw=;
 b=YvBfRfA32ScUjS8GVK7lHEIRQB7QPQrbWaIQdZLS1aH3EcZjDDK3TFcgroBU14iaEp8jn5
 8qdN9H0t9CkgpEwdj7vgtHW+WvvsaDehpvTPJMiIDIj6NqIJXGwF5S0neITGudaZ8LUmKT
 SrbG96F0mM0XhD0SI85CiUCFsPbkwbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-ZQ8x_enHO9qgqoSWxVmWVw-1; Fri, 09 Oct 2020 06:17:17 -0400
X-MC-Unique: ZQ8x_enHO9qgqoSWxVmWVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D69451074647;
 Fri,  9 Oct 2020 10:17:15 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD8A5C1BB;
 Fri,  9 Oct 2020 10:17:15 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:17:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/4] block/export: add BlockExportOptions->iothread
 member
Message-ID: <20201009101714.GC168921@stefanha-x1.localdomain>
References: <20200929125516.186715-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929125516.186715-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 01:55:12PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Add fixed-iothread option to set AioContext change policy [Kevin]
>  * Use os-posix.c signal handling utilities in qemu-nbd.c [Paolo]
>=20
> This series adjusts the build system and then adds a
> BlockExportOptions->iothread member so that it is possible to set the iot=
hread
> for an export.
>=20
> Based-on: 20200924151549.913737-1-stefanha@redhat.com ("[PATCH v2 00/13] =
block/export: convert vhost-user-blk-server to block exports API")
>=20
> Stefan Hajnoczi (4):
>   util/vhost-user-server: use static library in meson.build
>   qemu-storage-daemon: avoid compiling blockdev_ss twice
>   block: move block exports to libblockdev
>   block/export: add iothread and fixed-iothread options
>=20
>  qapi/block-export.json               | 11 ++++++++
>  block/export/export.c                | 39 ++++++++++++++++++++++++----
>  block/export/vhost-user-blk-server.c |  5 +++-
>  nbd/server.c                         |  2 --
>  qemu-nbd.c                           | 21 +++++++--------
>  stubs/blk-exp-close-all.c            |  7 +++++
>  block/export/meson.build             |  4 +--
>  contrib/libvhost-user/meson.build    |  1 +
>  meson.build                          | 22 ++++++++++++----
>  nbd/meson.build                      |  2 ++
>  storage-daemon/meson.build           |  3 +--
>  stubs/meson.build                    |  1 +
>  tests/qtest/meson.build              |  2 +-
>  util/meson.build                     |  4 ++-
>  14 files changed, 93 insertions(+), 31 deletions(-)
>  create mode 100644 stubs/blk-exp-close-all.c
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree with Eric's suggestions applied:
https://github.com/stefanha/qemu/commits/block

Stefan

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+AOKoACgkQnKSrs4Gr
c8hU7Qf/eWpLmp0jkt7wlsPuGU8FV9WJn6o0i9mvF9zRLrwVwJCXrtS1ZP99Ax9q
C31K/ReViBhrhp8gnOfZw08RXiru1nrMOn79eB4rSXY4qrHOQ46iXFlv4yPcBWSD
Oun4TEzqXrxUUpY/A9d1GaMsVQStP8mr3f0TsEVSYm3WHZ6xUloJWaQcZv0OEK5D
3/KqyVAVphblYbUuzxRECy1ZxLjBQtAI1PiqAy72YxSMFTn4vSLU/WrWWqR9uqSR
3cVEDJ7GPsJcuefgbhKcvWmX1e89zlogOViSxxxoa9NNm9/OmGEy7l8EXmWwV4We
AnNRMKe3WUwCCNqPe4SQVJGoHnTLog==
=6PjC
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--



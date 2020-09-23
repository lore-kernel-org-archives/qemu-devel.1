Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A015C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0845520BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlKaLeJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0845520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL47I-0007G1-Pd
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL45Q-0005go-3Q
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:41:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38036
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL45K-0006ox-D3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600864879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yXMdLIQ1bOgcZnIcVPX47Nt1gOOc1Wi/t5Fy6vdgXLk=;
 b=VlKaLeJQMIaHhSEX/91riWnBnQNDrqlTPENRuc1GueaFkdgGom+BNKf76S0cw5kj1KqqzB
 Oc18yOJnXO5PLIeQsYw6EZX4DHjZxEdyZYkatBdMCO0QWcM47ugt9XymDAPJhNzjcIRCkZ
 o3RqDbHh7O7i8ogG2r+bMOQ9lOXtRYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-DvTdXhvnMQqcsX2onOvnzw-1; Wed, 23 Sep 2020 08:41:14 -0400
X-MC-Unique: DvTdXhvnMQqcsX2onOvnzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 441261007464;
 Wed, 23 Sep 2020 12:41:13 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2DCF1002388;
 Wed, 23 Sep 2020 12:41:09 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:41:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] nvdimm: read-only file support
Message-ID: <20200923124108.GF51019@stefanha-x1.localdomain>
References: <20200916095150.755714-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916095150.755714-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:11:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, eric.g.ernst@gmail.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:51:47AM +0100, Stefan Hajnoczi wrote:
> v2:
>  * s/the the/the/ in documentation [Philippe]
>  * Assign nvdimm->unarmed earlier [Philippe]

Ping

> There is currently no way to back an NVDIMM with a read-only file so it c=
an be
> safely shared between untrusted guests.
>=20
> Introduce an -object memory-backend-file,readonly=3Don|off option.
>=20
> Julio Montes sent an earlier patch here:
> https://patchew.org/QEMU/20190708211936.8037-1-julio.montes@intel.com/
>=20
> Eric Ernst requested this feature again for Kata Containers so I gave it =
a try.
>=20
> Stefan Hajnoczi (3):
>   memory: add readonly support to memory_region_init_ram_from_file()
>   hostmem-file: add readonly=3Don|off option
>   nvdimm: honor -object memory-backend-file,readonly=3Don option
>=20
>  docs/nvdimm.txt           |  8 +++++++-
>  include/exec/memory.h     |  2 ++
>  include/exec/ram_addr.h   |  5 +++--
>  include/qemu/mmap-alloc.h |  2 ++
>  backends/hostmem-file.c   | 26 +++++++++++++++++++++++++-
>  exec.c                    | 18 +++++++++++-------
>  hw/mem/nvdimm.c           |  4 ++++
>  softmmu/memory.c          |  7 +++++--
>  util/mmap-alloc.c         | 10 ++++++----
>  util/oslib-posix.c        |  2 +-
>  qemu-options.hx           |  5 ++++-
>  11 files changed, 70 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.26.2
>=20

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rQmQACgkQnKSrs4Gr
c8gPPwf4kcecxhzF6CIq+0/QEEtGe46YDUj57Mc12QbX6DTGwKwsof/HRxreZMiK
JPJ8o2fiv6lStZde2kDGLVevBPureDr6Sj6b0rkB9axRrnqgc1BmQDfA/rwFRSfA
XqCG875/e1zpuBBjLvOXYSQxhzWp7+hh87LbYjLvxkDH2SkZEmKy0MyexkDcsldQ
KII5TMm78wV4YaX5jqdgkW+RKdYDgVfL/8e/zwVdLF24K5Cran9LLeaX/hRBbJ7K
k22B79i6IFonDtlO8zfUAipzjQR53JOZA/s6DS8hFfhbS4rCZ5q+bdiritLmcDZT
gWik2hFofWuBfqRiv2GKoBGBRNjY
=M4/+
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--



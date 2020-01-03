Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A894C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5068E20672
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 09:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnY0W4r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5068E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inJh2-0003N8-Ek
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 04:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inJg8-0002Z2-4S
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inJg6-00033W-Ce
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:55:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inJg6-00030q-4v
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 04:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578045333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ORjzl5W81FKie+C6f3/7IEEpT++uwfShOkO6kIIHPE=;
 b=AnY0W4r1ebsFCtsDtmJo2jHNgHQOf05EeZjXJ/zI3F4xTNHrVL8XFWEM0zOzCgReuLCyAC
 EuaUwQioOZzWPDyruC3n0mEqh3kQQX5SO0WmSMKyHbqQJnrm0v3X+nSYHS0vZQeYQZNclB
 6OeGzybSVXht5WrzfA9cay/t0SiEQ0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-IAL6VaHyN46m0FBNthDndw-1; Fri, 03 Jan 2020 04:55:29 -0500
X-MC-Unique: IAL6VaHyN46m0FBNthDndw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC26F800D41;
 Fri,  3 Jan 2020 09:55:28 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640245D9C9;
 Fri,  3 Jan 2020 09:55:23 +0000 (UTC)
Date: Fri, 3 Jan 2020 09:55:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 00/21] Add virtual device fuzzing support
Message-ID: <20200103095521.GA130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:35PM +0000, Oleinik, Alexander wrote:
> This series adds a framework for coverage-guided fuzzing of
> virtual-devices. Fuzzing targets are based on qtest and can make use of
> the libqos abstractions.
>=20
> In this version, I added a virtio-scsi fuzzer. The actual fuzzing code
> is very similar to the the virtio-net fuzzer. I experimented with using
> a single fuzzer with device-specific initialization for each virtio
> device, but it did not come out as cleanly as I hoped, since I could not
> find an easy way to override the qos drivers for devices that have
> more-complete qos support (such as virtio-net), so these changes have
> not made it into v6.
>=20
> V5/V6: (V5 did not have review tags)
>  * added virtio-scsi fuzzer
>  * add support for using fork-based fuzzers with multiple libfuzzer
>    workers
>  * misc fixes addressing V4 comments
>  * cleanup in-process handlers/globals in libqtest.c
>  * small fixes to fork-based fuzzing and support for multiple workers
>  * changes to the virtio-net fuzzer to kick after each vq add
>=20
> V4:
>  * add/transfer license headers to new files
>  * restructure the added QTestClientTransportOps struct
>  * restructure the FuzzTarget struct and fuzzer skeleton
>  * fork-based fuzzer now directly mmaps shm over the coverage bitmaps
>  * fixes to i440 and virtio-net fuzz targets
>  * undo the changes to qtest_memwrite
>  * possible to build /fuzz and /all in the same build-dir
>  * misc fixes to address V3 comments
>=20
> V3:
>  * rebased onto v4.1.0+
>  * add the fuzzer as a new build-target type in the build-system
>  * add indirection to qtest client/server communication functions
>  * remove ramfile and snapshot-based fuzzing support
>  * add i440fx fuzz-target as a reference for developers.
>  * add linker-script to assist with fork-based fuzzer
>=20
> V2:
>  * split off changes to qos virtio-net and qtest server to other patches
>  * move vl:main initialization into new func: qemu_init
>  * moved useful functions from qos-test.c to a separate object
>  * use struct of function pointers for add_fuzz_target(), instead of
>    arguments
>  * move ramfile to migration/qemu-file
>  * rewrite fork-based fuzzer pending patch to libfuzzer
>  * pass check-patch
>=20
> Alexander Bulekov (21):
>   softmmu: split off vl.c:main() into main.c
>   libqos: Rename i2c_send and i2c_recv
>   fuzz: Add FUZZ_TARGET module type
>   qtest: add qtest_server_send abstraction
>   libqtest: Add a layer of abstraciton to send/recv
>   module: check module wasn't already initialized
>   qtest: add in-process incoming command handler
>   tests: provide test variables to other targets
>   libqos: split qos-test and libqos makefile vars
>   libqos: move useful qos-test funcs to qos_external
>   libqtest: make bufwrite rely on the TransportOps
>   libqtest: add in-process qtest.c tx/rx handlers
>   fuzz: add configure flag --enable-fuzzing
>   fuzz: Add target/fuzz makefile rules
>   fuzz: add fuzzer skeleton
>   fuzz: add support for fork-based fuzzing.
>   fuzz: add support for qos-assisted fuzz targets
>   fuzz: add i440fx fuzz targets
>   fuzz: add virtio-net fuzz target
>   fuzz: add virtio-scsi fuzz target
>   fuzz: add documentation to docs/devel/
>=20
>  Makefile                      |  16 ++-
>  Makefile.objs                 |   4 +
>  Makefile.target               |  18 ++-
>  configure                     |  39 ++++++
>  docs/devel/fuzzing.txt        | 119 +++++++++++++++++
>  exec.c                        |  12 +-
>  include/qemu/module.h         |   4 +-
>  include/sysemu/qtest.h        |   4 +
>  include/sysemu/sysemu.h       |   4 +
>  main.c                        |  53 ++++++++
>  qtest.c                       |  31 ++++-
>  tests/Makefile.include        |  75 +++++------
>  tests/fuzz/Makefile.include   |  12 ++
>  tests/fuzz/fork_fuzz.c        |  55 ++++++++
>  tests/fuzz/fork_fuzz.h        |  23 ++++
>  tests/fuzz/fork_fuzz.ld       |  37 ++++++
>  tests/fuzz/fuzz.c             | 179 ++++++++++++++++++++++++++
>  tests/fuzz/fuzz.h             |  94 ++++++++++++++
>  tests/fuzz/i440fx_fuzz.c      | 176 ++++++++++++++++++++++++++
>  tests/fuzz/qos_fuzz.c         | 232 ++++++++++++++++++++++++++++++++++
>  tests/fuzz/qos_fuzz.h         |  33 +++++
>  tests/fuzz/virtio_net_fuzz.c  | 105 +++++++++++++++
>  tests/fuzz/virtio_scsi_fuzz.c | 200 +++++++++++++++++++++++++++++
>  tests/libqos/i2c.c            |  10 +-
>  tests/libqos/i2c.h            |   4 +-
>  tests/libqos/qos_external.c   | 168 ++++++++++++++++++++++++
>  tests/libqos/qos_external.h   |  28 ++++
>  tests/libqtest.c              | 108 ++++++++++++++--
>  tests/libqtest.h              |   4 +
>  tests/pca9552-test.c          |  10 +-
>  tests/qos-test.c              | 140 +-------------------
>  util/module.c                 |   7 +
>  vl.c                          |  38 ++----
>  33 files changed, 1813 insertions(+), 229 deletions(-)
>  create mode 100644 docs/devel/fuzzing.txt
>  create mode 100644 main.c
>  create mode 100644 tests/fuzz/Makefile.include
>  create mode 100644 tests/fuzz/fork_fuzz.c
>  create mode 100644 tests/fuzz/fork_fuzz.h
>  create mode 100644 tests/fuzz/fork_fuzz.ld
>  create mode 100644 tests/fuzz/fuzz.c
>  create mode 100644 tests/fuzz/fuzz.h
>  create mode 100644 tests/fuzz/i440fx_fuzz.c
>  create mode 100644 tests/fuzz/qos_fuzz.c
>  create mode 100644 tests/fuzz/qos_fuzz.h
>  create mode 100644 tests/fuzz/virtio_net_fuzz.c
>  create mode 100644 tests/fuzz/virtio_scsi_fuzz.c
>  create mode 100644 tests/libqos/qos_external.c
>  create mode 100644 tests/libqos/qos_external.h

Please use "git rebase -i origin/master" with "x make" after each commit
to verify that building succeeds.  This is important for git-bisect(1)
where we need the tree to always build successfully and for
cherry-picking patches without introducing breakage.

It's not enough for the tree to build at the end of the patch series.
It should build at each step along the way.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PD4gACgkQnKSrs4Gr
c8iP0Af/XEv8e60oYhCVT5g19dmu3m8ltSS16/wGbstjP6jIfs6Xu3Pcu5uue4gY
d1g0tt/FdViIV+hMuzNudb5biqZnsRd3bz/YVAR4b19Ere73cnVMD/b210xsCP4k
7sHGCgiHbwE4YK2GBOcM5od5yB2W2Ltnuu/zatz2yMXbyaJt/v7x5laZtSlj3uPA
6YxoNKsYxmggP+Zrj/NWVKQthVsHXi5kTieEJ6U5m2486E3m1VQppv+eJvid3Bly
NHnotr6z5AV2PeHWlbkOTvFEn1EXhwpTj8CRd2NjPmTzXQHB+tp0cxZWCEqqbjd0
pYETsPKW3N9qoyENT7Ttk+ITQo7hbA==
=pRcK
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--



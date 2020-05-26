Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA04C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FD1206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+wK57S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FD1206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbcD-0003H2-5W
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdbbZ-0002ln-R2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:35:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdbbX-0007iK-Rc
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590507298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sepANqzkspghmlxghwN3pNV4427hDrEuiKemgIzEQpY=;
 b=a+wK57S41kG95XH9qXN2gk/2N2av8AUaUj+Al7ftddiF6vql2G4GHxLoA1N4wuA7Xhz2RS
 D3C+0INN3+/qlrY+8EF+z+4Cmx+kmTa/Zh7C+bDuCtwqUOPkCV5MBSTIaobNjXcp4yWQRK
 dS8TQ3/08fSMy6kK7aITTTy9rDOLP2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-LM-dJYAZMP63jygkKAM9jg-1; Tue, 26 May 2020 11:34:54 -0400
X-MC-Unique: LM-dJYAZMP63jygkKAM9jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A6CF100CCC0;
 Tue, 26 May 2020 15:34:53 +0000 (UTC)
Received: from localhost (ovpn-113-132.ams2.redhat.com [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A80019D7C;
 Tue, 26 May 2020 15:34:49 +0000 (UTC)
Date: Tue, 26 May 2020 16:34:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH 0/4] fuzz: misc changes for oss-fuzz compatability
Message-ID: <20200526153448.GA6797@stefanha-x1.localdomain>
References: <20200512030133.29896-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200512030133.29896-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 11:01:29PM -0400, Alexander Bulekov wrote:
> Hello,
> With these patches, the fuzzer passes the oss-fuzz build checks.
> There are also some miscelanous improvement to the fuzzer, in general:
>  * If building for oss-fuzz, check executable_dir/pc-bios for
>    the bios images
>  * Fix a typo in the i440fx-qtest-reboot argument which resulted in an
>    invalid argument to qemu_main
>  * Add an alternate name to resolve libfuzzer's internal fuzzer::TPC
>    object at link-time
>  * For all fork-based fuzzers, run the main-loop in the parent, to
>    prevent the clock from running far-ahead of the previous main-loop.
> -Alex
>=20
> Alexander Bulekov (4):
>   fuzz: add datadir for oss-fuzz compatability
>   fuzz: fix typo in i440fx-qtest-reboot arguments
>   fuzz: add mangled object name to linker script
>   fuzz: run the main-loop in fork-server process
>=20
>  include/sysemu/sysemu.h             |  2 ++
>  softmmu/vl.c                        |  2 +-
>  tests/qtest/fuzz/fork_fuzz.ld       |  5 +++++
>  tests/qtest/fuzz/fuzz.c             | 15 +++++++++++++++
>  tests/qtest/fuzz/i440fx_fuzz.c      |  3 ++-
>  tests/qtest/fuzz/virtio_net_fuzz.c  |  2 ++
>  tests/qtest/fuzz/virtio_scsi_fuzz.c |  2 ++
>  7 files changed, 29 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7NNxgACgkQnKSrs4Gr
c8hclwf+KhmEOkoFRF8NwOSHX4N6tUCZx3vacVfsKppTNKYjQ7y+KJf0UxiWCz8b
mjbiHuJBT8eL2gzqotknXCetKN6x/gQabe1J1eM3xbJwhdiM9sgbbVfJTESrVSxg
Y+X6ZoRvt48umnk4yxKHsSWS/36+sc0mnngNVyezwVwBez56WfVtyeMb2HTd3mRV
F9y2zuMP+xSK2fm1pgmHOJnhXSULDB9qaiToo1eo1IcbUPga1Jbm+p+Jpo/BavE7
LnygnRQdklsyo3h8fRx5z8/10u8z/nXSo1eQgY2UMJxkAqqCHmMHGETP9cQrco5t
5cwCYSyC+qTxivMcYcJCkyh2bXb1iQ==
=kt4U
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--



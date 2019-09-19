Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44663C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198BE2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198BE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtnJ-0002XY-Qu
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtkc-0007y4-Vd
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtkb-0005RR-Sj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtkb-0005R2-Hl
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:33:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD86836955;
 Thu, 19 Sep 2019 10:33:24 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1C7819C5B;
 Thu, 19 Sep 2019 10:33:20 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:33:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919103319.GM3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/jvaajy/zP2g41+Q"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 19 Sep 2019 10:33:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/22] Add virtual device fuzzing support
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


--/jvaajy/zP2g41+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2019 at 11:19:27PM +0000, Oleinik, Alexander wrote:
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
>  create mode 100644 tests/libqos/qos_external.c
>  create mode 100644 tests/libqos/qos_external.h

Please ensure that all new files have copyright/license headers.  When
code was moved from an old file, use the old file's copyright/license.

--/jvaajy/zP2g41+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DWW8ACgkQnKSrs4Gr
c8h9GQf+MTg4yM3hN3ZL7hO9DF2zNCRm2bIhtEez9fd3L4qIOVXAbEudNqqfaVqO
hsQDIseSzfiqCko48s5CNdW+slwd9ChGXkvh3cqc+D2CR8lZIBSf11WF6tqZetcr
0EEQXJBhdq4xXhaJh9ZoAm52Bm78IPhzYIyNy/zcUKnxjQBDw8sFGH6qoDqjpSA/
Zoc4ozGpkQyrUQi2bSBB5BnVVvvohCcXebjPnjZ70J7IY6CVP9/3Z5hxWVU5vSZf
P5wCFwtWkNxW65w1UaJiAvAvJZeakN3HtEsYChAKzzU47/D6pLGe2RvF6Y6wQEso
Kphl23AemGau3QgkmIOh+vIeqNr3hA==
=/nBz
-----END PGP SIGNATURE-----

--/jvaajy/zP2g41+Q--


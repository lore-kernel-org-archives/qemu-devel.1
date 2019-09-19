Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C96218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C96218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwaB-0003VF-PT
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAvx2-0002jC-Q4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAvx1-00018B-M7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:54:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAvx1-00016B-Fu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2197C2A09D3;
 Thu, 19 Sep 2019 12:54:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A32E65DC18;
 Thu, 19 Sep 2019 12:54:17 +0000 (UTC)
Date: Thu, 19 Sep 2019 13:54:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919125416.GR3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-18-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3XZQkxCYp0f/VEFS"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-18-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 19 Sep 2019 12:54:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 17/22] fuzz: add support for fork-based
 fuzzing.
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3XZQkxCYp0f/VEFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2019 at 11:19:44PM +0000, Oleinik, Alexander wrote:
> diff --git a/exec.c b/exec.c
> index 235d6bc883..d3838f4ea4 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2295,7 +2295,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>          qemu_ram_setup_dump(new_block->host, new_block->max_length);
>          qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
>          /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
> +#ifndef CONFIG_FUZZ /* This conflicts with fork-based fuzzing */
>          qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DONTFORK);
> +#endif
>          ram_block_notify_add(new_block->host, new_block->max_length);
>      }
>  }

I didn't check Makefile changes but regular softmmu binaries should
continue to work with --enable-fuzzing so we cannot use #ifdef here.

Perhaps this should be a runtime check similar to qtest_enabled():

  /* The fuzzer's fork child requires access to guest RAM */
  if (!fuzz_enabled()) {
      qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DONTFORK);
  }

--3XZQkxCYp0f/VEFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DengACgkQnKSrs4Gr
c8htKAf/c69Ja43ixHjcSvoB34SuiG9qPxXe8Mcj4DWp/43tD+loRVSAW+xu3fWL
R9E0bDW5IvgmK2jskwuYKkuICKBBK+P2aHY9aOePgqNxAVjpoK7tvDKMiVf5B6Gw
Ma+XMSrTWR5vKyKkvZShLMkn/03DbaHUMEnM6pN2eIPHtVxR109FZf1UofbWSf/I
VxgYCUnZu5ygJPnvwnXzy3OV/51/OqkCyf7PEwWZPAEYwYuFkWx12cph0KUDm4T8
FmwV6QHRphApS75Lw9lb0k7Yj/iBVgN5WC4DniaxL8ypFNhcFYnUcC0+cE3TBQBu
pE6XC/dq94MoLMb/XigVtQ98DRSscw==
=UtSC
-----END PGP SIGNATURE-----

--3XZQkxCYp0f/VEFS--


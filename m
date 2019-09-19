Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9257C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02BD21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02BD21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtKI-00036y-1r
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtHW-0000sD-ON
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtHV-0006aN-Ir
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtHV-0006XH-BF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:03:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFC713084032;
 Thu, 19 Sep 2019 10:03:19 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7F145D9E5;
 Thu, 19 Sep 2019 10:03:16 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:03:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919100315.GE3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-2-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 19 Sep 2019 10:03:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 01/22] softmmu: split off vl.c:main()
 into main.c
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


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:28PM +0000, Oleinik, Alexander wrote:
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..327510c81f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -36,18 +36,6 @@
>  #include "sysemu/seccomp.h"
>  #include "sysemu/tcg.h"
> =20
> -#ifdef CONFIG_SDL
> -#if defined(__APPLE__) || defined(main)
> -#include <SDL.h>
> -int qemu_main(int argc, char **argv, char **envp);
> -int main(int argc, char **argv)
> -{
> -    return qemu_main(argc, argv, NULL);
> -}
> -#undef main
> -#define main qemu_main
> -#endif
> -#endif /* CONFIG_SDL */
> =20
>  #ifdef CONFIG_COCOA
>  #undef main

This looks suspicious.  Should the #ifdef CONFIG_COCOA be moved into
main.c?

> @@ -1794,7 +1782,7 @@ static bool main_loop_should_exit(void)
>      return false;
>  }
> =20
> -static void main_loop(void)
> +void main_loop(void)
>  {
>  #ifdef CONFIG_PROFILER
>      int64_t ti;
> @@ -2869,7 +2857,7 @@ static void user_register_global_props(void)
>                        global_init_func, NULL, NULL);
>  }
> =20
> -int main(int argc, char **argv, char **envp)
> +int qemu_init(int argc, char **argv, char **envp)

The return value is confusing.  0 =3D success, >0 error exit code, but the
function may also invoke exit(0) to terminate successfully.

It's simpler to make this function void and invoke exit(3) directly.

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DUmMACgkQnKSrs4Gr
c8ga6Qf+Lhmk147RD9tK7sA6nk6K59xDboci9sqkDehAqelPH0xxNctCmao/qPLN
rqYWjDontsUyEVJDB0EZZ3JA/dspiH0dR2WWdiBXs9CvD7iiJ+KHVikRxqcGO8+8
Jkx116pOovNHIJZ2A7D585Y0WJg+h3qtpZRuhSvUhal5vSxF901mGWIsGTgxCkbS
PDopYlnv5qs00fux4VaDOFa/C7R7zEbOjfqdVAMscGxw6xhZmEgeXSkL5M2zNemt
BTLWzKt5zOIhdbr7jzuWfKdD/k3omkBvOQ6sjVBbiHhm7skwquSFX0WoI/8gjSfp
srT+PaUp10imuczdkFMWT005BiyJyQ==
=khqk
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--


Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FAC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF76920856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF76920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAZzu-0005hC-QQ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sw@weilnetz.de>) id 1iAZqP-0005JP-Vz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sw@weilnetz.de>) id 1iAZqL-00012Y-Rf
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:18:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:36624
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1iAZqJ-00010O-Ph
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:18:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 9AFC4DB92A7;
 Wed, 18 Sep 2019 15:17:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id E2hfdaK7uZ1d; Wed, 18 Sep 2019 15:17:53 +0200 (CEST)
Received: from [134.155.36.73] (edv13.bib.uni-mannheim.de [134.155.36.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 27317DB92A3;
 Wed, 18 Sep 2019 15:17:53 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190918121101.30690-1-philmd@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Openpgp: preference=signencrypt
Autocrypt: addr=sw@weilnetz.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a06746f8-9eeb-134e-7616-d9f18c6d7120@weilnetz.de>
Date: Wed, 18 Sep 2019 15:17:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918121101.30690-1-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1L80hL4dmri8Ze2SVhJlwin2JyhNx9JwX"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix broken build with WHPX
 enabled
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
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Justin Terry <juterry@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ilias Maratos <i.maratos@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1L80hL4dmri8Ze2SVhJlwin2JyhNx9JwX
Content-Type: multipart/mixed; boundary="4uhrKSNKAzRefcnAf2oq8G8DPMoc8tXHe";
 protected-headers="v1"
From: Stefan Weil <sw@weilnetz.de>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Justin Terry <juterry@microsoft.com>,
 Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilias Maratos <i.maratos@gmail.com>
Message-ID: <a06746f8-9eeb-134e-7616-d9f18c6d7120@weilnetz.de>
Subject: Re: [PATCH] target/i386: Fix broken build with WHPX enabled
References: <20190918121101.30690-1-philmd@redhat.com>
In-Reply-To: <20190918121101.30690-1-philmd@redhat.com>

--4uhrKSNKAzRefcnAf2oq8G8DPMoc8tXHe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Am 18.09.2019 um 14:11 schrieb Philippe Mathieu-Daud=C3=A9:
> The WHPX build is broken since commit 12e9493df92 which removed the
> "hw/boards.h" where MachineState is declared:
>
>   $ ./configure \
>      --enable-hax --enable-whpx
>
>   $ make x86_64-softmmu/all
>   [...]
>     CC      x86_64-softmmu/target/i386/whpx-all.o
>   target/i386/whpx-all.c: In function 'whpx_accel_init':
>   target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
>   incomplete type 'MachineState' {aka 'struct MachineState'}
>        whpx->mem_quota =3D ms->ram_size;
>                            ^~
>   make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
>     CC      x86_64-softmmu/trace/generated-helpers.o
>   make[1]: Target 'all' not remade because of errors.
>   make: *** [Makefile:471: x86_64-softmmu/all] Error 2
>
> Restore this header, partially reverting commit 12e9493df92.
>
> Fixes: 12e9493df92
> Reported-by: Ilias Maratos <i.maratos@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/i386/whpx-all.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 0c15241ae4..def0c28480 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/runstate.h"
>  #include "qemu/main-loop.h"
> +#include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"


Thank you for fixing this.

Reviewed-by: Stefan Weil <sw@weilnetz.de>




--4uhrKSNKAzRefcnAf2oq8G8DPMoc8tXHe--

--1L80hL4dmri8Ze2SVhJlwin2JyhNx9JwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJdgi6CAAoJEOCMIdVndFCtvAYQAJMGBj9MiUzoTBkgLvAmlkCP
YMT1MEYHxsau8GkKx8cxWT1uZ3NNBAt24Yco2UOLbNAduK5q9DLQ/Vs9Z/LagyMY
TXIUeRJBilrZ8wqn10kvDpx14wjhKzzzCUv/gaHyFH8m4yjCrEa5B1bNg0/f9QF9
Tx3x8rcfhE5DykIerYMoeB1wMTREzTjpp/+QjbehtPJpg2LYPLN6LPYIMEJjcrwb
8yS104THk7Jb26MwZiVfKNb7EeG3DnoOoakRYVNmUZL7UsbO2qkPT0gD34eRvaja
vOp+n3Ekm5x0hnKY7fMsel81d9EAkXxuF9Y4qrnSZFpKOH6vDmGYd79pB4Ucqzj1
jsJzz4PAap8biL/aKpXUsmt7R33pu1CIRqRe+a8cUQdQvaZQ0VsKQJCqrtp4jWrf
lf4iaml8TT3/NjeXyhP86ICv+godu42jyTjKAOP05RJRIH+tJ2mVopg0j7p/zDcL
SaMjS8Kw+s9hElhoOmBZmv4fxItPrtyI3CjS//uJUQRj82oLFIRhEPpzASo1VPU5
TbbxMF6+tMELc7CXpP1kKTlwTPYBb9qo1VUTihyFALlqDiTJ2hS7cqGxMfhdhbnU
285aEJuIvXYGEKeOtXfzO7uIHnysxO2Fg+udPViYz0V5Kf7uyKqkbB0s7YqzTn1X
Qq/pZfPjpi7iEW8Gc4rp
=ZmL5
-----END PGP SIGNATURE-----

--1L80hL4dmri8Ze2SVhJlwin2JyhNx9JwX--


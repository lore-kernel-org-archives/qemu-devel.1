Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDCC468D8
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B35206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B35206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haNXK-0002yp-Kn
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1haNVk-0001lu-65
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1haNVi-0000bt-9s
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:51:08 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:54459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1haNVg-0000O4-7D
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:51:06 -0400
Received: from player778.ha.ovh.net (unknown [10.109.146.132])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 9A00A131375
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 18:50:51 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 3F9C269BC401;
 Mon, 10 Jun 2019 16:50:45 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190610152444.20859-1-peter.maydell@linaro.org>
 <20190610152444.20859-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a2fda64a-5e9a-4346-422d-c4f17de71cc3@kaod.org>
Date: Mon, 10 Jun 2019 18:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610152444.20859-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9973784327190252518
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehvddguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.60
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs/index.rst: Fix minor syntax
 issues
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/2019 17:24, Peter Maydell wrote:
> The docs/specs/index.rst has a couple of minor issues which
> we didn't notice because we weren't building the manual:
>  * the ToC entry for the new PPC XIVE docs points to
>    a nonexistent file
>  * the initial comment needs to be marked by '..', not '.',
>    or it will appear in the output
>  * the title doesn't match the capitialization used by
>    the existing interop or devel manuals, and uses
>    'full-system emulation' rather than the 'system emulation'
>    that the interop manual title uses
>=20
> Fix these minor issues before we start trying to build the manual.

I only tested the pdf generation of each file with rst2pdf :/
=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  docs/specs/index.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 2e927519c2e..40adb97c5eb 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -1,8 +1,8 @@
> -. This is the top level page for the 'specs' manual
> +.. This is the top level page for the 'specs' manual
> =20
> =20
> -QEMU full-system emulation guest hardware specifications
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +QEMU System Emulation Guest Hardware Specifications
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =20
> =20
>  Contents:
> @@ -10,4 +10,5 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
> =20
> -   xive
> +   ppc-xive
> +   ppc-spapr-xive
>=20



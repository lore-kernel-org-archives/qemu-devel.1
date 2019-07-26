Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C7C76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5711D22BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5711D22BEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqviY-0004vR-JQ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hqviL-0004RX-9J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hqviJ-0007kt-Nw
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:36:33 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:35635)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hqviH-0007hY-TD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:36:30 -0400
Received: from player731.ha.ovh.net (unknown [10.108.35.95])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4224210DACE
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:36:26 +0200 (CEST)
Received: from kaod.org (unknown [109.190.253.16])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 5ED64838CCC6;
 Fri, 26 Jul 2019 08:36:20 +0000 (UTC)
To: sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org
References: <20190726071809.32389-1-sathnaga@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ae2385ae-adb8-b8b4-0a10-94c6a4468082@kaod.org>
Date: Fri, 26 Jul 2019 10:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726071809.32389-1-sathnaga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13513332161010240486
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.46.122
Subject: Re: [Qemu-devel] [PATCH 1/2] tests.acceptance.avocado_qemu: Add
 support for powerpc
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/2019 09:18, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>=20
> Current acceptance test will not run in powerpc Little endian
> environment due the arch name does not match the qemu binary path,
> let's handle it.
>=20
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index aee5d820ed..a05f0bb530 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -19,6 +19,7 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
> =20
>  from qemu.machine import QEMUMachine
> =20
> +

extra new line ^

>  def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> =20
> @@ -39,6 +40,9 @@ def pick_default_qemu_bin(arch=3DNone):
>      """
>      if arch is None:
>          arch =3D os.uname()[4]
> +    # qemu binary path does not match arch for powerpc, handle it
> +    if 'ppc64le' in arch:
> +        arch =3D 'ppc64'
>      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):
>=20



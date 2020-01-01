Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A35DC2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25170206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25170206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imcD4-0001sG-9u
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 06:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1imcCI-0001G2-4K
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1imcCG-0004Gd-1L
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:29:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:14020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1imcCE-0003og-S6; Wed, 01 Jan 2020 06:29:51 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 604B27475F8;
 Wed,  1 Jan 2020 12:29:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3FA10745953; Wed,  1 Jan 2020 12:29:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D9AB745702;
 Wed,  1 Jan 2020 12:29:40 +0100 (CET)
Date: Wed, 1 Jan 2020 12:29:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 07/14] hw/ppc/Kconfig: Let the Sam460ex board use the
 PowerPC 405 devices
In-Reply-To: <20191231183216.6781-8-philmd@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001011223290.5612@zero.eik.bme.hu>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-8-philmd@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-769473693-1577878180=:5612"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-769473693-1577878180=:5612
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Dec 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> When configured with --without-default-devices, the build fails:
>
>    LINK    ppc-softmmu/qemu-system-ppc
>  /usr/bin/ld: hw/ppc/sam460ex.o: in function `sam460ex_init':
>  hw/ppc/sam460ex.c:313: undefined reference to `ppc4xx_plb_init'
>  /usr/bin/ld: hw/ppc/sam460ex.c:353: undefined reference to `ppc405_ebc=
_init'
>  collect2: error: ld returned 1 exit status
>  make[1]: *** [Makefile:206: qemu-system-ppc] Error 1
>
> Fix by selecting the PPC405 config.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

(The 405 and 440 devices are currently entangled by both using similar=20
parts and maybe not all of them are in 4xx yet. Because of this I'm not=20
sure if it's worth having separate configure options for these or just=20
have a common PPC4XX option for now until these are cleaned up to separat=
e=20
them.)

Regards,
BALATON Zoltan

> ---
> hw/ppc/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 0cd8d4053e..004b7d5ad5 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -50,6 +50,7 @@ config PPC4XX
>
> config SAM460EX
>     bool
> +    select PPC405
>     select PFLASH_CFI01
>     select IDE_SII3112
>     select M41T80
>
--3866299591-769473693-1577878180=:5612--


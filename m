Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A73C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC3920663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="eu74V6/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDseO-0004Tc-Nl
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael@walle.cc>) id 1jDpzX-0007BG-5f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael@walle.cc>) id 1jDpzV-0006z0-Ok
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:41:14 -0400
Received: from ssl.serverraum.org ([2a01:4f8:151:8464::1:2]:52727)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <michael@walle.cc>) id 1jDpzU-0006nh-I6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:41:13 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id EBE7E23E62;
 Mon, 16 Mar 2020 14:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1584365531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LydIEdGb7czgjM477BNoNgwPiUXp2UvSROzMkojLLww=;
 b=eu74V6/pk+VK/udlRKanAdGfXBM4aS9R6NDwisojsVdA6U5Q3xWyMvHNE+UUJMWTKe+MVq
 eS+9+4scSrI+pJjtNgGjYFQmC23PQ9G4G1bREWUy7xne1VLIrOkrhrZP0IB6HIMOwmvHW2
 cXhA+yyzf0YBBA43/65nGWkSi1GNGOg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 16 Mar 2020 14:32:09 +0100
From: Michael Walle <michael@walle.cc>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Mark the LatticeMico32 target as orphan
In-Reply-To: <20200316122641.14017-1-philmd@redhat.com>
References: <20200316122641.14017-1-philmd@redhat.com>
Message-ID: <ea275f93229c9ec81a5f6cf3cc0f546a@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: EBE7E23E62
X-Spamd-Result: default: False [-0.10 / 15.00]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 NEURAL_HAM(-0.00)[-0.736]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmx.com,nongnu.org,linaro.org,redhat.com,mail.parknet.co.jp,twiddle.net,braap.org];
 MID_RHS_MATCH_FROM(0.00)[]
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:151:8464::1:2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?=C3=81kos_Kov=C3=A1cs?= <akoskovacs@gmx.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Emilio
 G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,


Am 2020-03-16 13:26, schrieb Philippe Mathieu-Daud=C3=A9:
> Michael Walle expressed his desire to orphan the lm32 target [*]:
>=20
>   I guess it is time to pull the plug. Mainly, because I have
>   no time for this anymore. I've always worked on this on my
>   spare time and life changed. And secondly, I guess RISC-V is
>   taking over ;) It has a far better ecosystem. Also, to my
>   knowledge the only (public) user of LM32 is milkymist and this
>   project is dead for years now..
>=20
>   So time to say goodbye. It was fun and I've learned a lot -
>   technically and also how a huge open source project works.
>   Thank you everyone for that :)
>=20
>   Basically everything still works and there are even TCG test
>   cases which covers all instructions the processor has.
>=20
> Many thanks to Michael for his substantial contributions to QEMU,
> and for maintaining the LM32 target for various years!
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
>=20
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Michael: Do you want to keep your M: entry, switch it to R: or remove?

You can change it to R:

-michael

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32867bc636..5376c59581 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -184,7 +184,7 @@ F: include/hw/net/lasi_82596.h
>=20
>  LM32 TCG CPUs
>  M: Michael Walle <michael@walle.cc>
> -S: Maintained
> +S: Orphan
>  F: target/lm32/
>  F: disas/lm32.c
>  F: hw/lm32/


Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C1BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229DD20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="dpupufnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229DD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDskf-0004y5-5X
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <michael@walle.cc>) id 1jDq4M-0000gf-1q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <michael@walle.cc>) id 1jDq4K-0002Cx-8i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:46:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42289)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <michael@walle.cc>) id 1jDq4K-00028g-0c
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:46:12 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id AF54523EB7;
 Mon, 16 Mar 2020 14:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1584365801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hugZAMwipZ3Tx3BM02PnuRzV16Jd/CsPcCPrLsQCKMw=;
 b=dpupufnNxCb3CKljOHniZlYhCXC7zUJbz8j5D32pIvgPHolXmDSqh9P0wNnJ+0LA7BK0bJ
 ApK39LfWH1gzj8Mb4lLMeO2uGK06PXImwG3vrzWv3AtRSfezPkSLgdxqDf3tvFCiY1q1bs
 5/4jAPI5ajYFF/E6ht1x+JPmmxhaabM=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 16 Mar 2020 14:36:41 +0100
From: Michael Walle <michael@walle.cc>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Mark the LatticeMico32 target as orphan
In-Reply-To: <20200316122641.14017-1-philmd@redhat.com>
References: <20200316122641.14017-1-philmd@redhat.com>
Message-ID: <5f276a9c7037f16af71bef31131d7ffb@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: AF54523EB7
X-Spamd-Result: default: False [-0.10 / 15.00]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 NEURAL_HAM(-0.00)[-0.736]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmx.com,nongnu.org,linaro.org,redhat.com,mail.parknet.co.jp,twiddle.net,braap.org];
 MID_RHS_MATCH_FROM(0.00)[]
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 176.9.125.105
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

Acked-by: Michael Walle <michael@walle.cc>

> ---
> Michael: Do you want to keep your M: entry, switch it to R: or remove?
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


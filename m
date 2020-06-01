Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6270C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BD520734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="ao7CVuaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BD520734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfsFX-0001NY-L4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jfsBk-00087y-CE
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:41:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:53376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jfsBh-0006ug-Ok
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=2LyS3B+VQTKQ3rQoPTvv6ZN4OTQOytRK6vf1g+EzG3o=; b=ao7CVuaAjfkOp6PRqVdGwkFt3B
 Ai7uJ2a/fNI0ZBLgMISLWcg88NfoIT74vDlJWcUjh2Q76Pux9FTEpZspmZWYtXzUIhJMob+a5k54s
 a/ytqDcM0JW6z7c03raUK3MaorlrOeuxbnqgBF15VW8AWyd8aZ2QRmTpR1mz1aaxpht1KkYBOUz7L
 NXn/TehtLnfJiS+72OokTMduslUMnZYlrg7PEfBXjY9oe9drXI6qn0qrxuMVKZswrUzn59Y36rdrL
 RXRGgqbOnGP1JDkNM37qI17WuGqbxYcKNY+1WfqDgp+U4hKPwd1ZfQLnywABIZCHiUAFYRrFakV8I
 su37hhqA==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jfsBR-0002Ia-LF; Mon, 01 Jun 2020 23:41:25 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.93)
 (envelope-from <aurelien@aurel32.net>)
 id 1jfsBR-0084sD-13; Mon, 01 Jun 2020 23:41:25 +0200
Date: Mon, 1 Jun 2020 23:41:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
Message-ID: <20200601214125.GA1924990@aurel32.net>
References: <20200601092057.10555-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200601092057.10555-1-f4bug@amsat.org>
User-Agent: Mutt/1.13.2 (2019-12-18)
Received-SPF: none client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-06-01 11:20, Philippe Mathieu-Daud=E9 wrote:
> I don't have much clue about the Renesas hardware, but at least
> I know now the source files a little bit, so I volunteer to pick
> up patches and send pull-requests for them during my scarce
> hobbyist time, until someone else with more knowledge steps up
> to do this job instead.
>=20
> Suggested-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0944d9c731..cbba3ac757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: target/sh4/
> -F: hw/sh4/
>  F: disas/sh4.c
> -F: include/hw/sh4/
> =20
>  SPARC TCG CPUs
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
> =20
> +Renesas Hardware
> +----------------
> +SH4 Hardware
> +M: Aurelien Jarno <aurelien@aurel32.net>
> +M: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

That's fine for me, and just to be clear I don't mind being demoted to a
reviewer or even removed from there. I do not really have time to work
on that.

> +S: Odd Fixes
> +F: hw/sh4/
> +F: hw/char/sh_serial.c
> +F: hw/intc/sh_intc.c
> +F: hw/timer/sh_timer.c
> +F: include/hw/sh4/
> +
>  SH4 Machines
>  ------------
>  R2D
> @@ -1246,6 +1256,7 @@ S: Maintained
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c
> +F: include/hw/sh4/sh_intc.h
> =20
>  Shix
>  M: Magnus Damm <magnus.damm@gmail.com>

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net


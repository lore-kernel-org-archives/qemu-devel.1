Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563E9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D041207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="VdoinhVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D041207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiXui-0001so-30
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 02:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jiXrY-0001L3-9N; Tue, 09 Jun 2020 02:35:56 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jiXrW-00072A-Ee; Tue, 09 Jun 2020 02:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=ZYeN1174DU6nu8ldXp7sQyil3UP1tHo3cBAZCoAvu6k=; b=VdoinhVddl6E3OBfgp+UQdSoHg
 YDBIMb1r6bCuj2SwOo1wu/JgsDnQJcdhrHVsLSIacbovZSmvIGOfa+6AmsxGojYc6JmijF60HW9TS
 P1GPPbyGDVdsRZzlsPQ17uEr0KEaZAQafOPGsnInnVWOLnQHtD2AxfZx7ba+XUDUtNUSBY2pPEAZM
 bVEUNgDU7dtFqIrOJIsMwwMc90wzyhjxwh0VHnsiRPvy1LMgiEKKx4E8g4bpKaBwPN7RuUHWyUmcq
 eq0fvhY0/PEZjK9PNt68wMPqux8FOiUsOWyWzNjmaXA90j4J2+KQH2Qku2uF5XEp3jHs0pA9mD+J9
 V/Hh1GAg==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jiXr4-000077-1t; Tue, 09 Jun 2020 08:35:26 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.93)
 (envelope-from <aurelien@aurel32.net>)
 id 1jiXr3-001ZCh-15; Tue, 09 Jun 2020 08:35:25 +0200
Date: Tue, 9 Jun 2020 08:35:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 3/8] MAINTAINERS: Mark SH4 TCG target orphan
Message-ID: <20200609063525.GA373396@aurel32.net>
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200608090142.6793-4-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-06-08 11:01, Philippe Mathieu-Daud=E9 wrote:
> Aurelien Jarno expressed his desire to orphan the SH4 target [*]:
>=20
>   I don't mind being [...] removed from there.
>   I do not really have time to work on that.
>=20
> Mark the SH4 TCG target orphan.
>=20
> Many thanks to Aurelien for his substantial contributions to QEMU,
> and for maintaining the SH4 TCG target for various years!
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
>=20
> Message-Id: <20200601214125.GA1924990@aurel32.net>
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a012d9b74e..cd65bce72b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,8 +296,7 @@ F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
> =20
>  SH4 TCG CPUs
> -M: Aurelien Jarno <aurelien@aurel32.net>
> -S: Odd Fixes
> +S: Orphan
>  F: target/sh4/
>  F: disas/sh4.c

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net


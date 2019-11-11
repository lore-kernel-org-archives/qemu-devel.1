Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02391C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD005206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD005206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6m9-0006R8-Mq
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aurelien@aurel32.net>) id 1iU6hg-0004Xd-Fm
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aurelien@aurel32.net>) id 1iU6hf-0008GP-Bb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:13:48 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aurelien@aurel32.net>)
 id 1iU6hf-0008Fx-5r
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:13:47 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1iU6he-0002KI-Bx; Mon, 11 Nov 2019 11:13:46 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
 (envelope-from <aurelien@aurel32.net>)
 id 1iU6hd-0007X4-U5; Mon, 11 Nov 2019 11:13:45 +0100
Date: Mon, 11 Nov 2019 11:13:45 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: Adjust maintainership for R4000 systems
Message-ID: <20191111101345.GD28851@aurel32.net>
References: <1573240249-6966-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573240249-6966-6-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573240249-6966-6-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:30d7:100::1
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 aleksandar.rikalo@rt-rk.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-08 20:10, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Change the maintainership for R4000 systems to improve its quality.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1a49381..62e7d6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -957,8 +957,9 @@ F: hw/mips/mips_mipssim.c
>  F: hw/net/mipsnet.c
> =20
>  R4000
> -M: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +M: Herv=E9 Poussineau <hpoussin@reactos.org>
> +R: Aurelien Jarno <aurelien@aurel32.net>
> +R: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>  S: Maintained
>  F: hw/mips/mips_r4k.c

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net


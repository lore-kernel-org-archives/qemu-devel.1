Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C96C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F86720714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSOg8GV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F86720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkOG3-0002dt-Ha
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkOFT-000283-Hn
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:44:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36649)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkOFS-00038b-3r
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:44:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id d128so11852569wmc.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vUYnPOKs/QEvN1K9X7RrTheNzVDDXOuL0Xp4+egih2g=;
 b=DSOg8GV0fY0ftHVcKEs/4WO/snbjR2pCIMtkiO15fqQqlNQZsD+Y1azU9ijBjwD54f
 Nfv6ad4uYGRciGIN5bCWP2QSZu8GbAvsd3h3nbd2v855c9lUiV78qsc0C2oibpK+3LA6
 D753F6ixCY9WnTJ//CDihl9EuSyEamhlG5oWH7XxHI6gw+0j9pXqEcos9uYPLkWkCjmZ
 0w3oK9s2qPx33vn+hAsGIS5qKvLBli7lg52EYXPlIclO2BRXaMa7dR40oih+gS3smy3z
 VEcDaGHIjU5rjYnVqTBxRdGuChvF2hmXdRGDe9UwCFlp36xcUsTw8ZQMF7vxQixrcfpA
 wBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vUYnPOKs/QEvN1K9X7RrTheNzVDDXOuL0Xp4+egih2g=;
 b=cpchPk7EmmB/0HnwRCvZrrxV7EH+JWPgpGPCxNWP0AmOIEPv+JWO4hwbVCDLUDAvF5
 ec8XHSwRu6wI8vcWatAVxVPclZn53FHzlVGq9DIjyXJI57CMswaWpCvDuoljY0o1tp5i
 YyNgNb0LgxJogjkyq1cTruFS1xbdWmla9xv9sjqlzfkeyxFHIWZhxA4ayQv/rJsksXSD
 fTEhPvTC8Hzkb9dK/UwivpQ8iZMpRD0E86BkVhFwpCL+chNeByvnAVRJGI2WWeWo9uSi
 4lfTHVWug2lVs5Xeo4j+8cy2awdPbLB7ybyr+vmdhWZghDbAPdq9MClqCaCj8LVC2Veu
 3lQg==
X-Gm-Message-State: AOAM533mlYcVXacGMziNnh/k9maZx7EowfkqNRu1rx7f6PDxa4jBOFQl
 D/15tBRalaCMjmsVW93URLQ3PEQUOZu2OhjoriU=
X-Google-Smtp-Source: ABdhPJy8p8ajuzj942e16BhJlZwWOp3Ac9N03xKLf2/VVMu35AHMwRh/WsQI+RMr8kIZfHOm6yUJLatP+oiUWyAanZc=
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr7115872wmj.159.1592124247309; 
 Sun, 14 Jun 2020 01:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
 <20200614080049.31134-3-jiaxun.yang@flygoat.com>
In-Reply-To: <20200614080049.31134-3-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 14 Jun 2020 10:43:55 +0200
Message-ID: <CAHiYmc7qrAO7S3-xdBq8g4D3U+z2XnW-wq9=TnCn+euLSOeS5g@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/mips: Add comments for vendor-specific ASEs
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 14. =D1=98=D1=83=D0=BD 2020. =D1=83 10:03 Jiaxun Yang <=
jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
>
> Abbreviations of vendor-specific ASEs looks very similiar.
> Add comments to explain the full name and vendors of these flags.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Applied to the next mips queue.

>  target/mips/mips-defs.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index f1b833f947..ed6a7a9e54 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -57,9 +57,13 @@
>  /*
>   *   bits 52-63: vendor-specific ASEs
>   */
> +/* MultiMedia Instructions defined by R5900 */
>  #define ASE_MMI           0x0010000000000000ULL
> +/* MIPS eXtension/enhanced Unit defined by Ingenic */
>  #define ASE_MXU           0x0020000000000000ULL
> +/* Loongson MultiMedia Instructions */
>  #define ASE_LMMI          0x0040000000000000ULL
> +/* Loongson EXTensions */
>  #define ASE_LEXT          0x0080000000000000ULL
>
>  /* MIPS CPU defines. */
> --
> 2.27.0


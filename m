Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD35C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8148F207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLxAgJUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kzY-0003Wm-M9
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3kKa-0005Wy-5H
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3kKZ-00030Q-2h
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:37:15 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3kKY-0002za-St
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:37:15 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so16842139oty.6
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YODozfMxPH46+bdc44hHN01AjcWxu1Kq76iCbSVrs1U=;
 b=lLxAgJUo3+zBnye8b1zzXPE24hS5qyiLJBZNakhRMCu9OVPE56mK4AWRUgYrmN04wu
 a7b3Ixh9UY+Lax2vvQNz3y8UKXl4X/3V9moqwbQsIy9+EHL7vEtYRayNlxpt8Hg7Yb+I
 1g769LnhnbJaVJEasuE8DBkO57AoiDxVBl1PRG17DkUfRsRZYLfB1JIypVD04DjtGnLr
 x49S24eZRM6yA8BI+fJ8XFw9h/GzJ7X0nDtyXTlJ6jHNheQthpIRksUYTjD+vsejgFnO
 a4TN/bFK0OBoZK1M37DBc5HWvyRQW8QNfVsBWj+gDjij33AhSFIBg8fnBSp1xf6yVyI+
 OW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YODozfMxPH46+bdc44hHN01AjcWxu1Kq76iCbSVrs1U=;
 b=gDA93k8nk2WMJiIJkz1PImCGuvXMAFOKETUiG/m7iQtui3XMq8eoizr65YVcG+O+tw
 NT5XfoxN27fHjDB29f0sp9i5IronKo64TXdOpht32ev19gal6HIzplnrmWnawb8c3OSH
 ski/pOwr9cq3Q6R2zzjPxkZoS3sBOGuklNAD4rZd478oD3Uj5uxpALFFpnd/oycOTHSb
 ZDbbAMSragp8ydI7oJ6kIYdDUJBFxO+/piHK8bb7P7DyFrUE3JpiMxorxsgaNjKiB5M8
 VlyCkahpJrpAqnOBUQEOsaEPxabtvzTmXd2gXXzHeNKrGJlLNYb6rw7e4hZ3AwxNC8uS
 xq8g==
X-Gm-Message-State: APjAAAWUV4l0vlxnhosBOmXcH5paWL95QprKFl9DyA/9y90YxWBQUDlp
 o66Ioo2F6SUMOTpsp8Y5bg15az35iHKKcR7x6iJwcg==
X-Google-Smtp-Source: APXvYqx6IWn+X2ctF9tWkP20z2S9wFuBmpfcwQLN2+SOhd9GaSwAtqXlX4ru+MzHnJIAaeCg4eDo7obmVLlBhCQgo3Q=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr791789oto.135.1581961033517; 
 Mon, 17 Feb 2020 09:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20200213234148.8434-1-f4bug@amsat.org>
 <20200213234148.8434-3-f4bug@amsat.org>
In-Reply-To: <20200213234148.8434-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 17:37:02 +0000
Message-ID: <CAFEAcA_4=ZoBwV+X-k4ZSfNqrvDqt=hi0aetG4GFBUxXEeZBBQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/hppa/dino: Fix reg800_keep_bits[] overrun (CID
 1419393 & 1419394)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 23:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:


> Fixes: Covertiy CID 1419393 and 1419394 (commit 18092598a5)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I think this also fixes CID 1419387 ?

thanks
-- PMM


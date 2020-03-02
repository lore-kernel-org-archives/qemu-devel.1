Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02624C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB4721739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/+R/S4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB4721739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nbS-0000hD-Ti
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nan-00007D-GV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nam-0005iq-Gi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:06:53 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8nam-0005hw-AX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:06:52 -0500
Received: by mail-oi1-x244.google.com with SMTP id r16so10768578oie.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uwBp1BC/e+YqE2Z+qU+tY2wILWfkCO4jHo1fvAz565Y=;
 b=i/+R/S4peD+idb/yJGVYpIRlYpyi7QJr+GPvHv7MtOMVOqfAnm26teIG72jTncw2Ay
 16Q/wjLKLyC8aURPZD8a8mQguxOvqpI0+5094lUOOZsNKHcQNEvGW+Tv9vszkfbKhdXU
 hnATSknI12xRtFNY++OwftMMOyhFYns1y0O0f5w5EadTe5DOspl+qV4yhc/yPZ+NXCdo
 ZQvdGCpii7fQciKuxjtRzYSNlcuQ+KxJ+Gf3xcMNQqg9joORH5Yam51xaFus+SMo/1a4
 wRZcCsEVMm/CNz9NGwxhwWfFWsd8/bFMyjRNX3WfA20Wvf539DDjhs+unxr7GBOKX4eB
 AhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uwBp1BC/e+YqE2Z+qU+tY2wILWfkCO4jHo1fvAz565Y=;
 b=Au9kSc8dKVwqOBPsKRpCdSlHCEHVinQKWeOk86nvB5f3WmBxNLHOUnQq4pjXNQ4gjJ
 rYqt59PQf8/IwohlRbqWYKgj/WSyd4yz/lucLA1Ee1xa/h7XxhLUrIEk9Eg562aTIX1q
 WZjG+YErypDZ0L77gtR6ePnKDKakj+HF214dnPvWagSVbpQEjGDQEH738tGsdKWcganp
 f/lVUqEetRht8Qi4h1Q4ZFoSy5J58NMOvr0xaIMLh87VnCuyQdM/MlqQSqU5IuSlpPSu
 sYyyG1pplC3L5HnjXloj2ozaAV+8BuxdkN+PItimrP2+izaY8TZk+V3TFvzBCoDUlfsU
 oD6A==
X-Gm-Message-State: ANhLgQ3kAacXIKR6apQL2NfWyd03XuvbEEbdP+4rFPlnkZaqwOs6+0uN
 kz0JFreSUQ8nHd2y+SNK66MYIbn9nzLbiTha9wCDjg==
X-Google-Smtp-Source: ADFU+vuv+FxLrSlN7SIJVaWs/B6QGdKJvyBKRRe2JjjEECYxGERVxf1aFseoui/k1UzGonk0vYZhXVgRVOoSl6XP1LQ=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr121936oif.163.1583165211392; 
 Mon, 02 Mar 2020 08:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
In-Reply-To: <20200227220149.6845-1-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 16:06:39 +0000
Message-ID: <CAFEAcA8uEd_RqNi6iQDxZmGaAGpYoy=bgXFJVj-ow0Ci_Vz+DQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] hw/arm/cubieboard: correct CPU type and add
 machine argument checks
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 22:01, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> These patches change the Cubieboard machine definition to use the
> correct CPU type, which is ARM Cortex-A8 instead of ARM Cortex-A9.
>
> Additionally, add some sanity checks for the machine input
> arguments in the initialization function.
>
> Niek Linnenbank (4):
>   hw/arm/cubieboard: use ARM Cortex-A8 as the default CPU in machine
>     definition
>   hw/arm/cubieboard: restrict allowed CPU type to ARM Cortex-A8
>   hw/arm/cubieboard: restrict allowed RAM size to 512MiB and 1GiB
>   hw/arm/cubieboard: report error when using unsupported -bios argument


Applied to target-arm.next, thanks. (I tweaked a couple of commit
messages as mentioned in replies to those patches.)

-- PMM


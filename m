Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394DAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054E4206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxi2UaEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054E4206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZPo-0001Ay-4F
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixZNH-00051N-Bh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixZNF-0003L4-UX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:42:31 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:46060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixZNF-0003HB-Mo
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:42:29 -0500
Received: by mail-ot1-x32d.google.com with SMTP id 59so7114755otp.12
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CtE4fn1xpHrepDivz2pi7K8Ll2uTl88nZuBp4R2gwSc=;
 b=zxi2UaEpzqJIe8dClF3lU7iSK+VAVdqu2IXTQ4h987EvZ6d6fEQoFIHDvm29j8HC+Q
 yTAXEWhDiuqFl3DZNNJ/UhJsteZB79tMjAo1ED3zfQM3iWEGaeBh2j8UxGvKJ0e78mSI
 VnHl9Rs6R9jKdjXw7E7PM+i5vMMmXbVZs1439EpDZkg7aqV9uJZVXNB9YnNR+Zw18bQ4
 Bi9L3EU+a6D2va/fhrLgd8L/dHxWB2Iui0oiY0yWLt7BnYJ/AktEOxvvwVC0ZfJA0bwg
 afzmz/h+QB7p8+ctLe288K4KZf0KPAg0Z4ZayFy3HyyO1aX79PwUtzrIfsbXHs7ePptw
 MhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CtE4fn1xpHrepDivz2pi7K8Ll2uTl88nZuBp4R2gwSc=;
 b=PFAgGbHaaehLbpOfD8YlBfqSTKGlkuYL86r0A0bKmvgWu/TyOQ8M8cfsUWsgV1UTdN
 51JVBezAFny40cSAoKwc//akeFZdWmdkNSndG42g78V85G2eQZiEGqOZ3kI8wleGeu3I
 5bh2OM51DBsmaUwIBdXtEEvLJ0sIi7nHyWiwa5kbWe8gGWUAkhQ1+J+pc/ji07VxGzJO
 /dstNH1zSUZ9Ht27z678KXwsBTbbOEXNeguqsmJSHroaFATQvkDcIS9mof9fQVckaM2G
 KMr2T01LkwW+LwbF98abUMkNQOSIrxcqjY7sTkPF7OGPz5BT39wAGYjNQqupuoRS9VGo
 JwNQ==
X-Gm-Message-State: APjAAAXRlXDLihoeJpgZ3ezeCzF106C52bUazv49Eif6LlGvPZAs2f+B
 U4wFx5lYiWUVKCNZTDFEAfQgKvC84Ir+mDvhD6r4fg==
X-Google-Smtp-Source: APXvYqwg+7RLW4OnDAm3MzcecOCrA5Pp5Oi9N1HwlYSpzM58WijtsHQWbkFtgDUaQPTIBVbQbIuqea6C/WGKeZpuY98=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr8264220otd.91.1580488945556; 
 Fri, 31 Jan 2020 08:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200131060924.147449-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 16:42:14 +0000
Message-ID: <CAFEAcA8Uzt79o9509fyZOYgAot5m2mk2wWkQkgETW2gL0XOHWA@mail.gmail.com>
Subject: Re: [PULL 00/34] ppc-for-5.0 queue 20200131
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 at 06:09, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f57d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200130' into staging (2020-01-30 16:19:04 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200131
>
> for you to fetch changes up to 532fe321cf06d39d864de3642b4e1b18cc83c4de:
>
>   target/ppc: Use probe_write for DCBZ (2020-01-31 14:54:16 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-01-31
>
> Here's the next batch of patches for ppc and associated machine types.
> Highlights includes:
>  * Remove the deprecated "prep" machine type and its OpenHackware
>    firmware
>  * Add TCG emulation of the msgsndp etc. supervisor privileged
>    doorbell instructions
>  * Allow "pnv" machine type to run Hostboot style firmwares
>  * Add a virtual TPM device for spapr machines
>  * Implement devices for POWER8 PHB3 and POWER9 PHB4 host bridges for
>    the pnv machine type
>  * Use faster Spectre mitigation by default for POWER9 DD2.3 machines
>  * Introduce Firmware Assisted NMI dump facility for spapr machines
>  * Fix a performance regression with load/store multiple instructions
>    in TCG
>
> as well as some other assorted cleanups and fixes.
>

Hi; this pull req produces a bunch of extra warning messages in
my log files; is it possible to suppress them ?


qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=on
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=on
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG
qemu-system-ppc64: warning: TCG doesn't support requested feature,
cap-ccf-assist=on
qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
Interrupts(FWNMI) not supported in TCG

thanks
-- PMM


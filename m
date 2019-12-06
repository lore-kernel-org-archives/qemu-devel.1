Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9CAC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CF124659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KG55XHkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CF124659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFKx-0008LZ-9i
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEaT-0005dg-P6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEaS-0006OE-LR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:28:05 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEaS-0006Hm-EG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:28:04 -0500
Received: by mail-ot1-x341.google.com with SMTP id h20so5930153otn.5
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ylrm/4WFZx63ZkzH1Zw02+jjVl0M7w4X80tYAXrwsE=;
 b=KG55XHkplS/f4DvDbIEnkmjz6kb6kvAAhxUvC5FcOqf2uHt6f4TsXG57JhqIVWyU1F
 U0LC/tm9QlUFXnjQ+NW62oLjTtUwrLVvkd3MRoALvsqpX9tuFgOww8oNpSbV2jAWQkQ9
 emioOvBKvylPD7wmv2MBZMPT+SivDEM/cYxlN82luFIO0Tex7Nb2BwgoyR5kbVIa0IOo
 E0UzHSEfpuYqTcDtAkvpn67HyMyXWi5xK8XYkS/strHQu7l+Yr8Rf1oxlcLhE8bzfvWd
 LKKiM9dC9V/0Z5uGCuHhYr3RC6seNqfV3ARvvsqVpyAFOXHO+RMEpaeAlKpcnkrxEccX
 9CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ylrm/4WFZx63ZkzH1Zw02+jjVl0M7w4X80tYAXrwsE=;
 b=tBy+w/HrzNIDsD/9sfHlmKNFTZNi/A6cLaQHbNkeOeCRqeKmh5Jq/fDYJla9YKzLj1
 ZlsQdy5RAk7kFXvp4DJYw27kLxRZp3o9HCFXY51CGqeUTzJIVE9D4Pd8SfvVAeVQ9Ivl
 OsYbbFmsIb0qgcxXUP7DPko0g8pCNiNeGEoKKipmptuqelFL9sm4FX20d8YBiUeq1W1A
 ENpPALlgcv8LzwI6ldBE1MUA1HtMc7fg8IlCMJUkB1y1gEBKtyKF79zSR9bTR5fWxern
 5newoiDeybO71ii6C51j2iaPbfLmk1jaDYowEXf42auhUGN/kRMwWCkIaYGvs201M0Xr
 CUIQ==
X-Gm-Message-State: APjAAAXRues1IZM/l2Y9UiVpsAptkJrLOJhbehFyemW5PDRem4/OxMa1
 i3+HEX/43CuzJkrQGUYVVAJuzwFS+25vhRl45vH+Jg==
X-Google-Smtp-Source: APXvYqx/aOTIEihQVjKowj9DLIWD6rfIfM0nQD+Nabd+Y86A0w8g0dCnIIo/KALJBKVagXMCudgi/U87edrmlVfr85g=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11279749otq.135.1575642482817; 
 Fri, 06 Dec 2019 06:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-9-nieklinnenbank@gmail.com>
In-Reply-To: <20191202210947.3603-9-nieklinnenbank@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 14:27:51 +0000
Message-ID: <CAFEAcA-1Re0noxPN04uXqRYX=-g97jtiweZA=WcFo1OwXBoN5w@mail.gmail.com>
Subject: Re: [PATCH 08/10] arm: allwinner-h3: add Security Identifier device
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 21:10, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> The Security Identifier device in Allwinner H3 System on Chip
> gives applications a per-board unique identifier. This commit
> adds support for the Allwinner H3 Security Identifier using
> randomized data as input.

If this is a fixed value in hardware, I'm not sure that
having the QEMU model pick a random value is the best
choice. If we just set it to a fixed value in QEMU, is
that going to cause problems?

(Generally it's nice for QEMU to be deterministic, so it
behaves the same way every time you run it. Also if it's
always the same we don't need to bother migrating the
ID value.)

thanks
-- PMM


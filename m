Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9192DC43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FB92073F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFX4+IYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FB92073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf6KG-0007ND-K4
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hf6IJ-0005Xl-KK
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hf6IH-0006Tp-1r
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:28:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hf6IC-0006Mn-Ke
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:28:42 -0400
Received: by mail-ot1-x344.google.com with SMTP id e8so11201817otl.7
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ocu7dvhfT6qKErnmwC9GM3wR+wDZgRONvgHkwHbb7KM=;
 b=eFX4+IYHJ0tpKWlZLpLzsTT+gSpiaItRin5eYmrIzWgL8OjI/Cs+7dHG0NIR+0JOWX
 Eq/RBZ/FlqCHbo0lljfeqsAZEOwCmLrzKBxNtBDBD0ocJQiETYO4YwVjV/6vR77EvfYh
 gSySDTxKPOPMsLby0aw3vvoU8D+Z+3VMT8iuwsXACf064dU8UMP1pMh424MX/F/dowB5
 GF6yPB7E/vwHSIwGmvYJHt1L/7cmhaBeB9HtDWyeFLWZzXlKhBreSZoaE0AKD0EHmifp
 h7R12moTZWOpvkwhdWyWDFT1yvfG0Td00fjUqoiZscm1qnkOSOL0x+JftwE73VjMOj8r
 2cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ocu7dvhfT6qKErnmwC9GM3wR+wDZgRONvgHkwHbb7KM=;
 b=nyh1H5W/zjseKw0eYzfomD71RKj6cA+eK9kdZ7Z9QfaVnBY7GmPHp611Xw6/YDsKrt
 Ijn0RIRf4NzOn0RKmOzUJdquOPIDx5s1up3uZCeMRs9qBZ0c2n7IzNndFsy9QrbdK320
 j+mD5Ivr77OydBQYUuljdKWQkr45IVb9e4AGZjrxi1uCrn5Gh/BzJECpuoAJwJoaIjbF
 OG9PUi1p8f34oam3iiYqXkf99NnsX8y28t3Myebd+lEvkFT7ZEilZtMcCRgqR+Gv/s6D
 jqOWijE5M46ghOE6YydDG7fW8dA0Ld33Mc2NO5jFPIi0xUQWxoRVtsbZcSSNwacmZsOX
 tDRQ==
X-Gm-Message-State: APjAAAVQrTXBrL9JtGDS1TqCCRuvKoJQ4Vg16d2y+bz3TLMKaaddA25E
 SRLdNY8OMbOeSs8mW/LaIfkGDszKtV+99sNX04w4cg==
X-Google-Smtp-Source: APXvYqzZns4E/jIOHqrNi8IqZSqGbUxBM9t9O1aX9vVLa+d3PvKO3xX0kFZQoPsGDaAs597PIPxckg2oNUEzudvIIiE=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr8807008otk.221.1561310917626; 
 Sun, 23 Jun 2019 10:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <C95C3BAC-3DE1-44F3-BB08-715D3121371A@gmail.com>
In-Reply-To: <C95C3BAC-3DE1-44F3-BB08-715D3121371A@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jun 2019 18:28:26 +0100
Message-ID: <CAFEAcA8mcQJiYkHdzNJT3m+9-vak_CWaxGBQ0TME1tZQQK7f_w@mail.gmail.com>
To: =?UTF-8?Q?Juan_Rafael_Garc=C3=ADa_Blanco?= <juanrgar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-discuss] qemu-io-cmds does not compile on
 macOS
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Jun 2019 at 16:22, Juan Rafael Garc=C3=ADa Blanco
<juanrgar@gmail.com> wrote:
> I think the latest changes to qemu-io-cmds.c make it impossible to compil=
e under macOS. It now uses clock_gettime, which is not available in this OS=
. I=E2=80=99m using 10.9.5; I think this function is now included in 10.12.
>
> I would step up to try to prepare a patch that uses a replacement in case=
 it is being compiled in a macOS version that does not include that functio=
n. But I do not know if you want to support these =E2=80=98old' macOS versi=
ons=E2=80=A6

Hi; thanks for this report. (This kind of bug report is better sent
to qemu-devel or to the launchpad bug tracker -- qemu-discuss
is mostly user-to-user conversations, and developers tend to
be on -devel; I've cc'd -devel on this.)

Our official support policy is that we support building with the
two most recent versions of macOS; in practice we might support
building with some earlier versions; as of commit 5588840ff77800e839
we definitely dropped support for anything earlier than 10.10.
So in theory we don't strongly care about anything before 10.13
at the moment; but if it's easy to avoid the problem it might be
worth doing that.

Alex, it looks like the relevant commit was one of yours.
Could you have a look at how easy it would be to support
systems without clock_gettime/CLOCK_MONOTONIC ?
I notice that other places in QEMU have #ifdeffery for
a lack of CLOCK_MONOTONIC, so we should ideally be
consistent, and either support systems without it, or else
say we require it and remove the remaining legacy ifdefs...

thanks
-- PMM


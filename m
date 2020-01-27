Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99EA20716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/piUvSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99EA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw38v-0003vX-3o
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iw38I-0003Jp-HG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iw38H-0006QO-Fl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:04:46 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:44997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iw38H-0006NS-A0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:04:45 -0500
Received: by mail-oi1-x236.google.com with SMTP id d62so6351700oia.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 04:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c7NOTGGcRF8sv0fZ+S2TgN/PucHv0nGhK2aaaJtNeFs=;
 b=E/piUvSeZlWdXJtPiex7N2GJSRmbDTidpHkPzGKUSqHCB4NiCZEm1H2/HLHaZWxNkK
 8mRRWLgNiKy/O0h7DWE2eqeX1yBkSjUT/FjqGBh07veMlx9ESUmTmve/YEIOAHLIRGq1
 gfYK8/q+nBFomMy88orSCjSVeMnCoRAQQMIM10VnRqR5OjE0YX+GkiBGlsY9bfm5CUk/
 bFw3YTcFxy7Hmyfk5UqwWYHenBUwRNBJuvCFFLS/NhSM3PxA08483eGQIbadFqrXNeSH
 ohFbfJ/suTRvfbytHDiNwUb3/+8txgrO/HNjA9nCU27hlFz9R13U0o4UymbtMI+fbEgQ
 pt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c7NOTGGcRF8sv0fZ+S2TgN/PucHv0nGhK2aaaJtNeFs=;
 b=eJCD5tAC93xotTx0BvRzZGMnddapvaFFlA7Mxro0xCCsGNGA37s0hrBj1MS8L+UhJi
 UF2ivghSArJ/l51lPvnAqggiV01DiZfBtg6NOOWDn3PDHpNQWQnNeKqW6kEglVh9bnYb
 dRUaL84RE4BRF3gXExVPKFTQaQKyUH+GxmkYZRGSUhkx7b1qWG53UkVu8QaRdS9tQsjQ
 C4jiiG4R3tsnzW4O0NbLjd2RQ2FwMQgE8ZasGJZkkRhsaYGETj/VrdJ0SNJiGMQStzh7
 AMeuDNCHf9DE3+yPYT4xbL3bDWvl05Xx6i5PVOXTnthCZB9rUmJJfHDcOP24evpfbk1J
 UnHQ==
X-Gm-Message-State: APjAAAVOafEDc6JGqqGqyu9BhxIXn44WUEzRtgt72sFqtgXKI8nvdeWx
 8PqHG1IkqygG2/zuSUDiUdyBEGKp1BD6JUsGG3ec/w==
X-Google-Smtp-Source: APXvYqz/vu1zBqiuPqswX7HXWGQfJAOV+6xxD8ym7iM+3YDFC0uqalSv1T07G6KIpkEadMGkFvOOZYC1j+/Jd8QjVP4=
X-Received: by 2002:aca:f484:: with SMTP id s126mr6851667oih.48.1580126684436; 
 Mon, 27 Jan 2020 04:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org> <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
In-Reply-To: <20200127115606.GA5669@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2020 12:04:33 +0000
Message-ID: <CAFEAcA8R3gu=GQTXqqQvMxtsR0+QOQD-O0UXGJo8sC5_mkAx7w@mail.gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 11:56, Kevin Wolf <kwolf@redhat.com> wrote:
> If you have a long-lived production VM that you always run with the same
> configuration, then yes, having a config file for it in the file system
> is what you probably want. Currently, for this case, people directly
> using QEMU tend to write a script that contains the command line. I
> think I do have such scripts somewhere, but their number is very small.

I have some similar scripts, which I use for launching one-off
"run and then kill soon" VMs, mostly as test setups. The
advantage of a script is that you get an actual programming
language and can do things like "substitute in the name of
the directory the script lives in" when setting up parameters
that are filenames, or easily support "this is a default, and
you can override it with an environment variable". So I'd
still need to have a script even if the script changed from
"run QEMU with these command line options" to "create a temp
file with this config and run QEMU on it".

thanks
-- PMM


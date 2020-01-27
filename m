Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D50C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA4520CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdxyv5Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA4520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2V0-0007i4-I8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iw2UR-0007B3-Py
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iw2UQ-00015X-JW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:23:35 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iw2UQ-000146-Du
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:23:34 -0500
Received: by mail-oi1-x236.google.com with SMTP id 13so6249428oij.13
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KjtxNLJZOIn3QoVIh/aMZfpEZ6EMGJVSqbvoKVa6OBw=;
 b=zdxyv5Mlwe8LlWdhBK6eLa9Iq20MxzpfcBzgw4HqdhP0QcU9DPLWTqdAAFIUScnnq4
 3mCOr/Do5u54Ub6H/tkSM8ueOYy6r8WfwNcWB/IfcoFWGsslNWtDfr5jaDg9h9Mx6jXI
 SlFJ+Y1SSuroDaVynFW1YhORQtflJGqtf6T1VXPE2X2yp6J2QjZAH+H6/U6NyvvZ5nbF
 EzdQ4fQsOSliptU+/yDz8XFykOrn8PRMBU5mTBeYCGrKmpA5oZYqRzSX8ypKOpraTyI6
 x9d7HPR2jA2EmGg0YT3FWbLgoBIkzWDb3a2Ws9BJpUrWYXnatIvDN2Tiks+Am9cbuHVx
 hAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KjtxNLJZOIn3QoVIh/aMZfpEZ6EMGJVSqbvoKVa6OBw=;
 b=mLlu5Pw7bZZJonYHM/4+CMx6fuLSBC7o9Mp4y6rRjoi5KQ6AlWwu0rXMzWK5UQ2rzg
 IxQ+tvLuOeSbJAasWMXVcv1DKM8J2FwQy2xyeyZtwB0BA5hbN/EQIlrQ+SmzrPIWXFEK
 zt450VC545BRqQbTfatpSr7qTgtiRuIQL3bP0tUDk+yWQourWOddbZedz0nmiT5oV4P1
 MMYBuHqPDH+Ozv7cci2DVx2PBY892A7Zi4OVDe2JB/kxDDH97m8gIX6PBfUY7bskhd/0
 CbvlufYudL5iYK7FfH7J/KOmQM+YU5vVWdZm+zUsEhufMISeRJ1z6NXA7Csonp0bDTDl
 wfpQ==
X-Gm-Message-State: APjAAAUTroUBck/2DgTr5+Q14GdSloiwqj2ivBLOUL2gmZKdq+E6oMF+
 vXDJnMIGODmjW65b6HV9qd10tw3UpelMzqfbYLOtvQ==
X-Google-Smtp-Source: APXvYqyA6yruhpC6qViNhMmG1uimsb5u01866rt5irDzp79cYSEfVoAVP+Qy0oqKonF9lnad83foiHO04MNipD7O2go=
X-Received: by 2002:aca:f484:: with SMTP id s126mr6769202oih.48.1580124213574; 
 Mon, 27 Jan 2020 03:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20200124232009.12928-1-richard.henderson@linaro.org>
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2020 11:23:22 +0000
Message-ID: <CAFEAcA9wEGWe1E5JZssEJwvXTtaWZrVTwOpCdG7_h4RkbUsXdg@mail.gmail.com>
Subject: Re: [PULL v3 00/11] target/hppa patch queue
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 23:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 3 fixes printf formatting errors, and some indentation
> errors, in artist.c, lasips2.c, and i82596.c.
>
>
> r~
>
>
> The following changes since commit ba2ed84fe6a78f64b2da441750fc6e925d94106a:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-sf1' into staging (2020-01-24 12:34:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-pa-20200124
>
> for you to fetch changes up to 5b33eecce852658121b1190fee466f01a69e1910:
>
>   target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-24 14:35:58 -0800)
>
> ----------------------------------------------------------------
> Improve LASI emulation
> Add Artist graphics
> Fix main memory allocation
> Improve LDCW emulation wrt real hw

This fails to compile -- I suspect your pullreq needs updating
to account for something in Paolo's most recent applied pull:

/home/petmay01/qemu-for-merges/hw/net/lasi_i82596.c: In function
'lasi_82596_class_init':
/home/petmay01/qemu-for-merges/hw/net/lasi_i82596.c:171:7: error:
'DeviceClass {aka struct DeviceClass}' has no member named 'props'
     dc->props = lasi_82596_properties;
       ^

(and similar in hw/display/artist.c)

Looks like these should now be
     device_class_set_props(dc, lasi_82596_properties);

thanks
-- PMM


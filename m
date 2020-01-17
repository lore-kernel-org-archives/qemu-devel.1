Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B72C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549142467D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EneSngpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549142467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVdQ-0000HX-Dw
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1isVcW-0007pn-TP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1isVcV-0003D6-VW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:41:20 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1isVcT-0003Au-RB; Fri, 17 Jan 2020 12:41:17 -0500
Received: by mail-yb1-xb41.google.com with SMTP id x18so6228267ybk.6;
 Fri, 17 Jan 2020 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZbltzGJaQyeZ5szrL/Z/7BbqWF9ObYIMgsWiX8bTni0=;
 b=EneSngpjXgwzpEA+r9mmFqfJlO9Bb6VHgfMHEfHQpZ4sYAt9HI76FdfAILGdcREYDh
 ZoIlAkp32QPh1sTcl/bP8rNtTql6DBWiZrj19tgQ8YqKob5itxkFwP+Ot5y5s6ScOlGe
 wi7W85mKGFMR3SzknwrGMxCxyb3gxScNMcvBHdSSkAUFdKkxi9hZ1MdiZjExjSvEYhgQ
 ymWJvnY/esEKaP0GpxUAIWDX9GnBimBcWtSsk6/IsInoQ44F6EujVF3UdaXmBWKkp8v7
 0wQlHzpGR7dZkpsNBS6LslpuTE3mQYXroQv8e6BIcuX+blVlm6vau+X49IZe1ZH3Hf3d
 tCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZbltzGJaQyeZ5szrL/Z/7BbqWF9ObYIMgsWiX8bTni0=;
 b=Nh341DlpQggVCV+odr6dOV4dCGFjh9whOKz5ATm7t/V8I138lUgSf21tfeAQv78MeU
 AiZMffRfZpmcaKCTrtf8ytzlJebQjH7rOhkAjm7VocLoCPvEDQbZRDtKz4hGY5X2s+Lj
 LXp4AA2uB5PpHvdE4lCSGot8fZT9OnleAv8G+Cb6tsTKXfjdgooX+EcM1e2bKetsskmY
 7vzWZ+G6Jq39UX1wnO0UVz3x1eM1fZhFAUHi6pJMFw0EljsHOtdrg1dzRarElMOxg586
 V2q+eXC6Vww5rHbFxjTbgoOn0MsaRHp6T4L1D0OdGBuZMh58fgUzI/iIB23L9Ef/XoCz
 dssw==
X-Gm-Message-State: APjAAAU0/1cU/Mdp3AE9E4LYD2pBvnqYZCX7ZCj7ujJwQpzyqEsk3Wtz
 VAsxZdZ+5oLcC8nTOjKhdj8=
X-Google-Smtp-Source: APXvYqwUaVwl0ml5TIYeuAzfUMDRNuS6hPVTolghJucfLLJX0mhhtWLm13wTpqPlLUjoWLwzHPjbjQ==
X-Received: by 2002:a25:1a55:: with SMTP id a82mr13416432yba.497.1579282877052; 
 Fri, 17 Jan 2020 09:41:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 71sm11389007ywd.59.2020.01.17.09.41.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 09:41:16 -0800 (PST)
Date: Fri, 17 Jan 2020 09:41:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/6] dma/pl330: Convert to support tracing
Message-ID: <20200117174114.GA32278@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-2-linux@roeck-us.net>
 <CAFEAcA_k8xdzmsgMK+m6wSgnBN53UjCNU4nTBx=hnHnHz+Su6g@mail.gmail.com>
 <20200117164625.GA27197@roeck-us.net>
 <CAFEAcA9dvOQpPxkjG4XqYiMXbVsZ1VMCZWEWegeTu-GNW0Znaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9dvOQpPxkjG4XqYiMXbVsZ1VMCZWEWegeTu-GNW0Znaw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 05:05:07PM +0000, Peter Maydell wrote:
> On Fri, 17 Jan 2020 at 16:46, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Fri, Jan 17, 2020 at 01:23:46PM +0000, Peter Maydell wrote:
> > > Won't this now do all the work of constructing the hexdump strings,
> > > even if tracing is disabled ?
> > >
> > That is correct. Can I check
> >         if (trace_event_get_state(TRACE_PL330_HEXDUMP) &&
> >             qemu_loglevel_mask(LOG_TRACE)) {
> > directly in pl330_hexdump(), or is there some other means to handle
> > this kind of situation ?
> 
> It's not something I've had to do before.
> docs/devel/tracing.txt says "just use the TRACE_FOO_ENABLED
> macro", but looking at what it does that doesn't seem to check
> the runtime state of the trace event, so maybe those docs are out
> of date. Stefan, what's the current best way to guard expensive
> computations used only for trace output ?
> 
trace_event_get_state_backends(TRACE_PL330_HEXDUMP), maybe ?

Thanks,
Guenter


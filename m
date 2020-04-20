Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1149CC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF11207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHFBZmVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF11207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdrI-0006Dt-Qr
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdpr-0005Bi-KU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdpq-0004Ec-JA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:20:11 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:39389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQdpq-00048g-1N
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:20:10 -0400
Received: by mail-ot1-x334.google.com with SMTP id m13so9456018otf.6
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nJctbm03MbPJ6if54rJMd7RKd6TCCC2JwT68CqeHvSM=;
 b=NHFBZmVpKLSvrw/NQ2hlDPkpCepzgHdSW7AooWwMh04Qi3SiTBAmosxk/yScyGqfC7
 W2LmaMhflEe+xcLLygseMriju0HzjUolGsxydHhokxYt0FaUq5ZeVIHUOuXGYkTsxksL
 0Qa4GzFz3szTezm0ysw0t6vic1ipV35leu61kTTHUaWd6w8c8nEGd5K81wwEG1vbe39f
 DVJT/ozDg6GuqTAp/x22wvL0v5xsepyu7JOPQMuQgZ568ISZCdSCchmxkQny/lxifa7t
 H1KFuqkze0nDhhr783jf07GiXuiiYJ0CCVtSKUBPlTYLnpI66h5GlDe9MvS9eTY8xvry
 ymxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nJctbm03MbPJ6if54rJMd7RKd6TCCC2JwT68CqeHvSM=;
 b=W3tIT4iE5m6Y/cux3iqSnt8kH0LwfLCOSTteBT5N+dCl53d2M0yY2ONPel4v4UT5De
 IvrfBvyFrNaYz6dXXkIU5LK980PMY2+nydvXIewvKNF1cRTSChpaocOZMt0cziQyDOc1
 3b6+1q4CPngyUQ3JAQSXoB0NceCcfq7ahrSPn4fBYjbFARv0LEo+K0NYxt74D+Bzfk1W
 sgnlweQKeN6PfdAqVi96nwKIIZ396hsNyapkw54hU9HVB3zntI09knqQHYZskO4zVlKb
 cV6aYy7NaCOTB9ggQ8dW+2IbyjSssI1FgZ/vONvksJFv8WP1OscW6e4iXHqsZOKN8ylk
 t41w==
X-Gm-Message-State: AGi0PubA8EynlaQQOHDhb6qoYye/bNFa9KgSYDxTB9W6S/ZgLzZnSSjG
 1PjUnCHhaqLXS41BbubeXuGAJaweu71BgeSzVNdBcw==
X-Google-Smtp-Source: APiQypLDAPsiLtqfuxQvyz+lf4h3G0dGx8rvl0eKKkk//bcfEFPcx0TdPRP+KdAC0jeG3UfYCWNwgufNv6fQ6y5ue4U=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr11039173otj.91.1587417607950; 
 Mon, 20 Apr 2020 14:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200417050514.235060-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 22:19:56 +0100
Message-ID: <CAFEAcA9+iT+CDV8ZeLXH2aNLsdhpneqpAP2nRR6JFjk8HaX4Ag@mail.gmail.com>
Subject: Re: [PULL 0/3] ppc-for-5.0 queue 20200417
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 06:05, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472:
>
>   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200417
>
> for you to fetch changes up to 5ed195065cc6895f61b9d59bfa0a0536ed5ed51e:
>
>   target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts (2020-04-17 10:39:03 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2020-04-17
>
> Here are a few late bugfixes for qemu-5.0 in the ppc target code.
> Unless some really nasty last minute bug shows up, I expect this to be
> the last ppc pull request for qemu-5.0.

Applied, thanks (since we needed an rc4 anyway).

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


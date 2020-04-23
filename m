Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F25DC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F406A2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYZwoA6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F406A2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdHp-0002a8-3e
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRdGg-0001rV-NO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRdGf-0002l6-W5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:55:58 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:42569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRdGf-0002kd-Iz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:55:57 -0400
Received: by mail-ot1-x334.google.com with SMTP id m18so6472744otq.9
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4o6wEIcbD62prZrs0B3Uwa18U9uB2CFd1FYvHXkJpI4=;
 b=HYZwoA6elXL2sVHS4mrNWmtrHbDwwbsDGJC8BhA+r/KBzIqtgn4mbcHZOj0LIJkxao
 gw33cXVjYCLdiZarG6RlILpBAYB7Si1JoitZE8Okv6m6BHaU8SHNs1Xl2hYd5HEjRtC/
 EW3zXx3r7yINvg4ZqjkoEvQLwumv2ijg6i2KTq7W7ZJXeN8C87n2OiIT8aAyyqHyOAf/
 8EpEP0dKMDMOhquwFlxVmf837Hqqyi6fdljZ7z9gjhabUlLvv3JSKJwdUV/h4ip4PvjE
 xQem7a+GQJwrq67g6YO6w7IhPZzXwYHVnEeKrFGeb6WafAUA6Sentkz2FaoGRuEVG9fE
 3U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4o6wEIcbD62prZrs0B3Uwa18U9uB2CFd1FYvHXkJpI4=;
 b=ryd5omcwCxkbP942nSMSRT9axa0ZSoJ7WHpWqhUJ2+pAF4jW8TZPtB3RysCIt4676a
 pK7qCM7VLL+eWR5GaaBRAg/J8+D5irLeXD5pBIZ1cCJUsVLGHkSdLBrylX3wPDVy5V9d
 g3n4XjV1jNGg5KnOrgRAmKVGOM8Jrn32yDNJosTM0HCQOTPkzt5cqhFkddYh1bR+Hskb
 2oZFjDbnzs9l4K91vQWpa3g8V8Tmqkez/krW/muCBHi2HotopDxXnMQ/b1sM8hdM/n0w
 7mWbqrGjFwXWSdpFxoiiaox72RghUPwF6Pcn2lI18JVxdvOLnXmBJpHNi+1hrBjYxExD
 48QA==
X-Gm-Message-State: AGi0Pua7StEaEushrpCFQa1PJSOCcuCQA17qE39RiIT/+fFFYOVMbYQa
 hlJiTv9T1offEZZLPzN3FcW3iMn5IREtrPU3TCWWkw==
X-Google-Smtp-Source: APiQypIV6bi57T9+sC9kKz00MTozmyIBYvFb40Uf4Oa2eGhgvfTKWlvDOnaxq+p9psdk7HKlc4ub9+l/11w9os6q9Xo=
X-Received: by 2002:aca:3441:: with SMTP id b62mr1945019oia.146.1587653755989; 
 Thu, 23 Apr 2020 07:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <CADxL6wUGWZO0U=G7UTAebG57m6tG58hoMf_-TCC+0qReUB0G6w@mail.gmail.com>
 <20200423141112.GE1077680@redhat.com>
 <CADxL6wX-0Lt_LKT9pQMiK3Y1L0tdrF9G23dfYU=9FXgFZB-4Fw@mail.gmail.com>
In-Reply-To: <CADxL6wX-0Lt_LKT9pQMiK3Y1L0tdrF9G23dfYU=9FXgFZB-4Fw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 15:55:44 +0100
Message-ID: <CAFEAcA_cq=2pDwsGzNn0TG40sYQpgPU-iBd1prF+-JpTU56SBQ@mail.gmail.com>
Subject: Re: Need BT support in qemu for Zephyr
To: Dan Christian <dchristian@cardinalpeak.com>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 15:41, Dan Christian <dchristian@cardinalpeak.com> wrote:
> I'm new to trying to use qemu+bt (via btproxy) and haven't managed to get anything working.

As Dan notes, your command line isn't trying to use any of
QEMU's bluetooth support code. More generally, from the
point of view of the deprecation-and-deletion we were much
more interested in "I am already using this and it works for
me" reports (which we had none of) than in "in theory I might
be interested in bluetooth-emulation-in-QEMU but I'm not
actually using it" reports. Since we had none of the former (and
only one or two of the latter) our current belief is that
the code we removed was in fact broken and nobody was using
it so nobody noticed; if that's true then helping out people
in the "maybe I could use this" camp would require not just
undoing the code removal but actually trying to fix the
bugs and brokenness in it.

thanks
-- PMM


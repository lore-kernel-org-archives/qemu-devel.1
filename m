Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E77AC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 18:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB30F20840
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 18:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYHcBG53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB30F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrRJ9-0001EM-TT
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 14:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41268)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hrRIy-0000ms-Fw
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 14:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hrRIx-00040K-Jv
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 14:20:28 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hrRIx-0003zQ-EP
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 14:20:27 -0400
Received: by mail-ot1-x341.google.com with SMTP id q20so58517167otl.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2019 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UpclXlUPZEzYYqxICeZWZd2LGKN5CHZUBjXcJy6XWcM=;
 b=xYHcBG53CnUIcMv/J7qU2MY2iWAInOJiESqNsBKPZXxUTErlHa2D7szylBwx6aCwFa
 W7RudQXkaFxILQobBs20hJc7o0mm8qiP+byJ7muLnYd/mxwnlJo90o+eUszcrP/Z6PCT
 yyrHB2/49OXhBNvqWWkZi/yIFqHx1grolFccaE5gNOwvok6zfnnotdeAo3lHYz8oleF8
 YONSaYZgM7K2l8bLHFXxLChquG8ieyg1VXVBfcLsvyVkrmjEzbIP+LoetfNSR1eWuF8h
 Twh1jqn8IBIdTvsXDOWXp7P+hUWbyYxZNPxWJ//VhSiwabwNsJyZOiiv+nfixpJWyeDP
 nF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UpclXlUPZEzYYqxICeZWZd2LGKN5CHZUBjXcJy6XWcM=;
 b=GTDSnkvNm1iQJYEodX5hWthu5U9Fl9/ifpurU6k88roRB//HCARwqNXQVHlW6D1IWn
 32Y0dnyWBa3/iSWq9Nk8bD3RPkTWluqv6ISLb07EdcLbFbAbYhBKLhwKc34S0zKy2wou
 Ts/r+rgAAnlyFmIxTdL2BbbCZB4dv1EU/LV1Uce8L1fjwJcsS+PEWHtCclw3e24tVjfN
 ZGiQ4XFDETI0QHSYegF85QbyaluyZJZmUhKS7CmnKry3lS+UGKJUzxJKrdJrnp1nbeFG
 sSlhQBj/nMgR4dEe9F1kQ5CfanfhGMnz8EEIT9hvv6n4KY81BFOtw8U7LJwfkopWLwJq
 FeDQ==
X-Gm-Message-State: APjAAAWaLjF1lnGFHpmTRkvs4I3cOI//GkTPwf3drKT0JKeC1dJVMVLz
 x9n3QB129DM4vb6bV0kihRO8amiX+rof8ZMCVMm1zA==
X-Google-Smtp-Source: APXvYqx3a70oAVpMoH/6eHHHag+xsKUTgttqcB+OeRiR2EqYhO8iVJpKyZhGgse7R+d/RILoq1q2sBJhcxcCx3aw0VI=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr19849541otr.232.1564251626202; 
 Sat, 27 Jul 2019 11:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
In-Reply-To: <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jul 2019 19:20:15 +0100
Message-ID: <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 27 Jul 2019 at 13:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 27/07/19 09:16, Markus Armbruster wrote:
> > We started with a single trace-events.  That wasn't good, so we split it
> > up into one per directory.  That isn't good, so what about splitting it
> > up into one per source file?  Pass -DTRACE_HEADER='"trace-DIR-FOO.h"
> > instead of -DTRACE_HEADER='"trace-DIR.h"' when compiling DIR/FOO.c.
>
> For Make this would all work great, however not for Meson because it
> doesn't allow per-file compile flags.

Apologies for randomly parachuting into this email thread, but if
Meson doesn't support per-file compile flags then what's the plan
for handling the cases where we currently need per-file compile flags ?
(This is one of the things that I thought was quite a nice move
forward in our make infrastructure -- we now have clean syntax
for saying "these files need to be built with these warnings disabled
or these extra include paths or whatever" and also "these files
imply we're going to need to link against library X".)

thanks
-- PMM


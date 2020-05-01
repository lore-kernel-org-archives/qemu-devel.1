Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2094C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA4E2076D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3rpiNhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA4E2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUS2S-0004kz-Lg
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 05:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUS1p-0004HS-Gg
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUS1n-00047z-GW
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:32:17 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29]:45363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUS1n-00040Y-15
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:32:15 -0400
Received: by mail-oo1-xc29.google.com with SMTP id 190so590261ooa.12
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6HLzDph8HFp0Q/kIOeGFdkXmB/ZfZkFqGeC2z/Cqs4I=;
 b=w3rpiNhWVB161rmdfvcoV7CLF7TUsqMFDDrX4QHWBqBDzeFAkLKipWvybCahNjhmD0
 CC5S5eXCzF7fjTcxAk4kcZz+CMvPsJkslj80UuBSUHb4pLVogGvRNEAtSxOsYNaxfqWD
 l3BO6VZNy5esi8Td6f4BymN0HG5MBJjuV5J+SocWmoIbGHxr8S/+4n00oyAQ80I7AyJP
 1KlCYeOdeeDzaXUGlkwoQGDKCyqWongjRZ3kWTmoRGGbaJ352XQM6lYDEJu9voMH6DyK
 3DKBtkkS7Lw2C/x+fhTQzRI6LKZupyqN423YBc5tfRkqRiqZ7mr3a1ZwR/1BKBFiLqrv
 wyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6HLzDph8HFp0Q/kIOeGFdkXmB/ZfZkFqGeC2z/Cqs4I=;
 b=IxhRvLkJGtwPbtUwKgBzWCB2UFIL8Pb8LIr8cz/Z2gQf9YoqV+DIzD38PMoeu7xvTT
 bUEgsMtezRRYjCZvG6bWjlteFf8SdfmJjg0W+NoWBDSQu9zfaXl8aCia2ass34/WKyHS
 T6OJEoVzeADSbCLW5j8nqoFuUh59k6j2Y82LlnyO9a4Y2GwZRcKaVrbnOpWx/tuPtU/3
 5ruSy/3PoIL/LBwjYV+zlb0JkXmkDQrE1oikjeFesBZuDjdh5czyU3Ue0KRdUAtJSxjd
 yWBOylEms7odPG9F2yPGO/oLX6n3uLwKeGdrWwX+PHEeg0rgLnxzwghkj5pVFpJ5O2Jo
 yDJg==
X-Gm-Message-State: AGi0Pubo16Un0cPGCh0+U8kMaD7kVw9AbtGJk8k2gc4ujajSeFvI0u4H
 lL16aSDbTNfsIgkslHD6kAEHzBKthav2MePCmhyPEg==
X-Google-Smtp-Source: APiQypIFSWvl0lT2iti3LxcwQ2GWuUQlmAj7CBIY/p75jm4JGIxEJIu/Qkvonx7hm1YcpwtytbcX3FINwYyy3w+okqw=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr2999777oog.69.1588325533672; 
 Fri, 01 May 2020 02:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200501082806.205696-1-stefanha@redhat.com>
In-Reply-To: <20200501082806.205696-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 10:32:02 +0100
Message-ID: <CAFEAcA_VnBL8P4-UUgN9jGSTUCqvWpG2uaEYejjtJrEaFerRzw@mail.gmail.com>
Subject: Re: [PULL 0/4] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc29.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Bandan Das <bsd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 May 2020 at 09:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 27c94566379069fb8930bb1433dcffbf7df3203d:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2020-04-30.for-upstream' into staging (2020-04-30 16:47:23 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to cc1adc4488059ac16d4d2772a7aa7cd1323deeca:
>
>   lockable: Replace locks with lock guard macros (2020-05-01 09:19:25 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Fix the QEMU_LOCK_GUARD() macros, use them more widely, and allow the fuzzer
> target to be selected from argv[0].
>
> ----------------------------------------------------------------

Hi; this pullreq seems to include a stray change to the slirp
submodule in the "fuzz: select fuzz target using executable name"
commit. Could you fix that and resend, please?

(You might like to include a molly-guard in your pullreq
creation scripts; on my end I catch this sort of thing
when applying with a test like
if git diff master..staging | grep -q 'Subproject commit'; then
    # complain and exit unless I used an explicit command
    # line option to say I intended to include a submodule update
fi

though I haven't yet put the same test in the script I use
to send pullreqs, for some reason. I guess my workflow now
means I don't tend to accidentally commit submodule changes.)

thanks
-- PMM


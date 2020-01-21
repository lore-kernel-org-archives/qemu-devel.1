Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3569C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5D6217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXsPHAiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5D6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituFx-0006mm-21
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ituCM-0002cW-D9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ituCL-0000bo-6e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:08:06 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ituCL-0000bX-1n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:08:05 -0500
Received: by mail-oi1-x243.google.com with SMTP id 18so2607579oin.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 06:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dtq4GEHNbtHbv8UM2MbbYuRO7vvCC0elQwHfGqvU8vc=;
 b=FXsPHAiB6kBXA3ZZjRHINi4SEz1bLadGeMhspCgB8ElkLiYTGpb1M+pYUjtajQ8F3G
 2Q/Ln00oM/wVikzchUaWneWLZTZu2M7YUt2uSCNuqMYYQWIoNRBgpxBgTL5P9Dz2ZVsm
 6X+/kJRdTuH/ZIVVWX7o/BU5+byz0Rhx+3FfTeNerx3EfGN4Qic5tRuwSGyMqKCKI2+J
 P8JG95KzpK1mhMCCaEHzVgppEQ3D6g2umKOFy/IdNEqO4KlLkZ9B3USKuw8Cno0kJnI2
 /upNhayvvnX3gSgqvvfuGDlkFn6+QpEVOSqGueRBa5wJln1Gn9D3wOBMNYMzbS5IFVy7
 gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dtq4GEHNbtHbv8UM2MbbYuRO7vvCC0elQwHfGqvU8vc=;
 b=pTRlRoK3FWUxopZQzm9bxCWiR4cTgIdfoUJ5++xEM9hukXf9Peng3y7VxrjqGAyBRX
 W8R9BvJbePG/ggjas8e/YNdGEQ7b4SCJK8nV0Q+RMTxefmWVQULhwETxioe1Y8wO0/Ig
 jlBvUD0sfc0RpVw2Ru5hPUPkIdnhlxtQYNCS29m+w7htrHFFrXW0R3gP/Uc5Om5xgDbO
 q2CME2xBP7G4eM5CTx8bBTA79f3zPrsBgnZghG5u0g+GyMcSnr6J9gX7bGuhXXfTiIoy
 CSfUYq9hkUANt9jjXmmkqSN7DnpPvVtn+AAR6NUb7/GrwV7zxCTU0OG26Gma+d/LqhTN
 UORA==
X-Gm-Message-State: APjAAAWSzSAMr0ebyfu1kwRse4ai6D8Ab03PLAN/i+sMBqsFvQcNLJRe
 ZrOwJJ5s9swXIPkLT8VJybOHA5aZmHoI1LPmEvE=
X-Google-Smtp-Source: APXvYqzCpDWGyinZn3Ki+YzuHoBQW8QetOyXDLNJ9WjcI2HyzAd5nTLfJJdvy3m9ZPwV3GlmR+xOMAdgl3ba0EVYhWs=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr3135855oib.62.1579615684192;
 Tue, 21 Jan 2020 06:08:04 -0800 (PST)
MIME-Version: 1.0
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
In-Reply-To: <20200120145024.GJ345995@stefanha-x1.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 21 Jan 2020 15:07:53 +0100
Message-ID: <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, Jan 18, 2020 at 03:08:37PM +0100, Aleksandar Markovic wrote:
> > 3) The community will be given all devised performance measurement methods in the form of easily reproducible step-by-step setup and execution procedures.
>
> Tracking performance is a good idea and something that has not been done
> upstream yet.

Thanks for the interest, Stefan!

>  A few questions:
>
>  * Will benchmarks be run automatically (e.g. nightly or weekly) on
>    someone's hardware or does every TCG architecture maintainer need to
>    run them manually for themselves?

If the community wants it, definitely yes. Once the methodology is
developed, it should be straightforward to setup nightly and/or weekly
benchmarks - that could definitely include sending mails with reports
to the entire list or just individuals or subgroups. The recipient
choice is just a matter or having decent criteria about
appropriateness of information within the message (e.g. not to flood
the list with the data most people are not really interested).

For linux-user tests, they are typically very quick, and nightly tests
are quite feasible to run. On someone hardware, of course, and
consistently always on the same hardware, if possible. If it makes
sense, one could setup multiple test beds with a variety of hardware
setups.

For system mode tests, I knoe they are much more difficult to
automate, and, on top of that, there could be greater risk of
hangs/crashes Also, considering the number of machines we support,
those tests could consume much more time - perhaps even one day would
not be sufficient, if we have many machines and boot/shutdown
variants. For these reason, perhaps weekly executions would be more
appropriate for them, and, in general, given greater complexity, the
expectation from system-mode performance tests should be better kept
quite low for now.

>  * Where will the benchmark result history be stored?
>

If emailing is set up, the results could be reconstructed from emails.
But, yes, it would be better if the result history is kept somewhere
on an internet-connected file server

Yours,
Aleksandar

> Stefan


Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B876BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80676206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ua55TD2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80676206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw549-0002is-O9
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw536-0001gU-K2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:39:48 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw534-0007gb-Mq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:39:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id t4so5239065oij.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y65RhF2V5cNpl6EuruJMdTRMhPky0ICrRpc567TcmTo=;
 b=ua55TD2IDP/z4SjXLwS6mF4938Fh1TpulKKXNeUpa6WLNsJ/hAYlte62ugA/bzK8An
 0LljFV89kDOph4QtW7Qef5P+nrui9brwua5N8oI1rmLMvgeGwZM3lbBqixSI2UgJMrlk
 RhNSjkYQv/fBJyrsYBD+E2pboPIrruMDnNp9fJ1FwtnIfV4xNnPzfbzsAHZ6kQ6OPYki
 Rphk4CzxgfzUZ/VQJvl/LpqP/EoeJepc3OQtJf+/7ZVBpjBDauxvjVPOk0JAYjDHBOLd
 vVG+1g96NBL691ESkWQhTNjIRV+Oi0dLcEfAGNpj518++DwcttIqMFPR4vZ3zT2VqRT3
 o2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y65RhF2V5cNpl6EuruJMdTRMhPky0ICrRpc567TcmTo=;
 b=fWZWMtlZTJ+uChY8PijSC5TDopvtcz/TzkCLpwsa4vTU9X9ULRMXeJHXkYZtwTyO/l
 o44ypRJ4O7cwjtXqlhLG8nFUlPQ7Qdqp7lczRqKqSlDHQtrBFS+Ol0p39CVOiNA6C3Jf
 JnkVCmfFnYcar5dO3d9lUnuJgqCx1l3V/fAlKOueCYuWfoqQ1x1ub1iaHDlYI3BYf8Rd
 dEdkH9XbC9G7yLEac0ctAY+3Vo1l45ZxWbpjo9eY1XYEADZIu+6/z290e9J4AdnYy40E
 KhyLaYgVgIyriL5If/lztvizJfxbzkM7NOW4+NuAiUYBgTLaEu9ZBKRXbBhV8PcMhwfI
 IG6A==
X-Gm-Message-State: AOAM533rdeevr8y73L2h1Swf9E6/h7ApT7dset/OS1JHguFDq0hwPeVN
 rPAnZMhzVkW+1TPD41VG4hgQTa8uDYTLplRnZNKFbQ==
X-Google-Smtp-Source: ABdhPJw1bD4riNUx/a4caVwlp0e8whh6EAJGZ2hemSd60SgKRWBH89PQBqTGAIZNs/Scigo/GCB0xtVz/WXgvguJv+I=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4027494oib.163.1594910385218; 
 Thu, 16 Jul 2020 07:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxD6gQDBaj8tX0CMEj3si7qYKsM8u1km47e_-U7MC37Pg@mail.gmail.com>
 <631dad16-66cd-3f7b-90bc-969c52d29aa1@redhat.com>
 <51a660f2-2241-d27f-afd5-a02ce5bd0e73@comstyle.com>
In-Reply-To: <51a660f2-2241-d27f-afd5-a02ce5bd0e73@comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 15:39:34 +0100
Message-ID: <CAFEAcA-MEEAaAUp9Osn-A0yuEa1KToKQ2OYJRSCgwUyZ-_iAkA@mail.gmail.com>
Subject: Re: [PATCH] util: qemu_get_thread_id for OpenBSD
To: Brad Smith <brad@comstyle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 08:41, Brad Smith <brad@comstyle.com> wrote:
>
> On 7/15/2020 12:54 AM, Thomas Huth wrote:
> > On 14/07/2020 23.26, David CARLIER wrote:
> >>  From 9c7f54c67d40fae0174ba795fbaad829cd59c264 Mon Sep 17 00:00:00 2001
> >> From: David Carlier <devnexen@gmail.com>
> >> Date: Tue, 14 Jul 2020 23:23:55 +0100
> >> Subject: [PATCH] util: qemu_get_thread_id implementation for OpenBSD.
> >>
> >> ussage of getthrid syscall.
> >>
> >> Signed-off-by: David Carlier <devnexen@gmail.com>
> >> ---
> >>   util/oslib-posix.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> >> index 72907d4d7f..b4f7de83c8 100644
> >> --- a/util/oslib-posix.c
> >> +++ b/util/oslib-posix.c
> >> @@ -100,6 +100,8 @@ int qemu_get_thread_id(void)
> >>       return (int)tid;
> >>   #elif defined(__NetBSD__)
> >>       return _lwp_self();
> >> +#elif defined(__OpenBSD__)
> >> +    return getthrid();
> >>   #else
> >>       return getpid();
> >>   #endif
> >>
> >   Brad,
> >
> > since you're listed as OpenBSD maintainer, could you please review above
> > patch?
>
> Thank you David and Thomas.
>
> Reviewed-by: Brad Smith <brad@comstyle.com>

Thanks for the review. Since this is a one-liner I'll take it into
the tree via target-arm.next just for convenience.

Side note: the only things we use this value for are:
 (1) it appears in the output of the QMP monitor's query-cpus and
query-iothreads commands, so that a management layer app can
use whatever the host OS provides for setting host CPU
affinity to tie a particular guest vCPU thread to a host CPU.
 (2) the log tracing backend uses it in the output just as a
way to allow tracing from different threads to be distinguished

We should really write a doc comment explaining that. Maybe
I'll put a patch together.

thanks
-- PMM


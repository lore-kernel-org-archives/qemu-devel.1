Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3449EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29D524900
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29D524900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSM1Q-0005Tw-M7
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSLzU-0004WF-TN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:13:28 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSLzS-00088W-N3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:13:28 -0400
Received: by mail-il1-f194.google.com with SMTP id l16so120048ilj.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c8sbFAoVKGdbgaQXLpT6TJwGNE2XeXJsa9RBv20hgsE=;
 b=j5MxoLZCmRAjZx7/7M2rrtKGqd9CGLJDRnFjB9TH7EYWw/CXDlaTLu/tVfkXpdD9h2
 uoMHON6WjjkUw4HbJgmNiGB7D2IWW7Xosd8JJtjw+ZYr5siOBrR1JA6e1xzZSijS0VOo
 xcQlIq8zXGeSTxBDTbt083wVqQ7JwjoU7D3JHfGS6txoRfG9bKB+SYO5UOJBpsVinIhf
 S6dUkfI+KU476Ohv5JWMS8lf2rqn2sDX4iJMJkNwHOtK5uVgMXXuTJ5cuQ5F19FcHNNb
 RenL9Dk6qPDPBVW9m+PgXhpnAIxkDNoUIcA3u7hhj+14rjlpYrzFOr5nsAEXzWE4OAkk
 wGXg==
X-Gm-Message-State: AOAM532o9vhQmIBhNtcEt8mhF4gsq4B3ubwpp+GeM5G0h1yCCdjBF3IQ
 lNXfSFZT8/QEHVkEXcYytIOovD69g3A=
X-Google-Smtp-Source: ABdhPJwIOpPqaOSbK36HJI8yKBJuifXQmljT6n0OI5F1+M1mAtcJixECBbGfbCHyrKDBiWZkiUWBlQ==
X-Received: by 2002:a92:dc8f:: with SMTP id c15mr317903iln.293.1602602004750; 
 Tue, 13 Oct 2020 08:13:24 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com.
 [209.85.166.51])
 by smtp.gmail.com with ESMTPSA id c9sm123932iob.14.2020.10.13.08.13.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 08:13:24 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id d20so22987049iop.10
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:13:24 -0700 (PDT)
X-Received: by 2002:a5d:9243:: with SMTP id e3mr20193586iol.193.1602602004018; 
 Tue, 13 Oct 2020 08:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-10-j@getutm.app>
 <a132bc5b-9029-db47-1f38-0dec75029e10@redhat.com>
 <CAFEAcA9D+1g_6gxPLHwgVHbMwW7e=Ana-fM-fJa+jDDSm0gA8g@mail.gmail.com>
In-Reply-To: <CAFEAcA9D+1g_6gxPLHwgVHbMwW7e=Ana-fM-fJa+jDDSm0gA8g@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 13 Oct 2020 08:13:13 -0700
X-Gmail-Original-Message-ID: <CA+E+eSC6zD3gopRYRkfwZ0ZpQQPvKNegaEouT4c5-aCSnb8L_w@mail.gmail.com>
Message-ID: <CA+E+eSC6zD3gopRYRkfwZ0ZpQQPvKNegaEouT4c5-aCSnb8L_w@mail.gmail.com>
Subject: Re: [PATCH 09/10] tcg: support JIT on Apple Silicon
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.194; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:13:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Joelle van Dyne <j@getutm.app>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The APIs link correctly but are NOPs on Intel machines. I think full
testing would require Apple Silicon or emulation. Is there precedent
for any other platform/feature that requires hardware specific
features?

-j

On Tue, Oct 13, 2020 at 7:09 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 13 Oct 2020 at 14:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 13/10/20 01:29, Joelle van Dyne wrote:
> > > From: osy <osy86@users.noreply.github.com>
> > >
> > > https://developer.apple.com/documentation/apple_silicon/porting_just-in-time_compilers_to_apple_silicon
> > >
> > > For < iOS 14, reverse engineered functions from libsystem_pthread.dylib is
> > > implemented to handle APRR supported SoCs.
> > >
> > > The following rules apply for JIT write protect:
> > >   * JIT write-protect is enabled before tcg_qemu_tb_exec()
> > >   * JIT write-protect is disabled after tcg_qemu_tb_exec() returns
> > >   * JIT write-protect is disabled inside do_tb_phys_invalidate() but if it
> > >     is called inside of tcg_qemu_tb_exec() then write-protect will be
> > >     enabled again before returning.
> > >   * JIT write-protect is disabled by cpu_loop_exit() for interrupt handling.
> > >   * JIT write-protect is disabled everywhere else.
> > >
> > > Signed-off-by: Joelle van Dyne <j@getutm.app>
> >
> > Can this be emulated somehow on other platforms (such as Linux) so that
> > it does not bitrot?
>
> Some of it is write^execute, which we could test via OpenBSD
> I think if we updated our VM image not to mount the disk
> with that protection disabled. Having "generically support
> w^x" be separate from "iOS specifics" might be useful.
>
> The apple.com webpage linked above suggests also that we could
> test some at least of these APIs on our OSX builds if we
> enable the "hardened runtime" on x86 (though that might also
> enable other stuff we don't want to deal with? no idea)
>
> thanks
> -- PMM


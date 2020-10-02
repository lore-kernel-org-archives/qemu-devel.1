Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A834720758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uq3Ce+Ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A834720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQ2G-0001Ux-MJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOQ1c-00012n-HY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:43:24 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:33422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOQ1a-0002Vb-I2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:43:24 -0400
Received: by mail-ej1-x641.google.com with SMTP id c22so1965530ejx.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nVKm76r8TfyFonq8XNi7+ng1nB8PGpUxxqmnv3nP/AI=;
 b=uq3Ce+HocUqLGZ1SS9f3+lQEPCgzOv9a0ckVzhxtryiA0LjDLmAaeOGhZ6sKkpyJ70
 c+oZ3hEaDvE/ZiineQpSLM1t7Gd8aLV3rh/WavW1WzI+zz5gIcCvLn6yWHpoC2ndwiXO
 IGWfHNSuu9ZC/0/gJrc8KshkXS3du7Tem1NOi2U0CRfMChnzmhksAD/4G/T6BENR1OiW
 s2JG0EYFglC/hSwJEs8cXSvMtPrjROyrmEUYf108fj4jzzqwPujt+v3pjyEurmmxKfmO
 A69xE5BJUpnuhiqwITp4wQlKWBhGT6U+UT9B4AWr9Ol3HeoI4C/P8osrPJRVau+zNcCe
 FiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nVKm76r8TfyFonq8XNi7+ng1nB8PGpUxxqmnv3nP/AI=;
 b=uCgK8plimcDdpj+tcqjoBPPqFnIY5HLIIwPSSLal4Igqt5g/FOVrHYy2ZIYqrB2tfH
 ux8Vd3IcElQV0bPlsAU+wbmaEMbmTbwFMP1pitmFiBNRMEfIaEbLgRIaozEmyOx+kP8D
 2F3iulfW3Gf/hn7IwW1IFZsIh3Jx+5EM2/wJw8DQdx43Me64vLCrj4a8IX43m1zLP30K
 v28DWiOViMZz+mdYHifP362+zyzGeGK2j1/lgLnacgBrcnrUfLnKabOV+oyU0fJSL91u
 kK4i3bor3VsB8RUl84liCIPTNML2dXPkPV91nzvhp3EECY9FU3x8Ok16caP5xycrBRz9
 oHyQ==
X-Gm-Message-State: AOAM530BBUg/jDvMb8bC2ZyOjJNldT/zcooLeJGbfftfpTLxn3IlihJx
 KIn+dlxjXOCcggGuwrIa148bWyPSTkif3PiuNvJQug==
X-Google-Smtp-Source: ABdhPJwSOIKioGv5bgYXJlOYFx4SCXG2hnPOeB5WVcQu5lDFVZTR23qeKG5lSp4MSptYWpzGcYOhbmz34V2fHHHEUqc=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr3585500ejk.250.1601664200846; 
 Fri, 02 Oct 2020 11:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
 <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
 <20201002183455.GF7303@habkost.net>
In-Reply-To: <20201002183455.GF7303@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 19:43:09 +0100
Message-ID: <CAFEAcA_KXvADFm7uQX1a4peofK_On3DaFH2ZCUtWteaiABM-yA@mail.gmail.com>
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 19:35, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Dec 02, 2019 at 06:01:16PM +0000, Peter Maydell wrote:
> > On Fri, 29 Nov 2019 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > Surprisingly, QEMU does have a pretty consistent doc comment style and
> > > it is not very different from the Linux kernel's.  Of the documentation
> > > "sigils", only "#" separates the QEMU doc comment style from Linux's,
> > > and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
> > > accel/tcg/translate-all.c), so it's clear that the two standards are
> > > different in this respect.  In addition, our structs are typedefed and
> > > recognized by CamelCase names.
> > >
> > > Adjust kernel-doc's parser for these two aspects of the QEMU coding
> > > standards.  The patch has been valid, with hardly any change, for over
> > > two years, so it should not be an issue to keep kernel-doc in sync with
> > > the Linux copy.
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [...]
> > > @@ -1906,7 +1914,9 @@ sub process_name($$) {
> > >             ++$warnings;
> > >         }
> > >
> > > -       if ($identifier =~ m/^struct\b/) {
> > > +       if ($identifier =~ m/^[A-Z]/) {
> > > +           $decl_type = 'type name';
> > > +       } elsif ($identifier =~ m/^struct\b/) {
> > >             $decl_type = 'struct';
> > >         } elsif ($identifier =~ m/^union\b/) {
> > >             $decl_type = 'union';
> >
> > The match for 'type name' is pretty wide but I guess
> > we can find out through experience if we need to narrow it.
>
> This change seems to make it impossible to document any macros
> with uppercase names.
>
> (for example, most of the macros in object.h are not included in
> the generated docs)
>
> What exactly is the purpose of the hunk above?

It's so that QEMU's bare type names like MemoryRegionSection get
recognized as being types. Kernel naming style always
prefers to say "struct MemoryRegionSection" where we use the
typedef and say "MemoryRegionSection", which is why the upstream
kernel-doc doesn't care about this. IIRC, without it, doc comments
which reference a type like '#TypeName' like:

     * @log_sync:
     *
     * Called by memory_region_snapshot_and_clear_dirty() and
     * memory_global_dirty_log_sync(), before accessing QEMU's "official"
     * copy of the dirty memory bitmap for a #MemoryRegionSection.
     *

don't correctly render the typename into a link to the
struct definition.

thanks
-- PMM


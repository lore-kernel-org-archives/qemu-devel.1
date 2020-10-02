Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEFCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDAB206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH4vOluy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDAB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLum-0008Ka-2S
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOLtC-00067I-60
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:18:26 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOLt8-0001Y3-UH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:18:25 -0400
Received: by mail-ed1-x543.google.com with SMTP id g4so1831395edk.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L86NUpzLXQbyrrmwSkAej8BStCZ6EmGXDeVakcNMRgI=;
 b=MH4vOluyRBV5ThcPuTSJoFkhtw00T4GZGEu8pi1OVR5swblOW4IFrwfQUvlck+UnY4
 T1TV3ZdW0J5XaGzwa/E31okLDVEqLegQoJy5qHgpCDYcpAdACl1Lzm+H/yFadodLpRnu
 1LuJL989LibGWPpGBnxHSXUVtF6mXx74mcX6rt6L0vfZCpGuufpS0ZwK7O3xW0Hx2WMM
 skYrBZh2SerNG1AzH2DAxdW/YR5MF6OKhJAs8zPBgA+vHIUJLznFmyupLfbiKlwMg+ue
 a54BRHe/5VyWmrb2sPFnUol1XMkQA9tF9Idk7hS4m7H/8RCpA8oE70f7pIW8lVS8kw6a
 wpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L86NUpzLXQbyrrmwSkAej8BStCZ6EmGXDeVakcNMRgI=;
 b=Pcvzk2xw8b7fCL0qSB57oOp9hQwCEcaWBa62mb6nJzSV92qn536htkoZ4FeGxcK2YY
 mn3xG5AQRI76zIy/aoNR4mKQJSp++qHXwlQPd/pBxWWkFvXIFaf96eWRhAQB6Eo9I4sq
 5DBxthR9soPFFcF5X8/Rr2CFKJo1rn/vcRvA+UzZRuHmTNuF6nysBpJcL/rTDqyGgJYB
 LMTirN12erPt+6hKX5Ul3qNAtuVwahYci8nfhnG0iv0kHkcFj1GftksfshlBOC8mFX5h
 S/rfEsUTYnGi8pNpTftE/4FJx9AFWh5kUvefq7lEPeYRiGAN9LVdhJIGDtAVOFsEy6xI
 NWFQ==
X-Gm-Message-State: AOAM531v2/lckStwVl2wukFoaP1pNaN92KnFWOu8DCl3b/jZX+t2kU/U
 bcA8KccdrgIk18/g96T8459Gvm4cGOgf5cqtRGjMIiK2dBV4sQ==
X-Google-Smtp-Source: ABdhPJwwywcM42gKiJwraH7zsH051jxrfJ63cuQ97Dmv0JT03mTAVGPAVZ5HbXgT2w20jko6GCjkZPm4vlMWliREp2A=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr2638669edb.36.1601648295897; 
 Fri, 02 Oct 2020 07:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <405d680b-d088-58ff-9364-fcfcea1345dc@redhat.com>
In-Reply-To: <405d680b-d088-58ff-9364-fcfcea1345dc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 15:18:04 +0100
Message-ID: <CAFEAcA9vr+HKe3HnNECo8=pP7KcdjZXr1cJqg8HTbYKbaNDY3A@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 15:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/10/20 15:09, Peter Maydell wrote:
> > This duplicates the information that the thing that depends
> > on libudev is mpath. Can we put this in a wrapper around
> > dependency() so that we could just say something like
> >   libudev = compile_checked_dependency('libudev',
> >                        required: get_option('mpath').enabled(),
> >                        static: enable_static)
> >
> > for those dependencies that want to do the "does this compile"
> > check ?
>
> No, there's no functions at all.  You can of course put the detection and
> test in a single loop:
>
>   dependencies = {}
>   ...
>   if targetos == 'linux' and (have_system or have_tools)
>     dependencies += {'libudev': 'mpath'}
>   endif
>   ...
>   skeleton = 'int main(void) { return 0; }'
>   foreach var, option: dependencies
>     dep = dependency(var,
>                      required: get_option(option).enabled(),
>                      static: enable_static)
>     if dep.found() and enable_static and not cc.links(skeleton, dependencies: get_variable(var))
>       if get_option(option).enabled()
>           error('Cannot link with @0@'.format(var))
>         else
>           warning('Cannot link with @0@, disabling'.format(skeleton))
>           set_variable(var, not_found)
>         endif
>       endif
>     endif
>   endforeach

That is a lot uglier. I'm really getting fed up with Meson's
persistent "no, you can't do that" attitude :-(

thanks
-- PMM


Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1437C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E42D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJOVVkJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E42D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKqE-0006o2-AI
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKoy-0005wr-9V
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:10:00 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKow-0002B4-Aj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:09:59 -0400
Received: by mail-ej1-x644.google.com with SMTP id u21so1909928eja.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p+ce24c9kHkY2MpAAsAEW0VlaLMzCIvRf2D2QJkCfII=;
 b=jJOVVkJH7LBjbwl6Vj6G63GeYFqkPBn9dsxAWivflOOLzKqFC7ijBOCXYkwQ3fHixf
 2y8y+SdHTEUOGfYZ9zX02oiQ8J20lLJHJD2fLWHydzkXaDvNdxQG+Lfr9+RFXDTw/QsQ
 X6khnb4Jpvd/sfAhdbZWCWN3TO3cyI5wldh9lBpZp3+LFxaNMs3awezIaLWJhtEZehM4
 eu41epc6fQ7Kmz3TtxvX75deM+4wrfE+2x2qAaSQtBI5TBOGq8yXAbvipyWHRF4AZUEM
 oFj00PHKlJUpmV+XPQ7IEwbkEbDint8LpHPpHuEdOaWRlDZYfTC/N4Smt4tPx8kWgU5/
 E/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p+ce24c9kHkY2MpAAsAEW0VlaLMzCIvRf2D2QJkCfII=;
 b=Roa3iibSd0uONQ4Hlj22o/E7Upy+vkgtWG4x8FYrEpETC4IY0U5zhn6y9XhEP8wdM9
 L6dGaHjZkcjARjgcfv6icNhe6iyiEFThtiLE8Nm9MmbN16UnE4MIuR0W8J/Hrx2ZhBxY
 Bg30ys8sS5/oDzlrCLLlz1MzLRcxSy1mF5oyLxz8ws4URk93ylc2XWQknl5zuymr8zc9
 0h/i6Y4EyI/GNhSngZwI1TrZkIunbGjtJnZ+m+H/2GWtfcoZ7f4Or4dBRYgN95dGML9r
 gCpNjbINfJUnzZ59xZ2gVwGYk9jB6lnTm1+i2KoW5fXl7PMH4i4rmus6d7smldhdYTip
 DQcQ==
X-Gm-Message-State: AOAM533IH/geeI6kb3eVZLyr7TtqNPgqKeAfFuhysA/f2M1fY7XphvJ1
 qhrEBX8EcPQDZzxOKKim9e+Yereh8eTKAadQfYqykw==
X-Google-Smtp-Source: ABdhPJydFJPIyoLDA4sHpwZYyQ3XXugP9Xdnm78z2N7+ceqhs9BnT70ggNt4MsJFHzDOktiAolQz5WhAHZJ36o+hHBc=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr2143718ejb.482.1601644181795; 
 Fri, 02 Oct 2020 06:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
In-Reply-To: <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 14:09:30 +0100
Message-ID: <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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

On Fri, 2 Oct 2020 at 14:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/10/20 14:35, Peter Maydell wrote:
> >
> > It would be better to do the "see if a static library is present"
> > test. This isn't too hard to do in configure (compare that
> > six line fix to the detection of libgio). Hopefully it is
> > not too hard to do in meson ?
>
> Yes, something like:
>
> if enable_static
>   skeleton = 'int main(void) { return 0; }'
>   if not cc.links(skeleton, dependencies: libudev)
>     if get_option('mpath').enabled()
>         error('Cannot link with libudev')
>       else
>         warning('Cannot link with libudev, disabling')
>         libudev = not_found
>       endif
>     endif
>   endif
> endif

This duplicates the information that the thing that depends
on libudev is mpath. Can we put this in a wrapper around
dependency() so that we could just say something like
  libudev = compile_checked_dependency('libudev',
                       required: get_option('mpath').enabled(),
                       static: enable_static)

for those dependencies that want to do the "does this compile"
check ?

thanks
-- PMM


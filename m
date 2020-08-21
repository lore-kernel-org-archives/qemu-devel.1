Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F3820656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z624dX10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F3820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97Rx-0005PT-NL
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k97Qr-0004YC-B7
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:50:14 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:46795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k97Qp-0001zo-3v
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:50:12 -0400
Received: by mail-ej1-x635.google.com with SMTP id d11so2136654ejt.13
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=2idNJ5PAVGixfFsscDzSmFwpwPmPNc8GVJD2qT7sHnQ=;
 b=Z624dX1019N1RDb+M0vNFe5+QdhqxGYF8rEjlFWxRnePHt0Q0xJ8hL9IbvVNWjZ/NQ
 IOT9gBxYmtqvdbM52JS7PKR4k7eUtAVbfguX9y8omWz39pCF3BWyg5daqG4B0e4i5dCL
 6BDy8LD6ZsXVJaMbLEuRwasci4fr7ymKBqxkyeuO47C+1l1PvGftch5Dqo6Skoo7+vJO
 oWnkw9ksYTI4/VYNNSrTPBipoWgnhzkadO223jPKw8jAdYt3YEmBttni5hZ9eGunat3S
 Ko6haf2DHF7wuEvjcLFsKP5XlAcIJKkHHsMZ7qwCcvH3qq+Ema5h6zl8fnnhu6NOSjG8
 /G/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=2idNJ5PAVGixfFsscDzSmFwpwPmPNc8GVJD2qT7sHnQ=;
 b=GI3988rQEQVIlQPuiU4PEnHemBai1+UDrnLUhfBloQ0j1tK+e7z0WqInY2F1ojPMrV
 Maj23SiXfm/tziQnwJKsJNraHQSq9OxSkrh1S+bCbExP4SFKeBvs+nWiJvig/bMAiEWp
 AMMapaRNy6i9OmrW4J5fZEJ0wYOWy1C1phsHwD7RLwkYEOmdDBqsxAFQPjAy+FY5ONM/
 I3RxdlgrNkqjRJsjXKgK3XWxs0CGXleDo796yoW6M2Of+1MEH15Vc+J8ruxfh7doAGXF
 KHSVR/YQ/UsxwemoRXJ2g39u6HwhhZKwcazq43x+GnmUJ3f6NjXwnlmbtUM68SOpYKnD
 LzAA==
X-Gm-Message-State: AOAM5338m/QIa5FpEfBXgSYYgvvxTODkEilU7WCX5eilZiHEljUXVVD3
 XB1/aCGlJELzcOCud2s5Mhh7kGFtaAFUwU6/35bSnfwLgdfZU+dG
X-Google-Smtp-Source: ABdhPJwDjO6FdOVpFYy3ItSiH8/1YCFIKfmLlUooKuMTMcnPVxX2QnAPVCFhJDHiOmNBviZ87YUB5mia1AYV6K+x3iU=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr3171113ejn.56.1598017807645; 
 Fri, 21 Aug 2020 06:50:07 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 14:49:56 +0100
Message-ID: <CAFEAcA-87BcmoPjY9BCodx9+m6QmhfikHv5sLVJ8w20cszDvDA@mail.gmail.com>
Subject: ANNOUNCE: build system conversion to Meson has landed
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; we've just merged Paolo's patchset that converts the build system
to use Meson. This should mostly be fairly seamless for the average
developer (we hope) but there are a few things to be aware of:

 * you probably want to do a distclean or otherwise do a clean build
   when you first update your git tree to a version of master with Meson
   (especially if you do in-tree builds)
 * out-of-tree builds should continue to work basically normally
 * we have retained compatibility for an "in-tree build" workflow where
   you run configure/make in the source tree, but this is now implemented
   by having configure create a build tree for you under-the-hood
   (but do consider switching to just doing out-of-tree builds)
 * you will need at least GNU Make 3.82 (everybody probably has this
   already unless you're on OSX, in which case install a make from
   homebrew or similar as the Apple-supplied system make is too old)
 * you need the Python 'setuptools' installed
 * we provide meson itself as a submodule, so you don't need to install
   that yourself
 * if you have patches in flight that made build-system related changes
   (eg adding new files) then you'll probably need to update them to
   work with meson; fingers crossed this should be straightforward
 * I will continue to work through the outstanding pullreqs on the
   list, but probably a bunch of them conflict with the meson switchover
   and submaintainers will need to respin them. Sorry about that.
   (I'll work through them and send out the usual "please fix" emails,
   but feel free to actively re-spin before I get to your pullreq if
   you know it's going to need work.)

https://wiki.qemu.org/Features/Meson/Next has a summary of changes
and is worth a quick scan through.

We've tested this as best as we could, but there are probably going
to be a few teething troubles -- please let us know if something
seems to be broken.

thanks
-- PMM


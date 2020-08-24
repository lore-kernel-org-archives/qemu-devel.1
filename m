Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D342078A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faEM13ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D342078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAErh-00007J-US
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAEqx-00081h-2z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:57:47 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAEqv-0000Sn-8x
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:57:46 -0400
Received: by mail-ej1-x642.google.com with SMTP id oz20so7629570ejb.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VmAkoT29ZnWev/xj9EW0V9grUUOdGXeFOk1b8rqmIbU=;
 b=faEM13axFSi0iF+D1m+3RRfHC0vsdq89Y4HjKKrf75BaoOqsbesiD7VwVuwUdrhoiG
 y8nre1EpDuYzYK87m8eI7hPSd1XTmXFd3mfe2U/M6Fki7ARvpBhUHQBbsBtiDQ+Slf2A
 uS7NC4FCmucUA1hxV1YuY8t+pPryj+4JWez9DgQCPOlbtDeKrIauMLvk7KSv2kvkLpp+
 o5/T+rCScW1vRg13s9LSN+mrDTdLf2nDTfZ+UrPYRiXcWCC5FexUiDseDiijnLvs9iHS
 CY3nhHXLVjnRxupm5PNlox8yi0UBYZMg6h/7fcPma+yo7holDOPlgoUorXAznYIrPpuA
 /uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VmAkoT29ZnWev/xj9EW0V9grUUOdGXeFOk1b8rqmIbU=;
 b=pllIJ3dVyIlDV9glefqQonjVfkPD+iCnhJS5kTERmQJeXs0bZRpp+CYpSbdlQJpOJi
 CNleH9Vyn5hJLpkI0rAeuGVpiv7peBI42WN5uW7MdJEUQzJjC3Nu0Eb7SFrozqZXi62p
 l/+ZcpKbpp3aP5SPrBvzA5luhteX6KGBTzUh8g5huXPQy6hyuD5FK/3gnnWQ7XEqWZmt
 v4x5X2IxMVEnmut/QUcqZF12fQmMNBmfbfLBymrT2IGkvzMXsEz/ggivNhAzVCSABZ+F
 xIrHUV86t8p+AETrER3GMCiOOWMTUOfDM6kpvobUs2NWPXAu1eCC/cLNCcoehAEoEqVm
 IpEg==
X-Gm-Message-State: AOAM5302BqEShmYPdQ+IPW04rDxm6449dQY8bF32AY4PwQc8XVGwH3YH
 L/xOcq+2/HUj2n6GrDUCPe9Az7HFxPBC3zQDrRR3vw==
X-Google-Smtp-Source: ABdhPJwNtbzBK+W91HChMCwAwDeBtCZ4eBz/x1eLKcHsmQ58LAqHMNbOS4vVUyEo1+pKGoS4BXnCMRpY8KjILrGMkIQ=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr6019424ejr.250.1598284663010; 
 Mon, 24 Aug 2020 08:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-4-r.bolshakov@yadro.com>
 <051b2296-f656-9488-f66a-1e74fdd53dc7@redhat.com>
In-Reply-To: <051b2296-f656-9488-f66a-1e74fdd53dc7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:57:31 +0100
Message-ID: <CAFEAcA_zB0quJkmgT_rEPzZ7knVB4WGkxzUSM7w0WSGqiHF1og@mail.gmail.com>
Subject: Re: [PATCH 3/4] configure: Prefer gmake on darwin
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 15:51, Eric Blake <eblake@redhat.com> wrote:
>
> On 8/22/20 4:21 PM, Roman Bolshakov wrote:
> > New meson/make build requires GNU make 3.82+ but macOS ships 3.81 even
> > on Big Sur while homebrew provides GNU make 4.3 as 'gmake' in $PATH.
>
> Does this line up with our development policies on supported platforms?
> Should we be fixing the creation of Makefile.ninja to avoid constructs
> not understood by older GNU make, if that is what is shipped out of the
> box on MacOS as one of our supported platforms?  Or is MacOS on the
> fringe for what counts as supported, where we are okay mandating that
> users must install a separate newer GNU make than what comes by default?

If it's easy to add back support for make 3.81 that would be the
nicest thing, I think. But we already require the user to install
a non-system python, for instance, so asking them to also install
make from homebrew isn't a completely new thing. (The only awkward
thing is that homebrew doesn't actually put the new make on the
path as 'make', only as 'gmake', so you have to then manually
fiddle the PATH.) At some point requiring some tools from homebrew
or similar for QEMU compilation is just inevitable given
Apple's apparent policy of never moving the system versions of
tools beyond the last GPLv2 version.

thanks
-- PMM


Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE1C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4054A206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwnZWNN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4054A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCoz2-0002c8-CE
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCor3-0007Kf-Q7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:48:33 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kCor2-0008Cd-3w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:48:33 -0400
Received: by mail-ej1-x643.google.com with SMTP id bo3so9853925ejb.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KMM8B5nCz8rJffiTsoqa45cC0edT9hEdyaTvtbi8R7Q=;
 b=uwnZWNN3Fqlmkgl603yg5Lfy4bbHjBFSub71NMWL/HRj/aSRI+ZLIam7sv8BHPRxqa
 dQZOCGsuwI01kZQe+ZYTeqgModOPIi+wmJdwJ3E5ZyvOkipxCukvOp+1XC/q68lB40R8
 UnxoUbxCLVMpyQm9xO/rH66kbysZQ/jEnFFnttIKIQSu7bzPjyvTUD5SI/HJBQJjQctL
 +K2rjnXFtbpp+yCmloNwCkzZfyB5usrTkd8DQsrcplJPcsfyUzAabyEl56nfskWeTEYv
 AmSO/GZvz8dltv56D82f/zsGKgSX2AoUFOekKqOOZAKaVkqhcSO10ycRdLeXHClRHY+L
 oCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KMM8B5nCz8rJffiTsoqa45cC0edT9hEdyaTvtbi8R7Q=;
 b=BrDd8EwtbMY1M7S53iO8X/5pWujkZBTRvLBlTY+IdohYpHnsytnruGrwPkvg0FK40E
 Cm37G7dcShpZWdpsFzPuOtufgD5hmVTOPYGJmPtdOdxQAAbhwAWNIeD++2uCrUSqcgRc
 0o5qzVcozJ9P5UMMIEMVsYTKHzlcofe4C/tIh2zxWIi2UlvHH4/t9UjLVSrd4QVmmfAa
 S1z7yYcHWwfTlHIZ80eQj9G/aU+lf3Uk1gvUyCZYSNcKsczJS6So8Qjhf4f+sp9/NQdE
 EfnqXOrju5kCgtGmxuLsS8GUhpy+gHOL6nSIPYPEDrePKlTxLbKd0+pEvcrHZuC/nXH4
 KGtQ==
X-Gm-Message-State: AOAM533ilPEybMNVth78NVvywT35mcH8VxwYh0MqvPb33m3YeufuEJV1
 cottD9olSJC7ySxmlAIu4fGfzp2r/ozFgAoZH4DyBA==
X-Google-Smtp-Source: ABdhPJz9iYmuiuCz8HyVlk8ngTBLear2KZz6959firvpsymU99RYBL/+F6dogDjCL512vEfCUCFkCEre5qZhjWEy45w=
X-Received: by 2002:a17:907:728e:: with SMTP id
 dt14mr2287323ejc.4.1598899710687; 
 Mon, 31 Aug 2020 11:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-53-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-53-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Aug 2020 19:48:19 +0100
Message-ID: <CAFEAcA8=a8ix8s1dCne6q7uqHTk5oindhCiCtVdW0n94JKL1Sw@mail.gmail.com>
Subject: Re: [PATCH v3 52/74] rx: Rename QOM type check macros
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 20:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Currently we have a RXCPU typedef and a RXCPU type checking
> macro, but OBJECT_DECLARE* would transform the RXCPU macro into a
> function, and the function name would conflict with the typedef
> name.
>
> Rename the RXCPU* QOM type check macros to RX_CPU*, so we will
> avoid the conflict and make the macro names consistent with the
> TYPE_RX_CPU constant name.
>
> This will make future conversion to OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


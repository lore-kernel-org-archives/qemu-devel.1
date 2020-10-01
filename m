Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91FDC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32869208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOxQ4jWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32869208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwe9-0005mT-4t
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNwdb-0005Ma-1J
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:20:39 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:43875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNwdZ-0007UN-At
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:20:38 -0400
Received: by mail-ej1-x634.google.com with SMTP id md26so1807289ejb.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BKANgaEysEUHm3rif/40UdyyetmJoPpf+s4tJoj+JfQ=;
 b=FOxQ4jWGncyeaVjx0z3uk2Ds/hda1mLtioX+VtS9Vv8fV3rKhA3GLsGPWQS/yc+BMy
 Z/rDHtlkB+KNr5lFfYo7rs+LIO1EyXAL9o3QqnHt8QvGwKFSbH/Ce3f2vmMxU55YhTuI
 F3F5xfYA5kLXolgQ5q5a+ziIn5zwrgb+UAhneh7dJ3AQEuUB7vER7eKVVEgY5OcomlIr
 6k9ca/olejt2ifmswF22L244gmFWmwEgllfGSNXY9y8jtsXNrtrErExMMLd3bY7lmAsF
 cgBUOxhflVYQnwpzrqJKxDUTYEq0/Xh0jIGn47EpLgIRG3+InG3ZLFHWnAxxlcx6HSO1
 Qj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BKANgaEysEUHm3rif/40UdyyetmJoPpf+s4tJoj+JfQ=;
 b=fV0oWHwX0vGa95loeQm2N0FbW1QdsrWgE1b+LV0rYG1SXeH2+GKmdMJx5bEF6G3Iyk
 oE2Kvph4OKLr8KA6iX/Ug5ySB2HITTGo84yLYWJX0Y++xwVr5ya8XAUdoG02sZoBP+Zk
 GgYZitpbFwDeLESmCZx2I+ieBf8NQawKiKtvhSrL2Ah2izWRQ7LoSP8O2Z3I4W1nSKCH
 4kA3aUECDpQdd1T8SpUipVRh5WZqME29jlYfoI6XYBgOQU/xv/41qgJPAxUW70/OpAwC
 oD4whMaFsT/HmuuILDBjMt6WmEtZpd9g+dL2w/L5eK4GaKBTt0ggoPEXF8OmeGkGJQgf
 xLlA==
X-Gm-Message-State: AOAM531vzhaVL8tfv93CEuA1HOV3WYUlwxebunp+6lExDAW/Qu2/z1uE
 sUhadwpZXfqOMqrE+G2N/QlLI7UURYn/Klrh5QC6FA==
X-Google-Smtp-Source: ABdhPJyDZqPHyZlIUCrDdxNsmmXWmoD/tgd0zaAwVNUbD5Pl7Md2o1zePeV411ROHcksGXFOQ4rjaNyrXErdHRPwY2c=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr756461ejk.250.1601551235428; 
 Thu, 01 Oct 2020 04:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <87k0wa1bf8.fsf@dusky.pond.sub.org>
In-Reply-To: <87k0wa1bf8.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 12:20:24 +0100
Message-ID: <CAFEAcA9CNLdxAwq9ya5U_rUV2hdsHWwtwsgNws0+aUjDsAEwYw@mail.gmail.com>
Subject: Re: Use of "?" for help has been deprecated for 8 years,
 can we drop it?
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 11:35, Markus Armbruster <armbru@redhat.com> wrote:
>
> We deprecated "?" more than eight years ago.  We didn't have a
> deprecation process back then, but we did purge "?" from the
> documentation and from help texts.  Can we finally drop it?

Is it really that terrible a burden to support having an
alias for 'help' ?

thanks
-- PMM


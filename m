Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F293C206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgfxKDDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F293C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzDd-00082S-20
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyzCd-0007Os-HX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:01:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyzCa-00015s-9w
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:01:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id l27so34890oti.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y7MA/ZS0ffk6/m2thG9xj+T+SaVK+SUiEficw+qkVMY=;
 b=CgfxKDDpO9c6g87JAn2YHFj1juLh6kglIidBQsn7U7PNgqQUoH5ujzfFzLRzpKVBQ8
 2PF/0+JrQvLXuKDJNyv8MhHyp8MesyBGAhSXUhwpUkbJHwVxCx1Zq12WRLNIkmFmN8AV
 8ZHcRy9r4kKKQQDorjcwQ8ropWK0HqFUZ/BBgpMmGAsh9G0s/c+wl0ApmTHYbZtfaEvN
 yM0zyFVf7vIpx9O9p9sGOQDUWDHakBj7L16TB7bETxbX6aqe6yBGZXD51uKxtHxEBjt5
 fxQYWXpHg9KparG0Da0nJ4WbHmvRAuBVWCBYRFetFc0tqAUB9XAPquEtjRnfYAFjyx3t
 Fi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y7MA/ZS0ffk6/m2thG9xj+T+SaVK+SUiEficw+qkVMY=;
 b=gJMUov49hXN5La+Nr9JipFy7kTlOJzr8gXa/EWv/cQKnXT6SewknlnQOB3qCF3fmSi
 evYrlAa2tWSpYl3rf83nMmcP3Pl04y2OSeD+hWVdHFHAe4e+rkKuVFopPF70ck9ACFyg
 aJEfA5bvJ3AG342roJ90nYB39l3pu3mVeuUfqc2V4KLgqC9ZomiJJRriM8C7DTihjf94
 vZiG/2WdE3QMVQx+MyRta3nHz/O5InD7B+e/b3qpHTOqUUPSev/P95LujiIx0G4dv41p
 NfqHOLXQIp0L1yJA2PZCsh+vUOvkoVujslrM1k418M+suhpA0WstQYT7U0Da5F1/34Wr
 KVow==
X-Gm-Message-State: AOAM533X9PMYBKbPtMxZQqQ067JF5iMMk0oMQlpljX1b9yI684j5e4vl
 jjeIiHCW7g6AerCVGGY6FO9uONU2EMKGBHAhIbbIDQ==
X-Google-Smtp-Source: ABdhPJzwvbm+kF2Y9a2iC5tBprkIcUeWHnWeNHdF17pfncv+ohF7P5uyA7p5+j3zPYSjjIe8qFVQ3AP992ZCQmcqAEQ=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr8799864otk.221.1595602894745; 
 Fri, 24 Jul 2020 08:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
In-Reply-To: <20200724143220.32751-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 16:01:23 +0100
Message-ID: <CAFEAcA-EAd96iTzY08O4wth2VMbq_6WEMstCipDmPa+4dcWeHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Ed Maste <emaste@freebsd.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 15:32, Thomas Huth <thuth@redhat.com> wrote:
>
> Compiler warnings currently go unnoticed in our FreeBSD and macOS builds,
> since -Werror is only enabled for Linux and MinGW builds by default. So
> let's enable them here now, too.
> For macOS, that unfortunately means that we have to disable the vnc-sasl
> feature, since this is marked as deprecated in the macOS headers and thus
> generates a lot of deprecation warnings.

For my local OSX builds I use
--extra-cflags='-Werror -Wno-error=deprecated-declarations'
to work around the SASL thing.

thanks
-- PMM


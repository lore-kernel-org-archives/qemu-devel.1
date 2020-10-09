Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6218C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAC62184D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVgnRI9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAC62184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrNv-0001NM-08
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQrHT-0005WR-T2
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:13:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:46171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQrHO-0007MQ-5Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:13:51 -0400
Received: by mail-ej1-x635.google.com with SMTP id t25so12675627ejd.13
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dWkBET5tBsxLh7ba+vaUAKo61YT9Lqku+ANmsx4sxX4=;
 b=lVgnRI9Oq9OyH7C/1FUdV1qnJSzdldz/Ia654qU/0shGf4ou0hQuyWE0Xg+HOICGbv
 nv1wWwHGQNG033dQNOVfKslJICH+cOg6KAPqCbiB4iMqvwPHXkENk+yDo5RyqM0BR/Dm
 x/KxFNZEr/UYv3B/SQ6gZuYahEELCeorWyWDa/DGRzxahepdEpromo71JLyLD2+8xPMn
 wnATPVaDhxMJYOoJBn5/356GhMZBC/dbhaIp+bV/ZrhUa8SplAifxCOEb31/Ra0wHNIr
 5ImZ6R571pad82/4CM9jEUAXCN/nxTRYlV7BoCLJKwI0Xpt14FfcVQm4Nt8DcJuY5DEW
 TmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dWkBET5tBsxLh7ba+vaUAKo61YT9Lqku+ANmsx4sxX4=;
 b=qF6+bG4tF+mwWiQXS4FXL3xU7rma3q745rGRN7TpvY0vdegOdPI4ijDZBmYNwTWGcZ
 a5j0ml51Aj0ZUOFHoXJtfogzpPGXY4Vo8DnXCyHTI8qHtQm6OvpKmpMYrLPN0OgQNGDF
 tNve2h7KhAlFFaM6TYiiHeOIYDlf+Zn8/9Ie5038OyfMY7ZqJDLUXoQmRtJUX4/YqOHm
 wwa+ZoHZZw0F5BnRAtpJe6JATZheFBYYT1Sk+O4jrYVoBi+aJths4RmnT6R47yiSF73p
 aSYaAKJ0b7o3Wsu7ZL2kAxG3ENqNVp2nxcvnMa6eje01ejwoAReZVRe/IByoW938zjBj
 hM8A==
X-Gm-Message-State: AOAM531ePN5vZV9kC9I92ctIfW24r5rMpZQH/EXE70S+EmOz2P3oSSzM
 QvBg58S8jyQc1ijEUVgep/pOZYBgnj7K+LhMYW3EVw==
X-Google-Smtp-Source: ABdhPJzIE03G7vH9nvgt5oWCgifeCuCNq9gnDquMD4s8EDJ66AR88XC4lEf1xqHR0eba5cmmEKLotQh3n3bLCj0t2bs=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr14327026ejb.4.1602245624353; 
 Fri, 09 Oct 2020 05:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
 <8cedd3e4-dc6a-30ee-fd71-f4776aa8c953@redhat.com>
 <48641901-68e7-7e34-5046-31eea3967701@suse.de>
 <eba000db-c0d1-8474-15cc-6fa6e864bb88@redhat.com>
In-Reply-To: <eba000db-c0d1-8474-15cc-6fa6e864bb88@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 13:13:33 +0100
Message-ID: <CAFEAcA8YBF3Cq6pTHtq6EK6Qmb62FvwidT0a0rn7ZTC_3d-73Q@mail.gmail.com>
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Alex Bennee <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 12:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/10/20 12:28, Claudio Fontana wrote:
> > Running test qtest-x86_64: qos-test
> > ERROR qtest-x86_64: bios-tables-test - too few tests run (expected 23, got 22)
> > make: *** [Makefile.mtest:1326: run-test-187] Error 1
> > make: *** Waiting for unfinished jobs....
> >
> > What am I missing here?
>
> This is something else that is crashing.

It would be great if we could improve the error reporting for
this kind of failure, incidentally. I fairly often get
intermittents where there is nothing useful in the log
files, just one of these "too few tests run" lines (and
perhaps somewhere miles back up in the build output
interleaved with that from the other tests being run
in parallel with the one that fell over, there might
be more information, but it's basically unfindable).

thanks
-- PMM


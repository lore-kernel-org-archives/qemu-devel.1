Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2961BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75CC2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wC+Ubbij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75CC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSWp-0003z4-8k
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSWB-0003PA-Su
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:43:23 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSWA-0001cZ-6j
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:43:23 -0400
Received: by mail-ot1-x336.google.com with SMTP id 18so7175814otv.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=moqBChb5Wz84BLv4GbvrcoJfAQkkyfNLI8Ge5nMwbAM=;
 b=wC+UbbijgPfwuw3hU+DbZOXZQS4KsW9NepYVXzlYbaBqK9Yd+6FyI39hXRVfvJVb1f
 VIbXm2HisDlcMafEjrGkQYF5OLVOJ2VZd0B5OtdNdPSkoqTGxT1tbaew5ihHqvO9NJua
 EUugrjscYiMOkT3wID9AXvzkhvAU0qikVrMIeXplC8/iHt5U4KUmWb+OpG5/xZxDkiDn
 nmFtcTdKVVWq5bPeKyR4Fw5fBf30GQVySCV6KB2fIXfQie3f0vKrUJs171z2uneU9coa
 WYlHhbiuZhHA7ENFMjtmXUIbDDFY1Ty4ZrRoa5hNCPqJAAQB28WBi0QTHCCXwRTW5TDv
 j55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=moqBChb5Wz84BLv4GbvrcoJfAQkkyfNLI8Ge5nMwbAM=;
 b=lk0LR3nwK7hAaVt5cRfhpKy9KUT7UeL5CvI/nRB1onEan3mQE49wDRlGyiuSqlYtQ/
 hvevK3G2Wjjtz2ZeZUKJwEvPeuMmHEzthjBm2vmc5M1v2on9mqUrrJFxWeWLv+/CV1pE
 Gf0R+toWEBC4xs+fBBgxel2M1ZrHsHWXlI8GarrnWAtqk3nawppbuRWBmxzTSvCHC9Ph
 nU9jocRFbYte2cG4hyYCgw7Ho98TR1aDG1nvpJiBgftVK8+miAMJMr4ar3dwO9XwXEcS
 1ziNJWV8/PWKjWVbnE/LctX59q9f+ordB8hFJ2dhq4f9wuQawh4tg1TK0Eauu+YZSLAl
 +7Pg==
X-Gm-Message-State: AOAM533iVrTpW4Arz+PEo6wc3b/adl55BbOfpowOUiyd3lGldSDEIdpn
 To/9d8YzfrcqofFHvbgykYzCK0KL2ldlLvYNj4UwFw==
X-Google-Smtp-Source: ABdhPJwOzQ71hPaXpxQghrIhqprAV1SskkBHCl4PPOUCvKIRdBAeiMDdcZQ8ZcSLlKjZV9GubRzQkjaXtX/zaCVPASA=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr9626063oto.135.1595000600809; 
 Fri, 17 Jul 2020 08:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_DF5BA7114FBBA837DEBE64515ABC7CB27809@qq.com>
In-Reply-To: <tencent_DF5BA7114FBBA837DEBE64515ABC7CB27809@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 16:43:09 +0100
Message-ID: <CAFEAcA-F5zJhLs6YB8Xwsx7_H11MNk3NFQ-0Afc0+aPnKWppbw@mail.gmail.com>
Subject: Re: Implement standard file operation with QEMU
To: casmac <climber.cui@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 16:28, casmac <climber.cui@qq.com> wrote:
>    What I want to realize is to be able to call standard file operations =
(open, read, write etc) in the application program, and execute such progra=
ms in QEMU. But I am building under system mode.
>    TI provide copilation toolchain and a library that provide partial fun=
ctionality from libc. I am hoping to use TI's toolkit to generate object co=
de which contains calls to hook functions, and then use QEMU's host I/O imp=
lementation to realize low-level file operation. For example:
>     _stream[fildes]->WRITE  <---hook to ---> qemu_semihosting_console_out=
s

If the QEMU guest architecture you're using supports
semihosting (eg arm, mips, lm32, m68k, niso2, xtensa), then
you can use it to implement that kind of guest-libc
functionality. What you need to do is entirely in the guest
code: the implementation of the hook function for write
would need to invoke the correct semihosting call.
(For instance on Arm this is "put the arguments into the
correct guest registers/in-memory structures, then invoke
the right SVC instruction".)

If the guest architecture you're using does not have a
semihosting ABI, then you would need to define one, which
is a moderate amount of work and also requires some agreement
about what that ABI definition should look like (eg for
risc-v we asked the risc-v folks to write up a basic
spec document so that everybody implementing semihosting
was working to the same set of requirements).

The other usual way to implement the low-level hook
functions would be for them to talk to emulated devices:
eg a write-to-console function could be implemented to send
the string to a UART device.

thanks
-- PMM


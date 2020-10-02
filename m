Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F84C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386722053B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRc5ofGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386722053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOIHh-0001xM-0v
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOIGF-0001PD-Cu
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:25:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:37568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOIGA-000849-Fr
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:25:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id n22so1120882edt.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HEnshM4rYAZH6lizCkp0zzUBJ9TWuvjhn2KfMnre5jg=;
 b=aRc5ofGtfeQSqa2wOXaDRctnkAV+JbHW15AGIS3tlU09b3BatqOmWTeBRT0Ut6QE54
 tAiStOtjLUccNyay4a5+pW7CGn9Uarx45CeSTCU9axlrStI4/o4LS5OL9UW2ha0BpBc+
 Nubo64vU0Qkkoaure7CSA8NPM+CQci7q7IysIsnh2ns2my8AJRC8Pcba2u9/uq8qPCZr
 D/BZlBQP2BMsDsMMGxm2bpb2LH4JZtzTXWECc2fjBjy5JvbF1WhUfGwEYbXYFDNxjnKf
 IzyySem1FAsN+Nvd+vbWkntMxqwgx1oHGnQv/LGmaLz5jz9BmbfNays97ujLwvAVko6L
 sTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HEnshM4rYAZH6lizCkp0zzUBJ9TWuvjhn2KfMnre5jg=;
 b=i/vi3JzwDlPdAZTr0xc8+3RbLU0NIbpuTHjIcbFyYHi3FDYj9hR8plDbBXytfJn5Kq
 wtElGvOUIZ+N37c/yhRrU9Tr8hUMcqt13cBm6M+Idf7ywjrZ+24FZrZJrT0n0NPskev6
 r7nGIceROn8paPd5oCSdo372Dsk8U2K+eP1DvklcADemzfsFxYpryHc0al1Rx7R4Qotd
 1yYl5AufMUaqfSIfQ57ik4VyjmcCBsYmMqKU+p4wu8oyH133p0AvYoQrVmqkxhEF9Wkk
 US8hTQXtiXA9thZubesGuUCa0HCEIpZC3mLygHRJqyOiG0CZKkMX///3D36M3gxGZrvZ
 INNA==
X-Gm-Message-State: AOAM532CiOKr7rjivK4E0QKPf6FEA+qGlJ9fGMjgcLKzukiM8Ezda46C
 FlJeLkiM52aagBOg6W+WTPeuz+gW1SIL+oNlCCPFRoakqpUd3w==
X-Google-Smtp-Source: ABdhPJw//PikmvdG2FoutomMVVdi0YZZgHPgbBfFxRvGetEvxNMBszkDdyfke18OA+HC0fFcHgoSsG0GjbWJess4zeE=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr1497393edw.251.1601634352727; 
 Fri, 02 Oct 2020 03:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
 <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
 <CAD5UmjrjORJbP0sj-DnGQFaQ443-vYMBa-1qCBzJsnUG+gU=jw@mail.gmail.com>
In-Reply-To: <CAD5UmjrjORJbP0sj-DnGQFaQ443-vYMBa-1qCBzJsnUG+gU=jw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 11:25:41 +0100
Message-ID: <CAFEAcA9JecdSwd=gXSu7mhDHVysLP5JP4dtRBgBVr7=bt=j6Tw@mail.gmail.com>
Subject: Re: ARM semihosting issue
To: Bruno Prado <bruno@dcomp.ufs.br>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 1 Oct 2020 at 22:21, Bruno Prado <bruno@dcomp.ufs.br> wrote:
> Thanks for the reply... I am attaching some code and output:
>
> #include <stdio.h>
> int main() {
>        char name[50] = "Nobody";
>        FILE* file = fopen("name", "r");
>        printf("What is your name?\n");
>        fprintf(stdout, "Reading from file...\n");
>        fscanf(file, "%s", name);
>        fscanf(stdin, "%s", name);
>        printf("My name is %s\n", name);
>        fprintf(stderr, "I am alive!!!\n");
>        fclose(file);
>        return 0;
> }

This is not making direct semihosting calls. The behaviour
of these function calls will depend on whatever the C
standard library implementation you're linking with is doing.

You're not checking for errors from any of your function
calls, incidentally.

thanks
-- PMM


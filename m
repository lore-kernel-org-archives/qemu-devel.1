Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8FEC433E4
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC032074B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSKFGjzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC032074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwmzw-0000ar-Pd
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 09:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwmzH-0008W8-Po
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 09:34:47 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwmzG-0001WH-2A
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 09:34:47 -0400
Received: by mail-lj1-x243.google.com with SMTP id x9so15694912ljc.5
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ff7h9hUAX1MzVzN3TjfQrb8okEAUNvh5gAS5d7CXm2o=;
 b=uSKFGjzB9A6wspfSoNENTK85HjwfmXo0DkC1BIMnRM42gytpCebKOHdDKlFWuoxQWt
 /xFnZ4Xw1xyipxuPAtRmUJtq5M/KWXYrOIZ/T42uVtly2qUNhxpV3RUxxyWX3urdU8BE
 F5tS4y9wOQIlRX9ZitKmgXVd6RV9Y0beb684lcOm/coiYIpPrRD8e1IIxiOSViEYtrg2
 gyNkTHgWnaUT0xkVfNL6dZF3ecTr/WnSRmaUEmuEAtPyu5nc62czG2As4bioh24F+42t
 356GQYRHd2QAuANhO60Yza3Duy0AsAPukeP9Mqa+SO+Qw30727rniQd4gArftHWwxkd6
 t1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ff7h9hUAX1MzVzN3TjfQrb8okEAUNvh5gAS5d7CXm2o=;
 b=mcAxWbWvSpXFbESnk5hBvRKLD8A6nafF4TWqBalWvz2bmfk9/scix8aLYTNurjFnv3
 493XiYtSMZ+Jxz2tE6E8zFf90gbNNS5glQacLU8kZlLndTx6nN+k4IBA6fwOQpBP40x1
 xebmDI+UxpgzeKEKPu7c+nkm9T1GXUSGPu5h9IKp/XkXBD+ZrXHdkPLc4ZZ+sIdonqpe
 cRZdSKom1ZfWYBmSihfWsUgudelgfobblCRjxXgBfQnaAcljXAcdy8uScbO6Et3DkNOg
 nq5vld6kS7ZYSknLW9riMUODtc94RBz8Sa2SNOq0ZskFYIjvAzirbHwO6DZhjpi1d1T2
 8sbw==
X-Gm-Message-State: AOAM5333yG1Zy4iiN+OccUSGyYKR2E0sNCuzuvOJg1/fboE9NpUrrOMr
 EHcQo5T0EWQxHa5VriitAAlgJcxTR9sWOBNjvTdzUg==
X-Google-Smtp-Source: ABdhPJzZdVcTSxFjTt46i3Hu11sjZsqgNg8hsc4UtJhyou7tQperXYcjw20nXk4UxQwchAXvSZTa3FOy0n6a/f5Tic8=
X-Received: by 2002:a2e:b5b7:: with SMTP id f23mr5777137ljn.380.1595079283807; 
 Sat, 18 Jul 2020 06:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8iKKDKEdq8TtbZNwqfsH=ZO78eEXWfrVbYTDjdy9DYDw@mail.gmail.com>
 <890eb42e-cd77-2a63-c441-61637ac5094f@redhat.com>
 <42c71a79-4911-dc47-d983-783d98e819c5@redhat.com>
 <89f309c2-9909-f306-2f2b-93fc1b8adc17@redhat.com>
In-Reply-To: <89f309c2-9909-f306-2f2b-93fc1b8adc17@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Sat, 18 Jul 2020 09:34:57 -0400
Message-ID: <CAEyhzFvFxspN2XQmNTnJFOT14evhn21y1kF1EQW8Q-9uXM9Ydg@mail.gmail.com>
Subject: Re: tests/vm infrastructure fails to notice that QEMU dying is a
 failure
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 18:24, John Snow <jsnow@redhat.com> wrote:
>
> - The real problem, though: Why is QEMU hanging? It might need a longer
> timeout, or it might be having problems with the console socket again.
>
> (CC Robert Foley who has been working on the Console socket draining
> problems. Maybe he has some insight here?)

When we did see the console issues we would see a hung stack like this:

#0  0x0000aaaad43d141c in qemu_chr_write_buffer
#1  0x0000aaaad43d194c in qemu_chr_write
#2  0x0000aaaad43d3968 in qemu_chr_fe_write_all
#3  0x0000aaaad417cf80 in pl011_write
#4  0x0000aaaad3f3c7b0 in memory_region_write_accessor
#5  0x0000aaaad3f3a1fc in access_with_adjusted_size
#6  0x0000aaaad3f3e828 in memory_region_dispatch_write
#7  0x0000aaaad3f517b0 in io_writex
#8  0x0000ffff574a1d34 in code_gen_buffer ()
#9  0x0000aaaad3f67228 in cpu_tb_exec
#10 0x0000aaaad3f67228 in cpu_loop_exec_tb
#11 0x0000aaaad3f67228 in cpu_exec
#12 0x0000aaaad3f2dbe4 in tcg_cpu_exec
#13 0x0000aaaad3f305e8 in qemu_tcg_cpu_thread_fn
#14 0x0000aaaad4441d88 in qemu_thread_start
#15 0x0000ffff85bec088 in start_thread
#16 0x0000ffff85b5c4ec in thread_start

However, since we added console socket draining thread, it seems to have
fixed this and presently basevm.py should be using this console draining
for the vm-build-openbsd.

When QEMU is hanging and exceeding our shutdown timeout, could we
(optionally) send something like a SIGABRT to QEMU to force a core dump
so we can get the stack and see where QEMU is hung?
I suppose that presumes it is reproducible, but it might help to remove doubt
in cases where QEMU hangs.

-Rob
>
> --js
>


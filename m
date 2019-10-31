Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AB0CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 20:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC322086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 20:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oErNy3+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC322086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQHLw-00035k-VC
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 16:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iQEBN-0002ka-4C
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iQEBL-0004nu-JC
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:24:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iQEBL-0004nS-9f
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:24:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id n7so6776296wmc.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=hxY2xvCmHkLxQyEFc1Ne/xSaX0XlHc5GnIQ8lQEupv0=;
 b=oErNy3+C1js4Pj3gfC2nFEf6EZrvVk+ImTajXX2I4Hd6cdaVVsf2pqMKiJU67r0V+C
 boq9oM20nh6sDi4geatjqSMcn3SH9+0FfCD65bjA3iJXMPS3Glaz5nNO5uJyZE4PlEc0
 aVW2A5KgPL+lOu2m0PNez/gztEkKT1nS77Fs39CsNvK7N3GpIkQqNWEOkEbLKNlM4IvS
 qKHHyNq49cLyJcR2jy0Y5a+8SBONLez9w71+g2N1Ka8bPaTQwRvoscE05Gsk+QnYTwDh
 afrtUkJX+YOG4PIsdB/LL69DPYVsIT7YgVrMa5UbJi9s8f2BYUADBeHVqvtTPR+y3E6M
 Nrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=hxY2xvCmHkLxQyEFc1Ne/xSaX0XlHc5GnIQ8lQEupv0=;
 b=DDSDnLszED5tq+HdFhkC3UEoQTkimdNUCgzPJw4N3ejR78xgynQqBc6OgJP1EKc6t1
 9rB7YI3uN01Dz9pob6ZGL401yC4FqNTuW/KVa3k7pnPVOPBznAIeKMi3YTNhfNH7/gSh
 PotS1dpgN2nO2Ig/9SH7BlSoDhJZ05p3nnCiCuD2I1pYigkOX0m6XzSH3jdBhei4UOtg
 wx/dcdjaan6SO12xlggb7Go3keOd+MatAmH0z7a9GFBnjKXy0C6WQ6qGAsJFA50Z37OM
 LCeAuTJshyFPRoEtiyMLugaAkqnEWxhu0DVtBG2gOSzt7RgTK0IJrBZsiZfzlo62cM/t
 pQMg==
X-Gm-Message-State: APjAAAXngXHhw1jjpI4wcex8xfmWyvvzcHLXDzoyBhafBbtf3XLUsO5u
 0O+rMjDP91QRYRuJyXCIuaEuFoyN+HgPVgsqMEHSbMdu6Ws=
X-Google-Smtp-Source: APXvYqzdC3qjqMp85y7gajwXs4h88uwysW6YEJYbZbsgIUuOXFOsNOETaOMEN1NuA4bPLZeUu0nKJvSTyGfj+n8zLiE=
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr2929977wmk.67.1572542661262; 
 Thu, 31 Oct 2019 10:24:21 -0700 (PDT)
MIME-Version: 1.0
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 31 Oct 2019 13:24:10 -0400
Message-ID: <CAEyhzFtb6Gn86VkR+BXbUPsHLtfbjDwotwZXDVyLCMjbrTXWrA@mail.gmail.com>
Subject: logfile issue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-Mailman-Approved-At: Thu, 31 Oct 2019 16:44:58 -0400
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We hit an issue when trying to change the log file from the monitor
console.  The root of the issue here is that the qemu_logfile handle
is not thread safe.  So when we try to close the file, we end up with
a seg fault.  The full analysis is below along with some possible
solutions.
Will plan to post a patch soon, but any comments or opinions on our
proposed solution would be appreciated.  Thanks.

The version of QEMU we are using is: master as of about Oct 15,
9020e9526cd08c4dc99d54dba48730de2908c970.

This is what we did to reproduce the issue.
First we enable logging and select the log file.
(qemu) log in_asm,out_asm,op
(qemu) logfile asm.out

Then we start this command in the guest.  This just keeps the guest
performing operations that result in logging to be constantly
generated.
$ for i in {0..1000}; do ls -l; done

Next we switch to the monitor console and change the file.
(qemu) logfile asm_new.log

This action causes a seg fault.  Please see the stack trace (below).

The code, which changes the log file unconditionally
(qemu_set_log_filename()), closes the qemu_logfile, sets it to NULL,
and then opens the new file.
Since the file handle is still in use, we end up with a seg fault when
the code which is trying to log ends up using a NULL file handle.

We are considering a few solutions.

A straightforward solution would be to simply prevent the file from
being changed while logging is enabled.  In other words, force the
user to first disable logging before changing the log file.
This solution seems to cover the general case.  However, if a user
were to disable logging and change the log file in quick succession,
we would still be subject to a similar race.  A log call could still
make it through the logging enable check and proceed to use a file
handle that gets changed to NULL.

Another option is to add a mutex to prevent the qemu_logfile handle
from being changed while it is in use.  This certainly works and has
the advantage of being fairly straightforward.  Also we are thinking
that since the mutex would only be used when logging is enabled it has
the advantage of not having an effect on the normal case performance.
Another option is to implement a simple atomic ref count and prevent
the file from being changed while there are outstanding references.

We are leaning towards the mutex option, and plan to post a patch
soon, but would appreciate comments or opinions on this solution.

Thanks,
Rob Foley

stack trace
==========================================
Thread 10 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xffff113f9d90 (LWP 9493)] __flockfile
(stream=0x0) at ../sysdeps/pthread/flockfile.c:27
27 ../sysdeps/pthread/flockfile.c: No such file or directory.
(gdb) bt
#0  __flockfile (stream=0x0) at ../sysdeps/pthread/flockfile.c:27
#1  0x0000aaaae0fac8b8 in qemu_flockfile (f=<optimized out>) at
/home/rob/qemu/qemu_unchanged/include/sysemu/os-posix.h:87
#2  qemu_log_lock () at /home/rob/qemu/qemu_unchanged/include/qemu/log.h:57
#3  translator_loop (ops=0xaaaae17f1348 <aarch64_translator_ops>,
db=0xffff113f9088, db@entry=0xffff113f9098,
cpu=cpu@entry=0xaaab0a52bc50,
    tb=tb@entry=0xffff4c92d000 <code_gen_buffer+814927796>,
max_insns=max_insns@entry=512) at
/home/rob/qemu/qemu_unchanged/accel/tcg/translator.c:121
#4  0x0000aaaae10c1c18 in gen_intermediate_code
(cpu=cpu@entry=0xaaab0a52bc50, tb=tb@entry=0xffff4c92d000
<code_gen_buffer+814927796>, max_insns=max_insns@entry=512)
    at /home/rob/qemu/qemu_unchanged/target/arm/translate.c:11320
#5  0x0000aaaae0fab248 in tb_gen_code (cpu=0xaaab0a52bc50,
cpu@entry=0xffffabe2a000, pc=187650897458448, cs_base=65536,
flags=43690, cflags=-16252928, cflags@entry=524288)
    at /home/rob/qemu/qemu_unchanged/accel/tcg/translate-all.c:1738
#6  0x0000aaaae0fa8e74 in tb_find (cf_mask=524288, tb_exit=0,
last_tb=0xffff4c92cc40 <code_gen_buffer+814926836>,
cpu=0xffffabe2a000)
    at /home/rob/qemu/qemu_unchanged/accel/tcg/cpu-exec.c:408
#7  cpu_exec (cpu=0xffffabe2a000, cpu@entry=0xaaab0a52bc50) at
/home/rob/qemu/qemu_unchanged/accel/tcg/cpu-exec.c:730
#8  0x0000aaaae0f6de24 in tcg_cpu_exec (cpu=0xaaab0a52bc50) at
/home/rob/qemu/qemu_unchanged/cpus.c:1454
#9  0x0000aaaae0f70908 in qemu_tcg_cpu_thread_fn (arg=0xaaab0a52bc50)
at /home/rob/qemu/qemu_unchanged/cpus.c:1762
#10 0x0000aaaae145bd38 in qemu_thread_start (args=<optimized out>) at
/home/rob/qemu/qemu_unchanged/util/qemu-thread-posix.c:519
#11 0x0000ffffabe0a088 in start_thread (arg=0xffffcc20410f) at
pthread_create.c:463
#12 0x0000ffffabd7a4ec in thread_start () at
../sysdeps/unix/sysv/linux/aarch64/clone.S:78


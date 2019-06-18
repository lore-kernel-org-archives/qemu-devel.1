Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B90C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 23:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D5020873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 23:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmk6CzFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D5020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdNIg-0000qE-Lx
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 19:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hdNHk-000079-AX
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hdNHi-0004r5-O1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:13:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hdNHi-0004pg-Fa
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:13:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id i4so646173otk.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3uCZ/AvnT7NNBGJ65LQnfQ8QDd/np+DG0UH4jozCYKU=;
 b=Bmk6CzFJJR3oZdrQxVEH6Pe2fZ+E/lm0we9vMPZgtqkPf57eLKem1B9W38630HUHsD
 SDPIQnOfMWLWZ2MnchhdmXTLbV0wlQCoExZeiTL/odgq6KzWtHeW0XairEISkpT46ut1
 r9+EtdsT9lyPpGz3Gq9V4YIY4Xb+9n8qGEb03B8VoXaZXJDlQE7AmLK+JRUnLl5gaAc0
 T1RviqoOpW3GcYSr6rcr2rW6+0AkfqvpnbyOXimXkuBegc5pNWzOH/ExgAAuEfzlpJ6E
 iNApSm6j5eiOkl+No9GZs5NI0/AFBaDA6KSKCbDWRSBxzNf9Aqbl50o3MuG39tMnATZz
 CKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3uCZ/AvnT7NNBGJ65LQnfQ8QDd/np+DG0UH4jozCYKU=;
 b=RSCGo5oTWC9X69SkasEKmiNLWofX0ixVSo6ao5sJDgX43XFH0KY9/m+uSpctpmADii
 YwY7UdBJHKDsURn0jbjGWZ14NYAnETpmDxcM6aOLDo9DKXtDokKfMrHxa6O3NpYWx+bB
 f9odldnQNITwXUSo/6wBzSluWw+2PVL5xcNL4e/VW5Ax7l3gDt3xBlZ8a6bHJU0Vko7t
 MOfqutM2mO3wwd4N6Pawhoa2W1Gd5fXOKln89TX14L+WjN/lx1+UouRL12l6JrkA87fk
 Qdcz7VNU38ZxDSgBUGi77YMUYSdcI577MqtZpaePj6Y+k6W7qF1qEe0wrnXfhEe8QoJd
 NtGA==
X-Gm-Message-State: APjAAAUZx8HInpTMvQehIRHgXVS5EiuuNYK6mbktI9SlMdmrQbXqz8wR
 WkNtaWO7eduGkacObmui++9a1q+Jnip34w0zPUk=
X-Google-Smtp-Source: APXvYqyeDDu+RmKNaf4xPbuI5vyq5xZEArE9ahB1f9vJIl2DSh/2PyEAfQ5x1Kur+qzhnOAe8+7syPH0NWl/9TsObZ0=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr1418507otq.306.1560899580791; 
 Tue, 18 Jun 2019 16:13:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Tue, 18 Jun 2019 16:13:00
 -0700 (PDT)
In-Reply-To: <121c4da9-bf13-0da3-39a9-22891dabcb5c@sifive.com>
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <121c4da9-bf13-0da3-39a9-22891dabcb5c@sifive.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 19 Jun 2019 01:13:00 +0200
Message-ID: <CAL1e-=iArKHT+pVe5uT1v800=pGuMLB=SGpuBAZouq5-0ekfGA@mail.gmail.com>
To: Jim Wilson <jimw@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for
 statx() syscall
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, June 19, 2019, Jim Wilson <jimw@sifive.com> wrote:

> On 6/7/19 3:35 AM, Aleksandar Markovic wrote:
>
>> Implement support for translation of system call statx().
>>
>
> I also need these patches for 32-bit RISC-V linux user mode support.
>
> glibc ld.so calls statx if fstatat is not supported.  Apparently new linux
> architecture ports aren't allowed to define __ARCH_WANT_NEW_STAT which
> enables fstatat because this is already obsolete.  64-bit RISC-V linux does
> have fstatat, but apparently this was a mistake which we can't fix now
> because the ABI is already frozen.  The 32-bit RISC-V ABI is not frozen
> yet, so it won't have fstatat.  Anyways, without statx, ld.so doesn't work,
> which makes user mode qemu pretty useless, so we do need this emulated in
> qemu to make the 32-bit RISC-V linux user mode support work properly.
>
>
Jim, Aleksandar Rikalo, the author of the patch was about to send Laurent
explanation why this aproach is needed in its current organization, on a
very similar line of reasoning as yours.

I am waiting on him to send a new version of the series. Meanwhile you can
send strace patch to the list, and I can even incude it in my series after
and together with Aleksandar's patch, if you don't object.

Yours,

Aleksandar M.

I started with the August 2018 version of the patch a few weeks ago, and
> just noticed that it has been resubmitted.  I had to modify the patch
> slightly to apply to current sources, and had to fix one bug to make it
> work.  The line
> +                if (ret != TARGET_ENOSYS) {
> needs to instead be
> +                if (ret != -TARGET_ENOSYS) {
> I see that Laurent has already pointed that out.
>
> Incidentally, I also have strace patches for statx that work on top of
> this patch, since I didn't see that in the nanomips patch set I started
> with.  That helped me debug the 32-bit RISC-V user mode support.
>
> I've tested this on Ubuntu 16.04 (no host statx) and Ubuntu 19.10 (with
> host statx) and it worked well for me running the gcc testsuite for a
> riscv32-linux target.  I haven't tried testing the latest version of the
> patch yet.  I can do that if this is helpful.
>
> Jim
>
>

Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17330C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE34A20882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj5mNY6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE34A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTAm-0000zM-Rk
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <incredible.tack@gmail.com>) id 1iCT8b-0008LR-N1
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <incredible.tack@gmail.com>) id 1iCT8a-0001Ch-Ml
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:32:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <incredible.tack@gmail.com>)
 id 1iCT8a-0001CZ-Ek
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:32:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id v8so15139346wrt.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OAOxUsADOghG0aSSZ/BOAkyKYbdJZxguJGoZ6//bd2g=;
 b=Sj5mNY6jnGj9FPerqHmuiHhFlqOrXz8lHrnXBqkTUAOrfTFIi6OSMGhVfuMZ0kHNj+
 9u9s2xpHCzBytRloU/Wj3HWrLB4yz4wZbwzmWibj4zL8AajXOnOMwhMQ4mY2+aV7AR4D
 uM+G/UXiboIgu0u0rluf1HcoKBTWAU0093GTyRnDQUqL0Vc6TCJrgsR78fdw8/zbCJD0
 IAAiAhBUk5eyEjy7H908Jqkw2dW9Y2qKpQf+PJdXTeOySG+dUEeTXn0g/kqxIfMd9Uf7
 ZEpLj7WQr2TX2AEJ/XBJGATwRjyf9AC1Bv9ztn90e6D5CjjzkVXIakfue0EVszaGQDET
 tyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OAOxUsADOghG0aSSZ/BOAkyKYbdJZxguJGoZ6//bd2g=;
 b=HZ9isQ5GhrvXsc5++HMCQVxnek5EutB2Pa9gRSeD8dlv8tXxzSkajjGxfQ0NKISF+a
 J2I+vmOV8Zdfa6UHOvjDqv+0+FizzNCleyS7XsNXdjRzL9W3SZ7KMT9NdoJqjyYmHuAu
 WRvWeafBjHjPWLRM8lHeL9joeQXX5x3DI57wqN3BJj6mMJ5XSfKHu+2E8Fi7qjT60gaa
 zweqYnwegDhRXlSPT2bxU7MoM6M8NrQqVHyvC9MXUkOf26aTedFNA2clCapgnFtGdAej
 yCrZCbnY2q5tcu0txIkuBk4a7kPvJ8TBfjJCcSlKPrk1v9evGRhy0evkyYXriW6oZCOA
 4A0w==
X-Gm-Message-State: APjAAAXAZ3egB7y17DPvPjn5Z6VEmYqEy9JOYvqd2CsLoOsrxeJbbwSf
 wU6axnStzrZUw5hP7IKBONHEjEIbSXyezl/7/NU=
X-Google-Smtp-Source: APXvYqyAxKP/RN6BXlhgJjfxQjmQAxG+XpCYTBXah8SLfJeV1Vj4KZAr+rD7otPaSQmtIxEm0SGmOu/RPrSSZbBEFSg=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr528550wrt.59.1569263559305;
 Mon, 23 Sep 2019 11:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xhYrUbK0aEJmKp3_kOJG2E+AQLMUjyf7_pXVJgbqgv5JA@mail.gmail.com>
 <20190923104245.GA2866@work-vm>
 <6fa1b7a6-52c8-fc98-c532-f2c0484d04b0@redhat.com>
In-Reply-To: <6fa1b7a6-52c8-fc98-c532-f2c0484d04b0@redhat.com>
From: Jintack Lim <incredible.tack@gmail.com>
Date: Mon, 23 Sep 2019 11:32:28 -0700
Message-ID: <CAHyh4xgwTpM5rQ1qrwfjtqjHLj_U4Fes2Qmch0g=84yNxBQuZA@mail.gmail.com>
Subject: Re: Migration failure when running nested VMs
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 4:48 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/09/19 12:42, Dr. David Alan Gilbert wrote:
> >
> > With those two clues, I guess maybe some dirty pages made by L2 are
> > not transferred to the destination correctly, but I'm not really sure.
> >
> > 3) It happens on Intel(R) Xeon(R) Silver 4114 CPU, but it does not on
> > Intel(R) Xeon(R) CPU E5-2630 v3 CPU.
>
> Hmm, try disabling pml (kvm_intel.pml=0).  This would be the main
> difference, memory-management wise, between those two machines.
>

Thank you, Paolo.

This makes migration work successfully over 20 times in a row on
Intel(R) Xeon(R) Silver 4114 CPU where migration failed almost always
without disabling pml.

I guess there's a problem in KVM pml code? I'm fine with disabling
pml. But if you have patches to fix the issue, I'm willing to test it
on the CPU.

Thanks,
Jintack

> Paolo


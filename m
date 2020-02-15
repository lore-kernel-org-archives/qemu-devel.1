Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA311C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CCC217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yifanlu-com.20150623.gappssmtp.com header.i=@yifanlu-com.20150623.gappssmtp.com header.b="WwQHWltA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CCC217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yifanlu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2kup-00046i-S1
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 19:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@yifanlu.com>) id 1j2kuC-0003bF-LL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@yifanlu.com>) id 1j2kuB-0004f0-F2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:01:56 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:32949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <me@yifanlu.com>) id 1j2kuA-0004aw-VI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:01:55 -0500
Received: by mail-il1-x144.google.com with SMTP id s18so9515878iln.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yifanlu-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a19uAb4omz7/1mVazKdUiQwyBCTItWg+Z+WpIBipKvQ=;
 b=WwQHWltAh90HZal587QACMrf79iOaRTn3TCcDHYqZH2HXhuPNbrtvm0f0np6wntYb0
 tt06OKA/767IlLXADUDWeFE/Y6c9h5QcP9P1G62oZsCGX8COFbiR8cPCg8YoOB1DFvFb
 Zpm328O4iuc9ZoeOaPmpHRwv9NdWIdrsLG+aRSEAip0BW74+FWU5suSmFqoIBugZ/oy1
 T03tCOgvSC2Cthvs2pZ6s5ZVK/sP9CrYXAQvHno2WbDRGX3GPw4Yfo7p7Y13RChdeA9F
 THLzfCyV7PIOKk9VZJlUgdJmsV/U3uKWnSSybBzVrakeXpVLCOqsIix8uCVU5xRM5Vvy
 /Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a19uAb4omz7/1mVazKdUiQwyBCTItWg+Z+WpIBipKvQ=;
 b=YrUVxyk3fFYTb8PI4WRwDcX1AzYjMW68j+azMqNU6GpPzqKm/m118cLhQkEhG1RqWG
 xfglbS6e2UimrCpQJTI1ZoTPdltLECsTsuk+lDxH+79dK3iuZufkYWmKFmXrp9FhUW3L
 E1QnM8YYU0qzv7ea84K1NCLNK4vDHDZHs+6bKsGpXpQw1W9uQwmSooJxnbjR0Fcb1vh2
 y6fz5l99CxMMhJZPSVeQRTRMFKtDwXTZ0pgXIy1oSRWRdGfSBby1HeBszyZnZWQu1N8W
 kXbMHSVATJkJnj2Uh+35H4LqWbeNbOT+MGydQPJIcAngZKhgpdt5/t9tC8PLgF4lFKMb
 cCZg==
X-Gm-Message-State: APjAAAXg4wopGsrGd9Bv81Fzj5Blj0ztmBDa41wr9hVxKqKtUrmDJCgd
 yc5EtJGqiMnWQiqE2QKJ+tYXGmdkMou/pFtcck1AGg==
X-Google-Smtp-Source: APXvYqyMEkMvfc5UVK/uVni38XqBr6Bk1cW5WPkEh/ODXjwxktHb+QjVXG4Ntj08eEhnN+NXVANtNF/MJ+ntTUsZ8AE=
X-Received: by 2002:a92:b74c:: with SMTP id c12mr4961109ilm.154.1581724913429; 
 Fri, 14 Feb 2020 16:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20200214144952.15502-1-alex.bennee@linaro.org>
 <dc224902-b8bb-934e-947a-4417449566ea@linaro.org>
In-Reply-To: <dc224902-b8bb-934e-947a-4417449566ea@linaro.org>
From: Yifan Lu <me@yifanlu.com>
Date: Fri, 14 Feb 2020 16:01:17 -0800
Message-ID: <CAP4MwtfP_+pxb96WQ4coe187A4e2HasXqTXsobTn1UH+8RFK8Q@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: fix race in cpu_exec_step_atomic (bug 1863025)
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Bug 1863025 <1863025@bugs.launchpad.net>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What race are you thinking of in my patch? The obvious race I can
think of is benign:

Case 1:
A: does TB flush
B: read tb_flush_count
A: increment tb_flush_count
A: end_exclusive
B: tb_lookup__cpu_state/tb_gen_code
B: start_exclusive
B: read tb_flush_count again (increment seen)
B: retries

Case 2:
B: read tb_flush_count
A: does TB flush
A: increment tb_flush_count
A: end_exclusive
B: tb_lookup__cpu_state/tb_gen_code
B: start_exclusive
B: read tb_flush_count again (increment seen)
B: retries

Case 3:
A: does TB flush
A: increment tb_flush_count
A: end_exclusive
B: read tb_flush_count
B: tb_lookup__cpu_state/tb_gen_code
B: start_exclusive
B: read tb_flush_count again (no increment seen)
B: proceeds

Case 1 is the expected case. Case 2, we thought TB was stale but it
wasn't so we get it again with tb_lookup__cpu_state with minimal extra
overhead.

Case 3 seems to be bad because we could read tb_flush_count and find
it already incremented. But if so that means thread A is at the end of
do_tb_flush and the lookup tables are already cleared and the TCG
context is already reset. So it should be safe for thread B to call
tb_lookup__cpu_state or tb_gen_code.

Yifan

On Fri, Feb 14, 2020 at 3:31 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/14/20 6:49 AM, Alex Benn=C3=A9e wrote:
> > The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
> > which is invalidated by a tb_flush before we execute it. This doesn't
> > affect the other cpu_exec modes as a tb_flush by it's nature can only
> > occur on a quiescent system. The race was described as:
> >
> >   B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
> >   B3. tcg_tb_alloc obtains a new TB
> >
> >       C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
> >           (same TB as B2)
> >
> >           A3. start_exclusive critical section entered
> >           A4. do_tb_flush is called, TB memory freed/re-allocated
> >           A5. end_exclusive exits critical section
> >
> >   B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
> >   B3. tcg_tb_alloc reallocates TB from B2
> >
> >       C4. start_exclusive critical section entered
> >       C5. cpu_tb_exec executes the TB code that was free in A4
> >
> > The simplest fix is to widen the exclusive period to include the TB
> > lookup. As a result we can drop the complication of checking we are in
> > the exclusive region before we end it.
>
> I'm not 100% keen on having the tb_gen_code within the exclusive region. =
 It
> implies a much larger delay on (at least) the first execution of the atom=
ic
> operation.
>
> But I suppose until recently we had a global lock around code generation,=
 and
> this is only slightly worse.  Plus, it has the advantage of being dead si=
mple,
> and without the races vs tb_ctx.tb_flush_count that exist in Yifan's patc=
h.
>
> Applied to tcg-next.
>
>
> r~


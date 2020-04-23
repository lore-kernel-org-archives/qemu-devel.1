Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F86C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E2A20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E2A20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWm9-00029A-6T
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 04:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRWlZ-0001jP-C9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRWlY-0003wV-2N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:59:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRWlW-0003vz-RY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:59:23 -0400
Received: by mail-yb1-f193.google.com with SMTP id o139so2657923ybc.11
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=myYpUEvY//TatQNeT7DjQNiA586sJCnEEbluBVJaY8E=;
 b=gb10bFHkd6dKkB2RVJZiDOk07oxO4Vq5dZynYGxkUVvjiq0R5NSW0ZDxnBL6jrMr9e
 0b/1qZQCTiqbDsfk6gOe21o+igB79Oqa91N8EEfohJ1mfPhL4MVAREGKuuRzmLOyNGzR
 tUgR4Z4pf8YJR0Z/4hJltmsEIh6MciWqe7docqpSyt0lpG8FCQgbx8Q0gud6m0ulaFDy
 iie8Fj13XR8hmIQ5kkqRfAYHqtpqRAp1h8A3mVW9Rw4Sd5trpND1SnqB1Hk2ye4MD78t
 p5x/aulw7Aci997U8wjIx19SAu/I7sahPfsI2KExTrOGAfSXn8ti+kuZ576dbkdCm15h
 oY8Q==
X-Gm-Message-State: AGi0PuYBHsT2NOjd7oNF+OUlV1cJQlwuEAoATAPhh07g+zQDOjO6GvPS
 NBDR+NUroGpsmjEzQLeOp45uEXLT3ly8xkUv0Qw=
X-Google-Smtp-Source: APiQypIRIh/2DoDxHywWOQFmHilEcsVAkoc3mq/uIG0biec1L1eRmnuM483RntrzwwfhMxcqlfW3Ny2bogfmEt94ibY=
X-Received: by 2002:a25:aa27:: with SMTP id s36mr5212892ybi.387.1587628760057; 
 Thu, 23 Apr 2020 00:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200423071039.7010-1-f4bug@amsat.org>
 <bcc500de-9164-8ef9-240c-9a82161df9ad@redhat.com>
In-Reply-To: <bcc500de-9164-8ef9-240c-9a82161df9ad@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 23 Apr 2020 09:59:08 +0200
Message-ID: <CAAdtpL6hF2-XZwkyRp9nEOmAQir1wb-Bw4fv2bhV+OJGU=W8Vw@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Add stub for probe_access()
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.193;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-yb1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 209.85.219.193
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 9:49 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.04.20 09:10, Philippe Mathieu-Daud=C3=A9 wrote:
> > The TCG helpers where added in b92e5a22ec3 in softmmu_template.h.
> > probe_write() was added in there in 3b4afc9e75a to be moved out
> > to accel/tcg/cputlb.c in 3b08f0a9254, and was later refactored
> > as probe_access() in c25c283df0f.
> > Since it is a TCG specific helper, add a stub to avoid failures
> > when building without TCG, such:
> >
> >   target/arm/helper.o: In function `probe_read':
> >   include/exec/exec-all.h:345: undefined reference to `probe_access'
>
> I think you're missing the most important commit:
>
> 0d57b4999220 ("target/arm: Add support for DC CVAP & DC CVADP ins")
>
> I do wonder if dccvap_writefn() and calling code should be compiled for
> TCG only (CONFIG_TCG). I assume it is only called from TCG code -
> otherwise it would already be semi-broken.

I can only recommend you to read the thread after this previous patch,
as I don't have the knowledge to explain...:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689115.html

>
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Emilio G. Cota <cota@braap.org>
> > Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > ---
> >  accel/stubs/tcg-stub.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> > index 677191a69c..e4bbf997aa 100644
> > --- a/accel/stubs/tcg-stub.c
> > +++ b/accel/stubs/tcg-stub.c
> > @@ -22,3 +22,10 @@ void tb_flush(CPUState *cpu)
> >  void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
> >  {
> >  }
> > +
> > +void *probe_access(CPUArchState *env, target_ulong addr, int size,
> > +                   MMUAccessType access_type, int mmu_idx, uintptr_t r=
etaddr)
> > +{
> > +     /* Handled by hardware accelerator. */
> > +     g_assert_not_reached();
> > +}
> >
>
> Still, this makes sense to me as well
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> --
> Thanks,
>
> David / dhildenb
>


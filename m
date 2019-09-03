Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDEEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79FC215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAOWtnrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79FC215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58h4-00057V-NR
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i58fD-0004VF-CC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i58fB-0005Co-Tw
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:16:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i58fB-0005C9-My
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:16:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id h4so9289964oih.8
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ieRis/JwQOnIbjYZsU2aLyKSS2SxmD7HvZ8nzFRQYQY=;
 b=xAOWtnrEUaFZv4LFZOpgbLxHzRDa1yMoJsfVyVXVJ+F07sesdeTj/iLv08QM6e8RxT
 aaGhMFFXBMMk2uDJq9qbt00TCHXodOTa4nk7d1G9goYr3j8fs5Qlz8w/sK5Q1WJCdycK
 JmFDv/avYiUbYAO2eIg6k4j/GjAMmRIzfVfOrJYfR/oJa6eQZ+vQYsfYkoq2+rHH1NVg
 QtTfkXxMp1H7BaYf9gVlbmxAr6ns7a6Yoh++p2KPXUxLDZ0N9A8POK1jAyuxnyzEWMby
 5dagfZXem0+YWrddtY0blWj0rpVGXgnIaJPpWYHED63FSgSqayWh+oUQZQmtIGIRgcWi
 SFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ieRis/JwQOnIbjYZsU2aLyKSS2SxmD7HvZ8nzFRQYQY=;
 b=R199MqwwWW99xhd3XsBkqMvqYAaiIBoaYPfR2sdZiPrl3+XSTom6tGMU4Ge1j4i1oh
 7aKSmc5yWYjvnojBdVhID08fO9QWrhKWNTZvPHbN5OC3zYDtyR91+SRSatiXJKlvhtjM
 F8svFV4eCo/eLGazZZIpgyURebTD2VhvuEtSbXBgjpA4TjbNQpnVQYsBogZXdBTCpwxg
 P0G9iSxTlcj1cZlJ2I4IMXltnPGgrQ+2FWcM1SaM8Tie34iOu8k0xbkAtyqi8OZ+xvtC
 edEwPXdQHvstN9//vaQcTOiIB0yQS37jFw3j5QioX7dIqH97zthvtoXca6175D6/nXyc
 9LgA==
X-Gm-Message-State: APjAAAUkVeRYhtdFkRIMv6RCOP2hHV1OLY8FlNqlOL64M29G6CXZ7Lxa
 OIUvE39FZAr0VOYi+EX9d5qroaRt5sSfd+4mZLxvqW9SNQI=
X-Google-Smtp-Source: APXvYqwl8k0ZXQ42NJgcfT1RWCOSSwV56Bn7puXGzN8ZSk34txSk2/foVasaZy1gATu4DTn+ctKRxYr7qo/6gKIisyw=
X-Received: by 2002:aca:281a:: with SMTP id 26mr4579275oix.163.1567516560457; 
 Tue, 03 Sep 2019 06:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190801183012.17564-1-peter.maydell@linaro.org>
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 14:15:49 +0100
Message-ID: <CAFEAcA-hBDgVKkzsWu=L63z85y23u3hQqzMLQgmtvMvTYNKhOQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 0/7] target/sparc: Convert to
 do_transaction_failed hook
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark -- ping? Richard has reviewed this series; do you want
more time to test it, or should I just apply it to master
if you don't have any other pending sparc patches?

thanks
-- PMM

On Thu, 1 Aug 2019 at 19:30, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset converts the SPARC target away from the old
> broken do_unassigned_access hook to the new (added in 2017...)
> do_transaction_failed hook. In the process it fixes a number
> of bugs in corner cases.
>
> The SPARC ld/st-with-ASI helper functions are odd in that they
> make use of the cpu_unassigned_access() function as a way of
> raising an MMU fault. We start by making them just directly
> call a new sparc_raise_mmu_fault() function so they don't go
> through the hook function. This in-passing fixes a bug where
> the hook was using GETPC(), which won't work inside a function
> several levels deep in the callstack from a helper function.
>
> The next four patches convert places that were using ld*_phys()
> and st*_phys() and thus getting "implicitly causes an exception
> via do_unassigned_access if it gets a bus error" behaviour.
> We make them all use address_space_ld*/st* functions instead,
> and explicitly handle the transaction-failure case. Variously:
>  * for MMU passthrough, this doesn't change behaviour
>  * for the MXCC stream source/destination ASI accesses,
>    this doesn't change behaviour, but the current behaviour
>    looks a bit weird, so a TODO comment is left in case anybody
>    wants to chase up the actual right behaviour in future
>  * for page table walks this fixes a bug where we would take
>    an exception instead of reporting the page table walk failure
>    with the correct fault status register information
>  * for the page table walk in mmu_probe() this fixes a bug where
>    we would take an exception when we are supposed to just report
>    failure. Note that the spec says that MMU probe operations
>    are supposed to set the fault status registers, but we do not;
>    again I leave this pre-existing bug as a TODO note.
> Next, we remove one entirely pointless and unused ldl_phys()
> call from dump_mmu().
>
> Finally, the last patch can do the very small amount of work to
> change over to the new hook function. This will cause all the
> "handle error" code paths in the preceding patches to become
> active (when a do_unassigned_access hook is present the load
> or store functions will never return an error, because the hook
> will get called and throw an exception first).
>
> I have tested that I can boot a sparc32 debian image, and
> that sparc64 boots up to the firmware prompt, but this could
> certainly use more extensive testing than I have given it.
>
> (After SPARC, the only remaining unassigned-access-hook users
> are RISCV, which crept in while I wasn't looking, and MIPS,
> which is doing something complicated with the Jazz board that
> I haven't yet investigated.)
>
> thanks
> --PMM
>
> Peter Maydell (7):
>   target/sparc: Factor out the body of sparc_cpu_unassigned_access()
>   target/sparc: Check for transaction failures in MMU passthrough ASIs
>   target/sparc: Check for transaction failures in MXCC stream ASI
>     accesses
>   target/sparc: Correctly handle bus errors in page table walks
>   target/sparc: Handle bus errors in mmu_probe()
>   target/sparc: Remove unused ldl_phys from dump_mmu()
>   target/sparc: Switch to do_transaction_failed() hook
>
>  target/sparc/cpu.h         |   8 +-
>  target/sparc/cpu.c         |   2 +-
>  target/sparc/ldst_helper.c | 319 +++++++++++++++++++++----------------
>  target/sparc/mmu_helper.c  |  57 +++++--
>  4 files changed, 238 insertions(+), 148 deletions(-)
>


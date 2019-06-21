Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB49BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBBA2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="al6g0ACw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBBA2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKqO-0005L2-QX
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1heKoP-0003PE-Gr
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1heKi7-0003UA-Ic
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:40:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:43812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1heKi7-0003So-Bm
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:40:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id w79so4807311oif.10
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QRu88ASqSpE5ElN5F8+dkMskCs7Oq8uu+Z49OnBx/GE=;
 b=al6g0ACwXch8X/nPcRbMuyN8ySgijIL1t0lisk0QmBjRyEEgwpFF0uLyCvwTr7bM2K
 vF6nM2Vdatkh0/zTxY+ZgKGmOxjxy9FHLi2KO6JtemgjNE9kCeELXQdHMLqs/mKfkRJC
 R1TOIeFzn9oEcaKXWHP6IuJ9GyPJkxC0e7UfBcTUYRxlzcGsyE1SAQMe20pcFYNlilKR
 wQ1cS+xGDag6QQGQIaSrRId4Z56NX0hJkhIyfFp8Tf/Il/vZZetbsPHoJn3KFzcmzxt8
 Zk32GWzHl0/wulOdHIJNOyxAcgViCiMF5o18eIMsR9cPKrPbXxiTyyEpiFupwDkqlN1r
 klXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QRu88ASqSpE5ElN5F8+dkMskCs7Oq8uu+Z49OnBx/GE=;
 b=c0Y1F9zihO61DaPz3aKKLzMsBBN3/mZ0v7JEpuVG1D1JkApWbRcjlL89TkQpUmE3qy
 uhn9IiH+JXpTG43Iy6M5VY/rJhRr2/4uknbYyccxOk0kZ9hvdhftg1wGsnUzOQjDLl4G
 ATTnIVMnBbD3EnrTcQPKlmS2nSafkkJZww3f6qVULquVoAV7wRyjrhJuJTOILCD5GRF9
 a6dL/iTh3CJ1txY+kH0/NWvVWb52zGGzeQssW4mP0TjwWqwFquup5R7PQdCrXi0hStcB
 ViQJadocw1P9Jx70Ygg6OgPGDx8cxqFvfZjNQ85c/wqM6vLXxeBEYqbRYOhZ4BVXwJAc
 Xbkg==
X-Gm-Message-State: APjAAAXe1iKdrV/q6JmpoX6l8u2BhaFO6W1s13RM0TwFXmAUSnLPTMYd
 JawbipfQOhkn7tZ3dlCJg5o4K1tz2vp1L49XM7SjAg==
X-Google-Smtp-Source: APXvYqwIaWW6r93Qm7QJK5e9OAyjmS9PNCHPmq7sA8fRZgFBTOPVYmZHD9bvJfWCWOFUcFONHdtUUkxDKzJNWVZGBPo=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr2865094oie.48.1561128014317; 
 Fri, 21 Jun 2019 07:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2019 15:40:03 +0100
Message-ID: <CAFEAcA-eD9f25u17BYcj1qGBkdX4B-i0aB-ubGVcbyzfuyCdGA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL v2 00/25] Misc (mostly x86) patches for
 2019-06-21
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

On Fri, 21 Jun 2019 at 12:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 33d609990621dea6c7d056c86f707b8811320ac1:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-18 17:00:52 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8e8cbed09ad9d577955691b4c061b61b602406d1:
>
>   hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (2019-06-21 13:25:29 +0200)
>
> ----------------------------------------------------------------
> * Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (Greg)
> * Static analysis fixes (Igor, Lidong)
> * X86 Hyper-V CPUID improvements (Vitaly)
> * X86 nested virt migration (Liran)
> * New MSR-based features (Xiaoyao)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


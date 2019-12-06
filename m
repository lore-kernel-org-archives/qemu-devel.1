Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23914C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34B820706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFIDUgKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH9p-0002VY-HI
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFRn-0008DP-VU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFRm-000785-Iq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:23:11 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFRm-00075a-8o
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:23:10 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so6081470otd.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lLL/PA8yye6H36YmDTDJ1uLtOzjPFZ9wMfmCB3T9Qaw=;
 b=fFIDUgKOI1eK6U6SOWpzPMY5IN6xLt9g7ESb8lserQJo4MEbirU+ui8SF1e4sw60+S
 E1Xf+J43b/F8q3V8NvBwVLwOIL+W1EsXSxY3Dc2H9NlwF6aeE470tJBYmDgrRTfeLvkF
 HFrAomGXZqDzHmZM+HrnhTUJ5UC5Z9v1YgiMUWq5mBdT9vUPGwE9emNaiP4EtNUwNi45
 FwliZR36D0M1XhKbSPx3HbHNsiLnn40s84Yd8RL2ISNZhZW4RqPVCnakx+J9v3PeY33F
 mxlimG9lU9M5Jw4qT+gnRtXyt5g6zGUS2kYQaFu5E1f2aDM0Kv0AaSW8BLUBbh3XK6yb
 IpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lLL/PA8yye6H36YmDTDJ1uLtOzjPFZ9wMfmCB3T9Qaw=;
 b=ltjCEJcm/I3FhuOZaC1DB8Pe5amMQGm2pw2T8CDX9kg3823LxZynvNeCNYYEgHMmta
 Lz6/l7PZCOsIUTUZbnuXj3hv3+lGDpcs2MGPKLscLMXLhfD9gr6eW33Xi35ZP7cmW68R
 yT7HHsLkftd4A3yZ90oABwKlC8X08ejM5xur3nAxQ0xWcw4a74LJfbQRAVYCnvpgibox
 oLtocwv2YYyDlsBz0VPui2U6wf/Jxi69R9Hwf/ObcY+1kHzLkgd0Oz04RC2Or141s9bS
 +51TysZQJ8aUGFVvPw73EeztJdT/5tq2zgB0annJwprdxFXRLJkoHvDef41nVvGahYcZ
 f+YA==
X-Gm-Message-State: APjAAAXAAekccDXBCsaxOnvD9GU4nJLaESQ0ANAW7434v+0jwkMoyEX8
 uT9TNpPnujl36/pb9LlVQdAy5uO2dzeDUh0oCP86vA==
X-Google-Smtp-Source: APXvYqw03zSH9ugAJHHK2drjDnpsWCs3dJY/2x/6anKkZgiejvRbtuCIpGjAyWmr6rs8oUwX7MlxyngqTAlyD4EoXlY=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr11769992otg.232.1575645789270; 
 Fri, 06 Dec 2019 07:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20191016143410.5023-1-drjones@redhat.com>
In-Reply-To: <20191016143410.5023-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:22:58 +0000
Message-ID: <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
>
> v2:
>  - move from RFC status to v1
>  - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c and kvm64.c
>  - add r-b's from Richard
>
>
> This series is inspired by a series[1] posted by Bijan Mottahedeh about
> a year ago.  The problem described in the cover letter of [1] is easily
> reproducible and some users would like to have the option to avoid it.
> However the solution, which is to adjust the virtual counter offset each
> time the VM transitions to the running state, introduces a different
> problem, which is that the virtual and physical counters diverge.  As
> described in the cover letter of [1] this divergence is easily observed
> when comparing the output of `date` and `hwclock` after suspending the
> guest, waiting a while, and then resuming it.  Because this different
> problem may actually be worse for some users, unlike [1], the series
> posted here makes the virtual counter offset adjustment optional and not
> even enabled by default.  Besides the adjustment being optional, this
> series approaches the needed changes differently to apply them in more
> appropriate locations.  Finally, unlike [1], this series doesn't attempt
> to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, which
> only ticks when the VM is not stopped, is sufficient.

So I guess my overall question is "what is the x86 solution to
this problem, and why is this all arm-specific?" It would also
be helpful to know how it fits into all the other proposals regarding
time in VMs.

thanks
-- PMM


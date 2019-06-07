Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC6EC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F81E20825
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3LCcfYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F81E20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHo2-0001MS-8I
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGza-0003ZC-8h
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGyN-0003wC-UL
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:40:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZGyN-0003ux-PR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:40:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id n2so2223511otl.12
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yMyl7uBfzfRWn3wt0QEADOUdYYV2RLsnlF1NTQo4Rjw=;
 b=b3LCcfYse+pn5+63kwKOKwI1e61j04i8w1sP2o+X6nJXppWTlI83ZAZwXpYkR8VBJz
 flyEGTfJo2UkFnOWppjysXJo+iKSdPF45Dvue1E3FiBiyJBCsw7w+g40d8G/FvuqJDeG
 hlaG4qDYtrjs3CSgqH0tK+qPDEbZqckw6cSMSSWHxqp0T8eKhvjliPLIXGYYBPegIB9n
 uCiFlkEV2N+LqiybcfpkvA3P3mE39WGTd4bPJNX6hiVjljB8oT1ethwjYJjyfMBgfme3
 1lVDeGqomV4frRBF9JjXmDEo2uxpioFtFbSPQmPYQEnRG/IykPyvwYrEdvIJ+Pbj+CcB
 AzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yMyl7uBfzfRWn3wt0QEADOUdYYV2RLsnlF1NTQo4Rjw=;
 b=YLuPDtJv4A1hMJyjnfiEYlkW/nQuhOLMGLM2uBSGCm/Xh+xhEv5Z8gkJ0un4ibK904
 opfGJgMTl7vigQQ1KV7tTEwIRuj63vAw97X+aTWtudxe5DjYj67hTzvJ7PzJaEoDoF2J
 U3AlSxU0T7UhMP6uONTXFcguyxoUV7q03eNQIzNieSUtHsfbAI5x/yqpZm+gwoo0BY7C
 DAWpr1gb7YCkvQ+y96tuhSVROL/uenS3g0GD4XBGbmoEqrO6BtHUhs6QvKmAQiANTYkK
 E1Hrjs/TAzh9j4ftY42zZFmeaWPmBPExkNQ63PwZbR6uxHgO+wjv/l4ErEsWlOXrlJiZ
 bp3Q==
X-Gm-Message-State: APjAAAW23mZ5AgM6uNS8buh+eZ+oJbk42wnAJagnQeIuwWmjoyYIXOmO
 RQmTA9Ot3xQ94iwNNQC0Az14qHIqQhxqzl+VbGARIw==
X-Google-Smtp-Source: APXvYqzYriHIkdwMlcd3suhLfSsN8dFZk+kXyVBcKMVHwQ3i6VL9O8IOwbus+Fm3p+l3hCPPEMbOdTMEFfB2V3bQvvo=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr20093009otp.91.1559922006983; 
 Fri, 07 Jun 2019 08:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-10-peter.maydell@linaro.org>
 <9cf15c60-3cdc-7cac-f9d5-a3fe49b415b6@linaro.org>
In-Reply-To: <9cf15c60-3cdc-7cac-f9d5-a3fe49b415b6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 16:39:56 +0100
Message-ID: <CAFEAcA8ua9HRn2cgNhcYxMav+M+vwsHjPi=e92nuGeVk_fRk1A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 09/42] target/arm: Convert
 VCVTA/VCVTN/VCVTP/VCVTM to decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 16:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/6/19 12:45 PM, Peter Maydell wrote:
> > @@ -3452,6 +3446,15 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
> >          }
> >      }
> >
> > +    if (extract32(insn, 28, 4) == 0xf) {
> > +        /*
> > +         * Encodings with T=1 (Thumb) or unconditional (ARM): these
> > +         * were all handled by the decodetree decoder, so any insn
> > +         * patterns which get here must be UNDEF.
> > +         */
> > +        return 1;
> > +    }
>
> This could be merged into the previous IF.  Unless I'm jumping the gun and this
> too goes away at the end after everything is converted?

Yes, it goes away in patch 41 when we delete the no-longer-used
skeleton of the legacy decoder.

thanks
-- PMM


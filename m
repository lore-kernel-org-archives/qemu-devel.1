Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C777C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385902067D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNXlDR2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385902067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlyVZ-0005ZH-F2
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlyUt-0004lW-Ho
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:38:45 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:33910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlyUr-0007Wp-Om
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:38:43 -0400
Received: by mail-oi1-x234.google.com with SMTP id b8so5862984oic.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=075dXPEDcOcwdP9IQzTAf7X9x4tuD1nd1dHZRVN+ZAU=;
 b=RNXlDR2qA8R9l0wRnRRGC7tuvBll/a30RFLIJGgZOUEBiuh7fwXrXyRRwWQr1irgft
 oX+sVI6xFyJsuC6/TPM7s1O+Cv9Dfj+bNR7WV3YmzDLEqS8S1Sk0ToqF3Nm2nytgGDIe
 yncKri+zGKmIiuZlKdtC794v9uy8L8Z6FJZUhLBYEUJx/n/JstEkhXKT3wv+VasD2gKM
 KSwOZS3BXb5gf7QFqDP8cz+fofpUUjzdSRmp3nD0laD6aB93dvuIcjobqbsLlOF7/+2N
 uaVo//AYfIMW85O5ErJXuEzJoYitJ/vucCvUF6cAvOLdzsq8AV0MI4k7hBiB/r+TBQ/t
 h9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=075dXPEDcOcwdP9IQzTAf7X9x4tuD1nd1dHZRVN+ZAU=;
 b=e+O6svjDEKtomeSstmUWKbB45Nld1qwobS/B+BuGdY4mm9yyguZTpm5a91/p6rE8EQ
 T3LY3tyFPXlXK6Kw20MsMHt1bB7HjRHZGOK63LwItBcaoEX6491aLqIZir9DZqOl5v6k
 RnDWCSep4ou8B5kB9ajpw9FiWMsUvjtp871mV+aplLYhyt9GsQCiTo2s2xR1uMkNdzL1
 GS2XbkKPvWUrYw9xR3BUrRFHl5bpGIqLxYDjALhdBOCwGP9poCTkMVVB0mKVshqwmrGa
 72vJuR4OSUW+qgmiECX/xgqAmP+msq6PcBhqmoGVmtlOW7ONIhWFicGaF0+l5jnYL89x
 YgGQ==
X-Gm-Message-State: AOAM532Dl9axryRhWx2XG6jckqbDRd+9Hpv+V8ZJoWF+XdGVkwZIKhTn
 JFUBG3KEtG/PkLX9/QvsmytbStc8grennkkY4SyulEh6Hwf7TQ==
X-Google-Smtp-Source: ABdhPJzkF1n/Y3NEbzm6UwXzWwGTgiYCdUZsJqLjaKG1Mhz9HT+pL8qnWfLSfDVm9VosKHN8H2ixT73fNtWN1BSyKMU=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3825856oib.146.1592501920205; 
 Thu, 18 Jun 2020 10:38:40 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 18:38:29 +0100
Message-ID: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
Subject: what are the requirements on target/ code for -icount to work
 correctly?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For -icount mode to work, there are requirements on the target/
code (notably around marking up "I/O" instructions). Unfortunately
we've never documented what these are, which makes it pretty rough
for people writing new targets or reviewing changes to existing ones.
Does anybody understand what they actually are?

Some more specific questions on the general theme:

Q1: the comment on gen_io_end() says:
/*
 * cpu->can_do_io is cleared automatically at the beginning of
 * each translation block.  The cost is minimal and only paid
 * for -icount, plus it would be very easy to forget doing it
 * in the translator.  Therefore, backends only need to call
 * gen_io_start.
 */
but in fact multiple backends *do* call gen_io_end(). When
does a backend have to call this, and when not? Or are those
all legacy useless calls we should delete? (If so, can we
just get rid of this function entirely ?)

Q2: is it a requirement that after an insn which is a "known
to be an I/O insn" one (like x86 in/out) and which is marked
up with gen_io_start()/gen_io_end() that we also end the TB?
Or is it OK to generate more insns after that one? If the former,
is there somewhere we can assert() that this is done ?

Q3: why does gen_tb_start() call gen_io_end()? This is the
*start* of the TB so by definition we haven't started doing
any IO yet...

thanks
-- PMM


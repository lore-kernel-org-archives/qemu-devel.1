Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A57C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D95F20792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3LQKrmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D95F20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ4k-0004Wv-NC
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjPyS-0002FR-VQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:22:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51301)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjPyR-0005Rf-6N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:22:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so5515198wml.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O53+kYsYubNjtcguIdONU4ab0ohBhUukjtFA9Fp4sC0=;
 b=r3LQKrmzDjZmhJsVrXKIEbtvqLMxre6fpYezBTblnV5wvwj3yHtnflAfqPDqS6pVUx
 gkWUrmVcY1anKbbYRXdoQZ1zhvr2z+RO1pnLIkADPoZpcrGjFyNRE9ci4RnF4uutp2EO
 /iXhsT42hOtJRUTLw2kJpk7OYshejAtvMb3S5xuah2sb3MmtGVNM2eAvHKdrJqkOaxk6
 5S+QmbAFVgw76VC6Z2325gCO5PEZoidoBR5GDmTw0i41KlZRwTFQ+va7+NdMw7mhkfD+
 b9TztMWNSlAiF5hRxeEcWyd2Wlu69e+AJiY8EjnfMKXKmuXWt2bIDNNgwgemt9yhF1DZ
 8z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O53+kYsYubNjtcguIdONU4ab0ohBhUukjtFA9Fp4sC0=;
 b=dAec6duQmSpCyvakjmGLDLK+pmVYs+Z5h1yrdIA5T4GLBP5MtStPzPTa8BODD0uwtW
 slnsQmqMcgfj2JygBWerltO2cst7L3EHNQrZNnpiEnzalZHrKFE6Gg2nAju8CpuyTtLF
 FzlHS7Ik8wXXP4pBti+hkHzwne19gdDdiVMXkVe0On49NxJtaTgGMjM2iHNPfyu5h7kS
 es6tZrCEeKLXfFJFH+AT9Vbiq94ejru4tVOUlPyF+u40aR2ovyNVuBIJn0oV1USZgr8y
 vmetTeWboiMQu1Ygd6Pj6y4HGJ+Ofjq4ArGoz61rqQeJKtB1mWkBUxioDH3su9rtD4gW
 snKw==
X-Gm-Message-State: AOAM532hzBtg8mzrpuSKCEhBCcFHuef20MWjqk4jnfz+D24kQNG6bTB6
 BlEcvJpv78cwBL6kdqzBzbDH0A==
X-Google-Smtp-Source: ABdhPJzkJyG9aZtlmiVe1Z/H1qyTJbx3McoDEIo3k2pC4LWVm5mCOUIhqreZKd5PLGQNtG236yb5sw==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr8704254wmg.17.1591892548202; 
 Thu, 11 Jun 2020 09:22:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x66sm4746786wmb.40.2020.06.11.09.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:22:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0D111FF7E;
 Thu, 11 Jun 2020 17:22:25 +0100 (BST)
References: <20200611144531.20142-1-alex.bennee@linaro.org>
 <CAFEAcA_joU24OSa8fwbNFb1XMb-FKfcaY4xpjV9EHUdCbWZzwg@mail.gmail.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] logging: add a LOG_TCG_WARN for temp leaks
In-reply-to: <CAFEAcA_joU24OSa8fwbNFb1XMb-FKfcaY4xpjV9EHUdCbWZzwg@mail.gmail.com>
Date: Thu, 11 Jun 2020 17:22:25 +0100
Message-ID: <87eeql4loe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 11 Jun 2020 at 15:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Pretty much all calls to qemu_log are either wrapped in some other
>> enabling check or only enabled with debug defines. Add a specific flag
>> for TCG warnings and expand the documentation of the qemu_log
>> function.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> ---
>
>> -/* main logging function */
>> +/**
>> + * qemu_log: main logging function
>> + *
>> + * Most users shouldn't be calling qemu_log unconditionally as it adds
>> + * noise to logging output. Either use qemu_log_mask() or wrap
>> + * successive log calls a qemu_loglevel_mask() check and
> "inside a"
>
>> + * qemu_log_lock/unlock(). The tracing infrastructure does similar wrap=
ping.
>> + */
>>  int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
>
>> +/* Additional TCG warnings */
>> +#define LOG_TCG_WARN       (1 << 20)
>
> I don't object to the new log group in principle, but it has exactly
> one warning in it. I feel we'd be better to check for all the current
> places that use qemu_log not inside a loglevel_mask condition (or
> which use fprintf, if we still have those) and then see what the
> most reasonable categorization is.

I did a grep of qemu_log and fprintf cases in accel/tcg and tcg and this
was the only one that wasn't:

  - either wrapped by qemu_loglevel_mask()
  - part of an abort/exit() path (which should arguably be converted to err=
or_report/abort)

In the wider code most of the the qemu_logs() I found where in D()
functions in the various device emulations.

--=20
Alex Benn=C3=A9e


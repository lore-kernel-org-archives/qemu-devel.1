Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141CD207D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncBmSayw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141CD207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGSV-0003Jy-9h
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhGQr-0001f1-Ll
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:47:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhGQp-0005yw-MT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:47:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id l11so10628216wru.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=szRLaJkTq8YpJZUftMmZyJasvvWtFd9tKiC/HGO2Zxc=;
 b=ncBmSaywUu9jqwdkTBBQv6/YHOaW7+zObl5wXdHmP54nPJSKuUpG3m0U62o6KM05JO
 WuaDaLSpV7eWvkN9GfI9QrSos+klDtUmV3evEPHJ+0c/6ykYtFwMg4GhrBMl+m9zlzqv
 NS1wfaVww1oXrWkW2CnTKoQ+vsJcBA1XNib7xtqbF+KCmHqksNQaAmDr7fQrSETv7nm7
 ehcnEdFy501hgHAewwsG8TPz2DpNRyd8ink/a0Gx9xWiSaZO9teqzJnjDXXbpNDtrWuq
 M8FLFfA3kzINTKABHnPxA872N0ZUETqvqd6TD8/skkvMq8sHXDHhbB0EXT37h+mect1m
 yoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=szRLaJkTq8YpJZUftMmZyJasvvWtFd9tKiC/HGO2Zxc=;
 b=TTKSYArVQcRiK12wWY2aEbhzJYYOLhdHNhyvt8WDA4wyh1+qDQCo+C8tx2roeueTus
 vknIc44kTz22deJQW7+PSA5rPBP7SYOr4w4gCRBnJz+WQjbYPw5ITGNU/ZY7O52apwsR
 sfPVXczGPlaaV8DrT4lkib+TaAn3rHam4xSrKZkeHbE1cxWRiXkOkC6bALXlXiU81IkT
 Yn9eSNqaUjWJVWdbOADBKiBOW0HyIpHigGl0lzLIs+AqW3FTuPbldiWfQ5Qh7QeGp5wI
 YLA9nj6QWNZTl8846lM7QAhjs59DE20a4PsggLY3ux9iPjHDOMd5EXJ7XSIlr0HSjkWQ
 +UNg==
X-Gm-Message-State: AOAM532xTkoBqCNBakCR12G1sicJNgC2MF4N8nG+4AH2otA70itGMuTJ
 ToDLQ8qtPn79RbYpB4aKApZP4w==
X-Google-Smtp-Source: ABdhPJyxzkn8KvrLEULZ2oya7+EAF25B0MN2xVoZ3skdNunhjqhE6Hi8rzfcP2445omosHksiGiUvw==
X-Received: by 2002:adf:e908:: with SMTP id f8mr10625721wrm.184.1591379193031; 
 Fri, 05 Jun 2020 10:46:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s7sm13284911wrr.60.2020.06.05.10.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:46:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9A1C1FF7E;
 Fri,  5 Jun 2020 18:46:30 +0100 (BST)
References: <20200515144405.20580-1-alex.bennee@linaro.org>
 <20200515144405.20580-6-alex.bennee@linaro.org>
 <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu>
 <87zh9i4u1f.fsf@linaro.org> <87h7vp4n6w.fsf@linaro.org>
 <f8c9afba-4c7c-a410-f42c-c63aa2128ef6@twiddle.net>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <rth@twiddle.net>
Subject: Re: [PULL v2 05/13] accel/tcg: Relax va restrictions on 64-bit guests
In-reply-to: <f8c9afba-4c7c-a410-f42c-c63aa2128ef6@twiddle.net>
Date: Fri, 05 Jun 2020 18:46:30 +0100
Message-ID: <8736794d8p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 6/5/20 7:11 AM, Alex Benn=C3=A9e wrote:
>> @@ -467,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
 int prot,
>>           * It can fail only on 64-bit host with 32-bit target.
>>           * On any other target/host host mmap() handles this error corr=
ectly.
>>           */
>> -        if (!guest_range_valid(start, len)) {
>> +        if (end < start || !guest_range_valid(start, len)) {
>>              errno =3D ENOMEM;
>>              goto fail;
>>          }
>
> Interesting.  I was adjusting guest_range_valid tagged pointers yesterday=
, and
> thought that it looked buggy.

Should be picking this up in guest_range_valid?

--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921C5C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 15:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E072063F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 15:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTM+odr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E072063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcX9H-0004pu-9w
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hcX5k-0003YX-BM
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 11:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hcX5i-0007M7-B9
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 11:29:12 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hcX5e-0007Ag-AK; Sun, 16 Jun 2019 11:29:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id 65so5276617oid.13;
 Sun, 16 Jun 2019 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=vK2oPIWdX926GUcGpRQ9GL1RbklUyvCRcQMw7+hazb8=;
 b=mTM+odr6KdX0eBMiBRnRwhCCANR/YCMH9Ykxq7WcRPtje3A9mz1cBGL3Hd8aojwPSH
 2/afOJKbZhuovnINjMjb2uSl9eUd/ixR49H9uFZ/oCOwQ4O5VH1vuzB8Ns/OrCrd6djh
 A07QqeTd1EIuhN1gdfXGag4PKJMH9udd9hxMpWm7RqYVMwiID5yTTpn9Q/l3k2dTluRT
 b2H9brROds9vBysMzlSBUoJA3MG36WD4CLrUq5no1LDv7Z+M7+3Q2DuXXTY22Nf2u9jR
 HyR7L0VoTjFbu7GamRxcxneCVUtgRZZkRXfjGgN8lPvxryr/pnq3ZBifbVgC+ro6hBW5
 46Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=vK2oPIWdX926GUcGpRQ9GL1RbklUyvCRcQMw7+hazb8=;
 b=NdI9bBEVg1MteZ0U1hy+tobGOzNtcjplmj8fg8XXpc8HiDRDAgjQbR0MvdRQfWCMsV
 uCU41Iti6vnTzMYuTOMoqKG1lodVrQtwYWZeT3aI0c7Ei6e+grogLYs1/qn0uSx3UR1c
 OKnApOa2f8cR+R4kltgCvq26cIQoMqB56/Hd1At8ZLDPE1C0odngE14yB+Ljit0j+6R0
 qZD6EUuZg9g1RUZUEHqyY0qnWOdRZ1AGbZKVRX61r2r6hilNGuw2qIZn4jSGUR1nrdX3
 cSN111j+MuI1M1hbIQM3TbPwfjFnjp4mpVplHY+ZICZ9Mlwmd1BWLaAB8b0crMHovPeM
 onOg==
X-Gm-Message-State: APjAAAX3vB6tMArFpmBHDTnDSFu6gFV9n/AjbUoZqV1FdNcp5uB19LMK
 5/uF/gzshVqFD0x7Zgd5vRNXLfItWfbGXKd0s68=
X-Google-Smtp-Source: APXvYqwgIiGIbcXzgePDeYz01EDCKPRHSoMIe0MTuQapCcIyL7EEKapTTak3/vGGYJIIhWTAUDOeFKK3ETEBvfoRmuU=
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr7410618oif.79.1560698942297; 
 Sun, 16 Jun 2019 08:29:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Sun, 16 Jun 2019 08:29:01
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Sun, 16 Jun 2019 08:29:01
 -0700 (PDT)
In-Reply-To: <c81017d4-0ea0-99f3-854d-6ab4b514a15c@redhat.com>
References: <20190531154735.20809-1-philmd@redhat.com>
 <CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
 <947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
 <431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
 <a3cbd83c-a942-25f4-d424-bbbc0013acec@redhat.com>
 <c81017d4-0ea0-99f3-854d-6ab4b514a15c@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 16 Jun 2019 17:29:01 +0200
Message-ID: <CAL1e-=gEsF=-ttE5Ts=drjRGjOT9nCOmka+adj461U95w--sAw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, jhogan@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Aleksandar: Can we use SEMIHOSTING on KVM MIPS?
>

You can assume the answer is no, we can't. But James Hogan, who maintains
MIPS KVM, may have different view, and his answer would override mine.

Yours,
Aleksandar

> For ARM Peter said:
>
> "semihosting hooks either SVC or HLT instructions, and inside
>  KVM both of those go to EL1, ie to the guest, and can't be
>  trapped to KVM."
>
> Thanks,
>
> Phil.
>

Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACAC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF2A206E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ln7f9i0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF2A206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC36h-0007s6-H2
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 11:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jC35c-0006tH-9L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jC35a-00023y-K5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:16:07 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:40590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jC35a-00022N-Cs
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:16:06 -0400
Received: by mail-ot1-x333.google.com with SMTP id h17so2322571otn.7
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KzxhTmZdycdg1jFmPIAS7boETznN2GLADFKx0n22vVg=;
 b=Ln7f9i0+X2C3U9hP3fSc1IRBrzo2XnkjAHemp7BNzr4F1TxGsFiMojHWlLiBf5wv4m
 gGcCw+niJKOB15xWuk+GX/KUQrIUZF2oUiLPrBDV9Y/WbBtz6noXPMUeQfjHYCFTpxaO
 rsGrLryFXyhv1PXEk5KXuyaYNSdnW5Z09lly83ljfj+dmZqItIhPN3BkZ5Yt7mINe180
 r1UQQBE+H2E/zLtANYKpUK9iLIQqMZMleq+jG6gSg5c7RLol3kIIbjJFxRzDkJAaEd6q
 8KILSorgtwRcgMTtfS/URz7EY8hmt3y9TSKH3TSD+6NndCItGncsgIje84KCIHtLRToH
 l+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KzxhTmZdycdg1jFmPIAS7boETznN2GLADFKx0n22vVg=;
 b=Hi/WuaCdEInRGGL+dWiI5td57msmO3CVg0TGSF0NY6uxU3ebDZuVykEcJo1NNpwc5p
 Rdk3/+4ru9DH6OhEBlMyqo4FHf91DQnIefB/qGrXD5i6lQubI9haFo3G3w44IIR3Jrx3
 fmgcLRKkrN2ZjhrZeHAoNfiV3kRMmWEyvhK6A4aYkXjSUAUQfzplIf/+eH3UupSwAcC1
 F/NgjpFl2S+L66gxiyzpdwKP+rcKsAUQQph+xc0TZkiKACCBjwVDNtS/gKwfoSmYpD9y
 PuB7v/1CMEfFCfMtB2RzGJNaVQy+9yW/cfOfQX7vL2vV833C3gCnUwjCRtYZaGLfKoOC
 gvfg==
X-Gm-Message-State: ANhLgQ1gkADphRu8cIeSyB1Iuob6gEOEjT+7aZLKcpJjWCax8N69Uu5D
 wvXpzkvDYazm/pjzJcFmo86Zc2NeVwtymEWWkDp8lQ==
X-Google-Smtp-Source: ADFU+vu1SEN9aDCr8S6LNQahnox6aUHZCOBSz4I0/3NQZedjv20dxuQOPDDUPMJCJKymDCihx766wjj+DUkeQ+K32Mc=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr2601338ota.221.1583939764999; 
 Wed, 11 Mar 2020 08:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-32-peter.maydell@linaro.org>
 <87blp3x7rr.fsf@dusky.pond.sub.org>
In-Reply-To: <87blp3x7rr.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2020 15:15:53 +0000
Message-ID: <CAFEAcA9EEuAeKm8kXtSJUtm6F3=VfyMxOkESvrZzoVt87HwKpw@mail.gmail.com>
Subject: Re: [PATCH v3 31/33] docs: Stop building qemu-doc
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 14:53, Markus Armbruster <armbru@redhat.com> wrote:
> This appears to lose plain text, PDF and info output.  Any chance to get
> plain text back?

This is deliberate. Consensus when we decided on the docs
transition plan was that plain text was not a useful output
format. (discussed in
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04932.html
and following thread).

Sphinx does support text file generation, so you can if
you really want it generate it with something like
 sphinx-build docs /tmp/docs-out -b text
but:
 * it produces one text file per input file, so you might
as well just read the rST sources
 * at least in the version of Sphinx I have, the text builder
does not implement some of the table markup we use,
so it will fall over partway with a NotImplementedError

PDF similarly is in theory possible via 'latex' builder
(and then running LaTeX on the results). You can also
download a PDF from
https://readthedocs.org/projects/qemu/downloads/
You will find that there are some bits where rendering
is not good (eg long lines that didn't get wrapped so were
just truncated).

Personally I think it's difficult enough managing two
output formats and checking that they look reasonable
(we already found places in the QAPI docs where
clearly nobody had looked at *any* of the rendered
formats) so I think settling on "our supported document
formats are HTML and manpage" is reasonable.

thanks
-- PMM


Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8568C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06AB206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbknzA1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06AB206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPA3U-0007fy-Ot
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 15:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPA0Z-0006Gn-Pr
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPA0Y-0004mg-HP
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:17:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPA0Y-0004lp-CJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:17:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id m14so17543604oic.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rxJFpLRsrddQpnmB85ixvRqXkSTYA2fVhs6TDVNbjYs=;
 b=WbknzA1kvjB+YP35a5M7+pLlX2SXvhgUw1Z7Kju/0+JDn+lNspkOCPS4QsWP7iyWyd
 +IWO3k07wwiaS6F53rcHIK0CilPF1WyuTE14/LuyteTYvxuIu5Jmwy9XlZrdIy/ja4Y/
 Ec+B01spf1NSZjJuYdBRnQPwzRdHz7rcEXTZmVuQ8c/R9voaQ7FERvIulNW/rk3WsMjs
 uZ5X0Qk3pZx4d3fXTrTlCpRBRs7yGaajA6q1G1yYAINVgxAI5g9SSjGwqGIeTgdlTi3a
 L6urlhxh28FGmCoP1hgM8KUdrPQlaUUj5xsnsquSu9AR9DOHIUmeiasq+ORH+OYU/ezN
 XmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rxJFpLRsrddQpnmB85ixvRqXkSTYA2fVhs6TDVNbjYs=;
 b=srJvUJcKryIIcPw+CMXUSW7m/E+pZn4ooA/BDNb7W9FSMSiINEsylDBDjTxyIFo4D8
 beb/0+Iw+bYGH5T9AFP6wXMw1PDC/UGkJIXqlthqb/tRjznWgyhsGUjRGr7OT0uNRJn+
 Hc2cvHEAyrpii37J8GzIRorIOTUh43Eia2T3KZGW7GVNjO43zF5K1gmJfTBuysXf8Nqy
 rL+vX0Zxk6AaRLueFgCAw75rH3+m2JUh0aBVWwMaD48UfaCIRFM2OWIk6k6wLhrI6ZNs
 mbHyeLLe5/Mj6vZwjef2SBx/RdMwaDl50TVeCG5gujDRx0wavU7MMWmODofTLIErGYCL
 QuVw==
X-Gm-Message-State: AGi0Puad5YN7NcWBN1M96CS9YIKXIUkbcxYRGuHdg98qCPtbYwJLmrc9
 9g5cTL2mz7EjFszfGOSEhuyliw9kRWUYMwQl7fzVxw==
X-Google-Smtp-Source: APiQypJH/FNWmtLA1IeyI7DQlZw9k1X+/o51V4NfxLUBZlys4XsZNuSP93vwffAIkYFk6y015nFZKBMWAZWoVAkQlKE=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr3801050oig.48.1587064625302; 
 Thu, 16 Apr 2020 12:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200415173329.4920-1-jsnow@redhat.com>
 <CAFEAcA-ipjVsGuzTWhEq59SvSSSiO+ufcqdcx9JYDOZMLLfPfA@mail.gmail.com>
 <17333d73-f5be-b43b-0087-22529f985a50@redhat.com> <87lfmvfw7c.fsf@linaro.org>
 <1b30c1a3-2a30-7b0e-10f4-c1fba3df2209@redhat.com>
In-Reply-To: <1b30c1a3-2a30-7b0e-10f4-c1fba3df2209@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 20:16:53 +0100
Message-ID: <CAFEAcA9_e67tPSTphDtpXH6T-bgvt7GL3Ud6iCCPEdy+gwBcjg@mail.gmail.com>
Subject: Re: [PATCH RFC] configure: prefer sphinx-build to sphinx-build-3
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 19:22, John Snow <jsnow@redhat.com> wrote:
> My goal is to make virtual environments work out of the box.
>
> I.e., if you run ./configure from inside a VENV, it should "just work."

Yeah, this seems reasonable to me. If I understand your
patch correctly it ought to work without breaking
the setup Markus describes, because in that case
'sphinx-build' exists but will fail the test_sphinx_build
step (because it's a Python 2 sphinx-build) and we'll
then move on and use sphinx-build-3.

Patch looks good to me, but you'll need to rebase and update it
to take account of commits 516e8b7d4a and 988ae6c3a7
now in master.

thanks
-- PMM


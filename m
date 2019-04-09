Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B849C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8812084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLP+Q4MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8812084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtxj-0004pO-Kw
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:51:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDtwr-0004OW-J7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDtwq-0004rG-HE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:50:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDtwq-0004qc-9f
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:50:12 -0400
Received: by mail-ot1-x344.google.com with SMTP id f10so10079229otb.6
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cqzjqiQW6DBOypW8tH2F85uqTEEblvG6EsvNDEkVoUM=;
	b=vLP+Q4MOr8pqSSEUQOnqJfwsk5KUU6V2W0DdjSH4EKc6p0QrTungUxmFnez5aqYvp+
	KmuJsHYAfSD+TUPMI1YnEfV4VdYsR3OEtaHcyPpTC1zTjBWWQ4Bofr5nk7FnK5/FbWOX
	WeNUpsL0YV4nu15/cv0d8ckKdrG12KEMTtxD90itrL6KvVmBmfFqql8IVCdJ8PRkeI7W
	CcMfVCSG2torAIN2e8nm3VaHlgmYdketlGZMKOSdPSkReKR7BzVUuUpCXfJSV0MzR+Pd
	vcfXVJfTXHfSjQGPycF9b0eWYO7XBRGeLZDvckrOibJmk8ArrRiwPXPbpKB5Cwj8PvWj
	EOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cqzjqiQW6DBOypW8tH2F85uqTEEblvG6EsvNDEkVoUM=;
	b=NlWhtsFXspI8ZG93lzAk4ipOldyTsBMmmks89d8DbLuUdrUfpz5Y3+OlRApv7hBHG6
	ooo68h9m3+z5zgmRr+2YLH+4LQVjISXP1ljpEQZFhbVMzps+3duap+K10VxZ3TiWMwQA
	dOArSJI9nUhlmUm6yX3/fd4j5wIWqLF4/NEsoJBFQPdh/S69pUuE9LjwlneJtGqctvUU
	AvbGWMa72N2GwguSx8slvNhTF3FVMg6cpUluOgTXouLwFlFyZ0zkIRw0e98+ZskxYiig
	vzpPSHQ8yRM63O+i0o2X4Y8vznmW6CFOKm3ohrcTdyjUoqSH6HRd+zAK5FKwvvzWs/XN
	SUfA==
X-Gm-Message-State: APjAAAVmf1oQizn713ifiBNsmht+7GCZ16PIZRki3T7+5wT2/mmEy+wY
	MlG3PljzUzdaFyigB6Tiwur6m2wIRllapWOmHoPfPA==
X-Google-Smtp-Source: APXvYqxycs0aZGgKNLfinuz21m0dURJAaLb+fmEv9expE67wNbyK2W7qfTZKfSoFigWR0ZdV80AWkCcfK1j9upORysI=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr25411669otr.323.1554828611134; 
	Tue, 09 Apr 2019 09:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
	<CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
In-Reply-To: <CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 17:50:00 +0100
Message-ID:
 <CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409165000.7ikTFytewLDxsHRYCw23DDH-p8-UOkpHGlpRn-4iB1A@z>

On Tue, 9 Apr 2019 at 17:42, Aruna Jayasena <aruna.15@cse.mrt.ac.lk> wrote:
>
> Yeah this is a stand alone patch.

OK, thanks -- just wanted to check there wasn't a missing
bit. I think this could go in via the qemu-trivial tree
so I have cc'd them.

We're in the middle of a release at the moment, but we
should reopen for development in a couple of weeks. If
this patch still hasn't gone anywhere by a week or so after
that then please follow up with a 'ping' to check it hasn't
been forgotten by accident.

> On Tue, Apr 9, 2019 at 10:10 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk> wrote:
>> >
>> > Removed unwanted includes from cpu-common.h
>> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>> >
>> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>> >
>> > ---
>> >  include/exec/cpu-common.h | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> > index cef8b88a2a..a3594f3f50 100644
>> > --- a/include/exec/cpu-common.h
>> > +++ b/include/exec/cpu-common.h
>> > @@ -7,8 +7,6 @@
>> >  #include "exec/hwaddr.h"
>> >  #endif
>> >
>> > -#include "qemu/bswap.h"
>> > -#include "qemu/queue.h"
>> >  #include "qemu/fprintf-fn.h"
>> >
>>
>> I was surprised that no .c files are implicitly relying
>> on these includes, but apparently none are, so we can
>> safely remove them.
>>
>> A couple of notes:
>>  * this doesn't need to go to qemu-stable as it's just a
>>    code cleanup
>>  * did something go wrong with your sending of this patch?
>>    Its subject is "PATCH 0/4" which would usually indicate
>>    a cover letter for a four-patch series, but this seems
>>    to be a stand-alone patch.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


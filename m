Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF05B22D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxtXVhzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF05B22D0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cl6-0001Rk-GN
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3ckU-00010S-1S
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:03:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3ckR-00021b-Hr
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:03:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so43436535wrw.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=csRbLWCKluskKBGZYNHeFQ8uBvJFp6bevKzj9LAcSgs=;
 b=HxtXVhzb7wmD0+EaP5kKaWqWM91L73tZ9ojTMDIO39ZLX0ssHvidOzY8zCA+4OlIXZ
 2K24cYJX/VovNaqFtXYLXWxR7iTztTsIMG1Ge47GuINUHYdNKe/XV28kwn79xhaV2qfQ
 BkNUFBF0mIV/HxVFpUzI/cttiHbPK7Oz0MOGZpo5FbqJsSfITVjlQRjudrg3IRmZP88J
 i6dWgeEWzQhknMYBKIDb+etgFfrii1/nikF1iShOVW2w1kkvByQzaVvfmB1TkKEoRSpN
 +ZQ0OnQSu4ndjTwwrVAQAFGOqyJY7meUptWD/w7txl7JYJNl5aQXT+ymjYuoUzXCq/2E
 rUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=csRbLWCKluskKBGZYNHeFQ8uBvJFp6bevKzj9LAcSgs=;
 b=O7HEsibo235Nx6CCsvrOHiEy0jk+ljylNumpGAxzMC3Q/ZrdhCAIe4tYqIZTGFwNby
 PLRhGxMf2IBXVRe0FzPUe7gIa3bv02CGZDsZ3Nbl2sBLmuSrh+BykzH71JbzT2yUA4p5
 ioUIzhyqefUDX5KHtfZ+1rCinnU9iYB04hSWXAJcv0TzSGUUgtDp9HCvn22Qr6XvKbcD
 pIchgx7WQsiR6wnPON5wJajuOCtjY9QFsLkfOW43NPCIvyl7TZQKadfzOBPgCb22GlKm
 +WWoeE6/xWPcP168v5jf74fRIEu1IS+RZfOwo++UWgq2ogaHRfdehW5nT3tSG58xGzkY
 w5hQ==
X-Gm-Message-State: AOAM532OV7sZX56Y4SjIhU5cmR1pXE2ryDiRyL1zvRX8EnSfnX+68OxQ
 CGUv39Rlov+ROy4X0dwu6YuQ3A==
X-Google-Smtp-Source: ABdhPJyOXek0q7cfbmyvERJJjQM42838xK/GMTDhnaN8eu7IEaK5ZUcuvvza6NLZPd8txSOgOr1P5Q==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr6586762wru.272.1596708221455; 
 Thu, 06 Aug 2020 03:03:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e16sm5870526wrx.30.2020.08.06.03.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:03:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 498C71FF7E;
 Thu,  6 Aug 2020 11:03:39 +0100 (BST)
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-18-robert.foley@linaro.org>
 <20200806105923.2bd2b0de.cohuck@redhat.com>
 <fefaec2a-0bb3-80e8-7798-7537530ba041@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 17/21] target/s390x: add BQL to do_interrupt and
 cpu_exec_interrupt
In-reply-to: <fefaec2a-0bb3-80e8-7798-7537530ba041@redhat.com>
Date: Thu, 06 Aug 2020 11:03:39 +0100
Message-ID: <87r1skks5g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "open
 list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, cota@braap.org,
 peter.puhov@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/08/20 10:59, Cornelia Huck wrote:
>>>      bool stopped =3D false;
>>> -
>>> +    bool bql =3D !qemu_mutex_iothread_locked();
>>> +    if (bql) {
>>> +        qemu_mutex_lock_iothread();
>>> +    }
>> I'm not sure I like that conditional locking. Can we instead create
>> __s390_cpu_do_interrupt() or so, move the meat of this function there,
>> take the bql unconditionally here, and...
>>=20
>
> Agreed, except the usual convention would be
> s390_cpu_do_interrupt_locked.

We should probably document this convention in CODING_STYLE.rst/Naming

>
> Paolo


--=20
Alex Benn=C3=A9e


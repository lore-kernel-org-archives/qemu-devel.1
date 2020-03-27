Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A66C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2811E206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kebcX7if"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2811E206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlgp-00035d-B7
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHle5-0006NX-U1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHle4-0006sJ-SZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:51:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHle4-0006pE-Lw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:51:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so10647878wrm.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WEEPasaf3DU93ZsU78eAFzFZHVuT28DWn98dgfuYqOk=;
 b=kebcX7ifE8SDxa8cDbsWRuqn6G+J7FonTgkHdwOYNJt5YOm12ykKl7+8xGyGC/O+6H
 xGQDeSdCuz5RW+PCxSWjW72X0RCbGlR9iZK2dOhiBwAKyGV877Z2JWbp5kfobm7sy8r4
 Go6uR8Jy8Lup7BpGiuaBb6+bvaflpxiaDXopvrJjZ4ImJvB4xi6C74faw5r4MqC/9zQv
 lhjqGzstP/uhK61t6oEoKkZcAlJV6hI6BH9zdM0TKK2D14Dr4K2YzGvBqoCiu4FaOgdJ
 s4r6hPcJ8KCYhxEB6rG8YXLRnOaOtPHLTRshmclJqihJv+chX8hC7UMjc7cZYx0WIqvY
 IY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WEEPasaf3DU93ZsU78eAFzFZHVuT28DWn98dgfuYqOk=;
 b=B6AOI5PBGVkajRRhIz3i0kkRJ5h3AvOaJDXv51O0MVh4WOCi3lI48n4iIuo2wxgFPm
 pZKsWM9d2iHcbYDIuxOxl/fKrR/BuOjaxSty/Q7PRhz/4zgDybjnnWGKRcimlCyCku/x
 IXfV1FMA+aLHa04FtpLJ4RbZoK2/2szWguWwWaz3T9bDHYfGhK+qi6/bWrlcmeqlM4P+
 9HQskXx0kroo2EUGOhwwCKMPpTrp6VDrE1y3cyVoJPlTR8FCKRLD4NE7vfaAI9i9mpMh
 iF5hoRZCaPw3FwZ+sPaSQbTRb1c3iIwz1S1vvUmsjBKjg0a+45oduT1p7ZxAAuiuuO0f
 cUUg==
X-Gm-Message-State: ANhLgQ3nilWOQLdUf4TiV5iQLKZUXn4sH95vCQGRHVrC+vSkbVQZgXTF
 N7254SXPVlxipbdx5h+CXuAv/A==
X-Google-Smtp-Source: ADFU+vt61IRU5i3kpeIo6C1t85pa9PGBZwl6rh/Xc5HFrZHOdzP5I6BdfHcBwmtSiTcBsoiyv/XdHg==
X-Received: by 2002:a05:6000:11c2:: with SMTP id
 i2mr15071630wrx.210.1585302679723; 
 Fri, 27 Mar 2020 02:51:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm7761260wrx.48.2020.03.27.02.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:51:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6BE61FF7E;
 Fri, 27 Mar 2020 09:51:17 +0000 (GMT)
References: <20200326170121.13045-1-alex.bennee@linaro.org>
 <CAFEAcA8Lo84gNk2tFCKsgM_O50bXTCs6Z9jH6aCvfDA56TDCmA@mail.gmail.com>
 <ba33454a-6e57-960a-7114-fc71a9f09442@redhat.com>
 <CAFEAcA_KSVHkVznGD=cxzLaHSbPmWLN6MSqWHBqB8_ux05gD7A@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
In-reply-to: <CAFEAcA_KSVHkVznGD=cxzLaHSbPmWLN6MSqWHBqB8_ux05gD7A@mail.gmail.com>
Date: Fri, 27 Mar 2020 09:51:17 +0000
Message-ID: <87y2rmm8h6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 26 Mar 2020 at 18:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 26/03/20 18:14, Peter Maydell wrote:
>> >> +#ifndef atomic_fetch_add
>> >>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC=
_SEQ_CST)
>> >>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC=
_SEQ_CST)
>> >>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC=
_SEQ_CST)
>> >>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_=
SEQ_CST)
>> >>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC=
_SEQ_CST)
>> >> +#endif
>> >
>> > This will work around FreeBSD's current implementation in particular,
>> > but I don't think there's anything in the C11 spec that mandates that
>> > atomic_fetch_add() and friends have to be macros and not simply
>> > functions...
>>
>> That's not a problem as long as they are all functions, the macros would
>> simply override the function-based implementation.
>
> Oh yes, so it would. I think I was also vaguely thinking in terms
> of FreeBSD being the leading edge of "one day most or all of our
> hosts will have a full stdatomic.h", so maybe we should shift to
> use-host-stdatomic-by-default, with the use of the gcc __atomic*
> as the fallback at some point ?

At some point but I suspect not right now.

So what's the conclusion for this patch? Are people happy with it as a
sticking plaster I can apply to the bounced testing PR?

--=20
Alex Benn=C3=A9e


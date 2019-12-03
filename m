Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F77C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0046B206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGPj0Eo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0046B206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6EO-0007Cj-2j
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic6BD-0004xY-BL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic6BB-0008IE-4e
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:17:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic6B2-0008CU-OB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:17:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id u18so2513408wmc.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=czDIYX7qz+A0cudiap26LVM70Nz40ZVWYvcZEWbO/iM=;
 b=TGPj0Eo50K6u1WHTbdZPzUCUOGbTjGEuT2zx6WxFQ2kw7VjZvmZBcXrr54ByZJWTgA
 saJPJNIVve880j1BD5lq/Jr7b6iazlLpc+Kt7oGjsiao/DVX12d0Wb1Vk3pFUw5f5UY/
 56a38B/2IZK0VOQ3BUXZefILA5uI5KSQgAUAnP2hVS6lODxuDiNMNT/l7nOXF3FJRi7k
 vAv28jrOJuAgBAbTwFze/W3/mdHAxZjYPvPH++qIiovVmmaLI50zROFqa4oqnhLWtLtI
 uIJkHULP1cS4rQL/kBC7ctxikV4NzA2fk184z5VDp+IHDm/6sn3WCUtz8Iu5PH3SEmMj
 YqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=czDIYX7qz+A0cudiap26LVM70Nz40ZVWYvcZEWbO/iM=;
 b=SQ/KyFD8C/UagRZL547Ya/zM7mNn0gicGifF2sLWG3En0cC6YNFyCoog5XV8c4cZY+
 UGAJlyL2oyKskNGzQUB7ivC9/FPxeIT37ezzn4Vhv8OJjaVbIyFBFZxdH5NO1TK/0rba
 FedeGLlpFuTqvHUwWsp3iNQCDy0usuosjSqPQkBd4WnSf/oMxEpC7d2HJksoXD8F2Oxb
 wyASmzODLyHcqtVh3Wy6COUY0PvDlHVfvd1+Jku75MfgO+vp3zm/fD6H4qJdwPABgwd5
 SjxieSs1/lh8zfkX/oDHk3xWvJj2NITfjMIVNmGn+XM8xnMUlCTAxylNdBb4RZi+5OrL
 KAyA==
X-Gm-Message-State: APjAAAXfLKqVSEQ/78pcaZDJ7I2SOXjfjE+2Wt53k3wKeaDs7MfgpG4a
 bEkB2HOdrKdAeCAYkh2Zftt20g==
X-Google-Smtp-Source: APXvYqwHW16umi/LnQ3SaNW5CWwzszx/N8EaJmlrA2u9omDEMrEVcKRJh3nmNgW5vEcQ/eFpaKepKQ==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr14064794wmi.149.1575371821952; 
 Tue, 03 Dec 2019 03:17:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j12sm3326110wrw.54.2019.12.03.03.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 03:17:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C76C51FF87;
 Tue,  3 Dec 2019 11:16:59 +0000 (GMT)
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
 <20191127220602.10827-2-jcmvbkbc@gmail.com>
 <3c02ba4a-11fe-4d6a-e6d9-f1d164528d85@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] exec: flush CPU TB cache in breakpoint_invalidate
In-reply-to: <3c02ba4a-11fe-4d6a-e6d9-f1d164528d85@linaro.org>
Date: Tue, 03 Dec 2019 11:16:59 +0000
Message-ID: <87immxbqvo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/27/19 10:06 PM, Max Filippov wrote:
>> When a breakpoint is inserted at location for which there's currently no
>> virtual to physical translation no action is taken on CPU TB cache. If a
>> TB for that virtual address already exists but is not visible ATM the
>> breakpoint won't be hit next time an instruction at that address will be
>> executed.
>>=20
>> Flush entire CPU TB cache in breakpoint_invalidate to force
>> re-translation of all TBs for the breakpoint address.
>>=20
>> This change fixes the following scenario:
>> - linux user application is running
>> - a breakpoint is inserted from QEMU gdbstub for a user address that is
>>   not currently present in the target CPU TLB
>> - an instruction at that address is executed, but the external debugger
>>   doesn't get control.
>>=20
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>> Changes RFC->v1:
>> - do tb_flush in breakpoint_invalidate unconditionally
>
> Unlike Paolo, I don't think this is a good idea.

We previously had a general tb_flush during the MTTCG implementation as
a temporary fix. It was changed back in 406bc339b0 and it would be nice
to minimise the flushing of code if we can. While most interactive users
aren't going to notice the temporary slow down it would suck for any
automated gdb scripting.

>
> If I was going to change anything here, I'd change this to not use
> cpu_get_phys_page_attrs_debug but using the caching available from the ac=
tual
> cputlb, using cc->tlb_fill() in probe mode -- something akin to probe_acc=
ess(),
> but not returning a host address, nor handling watchpoints nor notdirty.
>
> This would help flushing too much by distinguishing different tbs for the=
 same
> virtual address mapping to a different physical address.
>
>
> r~


--=20
Alex Benn=C3=A9e


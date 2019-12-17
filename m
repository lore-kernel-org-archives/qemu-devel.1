Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69681C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3319120733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUsdD0c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3319120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDES-00045l-E7
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 08:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihDDY-0003dt-VG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihDDW-0003aL-Kl
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:48:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihDDW-0003Ts-DG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576590529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hk+7HmkDULmMy1KOGnl54fo1+VKeLwGRqnCJ2Jww1l4=;
 b=LUsdD0c4ePqZBwzyEhnuF5kQR6knIToBUjoVlEF9dbQibf0u0uy9qgxKwQopOyp9OTkPDB
 YZjjpx4FEJeuRtwhj7TEUD3ka7mHQkMDb8IWJEhgBL0jYuKdE18eywGAtbHhop3sPsLxHl
 Wp85oKKXdUK8PDpbQUJTn4qNb/8ztU4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-anLM4B8iP1O69O2xyA74QA-1; Tue, 17 Dec 2019 08:48:45 -0500
Received: by mail-wr1-f71.google.com with SMTP id b13so3967434wrx.22
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 05:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rHuHjNyj7YHGt3juuZOtLnoTZRz3IScSwGiMs6zt8ck=;
 b=nB09QdRWXV/kt7lP2CDNxMsoK3sbyy4oJwCCnBSAFOdWHpLzJFnDKXf1b8ViPFawHO
 zM8yGZZfoiqXZoUTjr63EhGWcW+pTgc9NVDCUhjMhwB91vTZlxqvifIGkVqElm33lII1
 G89lfJ41CnaQEmlS3z2v+3zyn5mpzUhI+3/G7TZ5ZuMsxJ6A0D1EbqMvAvwHeDB1veKY
 +EOg7ZsGuo5HCJQRrY14vO7G0+TrioE8T8h+Pnu1uQKAex09qrTrnKeyb8ihCkpAGRdV
 eRUEgZZBnBvu8ZbpgkcvE0gRPCIpum4xicnutM3qJ8oFyHUprtWg8eqBLci00sJ5oJCN
 eIZg==
X-Gm-Message-State: APjAAAVHMjYAPeMdhbbdCWrSBg8u0F+EBboEcglwwZyTuBVc0sVQWjZu
 Oe6AItugNJPfjGBRaPBQo4WWgKS5J+0ew4Bp0DHw73EXW5+aEDe8tu9ZWwwtfFXGU7ODvcyAXg0
 QuTEBUUJt3JevwgQ=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5594305wmi.51.1576590524915;
 Tue, 17 Dec 2019 05:48:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvIRSSn7wNW+SZlBEgWv65sN31XULJnO6YUaMbJf0XTukRazEFP8k9yABUEudLmR3+A7soZg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5594283wmi.51.1576590524695;
 Tue, 17 Dec 2019 05:48:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id 2sm25796684wrq.31.2019.12.17.05.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 05:48:44 -0800 (PST)
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com> <87bls7vzjc.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com>
Date: Tue, 17 Dec 2019 14:48:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87bls7vzjc.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: anLM4B8iP1O69O2xyA74QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 14:42, Alex Benn=C3=A9e wrote:
>> Why do you need to set exception_index to something other than -1 (using
>> cpu_loop_exit_noexc for example)?
> If there is no exception to process we won't exit the main loop which we
> need to do if we want to wait until there is data to read.

Okay.

>> Using ->stop here is a bit weird, since ->stop is usually related to
>> pause_all_vcpus.
>=20
> Arguably we could come up with a better API to cpu.c but this allows us
> to use cpu_resume(c->sleeping_cpu) when waking up rather than hand
> rolling our own wake-up mechanism.

But we already have the right wake-up mechanism, which is
cpu->halted/cpu_has_work.  That also makes it possible to just use
EXCP_HALTED instead of adding a new EXCP_BLOCKED.

Paolo



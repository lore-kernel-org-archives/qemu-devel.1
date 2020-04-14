Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FAFC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B64320678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjPRjyW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B64320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOb3-00032M-Ed
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOSR-00065N-Es
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOSQ-0000p6-Cj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:30:43 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jONsv-0005l5-5X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:54:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so14931616wrs.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+M3YxcBpVTHRfV9T7ktJT+BMteoS6RiXxkl/ZW/4gQQ=;
 b=AjPRjyW3vGNa0PepY/zEDmiFkT33OBhhXrwxiV3odnTsEfBHc+cxtRo4KrOOASj1JG
 r8hrnd6eOcORD7whdiiak9c337bUftrBRUL/2F5GUeE82G8iTYvMSaz5LPOduEK30Lrx
 0595IwD7Uqh4uvef4hPpf40GGvjaFUjGUcQvn/fUo9YKcTopoIxoFVTLRrY6UsOgY6KH
 TGRSScF2SDXy8yWjW3kXwZX+DArIraFs4BD6ww6/xXVLO66HIdmetwh3mDi/oML3jR67
 saR6nAIAH2e8fPkiKVB/cRwswO0udUS8JTiyU26OaNRrMwTEWgzUhp61WDYx2x/HjoDw
 jxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+M3YxcBpVTHRfV9T7ktJT+BMteoS6RiXxkl/ZW/4gQQ=;
 b=Gk8Q00DnozgMXD+SaWrKC1zLjCcnF16SKvC1Ii3qTRU+USR2lqyikCZYsrB84HjzOz
 Q+iBVDhutjTue7atAFyB9Pvy07SEL6b/t4EwaZG7gD9AK2PYjkyBSo6z1cgl9R2Qt0JC
 lB3LWJCUcKzE7ZopaVKgLzmwMQCSTsLBPTi20T7f1r2puSvFIvuk6k5KP7hz4l7fuqKd
 Fyi1fXXnAE1X92u4wCQsTfr1S5ea3ehh2fD0oXhqG8V1CRHTzSGj2cWmZ4Is46iak0Km
 ScRlXUNYaFD8xXa+jCGw3El7Fz6XKlMCZSz2TP/1E8tZRvB31Nl11vd+oA90y0PBouLE
 8Yog==
X-Gm-Message-State: AGi0Pua1iSJosSffvYBREInreIE1SpCKD7i/LTvN/MW9EB6OMpr0AE0K
 LZJpEmij1Pu8aNwjgJNmp7Be3Q==
X-Google-Smtp-Source: APiQypL0/7Zw+huV5HN6+Vd9WgnJjFqV3FVTDJpTmAbr94tWlC4dZzvKxGAJ053CmvPQlaTUp5A+Lg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr24273645wrc.184.1586879639680; 
 Tue, 14 Apr 2020 08:53:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k14sm20018303wrp.53.2020.04.14.08.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 08:53:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 660441FF7E;
 Tue, 14 Apr 2020 16:53:51 +0100 (BST)
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <20200411182934.28678-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0? 3/3] kernel-doc: Use c:struct for Sphinx 3.0
 and later
In-reply-to: <20200411182934.28678-4-peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 16:53:51 +0100
Message-ID: <871roq9i7k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> The kernel-doc Sphinx plugin and associated script currently emit
> 'c:type' directives for "struct foo" documentation.
>
> Sphinx 3.0 warns about this:
>   /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../include/exec/memory=
.h:3: WARNING: Type must be either just a name or a typedef-like declaratio=
n.
>   If just a name:
>     Error in declarator or parameters
>     Invalid C declaration: Expected identifier in nested name, got keywor=
d: struct [error at 6]
>       struct MemoryListener
>       ------^
>   If typedef-like declaration:
>     Error in declarator or parameters
>     Invalid C declaration: Expected identifier in nested name. [error at =
21]
>       struct MemoryListener
>       ---------------------^
>
> because it wants us to use the new-in-3.0 'c:struct' instead.
>
> Plumb the Sphinx version through to the kernel-doc script
> and use it to select 'c:struct' for newer versions than 3.0.
>
> Fixes: LP:1872113
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Looks reasonable although I don't have a way of testing it on my system.
Any idea what systems have the latest sphinx 3 on them? I tried fedora
but that still has 1.8.4 so it's not that bleeding edge.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


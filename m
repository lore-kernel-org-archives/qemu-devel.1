Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED7DC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 23:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18971206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 23:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUpX9MuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18971206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq3by-0005ju-16
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 18:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iq3bD-0004X6-Bv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 18:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iq3bC-0007gD-7e
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 18:21:51 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iq3bB-0007al-Uy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 18:21:50 -0500
Received: by mail-pj1-x1043.google.com with SMTP id l35so1628557pje.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:cc:from:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=kp4O2WYhB8M8qVlAzWL7aiNxbf6XZnIfXB6Jtayw4L4=;
 b=RUpX9MuFG6Ns9tW/Xr3iOZeoKJxbdY3eeb3NdsmnuVTsrbzYRelZmK4G4J0SDJR3J4
 DL6NtHNwEDOaXHqar+3rIe6NDT1r5bSGp6Pf1vaaRK/iE/j4DJ/V+taQFvtXBwTrSghw
 vGTYRpAJsLodc437iqZeQDramO91KzdhBhmIumZPspc0UCOaAb6a3WFLnjVTId1X1kFd
 CIvghCeSInE1D9w+26Z61JVWG2O+DiDknm7kHezm8LXv+kE5Gq9DtzM1tc0hhMf/X8h3
 53LEmH2uL3UB8Voixr1TtTg/MAO811FeE7YKOEMaFaiGZNNuuA4i9r8eWygL9zikCZiu
 /H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:cc:from:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=kp4O2WYhB8M8qVlAzWL7aiNxbf6XZnIfXB6Jtayw4L4=;
 b=iyK0vIP+UbHZ9l95cUjqg6r/qRBeZ9wAkZzdNe4Y+mkmutIcU7FzZJJLib0K4uOCVA
 fQ6S1vQy4uQjf/5S3rer8mUHjYSLXA0tyqWXYEJSFKhG4CLQN+SGNspMeMYEsOxHcbcr
 ENOlSyf8QwDzi6LhMWHF7eUpGOoV7KPY+HHddasZEM1tnJEXAwFdHaQUOdrsUsQkZkRJ
 Li7I3vBw3nxB1bW8aXpj57EHoYpI2TiFDL94jQUtuTF5eepoEphedw7CmCzp5NEUJJCw
 uW7rBbY7MPUQodCysa53XNfhZLOyp/GaHl0D0FcszYEFGq4vzlx+5vMOFWWwZxJYhKZq
 nSHw==
X-Gm-Message-State: APjAAAVam19IjTk7Y9SgX0zdlhibyTzCiN2drZuE8lFlsszdQDZFGUvJ
 YMPgBBJGMLy+h2JHXwT14lqyFQ==
X-Google-Smtp-Source: APXvYqz6xXUJ4zZZpOTSaL1cVn4+QLeQO/6XZJYY6tfdUGJNavPb6Q34Zd5A/E97ytkTnzzkh/y0fQ==
X-Received: by 2002:a17:902:b083:: with SMTP id
 p3mr1156648plr.141.1578698508540; 
 Fri, 10 Jan 2020 15:21:48 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id z6sm4232940pfa.155.2020.01.10.15.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 15:21:48 -0800 (PST)
Date: Fri, 10 Jan 2020 15:21:48 -0800 (PST)
X-Google-Original-Date: Fri, 10 Jan 2020 15:15:14 PST (-0800)
Subject: Re: [PATCH v1 20/36] target/riscv: Add support for virtual interrupt
 setting
CC: Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: richard.henderson@linaro.org
In-Reply-To: <200650e5-cb77-0518-8f27-30d0cf23de22@linaro.org>
References: <200650e5-cb77-0518-8f27-30d0cf23de22@linaro.org>
 <2389483485d4642a6e5670e2546c62e493e91fd6.1575914822.git.alistair.francis@wdc.com>
 <cover.1575914822.git.alistair.francis@wdc.com>
 <mhng-6814f8b9-d54a-4663-900c-83023307a658@palmerdabbelt-glaptop>
Message-ID: <mhng-ea44da17-abec-4d68-b276-9ac8cd3e18ce@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 08 Jan 2020 18:33:40 PST (-0800), richard.henderson@linaro.org wrote:
> On 1/9/20 11:49 AM, Palmer Dabbelt wrote:
>>> +    irqs = (pending & ~env->mideleg & -mie) | (pending &  env->mideleg & -sie);
>>
>> Isn't "-unsigned" implementation defined?  I can't get GCC to throw a warning
>> and it was already there, so maybe I'm just wrong?
>
> (1) You're confusing implementation defined with undefined, and unsigned
> arithmetic is the former not the latter.
>
> (2) There is no such thing as ones-compliment or sign-magnitude integer
> hardware anymore, so for this case "implementation defined" is in fact universal.
>
> (3) We build with -fwrapv, so we're explicitly asking for sane behaviour from
> our signed types as well.

Ah, thanks -- I didn't know we had -fwrapv.  In that case we're safe!

>
>
> r~


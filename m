Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEDB20679
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 19:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NePQKqDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEDB20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0WLh-0004nu-C6
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 15:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1i0WKi-000485-KQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1i0WKg-0005k6-D9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:31:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1i0WKe-0005Wk-HT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 15:31:46 -0400
Received: by mail-pl1-x641.google.com with SMTP id d3so1887287plr.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=X1tYQICcT1TcvBHCeuRcjOVj2LjQo3Fx9K9EITnTngI=;
 b=NePQKqDzhhN1UR5RPsKF/wvNh7kfRJlAwNbNNFZFCbld/mQ7kT0IomYB0zO0CHUw3x
 x4pi57HXq1OasLRiXEj1SP+rFiypEHwYzsEK9FB07BxFTbhbX33FQuZ5aIW1MbQtJ1Za
 GYfh40v4XdswynJFchmknuQ3h1geMFzs9f1DBYrLXu0qiwkSze6HV6xIlixj4kcy87lI
 SG5c/cC/lYmH35RKa+/1llb7BK96iS7CjIeRj8Tb7j8JjlNpoFAWGfTrrdkp6K9Sn5bt
 JM0tNr5Qg6TORW6hvN8dfofIue59QdE9jvBcWnlWgo824w97AumMGzUO+ODpsblmVBQu
 ddEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=X1tYQICcT1TcvBHCeuRcjOVj2LjQo3Fx9K9EITnTngI=;
 b=RJNSWq0PYqkeKtRk9W7XNp0YbI7qE7PsZEkNDv6iK/JsbEPVpS4iVqyITJE/DoLzqo
 m1BnvDv+3U91nuFIapAs9ntwQDhNsB6Bu82UI5phEz7KTTwPRXSInJUSSh4CM9I8ax4p
 A/qwHN+br4SwiRnYC3TRiVlatdH4XTOwh2+TB10arYASpdkbNSpHQ7uP77uyvapxTTBb
 E9jqDxZ3OJe1OU7tLYAr38UY2IKhN3WTT4x17UIhhqFWG3ZEfiG6pNezkJd8rseZDVEY
 jiQEv0JsEnlOFqUHBYH9V6weIvkJwFb1gq9LT2d3prrJlm78wnBKFGhSH6msZYQGPgnd
 eaSw==
X-Gm-Message-State: APjAAAWzpEAsL6l5xtd2DaABlKZE04aKTcxkQKIgB9XZXI4Crl18tzmn
 Yzk2vyNzsi1oGoTARfVWCnfIJQ==
X-Google-Smtp-Source: APXvYqzEOA9wUM0sIA/7o7Qym737sXiB+8IZgNqVIjRo7yHlfUcaEDdfDWYrrciltpLud3CLvMZVIA==
X-Received: by 2002:a17:902:5a0d:: with SMTP id
 q13mr6499478pli.5.1566415901098; 
 Wed, 21 Aug 2019 12:31:41 -0700 (PDT)
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net. [184.188.36.2])
 by smtp.gmail.com with ESMTPSA id 16sm48884127pfc.66.2019.08.21.12.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 12:31:40 -0700 (PDT)
Date: Wed, 21 Aug 2019 12:31:40 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Aug 2019 12:30:25 PDT (-0700)
In-Reply-To: <CAKmqyKM44ZAHgc5cYAiAXXtVG=dMcX1i7FLn+2mMwM1Av4Gqzg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-04cdd93a-df3e-4de0-b1f5-0365f2be0fab@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, bastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, zhiwei_liu@c-sky.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 14:37:52 PDT (-0700), alistair23@gmail.com wrote:
> On Thu, Aug 15, 2019 at 2:07 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 15 Aug 2019 at 09:53, Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com> wrote:
>> >
>> > > We can accept draft
>> > > extensions in QEMU as long as they are disabled by default.
>>
>> > Hi, Alistair, Palmer,
>> >
>> > Is this an official stance of QEMU community, or perhaps Alistair's
>> > personal judgement, or maybe a rule within risv subcomunity?
>>
>> Alistair asked on a previous thread; my view was:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03364.html
>> and nobody else spoke up disagreeing (summary: should at least be
>> disabled-by-default and only enabled by setting an explicit
>> property whose name should start with the 'x-' prefix).
>
> Agreed!
>
>>
>> In general QEMU does sometimes introduce experimental extensions
>> (we've had them in the block layer, for example) and so the 'x-'
>> property to enable them is a reasonably established convention.
>> I think it's a reasonable compromise to allow this sort of work
>> to start and not have to live out-of-tree for a long time, without
>> confusing users or getting into a situation where some QEMU
>> versions behave differently or to obsolete drafts of a spec
>> without it being clear from the command line that experimental
>> extensions are being enabled.
>>
>> There is also an element of "submaintainer judgement" to be applied
>> here -- upstream is probably not the place for a draft extension
>> to be implemented if it is:
>>  * still fast moving or subject to major changes of design direction
>>  * major changes to the codebase (especially if it requires
>>    changes to core code) that might later need to be redone
>>    entirely differently
>>  * still experimental
>
> Yep, agreed. For RISC-V I think this would extend to only allowing
> extensions that have backing from the foundation and are under active
> discussion.

My general philosophy here is that we'll take anything written down in an 
official RISC-V ISA manual (ie, the ones actually released by the foundation).  
This provides a single source of truth for what an extension name / version 
means, which is important to avoid confusion.  If it's a ratified extension 
then I see no reason not to support it on my end.  For frozen extensions we 
should probably just wait the 45 days until they go up for a ratification vote, 
but I'd be happy to start reviewing patches then (or earlier :)).

If the spec is a draft in the ISA manual then we need to worry about the 
support burden, which I don't have a fixed criteria for -- generally there 
shouldn't be issues here, but early drafts can be in a state where they're 
going to change extensively and are unlikely to be used by anyone.  There's 
also the question of "what is an official release of a draft specification?".  

That's a bit awkward right now: the current ratified ISA manual contains 
version 0.3 of the hypervisor extension, but I just talked to Andrew and the 
plan is to remove the draft extensions from the ratified manuals because these 
drafts are old and the official manuals update slowly.  For now I guess we'll 
need an an-hoc way of determining if a draft extension has been officially 
versioned or not, which is a bit of a headache.

We already have examples of supporting draft extensions, including priv-1.9.1.  
This does cause some pain for us on the QEMU side (CSR bits have different 
semantics between the specs), but there's 1.9.1 hardware out there and the port 
continues to be useful so I'd be in favor of keeping it around for now.  I 
suppose there is an implicit risk that draft extensions will be deprecated, but 
the "x-" prefix, draft status, and long deprecation period should be sufficient 
to inform users of the risk.  I wouldn't be opposed to adding a "this is a 
draft ISA" warning, but I feel like it might be a bit overkill.

>
> Alistair
>
>>
>> thanks
>> -- PMM


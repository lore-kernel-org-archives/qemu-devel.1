Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3FFC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 06:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB7C20714
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 06:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuQUQywF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB7C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI57b-0007do-Gg
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 02:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jI573-0007FD-Nc
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 02:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jI572-0007uS-MV
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 02:38:33 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jI572-0007rs-Dm
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 02:38:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id a23so4384275plm.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 23:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FBhGB9CUYk0eqbQsnC0WzrULrsDRaIkwiVLiAc4QFsg=;
 b=EuQUQywFeF7lD/DlcalgbBlHquftWhkDxikbKC0U2k39Cy1JmIhjZmEyMFQw1XnZmn
 L72fL2QgNsTwQwDSZCdNohg5VnnjuzgY3MCtfd6K6WunNpAMWP/GqoZa7g+CRTXbpSF3
 X+jMpuYdL6m/Pdz1tgttid4HM4jujnXELxyx1Ud/uHU86Y95yxdeZ9ACKlAOukwBVVnT
 IIqwDhargkm3nm4cQRWOwmyXXz4yN69Zady27bIi+RUxcs8niQUc6pOmoW1RGBlknGR3
 rvkovUcHi+ibVuiOT8Ugp8eIHrSE/LKQvJFpa5TXunjc6u6a5JyBqDA/ezgW1gSaf+b/
 pCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FBhGB9CUYk0eqbQsnC0WzrULrsDRaIkwiVLiAc4QFsg=;
 b=jYON68EWysHLPuEzzhzCgJ9AOt3veC7JPDCOtwEPlU0tFe27y9pCQM3DecVqWq4PJl
 A3PkX1utNUlcNtwPmBVw1WsjGggrxY0ApdCf4xYeJ1nD6ArHqmcvX6xZFp4l3zSJOPzl
 RNzrcLRjFG4h2bwbUGldmUvxSCNnw6sbSCIIApW12HIijFexdSNQZHq9fX79I4T0nq7O
 rsCjS78OyeyOb/YRG1r7HCsTjuDbrvVz7tGktX22Xd/jOD6OGEOnNY6IiRjSuuKG6MNL
 t3MT57u7BYb63kucivUQsnopiMIc4n7clciocQwMz42/sewu3I/cRXLPOgTZVaGJy23Y
 aznw==
X-Gm-Message-State: ANhLgQ3ZlbRj+oBQ7RHuBDP3kk489JZN2nzpuPrdlNfK0Y+P70ynWWRC
 B4CmkH0ejPiBrUlB1W6GJdQ4K7DzGfzglEYFlOM=
X-Google-Smtp-Source: ADFU+vuLEl61SUTDazp6gZyZ1HOv8Hskokvc4WVkJcz1XD3BDu3b3aVWgR0OJp07rcmqWyASmLyqMg9XDLfwBOIt9L8=
X-Received: by 2002:a17:90a:f98d:: with SMTP id
 cq13mr3381425pjb.105.1585377510605; 
 Fri, 27 Mar 2020 23:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
 <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
 <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
 <CAFXwXrkkOzuS=4Gfqm9XtkL5kc5m_5-9WmuziGgTfhFdm8VD0A@mail.gmail.com>
In-Reply-To: <CAFXwXrkkOzuS=4Gfqm9XtkL5kc5m_5-9WmuziGgTfhFdm8VD0A@mail.gmail.com>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Fri, 27 Mar 2020 23:38:19 -0700
Message-ID: <CA+ZmoZXvQ0iduKP_zWA0wTnpVSjjx=M6d5knWV-cayVuSQ2usA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 11:01 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> My preference is to add -Wno-tautological-type-limit-compare in
> configure, so we don't have to work around this same issue elsewhere
> in the code base.
>
> r~

What do you think would be the best way to add this? I could change
all additions of the `-m32` flag to instead use `-m32
-Wno-tautological-type-limit-compare` or add the flag if qemu is being
compiled with clang and `-m32` already enabled.

Daniel


Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB67C4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4393205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cN3vQqQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4393205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8fr-0003Rs-R0
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT8ev-00028f-8L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT8eu-0002U8-4C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:39:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT8et-0002Tu-HB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:39:11 -0400
Received: by mail-ot1-x344.google.com with SMTP id c3so27992069otp.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qXO1MV9LQSvXikG2gTD/XNrX1eAS53joYZpOVUCpneg=;
 b=cN3vQqQtEJWKc90RpWVXCMalS3OeBW8EX+lDY+AvtqGM/PpwHzOw+kdsQL+u8ftTR8
 abwNRjaZHno2vFEz0kHR8HxuaqTUryFFDLTRoZyGlWhoeihQuEgp+7O3bE5zK1s9CAm3
 V2lZEztrQt4nlukbwDiWWujP9IgAU0CIzUNARB+24HI2eJlaoQm/g+vnDTtGZ2/hqatr
 pUqJirj0kT0XKfS4xQtE0O6aqL365NEbd1IEkEhlEwSlLwed1V0Scmm5v6wyo84t2HK8
 C6M0rxyyfhCYeNhNfhPC/u3ARASFXFc7KT7mJgX+8YYpasZQtAwNhB0aSJVjRw8h/hhw
 BTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXO1MV9LQSvXikG2gTD/XNrX1eAS53joYZpOVUCpneg=;
 b=mbCgYEWTTYmD1lyZyo3sQBfOOgvGGhSIALPXSVyWlnLC+pC2jAmE1lwYuESKqmIsnQ
 a/6bgudCn3MSPK9qAQQSnIntJ9WXnw1k9U3QS6XJndeLn6MEmJSIFGEIc7I0ukSj+P6v
 m2chaRXzuOZqC4BsAqSJH5nq3cv7SkdBE/PkTuPxUuEu6oFVfV/8i90En4pR94NBj4y4
 LZ4feULSSNdN9cOWvas7kRFz8ZgitZtucwtSMwaYLYYAzVAy8YJn8gAjp/MUQVniol6x
 A6YlSy9PUWm78kEuF2fM/ORb8/4YESlHQnb6PbJc9x6NK5CEng1Bz8Lh6UOe1tCEXM1/
 kvBA==
X-Gm-Message-State: AGi0PubWYCfGeCzZZlXxqKE/uCmkn1Qff8wVchIOkJkLcytIH5jLeRbR
 Rl6/6m0sGeH8YKkzxhYpkH9nfqAlhH1ZrycaxA0NkA==
X-Google-Smtp-Source: APiQypJ32PawfmIC/aQtuLOyw3X4TZIAWHqZHbsAliKpBav4O9lmp41rMFYmCM18l1FH114YquTsk8K27CJOJtkk+vc=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr19045953otj.91.1588012750156; 
 Mon, 27 Apr 2020 11:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-14-richard.henderson@linaro.org>
 <CAFEAcA8oWP9XGzD+pb_VhDth8zx8j1Gz4vwiK+dArpw8x1BmqA@mail.gmail.com>
 <22c1fd55-7cd3-6320-1f90-40d1bd2cc883@linaro.org>
 <CAFEAcA-iqrEi_wQ+mBN1NtrEKq3uDYPoDunqW5e9KV6ivz3-SQ@mail.gmail.com>
 <d148806b-c7f1-fefc-bfb4-fcefb81ab509@linaro.org>
In-Reply-To: <d148806b-c7f1-fefc-bfb4-fcefb81ab509@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 19:38:58 +0100
Message-ID: <CAFEAcA-iJWqPQ-SwukaBcxgNFppAmeZNUR2doz6sgV6RduC32A@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 at 17:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We *can* indicate fault from MemSingleNF for any reason whatsoever, or no
> reason whatsoever.
>
> > // Implementation may suppress NF load for any reason
> > if ConstrainUnpredictableBool(Unpredictable_NONFAULT) then
> >   return (bits(8*size) UNKNOWN, TRUE);
>
> What I'm trying to talk about above, is the third statement in MemSingleNF,
>
> > // Non-fault load from Device memory must not be performed externally
> > if memaddrdesc.memattrs.memtype == MemType_Device then
> >   return (bits(8*size) UNKNOWN, TRUE);
>
> and the reason we can't actually test MemType_Device here.
>
> If you have better wording for that, I'm all ears.  But I don't think there's
> an actual bug here.

Oh, the comment didn't say you were relying on the operation being
allowed to return 'fail' for any reason; in particular the line about
"Normal memory [...] should access the bus" implies the opposite.
(I also missed the distinction here between "indicate fault" and "fault".)

But in that case you have the opposite problem, I think -- just because
something's backed by host memory doesn't mean the guest didn't
map it as Device: that case the architecture says must be indicated
as 'fault' but this code won't do it.

I would suggest something like:

+     * From this point on, all memory operations are MemSingleNF.
+     *
+     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
+     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
+     *
+     * Unfortuately we do not have access to the memory attributes from the PTE
+     * to tell Device memory from Normal memory. So we make a mostly
+     * correct check, and indicate (UNKNOWN, FAULT) for any MMIO.
+     * This gives the right answer for the common cases of "Normal memory,
+     * backed by host RAM" and "Device memory, backed by MMIO".
+     * The architecture allows us to suppress an NF load and return
+     * (UNKNOWN, FAULT) for any reason), so our behaviour (indicate
+     * fault) for the corner case of "Normal memory, backed by MMIO" is
+     * permitted. The case we get wrong is "Device memory, backed by
+     * host RAM", which we should return (UNKNOWN, FAULT) for but do not.
+     *
+     * Similarly, CPU_BP breakpoints would raise exceptions, and so
+     * return (UNKNOWN, FAULT).  For simplicity, we consider gdb and
+     * architectural breakpoints the same.

assuming my understanding is correct...

thanks
-- PMM


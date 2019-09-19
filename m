Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E13FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACA6207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5PrE43K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACA6207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB1If-0005e1-46
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:37:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB1Hk-0004pO-NS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iB1Cm-0004S6-Hl
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:31:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iB1Cm-0004Rl-Am
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:31:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id r17so7766372wme.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=B7zK8apYj5nqqDZ2KfuKz5w4T3CcB2MOukAuCFhQ8k8=;
 b=w5PrE43KwjvxqrfpL1aBPeHtcWDaMDTEGhQJe4Pe4y7xl1z4NuzlmpE4nXiVF0zyaS
 Dqcqb57m+tnGtru2W9YF/Eb3DHGxZEuO/+CI4I0ztZFqydhx3ykmeG/iHm5gKtSatLQ3
 +c5ptWqJ8JVeXclkhXaMkxjV1DZaKnWAhCF/WesKpQpRyHa2a0KWICrq0oLv7NpW/PJp
 70ailirSrw98FyItqRjatdcOvJhTZGRxDSzIVZtnE+BxaElQ5efAl0hLj8dxUHlnZOfh
 CsUZqu+l75KHVAB+GDTrT+h1fFPgumXIXnKRWDBzs0bLkmI7pwgk8PZoMgJSUYwcXxmS
 24iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=B7zK8apYj5nqqDZ2KfuKz5w4T3CcB2MOukAuCFhQ8k8=;
 b=GiR8O64IfwoJzoK025e4rH67a/4p5Y694/JWo7QtDEYV3W5/6o9PODElmmD81ijjaQ
 cQ3Fq78js/NuukAug9knDFmC03Ow7z2qd0L3bXeX3NFcZghVIVrXRblyWAmllgu8wnHF
 FcJ5ediFauWkSr80dQYJrIg7KPjHQs67U0s5l7L09c9+hqblk0kO/dpnuU3gMZd8ICwW
 hqyyyPbjpiOF+FW8C0N6XCT7h323tQbBpygK8KZEdCrklEHo7ldpd/wODcEwLSwC2kjN
 vviz4nFmmuxaJlE4WYSzjw2WsmF5X252xv5TAsAFnnBG6RNpLw/mVbnA2NJpVeH4tqSE
 JXcw==
X-Gm-Message-State: APjAAAUS+cm4LJXgob2obTxRyIyiAd5JEHzBXME9X1gsaloqwwCUBC9p
 7V88HgO+jRjUmaAngrtRWDe34g==
X-Google-Smtp-Source: APXvYqwIzDVOb5a/aL/B31YSbHa2rUQJgd+EMkhVq0TO97b62K76Ziys1W8EDxvOAUwn9Yvxs4isIA==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr4187356wmh.55.1568917858770; 
 Thu, 19 Sep 2019 11:30:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i1sm8445856wmb.19.2019.09.19.11.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 11:30:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DDCF1FF87;
 Thu, 19 Sep 2019 19:30:57 +0100 (BST)
References: <20190919155957.12618-1-peter.maydell@linaro.org>
 <87muf0yzvf.fsf@linaro.org>
 <CAFEAcA-eLvH2PfZjK_kxykQJT75y6CNzmZzxZg4SNZrekbvNHQ@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Makefile: Fix in-tree builds when Sphinx is available
In-reply-to: <CAFEAcA-eLvH2PfZjK_kxykQJT75y6CNzmZzxZg4SNZrekbvNHQ@mail.gmail.com>
Date: Thu, 19 Sep 2019 19:30:57 +0100
Message-ID: <87lfukyw7y.fsf@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 19 Sep 2019 at 18:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > In commit 27a296fce9821e we switched the qemu-ga manpage over to
>> > being built from Sphinx.  The makefile rules for this were correct
>> > for an out-of-tree build, but break for in-tree builds if Sphinx is
>> > present and we're trying to build the documentation.
>> >
>> > Specifically, because Sphinx refuses to build output files into
>> > the same directory as its sources, for an in-tree build we tell
>> > it to build into a subdirectory docs/built, and set up a makefile
>> > variable MANUAL_BUILDDIR indicating where the docs are going.
>> > The makefile rule telling Make how to build qemu-ga.8 correctly
>> > used this variable, but the lines adding qemu-ga.8 to the list
>> > of DOCS to be built and the 'make install' rune did not. The
>> > effect was that for an in-tree build we told Make to build
>> > 'docs/interop/qemu-ga.8' but did not provide a specific rule for
>> > doing so, which caused Make to fall back to the old rules.make
>> > rule for building any "%.8" file. Make tried to invoke texi2pod
>> > with a bogus command line, resulting in the error:
>> >
>> >   GEN     docs/interop/qemu-ga.8
>> > No filename or title
>> > make: *** [rules.mak:394: docs/interop/qemu-ga.8]
>> >
>> > Fix this by using $(MANUAL_BUILDDIR) when constructing the
>> > list of DOCS files we want to build and also in the source
>> > file name we install for 'make install'.
>> >
>> > (Among other things, this broke the Shippable CI builds.)
>> >
>> > Reported-by: Eric Blake <eblake@redhat.com>
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> heh I'd manually rebuilt the patch from your last email. I guess you can
>> apply this one directly though and I'll clean-up when I rebase for the P=
R.
>
> Yeah; I plan to apply it directly once it's accumulated some
> tested-by/reviewed-by tags.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e


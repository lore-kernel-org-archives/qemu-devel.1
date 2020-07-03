Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9338204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxmYAKhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9338204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPCc-0005jx-S1
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrOy8-00071a-Pn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:55:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrOy6-00066B-HV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:55:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so34757335wml.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=W8fHU1Q34qhbmf1bF38BEOB2Y1nvfjEx0sr5BNzD76M=;
 b=XxmYAKhbxIgJYjX1hA9bqWQH/mtmNcY+TEdNzFWxYNE/MA2rqFN7VH0Ki3ZlY4MTv/
 gp3+CWFdOCCp1O5UqzcUspAeJhRo5S3W4H2YOLCDQ3iHJTMs0HgYx5PQh/HMtouJrTas
 g5zt+5xvUV4GUuOr4HRUD1ykAlW/gR6G6EBuLLuMd0OebWcnAqQ3o8G792soTq9OsnC1
 /Nik6Yscroj0Db+8M5u9fbox2HJr0vtbDP7/OadTtswDmy11BOto8OmzvdD6vea7+qO9
 5VokRavpoectvDygxf7OVv+cyGQ2OLCZI+FXbY/kXrwKx8k/k7i1wVntqm8vRklaRMet
 KJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=W8fHU1Q34qhbmf1bF38BEOB2Y1nvfjEx0sr5BNzD76M=;
 b=q309mFTnzNg3VDF5j/imDb/kY8k2x+Uiq4BW0g0PUNbfW4J3oygEFc9sSoc+pnWdDB
 XOHq4c291t3UqGbYENNPhDPcK6qkQk75PwySaQXTyGHuh3MPRiFq+dkng6XFJUz5mB+W
 NEK/Uag/1DRcubvyshoH1WR44kH9flg+koQoaw0X6VvjjRV7aZYkBUbp0tu+1x5hvKPo
 FAzWiTwHOB/QOr4bIxOU16CBjDCQ/rm1e+f67/yJRLroMLMrnmEVIfHXWS+EZ+uqMBns
 8wHrE/+WG2m3SlW0LCkUwAuFFDvK3xqZc6lk/jL6yU+uKaLi4onCl6AluF/8J55AYqZ7
 fGYQ==
X-Gm-Message-State: AOAM533hvR1YxcqNZqZEvNIIkQCsXVmlUIPrmpujCJ6/4FZvHPWi73Pr
 E2uU6hIu5q7e+lw8TfMhlFxwQA==
X-Google-Smtp-Source: ABdhPJypzM37xfqdB86VJ8IH9EgWr6Z291isKpPh02LVudAHll5kOJUfAxPTcVwJXuKu8OcV8E1Dng==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr37172590wmb.87.1593795316962; 
 Fri, 03 Jul 2020 09:55:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e17sm14104281wrr.88.2020.07.03.09.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:55:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4943A1FF7E;
 Fri,  3 Jul 2020 17:55:15 +0100 (BST)
References: <20200701161153.30988-1-alex.bennee@linaro.org>
 <20200701161153.30988-2-alex.bennee@linaro.org>
 <CAFEAcA810JVTTfwkf9ezR=0dkwRLxERBUSgroUV3OTy4ZGu5Dg@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/3] docs/booting.rst: start documenting the boot
 process
In-reply-to: <CAFEAcA810JVTTfwkf9ezR=0dkwRLxERBUSgroUV3OTy4ZGu5Dg@mail.gmail.com>
Date: Fri, 03 Jul 2020 17:55:15 +0100
Message-ID: <874kqopmh8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 1 Jul 2020 at 17:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> While working on some test cases I realised there was quite a lot of
>> assumed knowledge about how things boot up. I thought it would be
>> worth gathering this together in a user facing document where we could
>> pour in the details and background to the boot process. As it's quite
>> wordy I thought it should be a separate document to the manual (which
>> can obviously reference this).
>>
>> The document follows the socratic method and leaves the reader to ask
>> themselves some questions in an effort to elucidate them about any
>> problems they may be having.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190308211557.22589-1-alex.bennee@linaro.org>
>>
>
> I have some typo/grammar nits below, but more significantly:
> I don't really see why this is a bit of QEMU's documentation
> rather than, say, a blog post.

The aim was to make it an initial overview so when people ask about why
they can't boot their systems they have considered the questions at the
end. It does seem to be a repeating topic on the IRC channel.

> It doesn't really say much
> about QEMU in particular. It's also rather vague about
> what guest architecture it's talking about, and they can
> differ significantly both in the real world and in how QEMU
> handles them.

Perhaps what we really need is a shorter punchier section offering
guidance in the manual itself? It just seemed quite a big topic which is
why I ended up with a fairly long explanation without even getting to
specifics.

I could certainly see the document being expanded in the future with
more concrete examples for various architectures and scenarios.

> Also, why put it in interop?

interop being where QEMU interfaces with other things such as kernels
and firmwares? It seems too user focused for devel and too long for the
manual itself.

--=20
Alex Benn=C3=A9e


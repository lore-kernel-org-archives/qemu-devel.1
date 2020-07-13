Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34957C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030382067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXYXn1tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030382067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1VG-0003c3-Ax
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv1Uf-0003Bu-KA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:39:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv1Ud-0005FC-IJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:39:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id s10so17208579wrw.12
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uyJYRC6az258cbdu/sX79QdwNCqduOfgSJXGvmTm2tk=;
 b=HXYXn1tVk7Splf82umxKK1wzvbBNFQJGz9/FHX1NaEq11N3vlRdV0a9fcl/j+bWc6R
 ZAoDIgfIccmSaMODXAXSG119wAO21190q5sCnbygheYkoeAvKJiWM4W9UIA83EciA2WH
 QaRcEeoiYn7FZSZ/bkO2WoP2WLb/srTuWkxChbjFGcGJB1GlhkGugUU/IT7aLw4TQowY
 NaN2dsqkvfX5yQrpOBYvMUztBw8fDTaGRXWblDQA5wThwbha3825c9GWXSsZruE7Tbzq
 0gopk8fXUmfpXo9NNJ9tbNEAhC92izvdb/KZxdmnWoqUb7ds5QYXavqhRELwd2UX2OSd
 xJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uyJYRC6az258cbdu/sX79QdwNCqduOfgSJXGvmTm2tk=;
 b=JgrUgTNlPwCXvZ8hmh9e4gYgEqpQt9k4ZfVXVxIrLcsBWk57X93eV1awUor4p5oXpJ
 qARvDCBPa+0Hf2qxq8fs79U3q5GqP3SCoW+c4AuGPfimaov8TT5JUFo8Fp8g4VsDKe/n
 L183vMSRwufMVJr1E15V0locxGyiBOI/C7vWE6vL35kCUlmPfl5xGHtqZDYLHZhNghUJ
 NgHEeRW42k5jhARgQIZms8fVyY/zqUVUO+p0oG4THAmFka8fa9SqA7JgINwH6c1HC3QY
 2eble6cjsd+UB7KF8YF5zKGl/EI5BQwq0YYz+D54GVERopZsTrMe6tGpppcdZOgCO08f
 yYbA==
X-Gm-Message-State: AOAM532tJcqvTnlMrVWHeswrt9RAMo+xwTRQJjK5BjmGyC6QupYELMXA
 +jPHatwJzUoQxy8LTBSA38oakg==
X-Google-Smtp-Source: ABdhPJzky2lMTZNp919I5eofY82KjhMOSlZ84IhxaWYObFPCfoeOr0gbSMH+NOEErQZ1FF+LfhuWrw==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr178631wru.399.1594658389895;
 Mon, 13 Jul 2020 09:39:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k4sm2858227wrp.86.2020.07.13.09.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 09:39:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 219A91FF7E;
 Mon, 13 Jul 2020 17:39:48 +0100 (BST)
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-11-alex.bennee@linaro.org>
 <9c736c87-34c7-375c-61b8-954aa70deab5@linaro.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 10/13] tests/plugins: add -Wno-unknown-warning-option
 to handle -Wpsabi
In-reply-to: <9c736c87-34c7-375c-61b8-954aa70deab5@linaro.org>
Date: Mon, 13 Jul 2020 17:39:48 +0100
Message-ID: <87wo37z7vv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 qemu-devel@nongnu.org, robhenry@microsoft.com, f4bug@amsat.org,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/9/20 7:13 AM, Alex Benn=C3=A9e wrote:
>> Not all compilers support the -Wpsabi (clang-9 in my case).
>>=20
>> Fixes: bac8d222a
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/plugin/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
>> index 0cb8e35ae407..dcfbd99b15b8 100644
>> --- a/tests/plugin/Makefile
>> +++ b/tests/plugin/Makefile
>> @@ -18,7 +18,7 @@ NAMES +=3D hwprofile
>>=20=20
>>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>>=20=20
>> -QEMU_CFLAGS +=3D -fPIC -Wpsabi
>> +QEMU_CFLAGS +=3D -fPIC -Wno-unknown-warning-option -Wpsabi
>
> Surely -Wno-unknown-warning-option is in the same boat?  E.g. I don't see=
 any
> version of gcc that supports it.

GCC doesn't seem to complain about it though.

> Originally, I tried to grab -Wno-psabi out of the existing QEMU_CFLAGS and
> transforming it, but I couldn't make that work.

I though the plugin Makefile was meant to be standalone to demonstrate
how you build stuff out of tree but I guess we include some of the main
make machinery in it. I'll see what I can do.

>
>
> r~
>
>>  QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu
>>=20=20
>>  all: $(SONAMES)
>>=20


--=20
Alex Benn=C3=A9e


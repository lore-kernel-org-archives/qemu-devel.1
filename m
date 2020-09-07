Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA4A20C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPUfEnIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA4A20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDsW-0008FA-GD
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFDrl-0007RE-5t
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:55:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFDrh-00073N-En
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:55:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so15161742wrn.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=C6do+SDtH388WeKdevTyowpBUxx3AyaDfVjWDJ38+wE=;
 b=sPUfEnIxQQmD5q1KDYd2SPX8HVwfatyg5UEd8bMWK5mtsFhK1HrcsSMrByLdWLZrHt
 9edSE0Ok9SrYb2CzlpplwHq5JddhtgXlYyxuBcJrUb25flkWCOu4lZp/ml7O4IaK/k4R
 nF0Ddr0xJpWGZCCTrveioPtPOb3efBSi8U3n8ze8H7k62uXg968TwBn3qJiG5i8sPO3O
 XDQY5RZysnOu90F4ZrU3IraWNJEE4rvCU1IQl89Su1lY6xOe1tKqXLlFebvIGVITxkIu
 uYwRb9SFVsSJisQDETz5KQ2C5Iq1Gh6cqaI6NiF1AZvOdU5/XtaIfBKHxH6EnIjjEwhZ
 wDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=C6do+SDtH388WeKdevTyowpBUxx3AyaDfVjWDJ38+wE=;
 b=ngbMhc8F2hwFOh5Gkee+AMtKDy20w7AW5hwpz18ukYLQNWrD4QD3FUnbjU+SV4PpDA
 Div0dDLcW3eYLo00ra/8EM44zS5ZFgprmj/ggdVfn0K2hhrW5DFEFraSKR7pJgWrVXth
 HTtNYBBjCeUjvaoHq3x8XnZiK85eo6QA/d1N3gQKZr9ODGKTwQhJMxUf3mckOXkQEItW
 yNIVDLSGbRB0bcbzXDP3VB7Mz3gwxiSRAHaUsCE84cd+Eop5Y3oCfYk11co4XG5M6x/R
 JFRX1x7uZyQjRxSKScXa/J4MH03q+LGzg5RJugyfdqjqdHcyO1QUmztD50aMyllzURUt
 9DtA==
X-Gm-Message-State: AOAM532Egme43/DVys2chjXPl3BvYgzIONJRPp4Lf7JAoWv19F41AiIs
 LTCwyTd8t4AR+0r/SRwkTB165A==
X-Google-Smtp-Source: ABdhPJxBUFmpI2zm7JGgLOQeDjlQzT8dY8kpkFVd0r/f4P0wPd5fGgbKL4piEp529lKfi1Fy8hQlIA==
X-Received: by 2002:a05:6000:12cf:: with SMTP id
 l15mr20213838wrx.312.1599472507688; 
 Mon, 07 Sep 2020 02:55:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm27497867wrm.10.2020.09.07.02.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:55:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF2D81FF7E;
 Mon,  7 Sep 2020 10:55:05 +0100 (BST)
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-7-alex.bennee@linaro.org>
 <CABgObfZ_Xdd-pnRjpWO=8NjEznZhz84DTq95OzCdjL_rxnw=XQ@mail.gmail.com>
 <87a6y2rlwq.fsf@linaro.org>
 <6c8531d2-a695-e964-bacf-a4322d4c9f40@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 6/8] tests/meson.build: fp tests don't need CONFIG_TCG
In-reply-to: <6c8531d2-a695-e964-bacf-a4322d4c9f40@redhat.com>
Date: Mon, 07 Sep 2020 10:55:05 +0100
Message-ID: <877dt5syh2.fsf@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 "Emilio G. Cota" <cota@braap.org>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/7/20 11:11 AM, Alex Benn=C3=A9e wrote:
>>=20
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha s=
critto:
>>>
>>>> As the tests build only softfloat.c no actual TCG machinary is neede
>>>> to test them (as is evidenced by GCC check-softfloat). Might as well
>>>> fix the wording on Travis while at it.
>>>>
>>>
>>> The reason is that softfloat is not built at all into QEMU if !CONFIG_T=
CG.
>>> We similarly skip block layer tests if !CONFIG_SOFTMMU &&
>>> !CONFIG_TOOLS.
>>=20
>> It's not built anyway if you don't call the test. Are you saying a
>> --disable-system and --disable-user build is invalid for running unit
>> tests? That is what check-softfloat is doing as it doesn't involve
>> softfloat built into any qemu binary.
>
> FYI my tools build dir is configured as:
>
> '--enable-trace-backends=3Dlog' '--disable-docs' '--enable-debug'
> '--disable-system' '--disable-user' '--enable-tools'
>
> and it still works after the Meson conversion.

But check-softfloat doesn't work with that right?

--=20
Alex Benn=C3=A9e


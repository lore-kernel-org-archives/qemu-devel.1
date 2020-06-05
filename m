Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A30B2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dixsWuh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A30B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFDW-0002jn-OF
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhFC7-0001j3-Lp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:27:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhFC6-0004lz-CN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:27:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id j198so9457796wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rbhj6tHjtgkzm/ewWrQUKlLpj2gOa4/9bvvmhdFxcOY=;
 b=dixsWuh1/nT3M2J454c9ObqhBWPk5yuIaYGTg5oHUSX+Eci5pHa8XLwfZRglK6r9E3
 gqcdtD/NANl6MLJNvxFBpb1zZfMU3mYpYx3tPTQUqhbL4+0RZnt7aJi1LZL5wkvY0TDn
 gEsO2Ed/MYyudQS1j/RA8Ui69+1qgVrMIS6XXLUznIyHem5f1KdI9ejuwrIY6a1/PDrx
 GIbujLPsVqLiNEkZbTlAJA841xEFriYf1ZtbT8BZFd7eF0oUTc4tNrBv+pxaL2QmtNUr
 ifmsONmS2Ht/1Jg+qN3yxmQRA0Mwi8FnQ0OCs8p5jGZafUu2XxDzDKNZcytKnwGiEBQn
 Ui4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rbhj6tHjtgkzm/ewWrQUKlLpj2gOa4/9bvvmhdFxcOY=;
 b=PfxKJlqslOi/4MjFQcg9wP/8YEjNQV2AraREjCcKiko5eIQNE34sP4z9da7+/LAZN3
 daYujnytyNU90qHqUxRZ7R40jj/x1T586GRnFXKYCspIdLM+JSzFdmp6I4djtEmC/2yo
 lDswIqi/Sx7ypaHSKma23B1d2q6J7BIbv3j07CJJ0pFu02vP4ss8dRYAY7dpPnKiAKyM
 UhKpq6155d1oelEWbSpOHEP82Az+tiGQaUDSIvxDPEruZLDPeXDnayrrgi77XKXfYnCh
 A/MD8oE23YMvOOlHC0tRUSJY6RDJ7ofEsjIJVUJB6VYFsXCDgbyngAuqf3LF4PrEdcGx
 yjKw==
X-Gm-Message-State: AOAM530o+0XhW3uT0D7dc/vujRHKqOvJLptAlk2V8MlImHWgohWjVGnp
 65D67j9HhvzGxIFOVIX5FFSeKA==
X-Google-Smtp-Source: ABdhPJyV/p+3HXW89qm9QHCfG/fqhwobwClRit3+j/Y9qFeivAJ3r5faGVbosy3K9A85CFnlV9U91A==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3697240wmi.126.1591374463688; 
 Fri, 05 Jun 2020 09:27:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m129sm12703228wmf.2.2020.06.05.09.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:27:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEC211FF7E;
 Fri,  5 Jun 2020 17:27:39 +0100 (BST)
References: <20200603112442.22833-1-alex.bennee@linaro.org>
 <dc06ca1f-4327-7511-eadf-cc5ad905c94c@redhat.com>
 <1bf57207-43c7-cfce-7c38-b0b6bea7b74b@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] exec: flush the whole TLB if a watchpoint crosses a
 page boundary
In-reply-to: <1bf57207-43c7-cfce-7c38-b0b6bea7b74b@redhat.com>
Date: Fri, 05 Jun 2020 17:27:39 +0100
Message-ID: <875zc54gw4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/3/20 2:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/3/20 1:24 PM, Alex Benn=C3=A9e wrote:
>>> There is no particular reason why you can't have a watchpoint in TCG
>>> that covers a large chunk of the address space. We could be clever
>>> about it but these cases are pretty rare and we can assume the user
>>> will expect a little performance degradation.
>>>
>>> NB: In my testing gdb will silently squash a watchpoint like:
>>>
>>>   watch (char[0x7fffffffff]) *0x0
>>>
>>> to a 4 byte watchpoint. Practically it will limit the maximum size
>>> based on max-value-size. However given enough of a tweak the sky is
>>> the limit.
>>>
>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> ---
>>> v2
>>>   - use cleaner in_page =3D -(addr | TARGET_PAGE_MASK) logic per rth
>>=20
>> Can we have a macro for this?
>> Maybe QEMU_IN_PAGE_OFFSET(addr, TARGET_PAGE_MASK)?
>> or QEMU_OFFSET_IN_PAGE()...
>
> As this is queued, I suppose the implicit answer is "no."

Richard took it into tcg/next as is. I think having a macro may well be
nice clean-up but I struggled to pick a good include location so left it
for a future clean-up series ;-)

--=20
Alex Benn=C3=A9e


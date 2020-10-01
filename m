Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF5FC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41B221481
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFvP52B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B221481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNurL-0001om-Ma
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 05:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNuqT-0001MW-Op
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 05:25:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNuqQ-0001cV-Tv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 05:25:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id k18so2244655wmj.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dDg9TReMIlHBZqYfirZYe/hI3gU6KheD/5hcoaaDeTU=;
 b=GFvP52B0ICq6tPlNgaSx7G7QS4vVGLwMBbharSAAiZ9Gv55whMex6Ket7MU7XhQnMf
 4Wg08Pq/NbEq06FkRa+yCpxhsYl4vlrFxfH9bmzxWrympYdap2ecNmLMvKVDF6JjwfJN
 zj6lc66x9lnIZbnl6qrR4/M02lF6UHzIVO0KrrJnMIgFvhQyeakoiwA/TgXbo509WNAj
 /qpPSpZMl32vBPynhO9o1QgSPnVON7RNb3wB3jAH/gqZYpam7GcxKDx5mLhuR8qDAZ+s
 ksRyr2ziCET+HQK/0Bt8eUL2v9is7fPUZ5TNdx8wNlgdiLMAj8OkvUQyCUXFlrAlLzcg
 jWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dDg9TReMIlHBZqYfirZYe/hI3gU6KheD/5hcoaaDeTU=;
 b=PEpsCFHbRWLm4nB9nlhKTH2nO2m3G6N1MOVoDOPoINKDTBK0GmNZg0ekIQuFcZUDbr
 +4WM7WmIE8dFTNPhTQd5Uxr3kAZ2U5FWewGHZJ7QiKGJ71Wxj7cBwcFULub6tvf9vaC/
 H8+XuRN3xDb/LGYyM0MSyWIrSuYza6hwBfMt2CsLgkmn7caOL+lY674rgjPWRkT9wEN/
 V4vSTEO+27tlL60BvmjnpCA24ns3v41vBg3B9zD3qIVjdicLCBu5nQpMbOWdLLmxSYsO
 e7CcOi4INAukPMH1uou2e2qvflJj4Dmr58LxeddrJCxGm90VQv401W12Lh/F2pF/2PeR
 yc4g==
X-Gm-Message-State: AOAM5309XQtzQeIbLE1C552ce1BdR+STbHDKKQHkSYhukcXebB8yVnRv
 zRqpAiDaIxl0B7hzZpU6PusmQg==
X-Google-Smtp-Source: ABdhPJxqTrh+o95YlpYSt1k/gy3n+n5UYnf/4msSahCZREEOWUdinc19i4ZM7xeQXKKKClsZmocfSQ==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr7141713wmi.108.1601544344965; 
 Thu, 01 Oct 2020 02:25:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m12sm7197059wml.38.2020.10.01.02.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 02:25:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 094481FF7E;
 Thu,  1 Oct 2020 10:25:43 +0100 (BST)
References: <20200925154027.12672-1-alex.bennee@linaro.org>
 <20200925154027.12672-4-alex.bennee@linaro.org>
 <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
 <87ft70pgpq.fsf@linaro.org>
 <0e0ebdd5-d9b9-17dd-82c9-2c63a73f4eea@redhat.com>
 <b34a2595-f68d-8aa9-cf32-72e9f4abd1a2@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 03/15] meson: move libmpathpersist test
In-reply-to: <b34a2595-f68d-8aa9-cf32-72e9f4abd1a2@redhat.com>
Date: Thu, 01 Oct 2020 10:25:42 +0100
Message-ID: <87imbunvqh.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/09/20 12:54, Thomas Huth wrote:
>> On 30/09/2020 12.51, Alex Benn=C3=A9e wrote:
>>>
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 25/09/20 17:40, Alex Benn=C3=A9e wrote:
>>>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>>>
>>>>> This is the first compiler/linker test that has been moved to Meson.
>>>>> Add more section headings to keep things clearer.
>>>>>
>>>>> [thuth: Add check for mpathpersist.found() before showing mpathpersis=
t_new_api]
>>>>>
>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> Message-Id: <20200918103430.297167-3-thuth@redhat.com>
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> <snip>
>>>>
>>>> This is not the latest version of the series, can you drop patches 2
>>>> and 3?
>>>
>>> Hmm so now I'm seeing failures in the bionic builds thanks to libmpath:
>>=20
>> Paolo's PR with the fix is still not merged yet (see "[PULL v7 00/87]
>> Misc patches for 2020-09-24") ... but maybe you could pick the newer
>> version of the libmpath patches from his PR into your queue?
>
> Unfortunately that part is what's still broken.  I'll send again the
> pull request today, hopefully eighth time is the charm.

Re-basing on:

  Subject: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
  Date: Wed, 30 Sep 2020 21:58:47 +0200
  Message-Id: <20200930195850.278104-1-pbonzini@redhat.com>

and everything is working again. Once your PR is merged I shall submit
mine.

--=20
Alex Benn=C3=A9e


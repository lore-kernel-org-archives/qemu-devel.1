Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39892C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8FA2071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM+p5j+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8FA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqetj-0007NA-Ac
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqesi-0006ME-5V
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:42:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqesg-00004y-9a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:42:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id l17so22935185wmj.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lF0s/m5egU9LBgFAkgsYyPlZRLMynOOSvEYAt6b6VPM=;
 b=iM+p5j+ixVQCM6582fxKe2bYpgn4rmPRQroJQu7OQxRK5Se4236ZjxopRX/K4Nhj56
 iYtpP+lJxh2RWd/FtuUFE0HztanFfz6Tn6v8mJXmR+wau8ikH1Ej2+nySlTWa/lbyapU
 FFador2e/lC0Jil7AnPtcBdvOEouAhWyc4H31dMXs8zrdpqbhfjEqp1n12DtgQbhFqIx
 5FDqbe1KtyFWYsbaB3q864JnRunSFA/Iyve9uZmiix5rSh8KIRhA9z70lBkU/rEiRVzb
 A/3oKLCKNODEIKcchMx/WxSm4cZzLxRc3lRDva2D/P0rGiVF9pcLl7BAPl67Jau8wEpS
 2/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lF0s/m5egU9LBgFAkgsYyPlZRLMynOOSvEYAt6b6VPM=;
 b=Cxn5BHrSUZYM01uWgm+3x72GCdWew2dc22nx65xcat+Wb08RFe/fYtcrjAHy0/9N5z
 xQihRiWfImwDcmynEdlJOu2s/UgfA7goGDshFe+53Yai9EIvM8d2FQRLlk6XaJafhjah
 WF38ao/KxBqA5mj1D7on940DLoLy6GyCo1eZJpRgRKLPob97WbtuhXyxUGDpZzgBfUiM
 /WZczfljD+EnGBtL4RaMLUrpWAXfatj36Wpr+2qkLgSxQFhXffzzos/Us2RKMtar6qOn
 NZDtSkX9BgjayFn+E4DFMNpYU6e1ohutlNNQPXq7s83K2hJmg14kmuYb93UzpWbbMH94
 VJMw==
X-Gm-Message-State: AOAM532TYzypm7SSaPLm4OVMfw6xZ3OcfTm0zDmOS7K2Gq/kmHMTZasD
 kvqI18N1EizOfamW0LAv3kJdtg==
X-Google-Smtp-Source: ABdhPJzhHJQO1NKYgntlFFXJUU8P+zuvwP0XBkaX7V5uFFdjRiajnA8UIXoI4XsZgSsZdyFsfl/G1A==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr29588936wmj.117.1593618156447; 
 Wed, 01 Jul 2020 08:42:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 207sm8514294wme.13.2020.07.01.08.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 08:42:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31BBC1FF7E;
 Wed,  1 Jul 2020 16:42:33 +0100 (BST)
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
 <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
In-reply-to: <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
Date: Wed, 01 Jul 2020 16:42:33 +0100
Message-ID: <87sgebqm1i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> Assuming your test case is constant execution (i.e. runs the same each
>> time) you could run in through a plugins build to extract the number of
>> guest instructions, e.g.:
>>
>>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so -d p=
lugin ./tests/tcg/aarch64-linux-user/sha1
>>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
>>   insns: 158603512
>>
>> --
>> Alex Benn=C3=A9e
>
> Hi Mr. Alex,
> I've created a plugins build as you've said using "--enable-plugins" opti=
on.
> I've searched for "libinsn.so" plugin that you've mentioned in your
> command but it isn't in that path.

make plugins

and you should find them in tests/plugins/

>
> Are there any other options that I should configure my build with?
> Thanks in advance.
>
> Regards,
> Ahmed Karaman


--=20
Alex Benn=C3=A9e


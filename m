Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45A32085B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QI6mC+yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45A32085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfod-0004it-1e
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqfn6-0002vF-Pt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:40:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqfn4-0003d1-RQ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:40:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so23948720wmh.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=w3Z2jEGMxYhvAHPAZN+Hwj6mc5OryRTpalipHcanpYE=;
 b=QI6mC+yNWprrMFEklResRjexfzleUGq6lOustvq6AlHI5FJDVQE7FI05oUKdZWaygH
 oDL9Ju2UIE5zTEfDXLby4BNyxxA6NbsSJz8HKyRbuBz3rOa5xFM091p8ahiWGzKuXC9m
 DyL3cQDDQTF4A3WIFS3o7WK3Z+ZcvW7CLuJSb4Glw0AWjKAqcurk4JQ7tJd2tC16mW+Q
 NCvnqLuk4cYW/K6tMF/MHwYFvTK8IK3EK7L+LrYlEsh0uLL7qCS8+LqDH6U7bZChlquf
 19waFP21zMoYqP7SlF8+64QIThgJmPh4dE4XWak7/ALLD3aiu4qQIs6xcAlgst9TA+/U
 B+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=w3Z2jEGMxYhvAHPAZN+Hwj6mc5OryRTpalipHcanpYE=;
 b=qVlFlZMrka87ybIRog40yfcNC9obr1S8riQaUzqNPOnILGD5+rshqadx0Ki0UuxayP
 usiI/AForzpLxyQqy3BYun99gtixMKdw4A+sb4guirYeTqOcX+DgBxWvtw33M7X6D7us
 sB/DFFU2j94FkcAl6ivWRbV0BUTG5ndS0MqAVdLWJqnaaHoXaV68LeokFAIkt4JYk13T
 Um8rxahKpjkBe1bKMCyj54YEhInSIiscTdJ4h5eWT7Q+uLT9b0PWmTQY+tOgj8iUqzlJ
 SRgug7Q5pxRTYrUViUarql8kBg8INDfmRoc5E4ODOk3pdMB2HMZU8/vgk8jRhpDaEi6/
 7YOA==
X-Gm-Message-State: AOAM531lKCwxeCZNLZMbHcTyxCRCEg6G1oaBMtqCO5JN2ayoNuKPu7fx
 bhNJjaA7UkP6yYkLO0CACl9gJw==
X-Google-Smtp-Source: ABdhPJy0hXVL3wDnf8W2yVdj9w2WVQ7P/gGj09CRuC8FOoqY9B4T2stHKvg+mnYo57aaV/fnwik3PQ==
X-Received: by 2002:a1c:5f45:: with SMTP id t66mr29022346wmb.144.1593621652501; 
 Wed, 01 Jul 2020 09:40:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u23sm8495129wru.94.2020.07.01.09.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 09:40:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 257061FF7E;
 Wed,  1 Jul 2020 17:40:50 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-2-alex.bennee@linaro.org>
 <85314d31-813a-8c20-7522-5186d5f31884@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 01/40] hw/isa: check for current_cpu before
 generating IRQ
In-reply-to: <85314d31-813a-8c20-7522-5186d5f31884@redhat.com>
Date: Wed, 01 Jul 2020 17:40:50 +0100
Message-ID: <87pn9fqjcd.fsf@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, "Michael S.
 Tsirkin" <mst@redhat.com>, Bug 1878645 <1878645@bugs.launchpad.net>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/1/20 3:56 PM, Alex Benn=C3=A9e wrote:
>> It's possible to trigger this function from qtest/monitor at which
>> point current_cpu won't point at the right place. Check it and
>> fall back to first_cpu if it's NULL.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Bug 1878645 <1878645@bugs.launchpad.net>
>> ---
>>  hw/isa/lpc_ich9.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>> index cd6e169d47a..791c878eb0b 100644
>> --- a/hw/isa/lpc_ich9.c
>> +++ b/hw/isa/lpc_ich9.c
>> @@ -439,7 +439,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, void=
 *arg)
>>                  cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>>              }
>>          } else {
>> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>> +            cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_IN=
TERRUPT_SMI);
>
> I'm not sure this change anything, as first_cpu is NULL when using
> qtest accelerator or none-machine, see 508b4ecc39 ("gdbstub.c: fix
> GDB connection segfault caused by empty machines").

Good point - anyway feel free to ignore - it shouldn't have been in this
series. It was just some random experimentation I was doing when looking
at that bug.

--=20
Alex Benn=C3=A9e


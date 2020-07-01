Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE1BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D671206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd/btaiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D671206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf7O-0002RO-D0
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf6N-00012w-Rb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:56:47 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf6M-0003Nb-9Y
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:56:47 -0400
Received: by mail-ed1-x543.google.com with SMTP id e22so20376313edq.8
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V5ulsk4xTWYO2ZTxAP7/b0Gc5JzWT50htbiSo62wLjg=;
 b=Rd/btaiwa1Mt337yPcYWmirxAOZn0SOXv7uqk0ehyZqlyF937wb0KXku1kQaos1F0S
 nDVBC4usktrT5II0Ruw3RLTD6yZkPOMnhmz7m+RoYfWi1QFZapZySt8Lc/7zLmup/Shw
 sZCNPjXvHoe6yha9R9F2ycKF+NYvn3ireEK0cI4piLbYdhnjQocrd6AxUgg0T3v0GvMn
 J3VVSo2fpK3SFo5qnQDdppZvdimO2L5IsKdSVZux3RdLQ/fnQYZrxeTrkgo3drApwmeR
 rW1Nnvwx2gSbbFMXeT1Rfq6yBRO/KU9Rzh5H4owx2dvYl5JWh6rdrtLjcadX8iRDhTlo
 VOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V5ulsk4xTWYO2ZTxAP7/b0Gc5JzWT50htbiSo62wLjg=;
 b=r1o9CjlleP6PvUZKmdJJuuf6ffYajwjWnfokAK7KtTiHp4YsGh1N/dKg/hnU1+Dl9w
 BZQ2y0CSrjnwkJAyiL2nmuEWwc/aDZNsIOyZVCMjMw8kyM/4v3vIn9n8ib40fuW7jod4
 HvJ2W6rnhnT7rH6DF7PEKm8Eve2bAmlTwXGxw88vG0tKcU+vpNbH6E3B77KH4cUbtV3W
 6X2GWeRPjOwhoyCD/fYJT7cZCBnW5ZiweTvDPJD5Zn+lqy3P9cx3LgQCbW0y3b7ED7pR
 PxoeQyefT/gslHofoZh810oNhmVTvafAsMJwXVS7EmplH/wb902QPPT4CqlFyHSyMkB4
 mq7A==
X-Gm-Message-State: AOAM530eBxa53dWncAyJAPXsPpHaKhc1et/jtEAuUDbE+pm91/gBF18/
 a5PThXirekiZw26QGF1N2nw=
X-Google-Smtp-Source: ABdhPJwuihzXtT53bM+9x+Ix52It38pcYnBVAHZN249FDMLztYhBmvAPJyhuxgEQeIIT0YracGcMiA==
X-Received: by 2002:aa7:c504:: with SMTP id o4mr29210073edq.311.1593619004793; 
 Wed, 01 Jul 2020 08:56:44 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id oz7sm4809777ejb.96.2020.07.01.08.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:56:44 -0700 (PDT)
Subject: Re: [PATCH v4 28/40] tests/acceptance: skip multicore mips_malta
 tests on GitLab
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-29-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2c5aab2c-5001-9d1a-d3f7-8afed1c4af1b@amsat.org>
Date: Wed, 1 Jul 2020 17:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701135652.1366-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:56 PM, Alex Bennée wrote:
> For some reason these tests fail all the time on GitLab. I can
> re-create the hang around 3% of the time locally but it doesn't seem
> to be MTTCG related. For now skipIf on GITLAB_CI.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  tests/acceptance/machine_mips_malta.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
> index 92b4f28a112..7c9a4ee4d2d 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -15,6 +15,7 @@ from avocado import skipUnless
>  from avocado_qemu import Test
>  from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import archive
> +from avocado import skipIf
>  
>  
>  NUMPY_AVAILABLE = True
> @@ -99,6 +100,7 @@ class MaltaMachineFramebuffer(Test):
>          """
>          self.do_test_i6400_framebuffer_logo(1)
>  

So the test works using a single core...
Good we have a test to figure the bug!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          :avocado: tags=arch:mips64el
> @@ -108,6 +110,7 @@ class MaltaMachineFramebuffer(Test):
>          """
>          self.do_test_i6400_framebuffer_logo(7)
>  
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>          """
>          :avocado: tags=arch:mips64el
> 


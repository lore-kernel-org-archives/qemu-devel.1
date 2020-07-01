Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA152C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B9D2085B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cy5ds3Hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B9D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfqI-0006Y5-NZ
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqfpf-0005vx-RM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:43:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqfpe-0003xc-06
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:43:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id q5so24761116wru.6
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iJJFrsRgLgPVzDDdzBSoQ9owWAboOX6vG+wFvtEzsis=;
 b=cy5ds3Hh6GC19MduR8JqWv5rze5lvPYFnLx1D1tJudT7UZpDbSfka2nKIQ1pYZALD0
 ptnMv9tNOT7C9fe5JsOLN+sfzHpdM6/gY88C4sgIjBz2iWCD2LgKAmP765fqJBTbgbr0
 tRugznknvvU+JhNCSkLOBwsliQLwjE+uMaRD7lcauRNXrtt2j3HkYOn4z4x8JV8fTj6j
 q8yUCnJtJ/Saj4WOhmOxvYCTnURlP6QEZM0N0r7GeowDgKFYnsY/2IY0gsBh6V6E/cLr
 +PsPw9wWq2g3f27kDut3fX2NQPzW7N8GOsjNj+CmWFDEHUQEE1iASv5TsmA3EkqYX0Yi
 MB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iJJFrsRgLgPVzDDdzBSoQ9owWAboOX6vG+wFvtEzsis=;
 b=ZzApvFQFLlmxWhC9Zl1o3lDL61qu7QQ0pq3wKYXKPUIKP/4GoRlwHglza7ObVHdKh1
 K42YSrrcscbCT7X/GMFQKyiQVtG5ax9M9f/qiUxr711n2nRpl84b5klsEHOCHRlVprEa
 LaGzWu25dHhnB+eIHx0xzjYRuSGttrIvGFTaoLGJgzQ1aKw5LboJF2D1ZY0sFgzHrRUL
 YKL3jD1YxavA84FPzHZCicmaYDmEMK9n9rKLoQ1D16N6By5miPSnjk4Cz8dzr9OYjZot
 hh6D1iqBKrffmAmwVS2Xnum/3WWRCRmawn0O2Ei3lKEdaU1Dqm/xiJi/lwI3pg16zLW+
 dPnw==
X-Gm-Message-State: AOAM533WWaLCoA/sMgNYJ9hJtgE30rR3H4Xr+XJNNZ8JpPecpHkmo9iI
 91NGp9abwoNH5OB1vIOtKNypAA==
X-Google-Smtp-Source: ABdhPJzz8gc9nFyF16lw4ZSRUEp61iR1aVpQ8es6mUG5f1X/WuASrMuIdARewXEKA8iBTQvGqWYj0w==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr29754692wrx.219.1593621812374; 
 Wed, 01 Jul 2020 09:43:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m16sm2830193wro.0.2020.07.01.09.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 09:43:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6B9D1FF7E;
 Wed,  1 Jul 2020 17:43:29 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-29-alex.bennee@linaro.org>
 <2c5aab2c-5001-9d1a-d3f7-8afed1c4af1b@amsat.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v4 28/40] tests/acceptance: skip multicore mips_malta
 tests on GitLab
In-reply-to: <2c5aab2c-5001-9d1a-d3f7-8afed1c4af1b@amsat.org>
Date: Wed, 01 Jul 2020 17:43:29 +0100
Message-ID: <87mu4jqj7y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: fam@euphon.net, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 berrange@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/1/20 3:56 PM, Alex Benn=C3=A9e wrote:
>> For some reason these tests fail all the time on GitLab. I can
>> re-create the hang around 3% of the time locally but it doesn't seem
>> to be MTTCG related. For now skipIf on GITLAB_CI.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> ---
>>  tests/acceptance/machine_mips_malta.py | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/m=
achine_mips_malta.py
>> index 92b4f28a112..7c9a4ee4d2d 100644
>> --- a/tests/acceptance/machine_mips_malta.py
>> +++ b/tests/acceptance/machine_mips_malta.py
>> @@ -15,6 +15,7 @@ from avocado import skipUnless
>>  from avocado_qemu import Test
>>  from avocado_qemu import wait_for_console_pattern
>>  from avocado.utils import archive
>> +from avocado import skipIf
>>=20=20
>>=20=20
>>  NUMPY_AVAILABLE =3D True
>> @@ -99,6 +100,7 @@ class MaltaMachineFramebuffer(Test):
>>          """
>>          self.do_test_i6400_framebuffer_logo(1)
>>=20=20
>
> So the test works using a single core...
> Good we have a test to figure the bug!

It's about a 1-3% failure rate on my big test box but hits every time on
CI. However I did disable MTTCG and still saw failures so I think it's a
more subtle breakage than just a straight race.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>> @@ -108,6 +110,7 @@ class MaltaMachineFramebuffer(Test):
>>          """
>>          self.do_test_i6400_framebuffer_logo(7)
>>=20=20
>> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>>=20


--=20
Alex Benn=C3=A9e


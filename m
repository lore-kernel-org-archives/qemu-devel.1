Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22ADC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3F62088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxqBNNv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3F62088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdynh-0005N0-Nr
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdymz-0004pw-LW
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:20:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdymy-0005be-AY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:20:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so7924954wro.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FIASZnAGDkViQ4R/r27C0FUHsK1jmzzQm9M844s+Iic=;
 b=fxqBNNv50ICkd0repxK/tKRt9FeB+E90B1csQXkBWdm6emy998+8scBuW6+HKE0yQJ
 kGf8izVfh0Ympld2yVrb5UegHlLQ1oyzuDnXx8V5j2ZYVe20UaUNphQzXq2bCwA/LTY2
 0UTw+3eQnsG1inweYGzzdLCaaqZMux0gjL0otI/3HbOOsfN2UN0g+ClhOFV9PYwOw5wC
 7AS2dfwZrz6Hf7i8xG54q98piHWQkGQir6Ba2dxzygCHxdbKrrsT/EVEn6mp+YdkXDTH
 i2usDyVFZdoIOmlMV8K17cj9RcMjCFvdU4M17uX0nC2SSnt6nIdtZfu54lCg3cwy2cjo
 AZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FIASZnAGDkViQ4R/r27C0FUHsK1jmzzQm9M844s+Iic=;
 b=ZhR1qxKP2zFKKnDACHdt57almLsCWQnyB/5yS1qSYbxXKY14wzW72egIfTBe5M0cBz
 FFToe8JVNTVF4UUXkfJvJ3BfK0WKgIrt9G1qfYjKmw/0JvziflrMcB1CtYoINk+7ywkC
 Td4+26IDNAECivwRkhfwJjPsUFYIuPp42M1amt+Dai5o9paJydTTzdgXRCYGxdur2QNU
 iOiW2/Tuzm29olFxguOoze7FoW2WOMqo7wyR7qpi2DkO+pOJdj6irf4WpXgCwXelpdpY
 ZE3Vw4G/ggAI8arAGCydJRRftM+hVHhz0i98Us90oe5tErO1c8BKRPdLAnFfKrJMxyHN
 gtnw==
X-Gm-Message-State: AOAM532rykrdx8dUX1p9J7lw2uP9xfaYb5JUNDghnItiDF1sKrFv1Ed/
 ooQMB6bYisW1Jswf0t5vEVkK8Q==
X-Google-Smtp-Source: ABdhPJzhw20Hx+IJ/Siat5w6KHMf8b5WRUODgD5Bb77lqTQzCPCaVYV210sOaVfYezAfawutsV0arA==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr26144918wrv.392.1590596418681; 
 Wed, 27 May 2020 09:20:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k17sm1811150wrl.54.2020.05.27.09.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:20:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6EC61FF7E;
 Wed, 27 May 2020 17:20:16 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
 <87v9kh5qtm.fsf@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay
 test for x86_64
In-reply-to: <87v9kh5qtm.fsf@linaro.org>
Date: Wed, 27 May 2020 17:20:16 +0100
Message-ID: <87lfld5ozj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>
>> This patch adds a test for record/replay an execution of x86_64 machine.
>> Execution scenario includes simple kernel boot, which allows testing
>> basic hardware interaction in RR mode.
>>
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>  0 files changed
>>
>> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay=
_kernel.py
>> index b8b277ad2f..c7526f1aba 100644
>> --- a/tests/acceptance/replay_kernel.py
>> +++ b/tests/acceptance/replay_kernel.py
>> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>>                      True, shift, args)
>>          self.run_vm(kernel_path, kernel_command_line, console_pattern,
>>                      False, shift, args)
>> +
>> +    def test_x86_64_pc(self):
>> +        """
>> +        :avocado: tags=3Darch:x86_64
>> +        :avocado: tags=3Dmachine:pc
>> +        """
>> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive=
/fedora'
>> +                      '/linux/releases/29/Everything/x86_64/os/images/p=
xeboot'
>> +                      '/vmlinuz')
>> +        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
>> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkerne=
l_hash)
>> +
>> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE +
>> 'console=3DttyS0'
>
> I note that:
>
>   KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> and given we are looking for repeatability here maybe we should use our
> own command line so we can compare the recorded and replayed boot?

To build on that I think a command line like:

  KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D1 panic=3D-1 '

called with --no-reboot and a pattern:

  console_pattern =3D 'VFS: Cannot open root device'

You will run more of the kernel (importantly with timestamps > 0.000) so
we can have a better compare between the recorded and replayed run.

--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8921FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BE32088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKyvP8u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BE32088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGWa-0004M3-8a
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeGNc-0001ne-Vm
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:07:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeGNb-0001CQ-Ep
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:07:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id j16so14973267wrb.7
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uMy6Cq+D48z3kraLYS/BScyi7sgCqbRC4qX92FrlzTU=;
 b=IKyvP8u7gOPki3fkPuypU3fgm4oJJISg8yXbdI9s8gq8XlOsSzrbs5JHlsEgvqX9Pt
 MKS9z1lokldrCQhhCD+Cc8lu+Juy1pvZeHe93V3pbkuxbn4rNAezpEznVjL+Spm18ztM
 wY0Z+R+VYT/bToQYXEREa5DRBz5Kx4Y+dF7EcTItcs9fusKo683Ify34eBMUMojU8xQu
 oS8fXCjfwvSyk0iboeuUzIlB8QZu2VNNHJmmrHT9jF1NYOfKrrwax1uJscA1qw+P5lZV
 m4se8Y5tfnKL5B3+s6vhDihPggebfK3SREpaD4ptD7NgLDHLR93tUAyXBr5FBWDISATo
 tUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uMy6Cq+D48z3kraLYS/BScyi7sgCqbRC4qX92FrlzTU=;
 b=aeJzOuLNaCqIt00hZSlkAmPZprXj/xFv9kK+Bus/TPGedPfRiebvA/ZgLpv+xobu21
 68OLNEw+IdhEZpt0qrnRcYKa1kfw2nIGuzuarIfIYCFtelmPnM18fS1w6aLEAZZYf5co
 FsbigQ9DPJoXuY5p3yx7gkQB9pAy624NkSDeyI6WB4n+odl1pHpMsQwKDP9ozzCxQwlZ
 SepmiroVLmg2Rv0zbKbUiF3Vf5jb8Bb7SZkrrW22VclrfD1q4C4ouctVWBqjt0eHuy+/
 3T0K0Bo2SYuCaDEDU3V6OzLDmMNuOcFFG4+h+8eFE3/N43QbC2zrabi6Cnn3lDugnVtj
 1LrQ==
X-Gm-Message-State: AOAM531bHyEp0J4VvTiBePs8CfEO6992KJFPSWS36lGTG0iyGDWvmfb1
 +5oj3D1TZ9/wns3odY0CVXOHRA==
X-Google-Smtp-Source: ABdhPJx1Scwsi3ATBBq+JnbKEiwbmMoCPhekcYwhVLwPabL9M5QMzXgKxRBtIOBd+eDFAb7R4UUcLg==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr2967183wrq.196.1590664036395; 
 Thu, 28 May 2020 04:07:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k16sm3774439wrp.66.2020.05.28.04.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 04:07:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2AC471FF7E;
 Thu, 28 May 2020 12:07:14 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
 <1510a96e-2768-32c9-44f5-465ed9b0d859@redhat.com>
 <19507b45-b8d5-0bab-c0bf-a9ae161281f6@ispras.ru>
 <d03e2479-a341-c3e2-247b-797bc7d24a9b@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay
 test for x86_64
In-reply-to: <d03e2479-a341-c3e2-247b-797bc7d24a9b@redhat.com>
Date: Thu, 28 May 2020 12:07:14 +0100
Message-ID: <87k10w48t9.fsf@linaro.org>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, pavel.dovgaluk@ispras.ru,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, wrampazz@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/28/20 9:12 AM, Pavel Dovgalyuk wrote:
>>=20
>> On 27.05.2020 17:53, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 5/27/20 12:31 PM, Pavel Dovgalyuk wrote:
>>>> This patch adds a test for record/replay an execution of x86_64 machin=
e.
>>>> Execution scenario includes simple kernel boot, which allows testing
>>>> basic hardware interaction in RR mode.
>>>>
>>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>> ---
>>>>   0 files changed
>>>>
>>>> diff --git a/tests/acceptance/replay_kernel.py
>>>> b/tests/acceptance/replay_kernel.py
>>>> index b8b277ad2f..c7526f1aba 100644
>>>> --- a/tests/acceptance/replay_kernel.py
>>>> +++ b/tests/acceptance/replay_kernel.py
>>>> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>>>>                       True, shift, args)
>>>>           self.run_vm(kernel_path, kernel_command_line, console_patter=
n,
>>>>                       False, shift, args)
>>>> +
>>>> +    def test_x86_64_pc(self):
>>>> +        """
>>>> +        :avocado: tags=3Darch:x86_64
>>>> +        :avocado: tags=3Dmachine:pc
>>>> +        """
>>>> +        kernel_url =3D
>>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>>> +=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>>> +                      '/vmlinuz')
>>>> +        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
>>>> +        kernel_path =3D self.fetch_asset(kernel_url,
>>>> asset_hash=3Dkernel_hash)
>>>> +
>>>> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE +
>>>> 'console=3DttyS0'
>>>> +        console_pattern =3D 'Kernel command line: %s' %
>>>> kernel_command_line
>>>> +
>>>> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
>>>>
>>> This one timeouted (I build with --enable-debug):
>>=20
>> I've got the strange behavior for the couple of times.
>>=20
>> Console output was correct (I saw 'Kernel command line' in logs), but
>> _console_interation function didn't notice it.
>>=20
>> Therefore the test finished with timeout.
>>=20
>> How this could be possible?
>
> IIRC there is a problem in how Avocado consume the chardev output.

Is this the same problem Robert has tried to work around in tests/vm?

  From: Robert Foley <robert.foley@linaro.org>
  Subject: [PATCH v7 12/12] tests/vm: Add workaround to consume console
  Date: Tue, 19 May 2020 09:22:59 -0400
  Message-Id: <20200519132259.405-13-robert.foley@linaro.org>

>
> Cleber has been working on some PoC / kludge.
>
> Cleber/Eduardo do you remember the problem?
>
>>=20
>>>   (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc:
>>> replay: recording...
>>> replay: replaying...
>>> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
>>> reached\nOriginal status: ERROR\n{'name':
>>> '1-tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc',
>>> 'logdir':
>>> 'avocado/job-results/job-2020-05-27T16.48-71d7bf4/test-results/1-tes...
>>> (90.68 s)
>>>
>>=20


--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F95C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2567F207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e90GPy2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2567F207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIYz-0004fQ-8g
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeIYP-0004F4-LW
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:26:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeIYO-0007zw-Cp
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:26:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id h4so3123955wmb.4
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=n+m6GOmLj1XEX9ujK3vOgr8h9LltiPyg5DDbwB+Npf0=;
 b=e90GPy2/UDnBZzS4Hs/+RW2zE/rmMqRY9Dd9Cu0A6XoHBA7JggwBL6yLam/+ABGADT
 UQkormBJtuQmuAwCFIGQSJlV0P8IAT0qLGgAESFowkbUBi3LZG752oA4KUvVCtNX0Aec
 dVb7mN9NX1NoCAu0WfTyOueWJ6scK0FQP1p94z9orTexZaWQHI/jGcPr7EpPuISUXkPe
 1X40/X/La7gRMAeXxciDneDbosdCX0WzXgYB0qzMNEnrgftROlGQ5ddgVHJEyTAfoP8t
 Ev4xLfNV25kPmpotDnWV7LErpfrtN2OQ06iNGeqnhn6JxrHKQV0V/ZBDQbhSJR5I4dHa
 UYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=n+m6GOmLj1XEX9ujK3vOgr8h9LltiPyg5DDbwB+Npf0=;
 b=lLdZanS06m37RZ+qIDKvYsGN0Ut2iaD1JnO4kD8jJya4c1ObsN6OgP8wTU81DkN1qJ
 TlgDsydnRimVGz3jk+rR1LOl5eRLI63VHMyAEOqQTS9rpcj0YjhfSqjJgIHC1npLnyez
 mUHJjWzUrqCdkX55fghkewUxg0CbKY+p0laFzA8AUXKHz6oPKxjBvRypkQefL4YVmwBj
 u6BMNLzpxNPZnHlNbjtpimzAut8mOO363aJ/sd/kE64he6m6o18grZSNgCAvAVZ4mrcU
 CHpeZKoqWalXpvx1pZtCfSfBSpCh5GGsbom3xbOzCTZQJs4eiir5w6WrNoy/VQOT0YxZ
 A72g==
X-Gm-Message-State: AOAM530dq98FCq5SKHiUQlMBZ1HwoFMahfLRfmj8BovSwidkQ7ayPi1d
 XKpxjj+Bg7JBVWswJmBIpn8wmA==
X-Google-Smtp-Source: ABdhPJytc6YU5uwS+9Cl4IijAZ7pfN0wKSQ0Q/uVwKhoKBWGZPbx1IYraZYkxz5NrWynJ7oeOOSjJw==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr3524882wmg.181.1590672394512; 
 Thu, 28 May 2020 06:26:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm5236124wmc.0.2020.05.28.06.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 06:26:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A4CD1FF7E;
 Thu, 28 May 2020 14:26:29 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
 <87sgfl5qsl.fsf@linaro.org>
 <e9b00219-e7f2-a109-dcc1-f5a325cfae40@ispras.ru>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay
 test for x86_64
In-reply-to: <e9b00219-e7f2-a109-dcc1-f5a325cfae40@ispras.ru>
Date: Thu, 28 May 2020 14:26:28 +0100
Message-ID: <87h7w042d7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> On 27.05.2020 18:41, Alex Benn=C3=A9e wrote:
>> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>>
>>> This patch adds a test for record/replay an execution of x86_64 machine.
>>> Execution scenario includes simple kernel boot, which allows testing
>>> basic hardware interaction in RR mode.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>> ---
>>>   0 files changed
>>>
>>> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/repla=
y_kernel.py
>>> index b8b277ad2f..c7526f1aba 100644
>>> --- a/tests/acceptance/replay_kernel.py
>>> +++ b/tests/acceptance/replay_kernel.py
>>> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>>>                       True, shift, args)
>>>           self.run_vm(kernel_path, kernel_command_line, console_pattern,
>>>                       False, shift, args)
>>> +
>>> +    def test_x86_64_pc(self):
>>> +        """
>>> +        :avocado: tags=3Darch:x86_64
>>> +        :avocado: tags=3Dmachine:pc
>>> +        """
>>> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e/fedora'
>>> +                      '/linux/releases/29/Everything/x86_64/os/images/=
pxeboot'
>>> +                      '/vmlinuz')
>>> +        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
>>> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
>>> +
>>> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'con=
sole=3DttyS0'
>>> +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>>> +
>>> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
>> This test fails for me on the replay:
>
> Have you applied latest RR patches?

I have the following on top of the acceptance patches:

a36c23042fe * review/record-replay-acceptance-v2 icount: fix shift=3Dauto f=
or record/replay
4ab2164c10b * replay: synchronize on every virtual timer callback
66104ce6e4b * replay: notify the main loop when there are no instructions

>
>
>>
>>    2020-05-27 16:22:21,658 machine          L0326 DEBUG| VM launch comma=
nd: 'x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev soc=
ket,id=3Dmon,path=3D/var/tmp/tmp4n_geosi/qemu-9516-monitor.sock -mon charde=
v=3Dmon,mode=3Dcontrol -machine pc -chardev socket,id=3Dconsole,path=3D/var=
/tmp/tmp4n_geosi/qemu-9516-console.sock,server,nowait -serial chardev:conso=
le -icount shift=3D7,rr=3Dreplay,rrfile=3D/var/tmp/avocado_b85h3ycg/avocado=
_job_8xrxksgj/1-._tests_acceptance_replay_kernel.py_ReplayKernel.test_x86_6=
4_pc/replay.bin -kernel /home/alex/avocado/data/cache/by_location/df533120a=
0e0ffda2626bed6e8a975d3b07e3f05/vmlinuz -append printk.time=3D0 console=3Dt=
tyS0 -net none'
>>    2020-05-27 16:22:21,725 qmp              L0194 DEBUG| >>> {'execute':=
 'qmp_capabilities'}
>>    2020-05-27 16:22:21,736 qmp              L0202 DEBUG| <<< {'return': =
{}}
>>    2020-05-27 16:23:49,372 stacktrace       L0039 ERROR|
>>    2020-05-27 16:23:49,372 stacktrace       L0042 ERROR| Reproduced trac=
eback from: /home/alex/lsrc/qemu.git/builds/all/tests/venv/lib/python3.7/si=
te-packages/avocado/core/test.py:860
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR| Traceback (most=
 recent call last):
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 73, i=
n test_x86_64_pc
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     self.run_rr=
(kernel_path, kernel_command_line, console_pattern)
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 57, i=
n run_rr
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     False, shif=
t, args)
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 46, i=
n run_vm
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     self.wait_f=
or_console_pattern(console_pattern, vm)
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/acceptance/boot_linux_console.py", line =
37, in wait_for_console_pattern
>>    2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     vm=3Dvm)
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py", li=
ne 131, in wait_for_console_pattern
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     _console_in=
teraction(test, success_message, failure_message, None, vm=3Dvm)
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py", li=
ne 83, in _console_interaction
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     msg =3D con=
sole.readline().strip()
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/usr/li=
b/python3.7/socket.py", line 589, in readinto
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     return self=
._sock.recv_into(b)
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/a=
lex/lsrc/qemu.git/builds/all/tests/venv/lib/python3.7/site-packages/avocado=
/plugins/runner.py", line 89, in sigterm_handler
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     raise Runti=
meError("Test interrupted by SIGTERM")
>>    2020-05-27 16:23:49,374 stacktrace       L0045 ERROR| RuntimeError: T=
est interrupted by SIGTERM
>>
>>


--=20
Alex Benn=C3=A9e


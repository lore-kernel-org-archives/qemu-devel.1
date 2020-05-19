Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF549C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA35D206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvT/5y3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA35D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazYl-00038x-Sd
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jazXl-0002Ve-Od
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:32:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jazXg-0003E8-P9
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:32:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so15301361wrt.5
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rIGdCHgbqiaDjsRwTDc24ECCaxyt+kXycoAoxMASkmE=;
 b=bvT/5y3nl49OuDnr3sDJDcXn2OCb8xGFoBFRc08mUiFa5rwfwdOm2FdhxrFjP/A/zN
 bYALG+lLjXwORFVDdektpM7vIrYgvDrZipnf7C/nJW2TOp80VmXywnxgdI8nW9BH+DE1
 0lkxeSlxwoolKnIagAffgTezRvjBVLRsnUhuIypn2UGlRfU5XoZ9st/7nWNfuqyC0g8a
 zJgFdvYpu6I/WHckbfGYYEDv1ydncAwoxPNEY/eDRi4ISlOGseN7/8PMhpSU8BUqN1Pm
 eIB8of9AcgcuMxk76SKGyakgbjiqhq3nAexLJc16MvEpWGVinYVYU0OYYEEfcFittgwI
 5UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rIGdCHgbqiaDjsRwTDc24ECCaxyt+kXycoAoxMASkmE=;
 b=nfY+NmJYrjTTqGge3ITDZnHhNRmSiGSjsSvWPGENYsS69Eykm3ygQsksYLsEHo3nOa
 pXCKBKMOgeMqEZmOUnppz9DAH3g3CuNMf4+SrQdbw9NsqkGGFIKKYY6a2Z8d8zBqfnIq
 VvbJAMoJVh7hrEBNhETPYaIZsWmIEO5XEVvnDFT/YLPOS7Mf6kIsHczJMB8Ky/AB1p/D
 AexZGc7qbKW7Mh08OEhl6IJKJdsXzEqnGgNgeQ2bojHuqU96ErdYTUM/e66iOTlqlzV0
 Qsy9UcF1AgBp5364+Ejx25TNhs5qJIMBhlNz1k9JJf85akWOcOgjhBDxMVPp0v5Kxhek
 i7zg==
X-Gm-Message-State: AOAM530yCx3AbH46XCuCRc5e1+AqbOQRqaRrWabqjQAaBitHrgv80/Hh
 lB/4IaV/WwgEUuBRVtVPsTTGAQ==
X-Google-Smtp-Source: ABdhPJxQvrGTG4B5uqjDFhwpp4Tg9iSIyqBEt3gUSy72JgSdtXTGouaiTDdbwDU6lCDP+YOG+VOuXA==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr26555417wrh.254.1589884330914; 
 Tue, 19 May 2020 03:32:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e21sm3204925wme.34.2020.05.19.03.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 03:32:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D335A1FF7E;
 Tue, 19 May 2020 11:32:08 +0100 (BST)
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
 <c74e9498-75b4-d80c-e380-3d448497cfd0@redhat.com>
 <87wo59jky3.fsf@linaro.org>
 <b4da7577-8f42-3308-a4d6-05ff6451e944@ispras.ru>
 <87eergjqe5.fsf@linaro.org>
 <093880f8-72d4-f404-6792-d11c177aaedc@ispras.ru>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
In-reply-to: <093880f8-72d4-f404-6792-d11c177aaedc@ispras.ru>
Date: Tue, 19 May 2020 11:32:08 +0100
Message-ID: <87h7wci5av.fsf@linaro.org>
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
Cc: pbonzini@redhat.com, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> On 19.05.2020 11:11, Alex Benn=C3=A9e wrote:
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>>> On 18.05.2020 18:56, Alex Benn=C3=A9e wrote:
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>
>>>>> + Alex
>>>>>
>>>>> On 5/6/20 10:17 AM, Pavel Dovgalyuk wrote:
>>>>>> Sometimes virtual timer callbacks depend on order
>>>>>> of virtual timer processing and warping of virtual clock.
>>>>>> Therefore every callback should be logged to make replay determinist=
ic.
>>>>>> This patch creates a checkpoint before every virtual timer callback.
>>>>>> With these checkpoints virtual timers processing and clock warping
>>>>>> events order is completely deterministic.
>>>>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>>> ---
>>>>>>     util/qemu-timer.c |    5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>>>>>> index d548d3c1ad..47833f338f 100644
>>>>>> --- a/util/qemu-timer.c
>>>>>> +++ b/util/qemu-timer.c
>>>>>> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_=
list)
>>>>>>             qemu_mutex_lock(&timer_list->active_timers_lock);
>>>>>>               progress =3D true;
>>>>>> +        /*
>>>>>> +         * Callback may insert new checkpoints, therefore add new c=
heckpoint
>>>>>> +         * for the virtual timers.
>>>>>> +         */
>>>>>> +        need_replay_checkpoint =3D timer_list->clock->type =3D=3D Q=
EMU_CLOCK_VIRTUAL;
>>>>>>         }
>>>>>>         qemu_mutex_unlock(&timer_list->active_timers_lock);
>>>> So the problem I have with this as with all the record/replay stuff I
>>>> need want to review is it's very hard to see things in action. I added=
 a
>>>> *very* basic record/replay test to the aarch64 softmmu tests but they
>>>> won't exercise any of this code because no timers get fired. I'm
>>>> assuming the sort of tests that is really needed is something that not
>>>> only causes QEMU_CLOCK_VIRTUAL timers to fire and trigger logged HW
>>>> events and ensure that things don't get confused in the process.
>>> I encounter most of the bugs in different OS boot scenarios.
>>>
>>> We also have internal tests that include some computational, disk, and
>>> network interaction tasks.
>>>
>>> Is it possible to add a test like booting a "real" OS and replaying
>>> it?
>> Yes - for these bigger more complex setups we should use the acceptance
>> tests that run under Avocado. See "make check-acceptance".
>
> I've installed avocado and avocado-framework, but got the following error:
>
> venv/bin/python: No module named avocado

Hmm make check-acceptance should automatically setup local copies of
avocado using virtualenv. You shouldn't need to install the system
version.

>
>>
>>>> If I read up the file I just get more questions than answers. For
>>>> example why do we release the qemu_timers lock before processing the
>>>> replay event? Is it that the replay event could cause another timer to
>>> We release the lock, because accessing the replay module may process
>>> some events and add more timers.
>> OK. I guess the adding of the timer is a side effect of processing the
>> event rather than something that gets added directly?
>
> Right.
>
>
> Pavel Dovgalyuk


--=20
Alex Benn=C3=A9e


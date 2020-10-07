Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B666C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D2F206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjpOOboZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D2F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7Yq-00085k-Ec
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ7WT-0006YW-Ur
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:22:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ7WM-0005XJ-By
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:22:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id m6so1731514wrn.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FP0Y3iNmkBtVN4YfT+Yiz5RA8hDR/Qq/YODc2l+J1No=;
 b=HjpOOboZLHStXF7z2kUawnrbzMAMtHkAgLk6XbWAqj0i51NhYEhCfaG/vCYhHWVRVO
 8Iy4e0XsBpzR0h1IRpKXXUI38Ri8oAZNU4IVOG3FhKochhk5Mm8UCiVH1vsZc1/ioTUt
 ZBAKL+poE8NizfCsUE1szgkwuMVHYml5Spf5fvEI98L6HKuQPvre7o44JDtzkisdUqYJ
 leYSBr+GvRhIVR9tqz317DHrUnP92DK7hy/eOIgjmlCzLx+04UbhX+lsi4AXoWOcbX7y
 B5DU7ZkE1V18ejuhhbT8BJG0q17lwMjgw3cNeWdtM/VVtWbFvDx+wd6aV+3/RXaP8QTp
 LZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FP0Y3iNmkBtVN4YfT+Yiz5RA8hDR/Qq/YODc2l+J1No=;
 b=YPEzGhTZacCU+/lv8n7atkfg0/V6mjRUsY7Ud0oZ/IVY9c+6DQ9fCC1Ew2f1Y/It9c
 JImgqz+xVvNxjz1ELPcfWYlZAX2u7xG/HDqlOYkezs8QSgH5B9NumVV3iL0LuxbuDZLJ
 SpvcW7TZGRHRwrQERsXNcbAS5WVodK+dLMDR9zA5jZp9wiqpeBhMfhznasQDoOqNa5sm
 SfeuIqV/CgaVWzCfUosRfg3BL7cHHwIJJzw3pGpvEUrGSbmZuxi2FNsdNl6Xyh5D8oA2
 leJeFGgBLatMHW3h0IAgfxWejo39l8kCYCp6IIpfwUkyuCiNfunHw624C7FWQ8rvI+Ua
 PZ0Q==
X-Gm-Message-State: AOAM532/1xn46Lx7EpGzxqpssm7ig0FMnpwy3hyiCY9nALM3w0HUd2R3
 p/8DV/0QpNiYWgZdrWkP8vL6cQ==
X-Google-Smtp-Source: ABdhPJwiyVdCRXam+TvI6BUoWhzNiIbhJK8TXbP9H/Y/tWRSmxc9O/eOHbtlz/igyNGd2p37APyN3g==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr2801745wrm.419.1602069725106; 
 Wed, 07 Oct 2020 04:22:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 76sm2353416wma.42.2020.10.07.04.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 04:22:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 697C61FF7E;
 Wed,  7 Oct 2020 12:22:03 +0100 (BST)
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: acceptance-system-fedora failures
In-reply-to: <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com>
Date: Wed, 07 Oct 2020 12:22:03 +0100
Message-ID: <878sci1dt0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>> On 07.10.2020 11:23, Thomas Huth wrote:
>>> On 07/10/2020 09.13, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 10/7/20 7:20 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 10/7/20 1:07 AM, John Snow wrote:
>>>>>> I'm seeing this gitlab test fail quite often in my Python work; I
>>>>>> don't
>>>>>> *think* this has anything to do with my patches, but maybe I need
>>>>>> to try
>>>>>> and bisect this more aggressively.
>>> [...]
>>>>> w.r.t. the error in your build, I told Thomas about the
>>>>> test_ppc_mac99/day15/invaders.elf timeouting but he said this is
>>>>> not his area. Richard has been looking yesterday to see if it is
>>>>> a TCG regression, and said the test either finished/crashed raising
>>>>> SIGCHLD, but Avocado parent is still waiting for a timeout, so the
>>>>> children become zombie and the test hang.
>>>>
>>>> Expected output:
>>>>
>>>> Quiescing Open Firmware ...
>>>> Booting Linux via __start() @ 0x01000000 ...
>>>>
>>>> But QEMU exits in replay_char_write_event_load():
>>>>
>>>> Quiescing Open Firmware ...
>>>> qemu-system-ppc: Missing character write event in the replay log
>>>> $ echo $?
>>>> 1
>>>>
>>>> Latest events are CHECKPOINT CHECKPOINT INTERRUPT INTERRUPT INTERRUPT.
>>>>
>>>> Replay file is ~22MiB. End of record using "system_powerdown + quit"
>>>> in HMP.
>>>>
>>>> I guess we have 2 bugs:
>>>> - replay log
>>>> - avocado doesn't catch children exit(1)
>>>>
>>>> Quick reproducer:
>>>>
>>>> $ make qemu-system-ppc check-venv
>>>> $ tests/venv/bin/python -m \
>>>>    avocado --show=3Dapp,console,replay \
>>>>    run --job-timeout 300 -t machine:mac99 \
>>>>    tests/acceptance/replay_kernel.py
>>>
>>> Thanks, that was helpful. ... and the winner is:
>>>
>>>      commit   55adb3c45620c31f29978f209e2a44a08d34e2da
>>>      Author:  John Snow <jsnow@redhat.com>
>>>      Date:    Fri Jul 24 01:23:00 2020 -0400
>>>      Subject: ide: cancel pending callbacks on SRST
>>>
>>> ... starting with this commit, the tests starts failing. John, any
>>> idea what
>>> might be causing this?
>>=20
>> This patch includes the following lines:
>>=20
>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> +                                ide_bus_perform_srst, bus);
>>=20
>> replay_bh_schedule_oneshot_event should be used instead of this
>> function, because it synchronizes non-deterministic BHs.
>
> Why do we have 2 different functions? BH are already complex
> enough, and we need to also think about the replay API...
>
> What about the other cases such vhost-user (blk/net), virtio-blk?

This does seem like something that should be wrapped up inside
aio_bh_schedule_oneshot itself or maybe we need a
aio_bh_schedule_transaction_oneshot to distinguish it from the other
uses the function has.


--=20
Alex Benn=C3=A9e


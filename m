Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F8C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04A62078E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fACy8wsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04A62078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbX7-0003tu-Vy
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFbWK-00033K-Ai
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:10:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFbWI-0006Fn-8N
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:10:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so1603298wmj.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0sbHd7QIKaZwovgxTMtDRBhi3nZMJ8fK2OHQHOsrQnE=;
 b=fACy8wsYpIaBfP1kZbfj5MdNFeQoI3BGLmTdlgDYk2edOXvW2LRLy0PCwyguoceY2W
 0gRjsRtycq195Kximg9NCoT4TABbQ5Iw1eQc0mlQyfT5nCIlzhENRHKy/EJuNVU3cqBf
 rFFonO7Ggf5MN4U7huiBiYaK8DIxl9cmgtFuXwKGyNm9flro197VP7Wvt6zkEc/OEiq5
 8409RHoK4WGTzf1kJZPGojkHuIvfRootXi4502P2lKNyuPo07qQtYshOyb/Vk9CyhEUy
 3TZhA5PkfGtctfzIt3D5tY6rXU6NzdSpQuXxsK3iI2zxCAYsi+zSTlxpWhTSPvE8AdAa
 fiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0sbHd7QIKaZwovgxTMtDRBhi3nZMJ8fK2OHQHOsrQnE=;
 b=Dk27ybTWp38VV0HRm4DfD4g+SAASlsDabmgiRKaIecZYVoVRoB0isHpXyTofTYZQdr
 FWg1c/VcCDVC5B+UGhXXWrp/+BRwadkNLCvNYB3bBvpEO6KnceqTy2gBPCUmHuNZiAKA
 DTgeBypSzqS9uuGoHQrp2Me6biP/xMAmb5ieU6eDafPXvlKxl6N6dhUyA9sf3cpXx4hR
 Z6lInq+rU86y6KGtdGnNkTvyotwGgVw4NtKJSHyF9/1UcJdbfpJlkeh2Psdn6UCHuKEb
 v3Q4+vRqojyqHi8qiKFhhBnTQJFtLWAEPdQIxQ2meixZfHq0M8OZApMlNDMFK/8LgwUw
 QlXQ==
X-Gm-Message-State: AOAM532pY6yA6HuuW2UHxkLxgajoelC/OXU2eOTOAfmL9k9O2or6+Zaw
 Kuni1gEVyj6yneMbXiKX3HTESA==
X-Google-Smtp-Source: ABdhPJxNIl9IDp7Tg4vawr9bzbNTaYCSdghmSKn1d0UPMszV0zir+15sMoq1wU5zkwIE0hHo15syuA==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr3785294wmc.62.1599563436520; 
 Tue, 08 Sep 2020 04:10:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm33339678wru.88.2020.09.08.04.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 04:10:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6AA961FF7E;
 Tue,  8 Sep 2020 12:10:34 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
 <87sgbtrbf5.fsf@linaro.org>
 <8f077f41-f99b-cd46-ff3b-3cb191dc1c4c@ispras.ru>
 <87mu21r5t0.fsf@linaro.org>
 <1a0b8180-ae11-c6a0-6fc6-bfe87bbeaf27@ispras.ru>
 <87eendr1ty.fsf@linaro.org>
 <087c1214-d82f-8cd1-6418-5d823b9b5ae9@ispras.ru>
 <875z8or5qy.fsf@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
In-reply-to: <875z8or5qy.fsf@linaro.org>
Date: Tue, 08 Sep 2020 12:10:34 +0100
Message-ID: <87363sr0b9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>
>> On 07.09.2020 19:25, Alex Benn=C3=A9e wrote:
>>>=20
>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>=20
>>>> On 07.09.2020 17:59, Alex Benn=C3=A9e wrote:
>>>>>
>>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>>
>>>>>> On 07.09.2020 15:58, Alex Benn=C3=A9e wrote:
>>>>>>>
>>>>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>>>>
>>>>>>>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>>>>>
>>>>>>>> This patch adds hmp/qmp commands replay_seek/replay-seek that proc=
eed
>>>>>>>> the execution to the specified instruction count.
>>>>>>>> The command automatically loads nearest snapshot and replays the e=
xecution
>>>>>>>> to find the desired instruction count.
>>>>>>>
>>>>>>> Should there be an initial snapshot created at instruction 0? Using=
 a
>>>>>>> separate monitor channel:
>>>>>>
>>>>>> Right, you can't go to the prior state, when there is no preceding
>>>>>> snapshot available.
>>>>>
>>>>> It seems creating an initial snapshot automatically would be more user
>>>>
>>>> Please take a look at 'Snapshotting' section of docs/replay.txt.
>>>> Reverse debugging is considered to be run with disk image (overlay)
>>>> and rrsnapshot option of icount, which allows creating an initial
>>>> VM snapshot.
>>>=20
>>> Given that I'm using the block device purely for VM snapshots I think it
>>> would be useful to document the minimal "no disk" approach - i.e. where
>>> the disk is only used for record/replay.
>>>=20
>>> However I'm still having trouble. I can record the trace with:
>>>=20
>>>    ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio \
>>>      -machine virt -kernel zephyr.elf -net none \
>>>      -icount shift=3D6,align=3Doff,sleep=3Doff,rr=3Drecord,rrfile=3Drec=
ord.out,rrsnapshot=3Drrstart  \
>>>      -drive file=3Drecord.qcow2,if=3Dnone,id=3Drr \
>>>      -monitor telnet:127.0.0.1:4444 -S
>>
>> Can you provide your zephyr.elf image?
>>
>>>=20
>>> which shows:
>>>=20
>>>    (qemu) info snapshots
>>>    info snapshots
>>>    List of snapshots present on all disks:
>>>    ID        TAG               VM SIZE                DATE     VM CLOCK=
     ICOUNT
>>>    --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000=
          0
>>>=20
>>> but do I need a whole separate overlay in the replay case? I thought
>>> supplying snapshot to the drive would prevent the replay case
>>> overwriting what has been recorded but with:
>>>=20
>>>      -icount shift=3D6,align=3Doff,sleep=3Doff,rr=3Dreplay,rrfile=3Drec=
ord.out \
>>>      -drive file=3Drecord.qcow2,if=3Dnone,id=3Drr,snapshot
>>
>> When you provide qcow2 (overlay or not) for snapshotting, you don't need=
=20
>> any 'snapshot' option on drive.
>>
>>>=20
>>> but I get:
>>>=20
>>>    (qemu) info snapshots
>>>    info snapshots
>>>    There is no snapshot available.
>>>=20
>>> so if I drop the ,snapshot from the line I can at least see the snapshot
>>> but continue doesn't seem to work:
>>>=20
>>>    (qemu) info snapshots
>>>    info snapshots
>>>    List of snapshots present on all disks:
>>>    ID        TAG               VM SIZE                DATE     VM CLOCK=
     ICOUNT
>>>    --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000=
          0
>>>    (qemu) replay_break 190505
>>>    replay_break 190505
>>>    (qemu) c
>>>    c
>>>    (qemu) info replay
>>>    info replay
>>>    Replaying execution 'record.out': instruction count =3D 0
>>
>> It seems, that replay hangs. Can you try removing '-S' in record command=
=20
>> line?
>
> That doesn't make any difference removing from both the record and
> replay cases. It seems to need a loadvm to start things off.
>
> I've sent you an image off list. Please let me know if you can
> replicate.

OK I can successfully use gdb to reverse debug the acceptance test (\o/)
so I suspect there are differences in the calling setup.

The first one is ensuring that rrsnapshot is set for both record and
replay. For this reason I think a more user friendly automatic snapshot
would be worth setting up when record/replay is being used.

-icount sleep=3Doff definitely breaks things. Do we keep track of the
 icount bias as save and restore state?

--=20
Alex Benn=C3=A9e


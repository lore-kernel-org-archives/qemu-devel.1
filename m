Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94155C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50D721741
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyHyLLIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50D721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZhW-0003zI-17
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFZgi-0003GX-EX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:13:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFZgg-00088P-AR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:13:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id x23so6592939wmi.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ASb0Wz4yw7CBzKnHu8xZryVqPC3FqSRe3WDu3L0R7LU=;
 b=jyHyLLIP8YeS9Ahqo9raWfw8A9o4AMyHrNswdVPjH+EiKM/Z4L5WuGiaTwNW42l8qm
 GUb1L2c8rvVVfxos0Qx1feelpKF0myIMIQ/88ESCH+SO0HU7vg7EWQ9egGaziAfgVNpp
 22O7BJPQ3vZ1i/6cU9D3ywsmAVfPFv9tsJ/tcvqyIZYuyy10bLWv5lAglfqZzcZr9tQY
 /gId+qZCvA5Vv3+Y9FeDygiGnU8JFPzlSnqfcA+KAURmusJFZANgILYLinvmmlvufcc/
 /dGT80HQbweb5ZgwckuoQGWq+BFRklTFnc1heVlzc3gs/XQouXf0TxlPGyNjpAmlH/LP
 L6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ASb0Wz4yw7CBzKnHu8xZryVqPC3FqSRe3WDu3L0R7LU=;
 b=lAyLhwxID44w7FFZWS7UXb3udztlBqBZxKqk98uU5HVoCjhhnrIevijkOtxnhC+QaS
 iG3Bqt2UH5L1Q7lpubicWp7wPsUZNHoza0myr9Yu5/Be6FQYNtT105+Tx2VJLvY0Nxf6
 Z0L3MN4Jt+96qZb3kg31wBcuKB0SYovE1/7ax8Q+09bAA44s32mzLV9lbvD1z5Po/+LY
 xDYbYW6swaDO85KB8l8owL55WP9yjgAXWW6ua6leXTo15SLgOgQiq5UsW5rzKs+jhNB3
 E9F9QclXhbrlTwPfKCSDyVDqS0A2+hldXfSLs9nAFzUtDQc2A6ElgncxoQnEzTZIKHhK
 AfLQ==
X-Gm-Message-State: AOAM530vnToTfvnVj56vgxsND0YDhN/Vwm4sVIOVVtb6p6k5ug9n+6OL
 zOiFVzVKpbyJwtv3YV5VU4iumQ==
X-Google-Smtp-Source: ABdhPJzFEp5N+JZ2+r8BgqPPZoRZIPjbwQk5/3k8nRWSbvrJ4kOX58GFNX/0t7gDIX3C9dOWfF+eLw==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr3383387wmb.60.1599556391834; 
 Tue, 08 Sep 2020 02:13:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b76sm31416549wme.45.2020.09.08.02.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 02:13:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD92D1FF7E;
 Tue,  8 Sep 2020 10:13:09 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
 <87sgbtrbf5.fsf@linaro.org>
 <8f077f41-f99b-cd46-ff3b-3cb191dc1c4c@ispras.ru>
 <87mu21r5t0.fsf@linaro.org>
 <1a0b8180-ae11-c6a0-6fc6-bfe87bbeaf27@ispras.ru>
 <87eendr1ty.fsf@linaro.org>
 <087c1214-d82f-8cd1-6418-5d823b9b5ae9@ispras.ru>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
In-reply-to: <087c1214-d82f-8cd1-6418-5d823b9b5ae9@ispras.ru>
Date: Tue, 08 Sep 2020 10:13:09 +0100
Message-ID: <875z8or5qy.fsf@linaro.org>
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


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> On 07.09.2020 19:25, Alex Benn=C3=A9e wrote:
>>=20
>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>=20
>>> On 07.09.2020 17:59, Alex Benn=C3=A9e wrote:
>>>>
>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>
>>>>> On 07.09.2020 15:58, Alex Benn=C3=A9e wrote:
>>>>>>
>>>>>> Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:
>>>>>>
>>>>>>> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>>>>
>>>>>>> This patch adds hmp/qmp commands replay_seek/replay-seek that proce=
ed
>>>>>>> the execution to the specified instruction count.
>>>>>>> The command automatically loads nearest snapshot and replays the ex=
ecution
>>>>>>> to find the desired instruction count.
>>>>>>
>>>>>> Should there be an initial snapshot created at instruction 0? Using a
>>>>>> separate monitor channel:
>>>>>
>>>>> Right, you can't go to the prior state, when there is no preceding
>>>>> snapshot available.
>>>>
>>>> It seems creating an initial snapshot automatically would be more user
>>>
>>> Please take a look at 'Snapshotting' section of docs/replay.txt.
>>> Reverse debugging is considered to be run with disk image (overlay)
>>> and rrsnapshot option of icount, which allows creating an initial
>>> VM snapshot.
>>=20
>> Given that I'm using the block device purely for VM snapshots I think it
>> would be useful to document the minimal "no disk" approach - i.e. where
>> the disk is only used for record/replay.
>>=20
>> However I'm still having trouble. I can record the trace with:
>>=20
>>    ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio \
>>      -machine virt -kernel zephyr.elf -net none \
>>      -icount shift=3D6,align=3Doff,sleep=3Doff,rr=3Drecord,rrfile=3Dreco=
rd.out,rrsnapshot=3Drrstart  \
>>      -drive file=3Drecord.qcow2,if=3Dnone,id=3Drr \
>>      -monitor telnet:127.0.0.1:4444 -S
>
> Can you provide your zephyr.elf image?
>
>>=20
>> which shows:
>>=20
>>    (qemu) info snapshots
>>    info snapshots
>>    List of snapshots present on all disks:
>>    ID        TAG               VM SIZE                DATE     VM CLOCK =
    ICOUNT
>>    --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000 =
         0
>>=20
>> but do I need a whole separate overlay in the replay case? I thought
>> supplying snapshot to the drive would prevent the replay case
>> overwriting what has been recorded but with:
>>=20
>>      -icount shift=3D6,align=3Doff,sleep=3Doff,rr=3Dreplay,rrfile=3Dreco=
rd.out \
>>      -drive file=3Drecord.qcow2,if=3Dnone,id=3Drr,snapshot
>
> When you provide qcow2 (overlay or not) for snapshotting, you don't need=
=20
> any 'snapshot' option on drive.
>
>>=20
>> but I get:
>>=20
>>    (qemu) info snapshots
>>    info snapshots
>>    There is no snapshot available.
>>=20
>> so if I drop the ,snapshot from the line I can at least see the snapshot
>> but continue doesn't seem to work:
>>=20
>>    (qemu) info snapshots
>>    info snapshots
>>    List of snapshots present on all disks:
>>    ID        TAG               VM SIZE                DATE     VM CLOCK =
    ICOUNT
>>    --        rrstart           653 KiB 2020-09-07 17:12:42 00:00:00.000 =
         0
>>    (qemu) replay_break 190505
>>    replay_break 190505
>>    (qemu) c
>>    c
>>    (qemu) info replay
>>    info replay
>>    Replaying execution 'record.out': instruction count =3D 0
>
> It seems, that replay hangs. Can you try removing '-S' in record command=
=20
> line?

That doesn't make any difference removing from both the record and
replay cases. It seems to need a loadvm to start things off.

I've sent you an image off list. Please let me know if you can replicate.

--=20
Alex Benn=C3=A9e


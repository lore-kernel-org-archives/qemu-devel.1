Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D085820872
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omRfpBvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D085820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiCL-0000UD-W2
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jai88-0001py-UF
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:56:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jai87-0000iY-PA
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:56:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id k13so10400445wrx.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ehPpeIyOnjQ8BG0XmY+2D7WZYbIk78HuhWeSK53q4Xc=;
 b=omRfpBvFYp8K/RD505DQKr1ZjyUuJQ6KgkjF39fW7xEZnspeVWfNTXp1w2Qi6cTjsb
 Ytn+E2WZ1v1Ud0Hqqim+KxZKE4NhXOk7mFrqilCXnE3+4rPtduocExaR1IZvXMSaNpm4
 D6rj6T7DnKmZL+0hZT6+j+LLxib1C7Yf0Q4dd+MQBTw1jvqodLOqxso2ipmaVFy0TKeD
 FUbBNh7f6EuBvZ6ia4xZkLEeXwkWaJdCaU5gUUEd2VQcqOFsJl+E8IUxz/UX4yR+KvCM
 UffatpPeB0vhqvUnMkQ0hgrDcuihotlytme8kH9P4kOmWrbOZViwvh3pzBcbm9iZ6ZZn
 E1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ehPpeIyOnjQ8BG0XmY+2D7WZYbIk78HuhWeSK53q4Xc=;
 b=qRLwta3qqgGbHelhWjCGJyYwXj9w9hhnrM2+CbFOjPPvVokUpre6Y/LzeO4q7Od/Jq
 BcA7M7+7k4lF7a9nkkl7kCoxh1HCC7dn60JbrWe7zL1fmqG10+vHid/VpXODCvKI1Sp3
 3i8oNITaajnXTZCVqkC8C0IvOnBYNm61MRnsYKhBKpUW/o9+xppPAOWuZKtIfqbnGnRC
 O26QHYCtdDmmO0zHY13i+cjO4gQ4bKQMTsxyAlDHaHnHy+BMtJ+zFS10pWq5DYDys1kt
 0Jk89xy0qTG/s7cd99EcWyDi8o94CR8n2qqdIyEkIWnMMU2G29/fllYAVJYdCAiqki4e
 2BOA==
X-Gm-Message-State: AOAM5314Yn/NpvPJ5wjPFdV2HA0D08k0FAKUtTOQU54KW4OtSJYNRY5D
 BhpsiXkWgFcw6E44yF/8hJsMlQ==
X-Google-Smtp-Source: ABdhPJy2hl9eU4jhk3z1CvL7WE33BPrp9CGRr42Ztwly+niCw0QpufzHiqGjx4NO9bgJCRKvtHGvGA==
X-Received: by 2002:adf:e703:: with SMTP id c3mr21138386wrm.252.1589817398199; 
 Mon, 18 May 2020 08:56:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c17sm17328144wrn.59.2020.05.18.08.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:56:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 367191FF7E;
 Mon, 18 May 2020 16:56:36 +0100 (BST)
References: <158875304273.3986.105601155554744438.stgit@pasha-ThinkPad-X280>
 <c74e9498-75b4-d80c-e380-3d448497cfd0@redhat.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] replay: synchronize on every virtual timer callback
In-reply-to: <c74e9498-75b4-d80c-e380-3d448497cfd0@redhat.com>
Date: Mon, 18 May 2020 16:56:36 +0100
Message-ID: <87wo59jky3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
 dovgaluk@ispras.ru, qemu-devel@nongnu.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> + Alex
>
> On 5/6/20 10:17 AM, Pavel Dovgalyuk wrote:
>> Sometimes virtual timer callbacks depend on order
>> of virtual timer processing and warping of virtual clock.
>> Therefore every callback should be logged to make replay deterministic.
>> This patch creates a checkpoint before every virtual timer callback.
>> With these checkpoints virtual timers processing and clock warping
>> events order is completely deterministic.
>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> ---
>>   util/qemu-timer.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>> index d548d3c1ad..47833f338f 100644
>> --- a/util/qemu-timer.c
>> +++ b/util/qemu-timer.c
>> @@ -588,6 +588,11 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
>>           qemu_mutex_lock(&timer_list->active_timers_lock);
>>             progress =3D true;
>> +        /*
>> +         * Callback may insert new checkpoints, therefore add new check=
point
>> +         * for the virtual timers.
>> +         */
>> +        need_replay_checkpoint =3D timer_list->clock->type =3D=3D QEMU_=
CLOCK_VIRTUAL;
>>       }
>>       qemu_mutex_unlock(&timer_list->active_timers_lock);

So the problem I have with this as with all the record/replay stuff I
need want to review is it's very hard to see things in action. I added a
*very* basic record/replay test to the aarch64 softmmu tests but they
won't exercise any of this code because no timers get fired. I'm
assuming the sort of tests that is really needed is something that not
only causes QEMU_CLOCK_VIRTUAL timers to fire and trigger logged HW
events and ensure that things don't get confused in the process.

If I read up the file I just get more questions than answers. For
example why do we release the qemu_timers lock before processing the
replay event? Is it that the replay event could cause another timer to
be consumed? That seems suspect to me given we should only be expiring
times in the run loop.

Could the code be re-factored to use QEMU_LOCK_GUARD? It's hard to know
and I really wouldn't want to try that re-factoring without some sort of
confidence we were properly exercising the semantics of record/replay
and alive to potential regressions.

Please realise I do like the concept of record/replay and I'd love to
get more features merged (like for example the reverse debug patches).
However by it's very nature it gets it's fingers deeply intertwined with
the main run loop and we really need to better exercise the code in our
tests.

FWIW you can have an:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

which means it doesn't look obviously broken to me and it doesn't seem
to break the non-record/replay cases because that's all I can really
test.


--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E4AC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D0A20870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNSMhGtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D0A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7F3-0004nf-Qw
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ7Bo-0001ZS-4M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:00:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ7Bl-0002yc-P3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:00:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id d81so1846617wmc.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8u8SBSMZ+c1vmVLzkLtI8dVoB23/oZiQIdhsNt85Ob8=;
 b=uNSMhGtG58n763qgfGz7cAkUBndMIFPpxjyzdeL88zPE0pefEc4hL8uBxRUS9YGSI0
 ZqhruuqIqVdFh2/j/E3esDOq2wHbHmw0Hy01ZrbnVCwRvQIk2rTdnfKvnY3rXViz418d
 XNIH4QMUE8UJkGqnrP1HAcCdUeGxgIgWa+FDNJF00XjSfpbz04VbjO2DEOkzuGRbyr7c
 zlt5Cqd3QZlZgX360xZbN4D2sW3QuIK6/94HQRak+xX/Q7PlYxov35O5SbPNyS1qtIus
 qAyNDTfEALQHSXZnoDGcS9O2xp6cYS1w1jzH8/RoWCWtQ5k9SLA92wGAVTN1fzno7XMh
 oWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8u8SBSMZ+c1vmVLzkLtI8dVoB23/oZiQIdhsNt85Ob8=;
 b=UVYXZj459lOD7aoERJpD/HSKc8rUv1oR7e+mVGdWdQH4XCErrhZwlRTzF2u6CrHyoj
 S5pVbQsI1tJwmV3b8MrwcHgcbotD7WVGTf0iZczFRiaqwyGX6VoA6ptT64Xw9Ki5Ot6N
 8zZ7f8FGS9DAPCWwLXGhwkF7w08tO/o6qtKFj+pd4NwuiLdLnORrXwQrlFXxDL5oFMXV
 uE6YWdOiivaMXsOCa1TFGNMkANx9UrLHW/KQGRjQrtvBCjzes1L40w5j4U3yoPn7nJKx
 +KQEKfrTsaMUNXKRVzUrMLywz71cjPUguqBhRVgILt805lSHmqcxGjgyor/Zyao/xZlT
 WAVg==
X-Gm-Message-State: AOAM532F573VNycLfk2i/IqLS77DQC8cemf3jgyqTx6IXAMjxrlHfrVU
 XxP2q3abIH0e5/I2/h4qVUnv6Q==
X-Google-Smtp-Source: ABdhPJxjydNBu2m7jALKtIY3eY6LFvbzadr1NXcJ8/WcKmYWWTzE3dM/O9zaiYVxg1By8nnTT1hHeg==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr2725570wmj.79.1602068452043;
 Wed, 07 Oct 2020 04:00:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l3sm2179504wmh.27.2020.10.07.04.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 04:00:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 19FDD1FF7E;
 Wed,  7 Oct 2020 12:00:50 +0100 (BST)
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org>
 <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com>
 <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
 <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
 <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Schneider <74cmonty@gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
In-reply-to: <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com>
Date: Wed, 07 Oct 2020 12:00:50 +0100
Message-ID: <87blhe1esd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Schneider <74cmonty@gmail.com> writes:

> Hi,
>
> I already considered the host CPU power.
> However I have this=20
> <https://ark.intel.com/content/www/us/en/ark/products/33924/intel-core-2-=
quad-processor-q9550-12m-cache-2-83-ghz-1333-mhz-fsb.html>=20
> CPU
> Intel Core 2 Quad Q9550 2,83 GHz
> and assumed this should be powerful enough for RPi emulation.

For each emulated instruction you can be running between 6-10 host
instructions on average. We have certainly improved the performance of
the emulation over time and take advantage of multiple threads but in
the end system emulation will always be fairly expensive.

> But maybe my assumption was too optimistic.

You can use perf to record your boot and analyse where QEMU is spending
it's time. Unless there is a major outlier though it's unlikely to be
easy to optimise.

>
>
> Am 07.10.2020 um 08:50 schrieb Paul Zimmerman:
>> On Tue, Oct 6, 2020 at 11:28 PM Thomas <74cmonty@gmail.com> wrote:
>>> Hello!
>>>
>>> Many thanks for your support.
>>>
>>> I managed to get emulated RPi starting.
>>>
>>> However there's one question I want to ask:
>>> How can I accelerate the startup sequence?
>>> I mean booting the emulated RPi takes more than 3 minutes.
>>>
>>> Regards
>>> Thomas
>> Get a faster computer? ;)
>>
>> On my Intel i7 desktop it takes about 40 seconds to boot to the login:
>> prompt on the serial console, and about 1 min 8 seconds before the
>> GUI is up. On my 5 year old laptop it's probably twice that. I don't know
>> of any way to make it go faster.
>>
>> - Paul
>>
>>> Am 06.10.20 um 11:58 schrieb Alex Benn=C3=A9e:
>>>> Thomas Schneider <74cmonty@gmail.com> writes:
>>>>
>>>>> Hello Paul,
>>>>>
>>>>> many thanks for sharing this info.
>>>>>
>>>>> Can you confirm that the emulated RPi with your command will use
>>>>> "internal QEMU" network, means the client cannot be accessed from any
>>>>> other device in LAN?
>>>> The support for user-mode and TAP networking is orthogonal to the
>>>> emulated device. However if you only want a few ports it's quite easy =
to
>>>> use port forwarding, e.g:
>>>>
>>>>    -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22
>>>>
>>>> which forwards 2222 to port 22 on the device. I have an alias in
>>>> .ssh/config for accessing my QEMU devices.
>>>>
>>>>> If yes, what is required to setup a TAP connected to host's network
>>>>> bridge?
>>>> I'll defer to others for this but generally when I want proper bridged
>>>> networking for a VM I use virt-manager/libvirt to configure it because
>>>> it can be quite fiddly to do by hand.
>>>>


--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE00C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB7C2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2h2ezEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB7C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGJk-00088Y-Fs
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVGIf-0007ZS-31
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:45:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVGId-00079H-5Y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 11:45:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id x7so3697501wrl.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XY6xvBHYC4qWatooHXPBZ420QKNbcv2K0kCyAK4iVYU=;
 b=M2h2ezEWYupo4uCCVVhmjVr8hhz27vz7ErJlIMeaGb/OWQS6IxPWG8mWrYH6jwVMRp
 eiTGQWBklNrj9+jKy/d+uwPt5iYxeRwzccHEcoNMqx3r87k2wDTKXL+DEu+54+TBgg3/
 P2J5f1iTZRomJ1/DHX9tXuLB0aPhSxvQiA+bTfnOMb2ajB9gez8InJsrTxvG7lowCpCY
 LMa6gqA1Z8il7+AdsZL5X5LMURrwOT+NEndKVfVT6wB0CxdG1M3qb4oPx7t8vdGTzyhc
 ojNhI9vWSVkJNna4nQQeHPlPfpleVjE2WDk65HiODS/cc4Q+ZX7fpzU5ieJdtRqquzCD
 SPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XY6xvBHYC4qWatooHXPBZ420QKNbcv2K0kCyAK4iVYU=;
 b=CH+nnrG5jrVVRr7Qp11SMpYaUj4+SuiwyLAD1sqM+FpYeQAsiz2SXN9zjB4tSbDa27
 Hks3Ov5NE4HuLItx8CQxxHmmV+gdGYujDCMZoq5wlkJB8emZpSn9TytqzhHkAsVek7VV
 4/RSmJxNinebstiRYuXJjUdTWB+kgDPuBKwP0AY+ErWFrQadTQ3vGpiA+AsJQMhOTHuJ
 X/nNPIkzTTQIAoVbHO7nAtYScPV9Wo0rKZ0QFGmvmzf2q+yMs8sO9GNVmrhCKoyM3jX8
 w8PHITRIC8MKeJ6g8r4JaRPNCNSi1vMdUnhVwURbylTniTuhBy/F2mBf0bwVYed6bNNX
 NsWw==
X-Gm-Message-State: AOAM531DUj18+JI8Fsgy9nEqy0JReI4sSZ7oRaJD1beVGkKDPkaPXE9k
 G2paPqRFC/ToxojeGFt444uxiQ==
X-Google-Smtp-Source: ABdhPJwIt2iT8uloebovRv4svM3a0kHMnytpsgQLQ5gB+Us4XwHYiRAhWNKpPJHUbEvg2avhVGe5FA==
X-Received: by 2002:adf:deca:: with SMTP id i10mr5591381wrn.96.1603295111771; 
 Wed, 21 Oct 2020 08:45:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 32sm4462551wro.31.2020.10.21.08.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 08:45:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED1BE1FF7E;
 Wed, 21 Oct 2020 16:45:09 +0100 (BST)
References: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
 <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
 <CAD5UmjrjORJbP0sj-DnGQFaQ443-vYMBa-1qCBzJsnUG+gU=jw@mail.gmail.com>
 <CAFEAcA9JecdSwd=gXSu7mhDHVysLP5JP4dtRBgBVr7=bt=j6Tw@mail.gmail.com>
 <CAD5UmjrFgv1pCKGW813dzmYcEEWLdvu9FmGi0ymvXbvfw-aonQ@mail.gmail.com>
 <CAD5UmjqDGmOksXSk31q3asXLogSggc7rqOXuo2K2yLLs81ccQQ@mail.gmail.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bruno Prado <bruno@dcomp.ufs.br>
Subject: Re: ARM semihosting issue
In-reply-to: <CAD5UmjqDGmOksXSk31q3asXLogSggc7rqOXuo2K2yLLs81ccQQ@mail.gmail.com>
Date: Wed, 21 Oct 2020 16:45:09 +0100
Message-ID: <875z73wpkq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bruno Prado <bruno@dcomp.ufs.br> writes:

> Hello, is it really a bug?
>
> ----
> Bruno Prado
>
>
> On Fri, Oct 2, 2020 at 8:09 AM Bruno Prado <bruno@dcomp.ufs.br> wrote:
>
>> I am including some syscall functions:
>>
>> int _fstat(int file, struct stat* st) {
>>        register int value asm("r0");
>>        uint32_t p[] =3D { file };
>>        R0(0x0C);
>>        R1(p);
>>        BKPT();
>>        return value;
>> }
>>
>> int _read(int file, char* ptr, int len) {
>>        register int value asm("r0");
>>        uint32_t p[] =3D { file, (uint32_t)(ptr), len };
>>        R0(0x06);
>>        R1(p);
>>        BKPT();
>>        return value;
>> }
>>
>> int _write(int file, char* ptr, int len) {
>>        register int value asm("r0");
>>        uint32_t p[] =3D { file, (uint32_t)(ptr), len };
>>        R0(0x05);
>>        R1(p);
>>        BKPT();
>>        return value;
>> }
>>
>> Also the interruption output from execution:
>>
>> $ qemu-system-arm -M netduino2 -nographic -semihosting -kernel vp2.bin -d
>> int
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x1
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x1
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x1
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x1
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0xc
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x5
>> What is your name?
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x5
>> Reading from file...
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0xc
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x6
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0xc
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x6
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x5
>> My name is Turing
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x5
>> I am alive!!!
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0xa
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0xa
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x2
>> Taking exception 16 [Semihosting call]
>> ...handling as semihosting call 0x20
>>
>> Could you please provide any working example using ARM semihosting on
>> stdin?

We have a test which you can run by hand:

   ./tests/tcg/arm-linux-user/semiconsole

>>
>> Thanks,
>> ----
>> Bruno Prado
>>
>>
>> On Fri, Oct 2, 2020 at 7:25 AM Peter Maydell <peter.maydell@linaro.org>
>> wrote:
>>
>>> On Thu, 1 Oct 2020 at 22:21, Bruno Prado <bruno@dcomp.ufs.br> wrote:
>>> > Thanks for the reply... I am attaching some code and output:
>>> >
>>> > #include <stdio.h>
>>> > int main() {
>>> >        char name[50] =3D "Nobody";
>>> >        FILE* file =3D fopen("name", "r");
>>> >        printf("What is your name?\n");
>>> >        fprintf(stdout, "Reading from file...\n");
>>> >        fscanf(file, "%s", name);
>>> >        fscanf(stdin, "%s", name);
>>> >        printf("My name is %s\n", name);
>>> >        fprintf(stderr, "I am alive!!!\n");
>>> >        fclose(file);
>>> >        return 0;
>>> > }
>>>
>>> This is not making direct semihosting calls. The behaviour
>>> of these function calls will depend on whatever the C
>>> standard library implementation you're linking with is doing.
>>>
>>> You're not checking for errors from any of your function
>>> calls, incidentally.
>>>
>>> thanks
>>> -- PMM
>>>
>>


--=20
Alex Benn=C3=A9e


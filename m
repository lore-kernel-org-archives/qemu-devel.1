Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB2C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FC924F58
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FC924F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35644 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXned-0002rP-JN
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 10:09:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXnbJ-0000cQ-FD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXnbH-000051-IX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:06:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hXnbE-0008NE-Ic
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:06:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so12189944wrq.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 07:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lpWJgT7nZJ31/XsZZPoQHcNs1sZQLJn93gGOfom35ZA=;
	b=QG5ZJ1JsKaHOCbPF4eTft/81IuRTFD9w0WFlbfp3dl1jTJ69kHYjSW+85LKXZ5i90r
	dDuoX6frlMI/NFND+tKERR+R4zV784zBF59O6aGH2J9ZtuIX6FjEnLzdw7ZL/gxY0xYP
	ZoDeo0/RF83y8ZVP+fiyaNgX7Cxwp62CxGC8w9C7VB1UujTXK9skfgiTzIYFs/dINuSl
	DmRbjzAvJuf4MOV0Iap+X1dadw6ONhgE3F7GvmtpCidMs9cY5tV8qcumPHznF6Aqviy8
	GWafxG77A0Lco7WBlOFkCqThtaOo6bz4xphUL56CFAH5czLeThjKwa2QZ2/rj9pxvSpS
	b8+A==
X-Gm-Message-State: APjAAAUM7peKaLUozJE3sMNxrI2Ekd6cDm+39rPRztXlPRgiZE6XsxBk
	ikgrWygX6z+WiBs3yzzlac1emQ==
X-Google-Smtp-Source: APXvYqy8Q2zb+u49mQFFvW0MRG3p/LOAnq83omuC4HiVTIqZvU8pv9a5qV6uYjd6p1oLr0kwDpkfmA==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr2685493wrw.232.1559570765227; 
	Mon, 03 Jun 2019 07:06:05 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	c5sm12577952wma.19.2019.06.03.07.06.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 07:06:04 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-5-f4bug@amsat.org>
	<CAL1e-=jfYuh4jLAacFeZcOes5A3PERNLqsE4_hiEci+x0XBTrw@mail.gmail.com>
	<CAL1e-=heGtJj-30YsAVyGKSMULZ5ggVd42+c9caGqN3PBRddag@mail.gmail.com>
	<92d1d73c-c091-9768-a850-69b736c28edc@redhat.com>
	<CAL1e-=h_rdCPicD7T3hdJSn0Ea5dzowGLts6P1VNm4FvWU_z5Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4ebef20d-4852-d443-6500-f7952f31ccec@redhat.com>
Date: Mon, 3 Jun 2019 16:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h_rdCPicD7T3hdJSn0Ea5dzowGLts6P1VNm4FvWU_z5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 4/4] BootLinuxSshTest: Test some userspace
 commands on Malta
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 3:41 PM, Aleksandar Markovic wrote:
>>>>> This test can be run using:
>>>>>
>>>>>   $ avocado --show=ssh run -t arch:mips
>>> tests/acceptance/linux_ssh_mips_malta.py
>>>>>   ssh: Entering interactive session.
>>>>>   ssh: # uname -a
>>>>>   ssh: Linux debian-mips 3.2.0-4-4kc-malta #1 Debian 3.2.51-1 mips
>>> GNU/Linux
>>>>>   ssh: # lspci -d 11ab:4620
>>>>>   ssh: 00:00.0 Host bridge: Marvell Technology Group Ltd.
>>> GT-64120/64120A/64121A System Controller (rev 10)
>>>>>   ssh: # cat /sys/bus/i2c/devices/i2c-0/name
>>>>>   ssh: SMBus PIIX4 adapter at 1100
>>>>>   ssh: # cat /proc/mtd
>>>>>   ssh: dev:    size   erasesize  name
>>>>>   ssh: mtd0: 00100000 00010000 "YAMON"
>>>>>   ssh: mtd1: 002e0000 00010000 "User FS"
>>>>>   ssh: mtd2: 00020000 00010000 "Board Config"
>>>>>   ssh: # md5sum /dev/mtd2ro
>>>>>   ssh: 0dfbe8aa4c20b52e1b8bf3cb6cbdf193  /dev/mtd2ro
>>>>>   ssh: # poweroff
>>
>> Aleksandar, do you think of other commands we should run? What commands
>> do you usually try?
>>
> 
> Philippe, I will leave to you the choice of commands. You know that I
> have a very high opinion on this test that you designed and also
> implemented, I am more than happy even without any additions. But,
> by no means, add something whenever you think it is interesting
> and useful.
> 
> However, I want to bring to your attention something that could also
> be of tremendous importance: Can we try communicating with the
> newly booted machine via gdb? And do some simple commands,
> like load a binary, set a breakpoint, display register content, etc?

Yes! This is my next step, I'm working on some draft series. It might
takes a while. My idea is to have some prototype working, then send as
RFC and ask for help. I'll Cc you then.

Regards,

Phil.


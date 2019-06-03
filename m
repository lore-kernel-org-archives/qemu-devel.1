Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FFC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06292542C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4HGBaBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06292542C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXnEO-00059M-W2
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 09:42:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hXnDG-0004Me-6v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hXnDF-0007j5-3T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:41:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hXnDE-0007gv-T8
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:41:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id u11so16069832otq.7
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eJiTNkvrYLkbSXMmJzCPX8kI+gQZQcRn5slawPLdA0A=;
	b=i4HGBaBJKZoYdZHI4gtT2xcAs9MDTQih7xxZ5EyQe4T0vbRqgtMIBKs6FBheULKJ3V
	B6T3J4GI/R9jNbdhuijGQsV/6egGdyo5nSwL1+qr+oZMtwvRchcM8JyI2MqXfoLYNaj+
	XcgFbAEHBDd9IZ1lqPZPbFrsdN48ITn4BDFNHHyC4iwgGE2P2O+qIH3YDUqW8ObeJTiM
	owFwnUoKeE3Akajg9oeA/VMM7nciAdH0QqEw+xau/Yd63G6N7FajO9kK7czvbMnDiFlQ
	6lPLtYxGYPOtLcCQuw4PGjFPn16ng26M/PzZbPQIXoeG9zSSEkQB14B8bSYNBP3JWx5n
	POrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eJiTNkvrYLkbSXMmJzCPX8kI+gQZQcRn5slawPLdA0A=;
	b=cXji7tw+YvnpBfJ3VL8dMJ5pI9OxgrNL/ORYvjnERCoLxdvcgub6btavJ3hjS0gt2h
	rkDPkcc3d0/vmVQSYYgvPLh+cWQC4mP7Z6FBedwijEtslh11PQYRm2nfHpbIVlpTALLL
	/WOt0rfl0jKwYkW8CyR6zzgwtguLhcj6VrDtU5BAx7kOsaYGwsf3T22gMs9pmrL0+B3N
	vM/KARQiJEYw86hYbARPXekWxUbjoAqMlXJv75aDhWwORImuCGaVIHAcUxMzGIUb0dvO
	C+iNMtoou8fdsfwCmaKaYCgc146niZId/KZppchRvBIWyMy3EFeb30TlwiAEujexEZ+j
	3z3Q==
X-Gm-Message-State: APjAAAWi83KdoJr2a/HEyKPjKz9UEwFqHZCPFQWDPcWcZh7UKkvvJNT3
	b2/xPXd2uFUbTsgm8/9RdJ94NtrYeT6iZ067ZKk=
X-Google-Smtp-Source: APXvYqyUeGJiV+CtLiCTqB8DA6oqpFhTh3unm06v2AdpM9lxaV8q0XNse/8h+9QIZC9xJvW1htlMYa2HcoNBawtz4kQ=
X-Received: by 2002:a9d:2aa:: with SMTP id 39mr1171893otl.121.1559569279380;
	Mon, 03 Jun 2019 06:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-5-f4bug@amsat.org>
	<CAL1e-=jfYuh4jLAacFeZcOes5A3PERNLqsE4_hiEci+x0XBTrw@mail.gmail.com>
	<CAL1e-=heGtJj-30YsAVyGKSMULZ5ggVd42+c9caGqN3PBRddag@mail.gmail.com>
	<92d1d73c-c091-9768-a850-69b736c28edc@redhat.com>
In-Reply-To: <92d1d73c-c091-9768-a850-69b736c28edc@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 3 Jun 2019 15:41:08 +0200
Message-ID: <CAL1e-=h_rdCPicD7T3hdJSn0Ea5dzowGLts6P1VNm4FvWU_z5Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >>> This test can be run using:
> >>>
> >>>   $ avocado --show=ssh run -t arch:mips
> > tests/acceptance/linux_ssh_mips_malta.py
> >>>   ssh: Entering interactive session.
> >>>   ssh: # uname -a
> >>>   ssh: Linux debian-mips 3.2.0-4-4kc-malta #1 Debian 3.2.51-1 mips
> > GNU/Linux
> >>>   ssh: # lspci -d 11ab:4620
> >>>   ssh: 00:00.0 Host bridge: Marvell Technology Group Ltd.
> > GT-64120/64120A/64121A System Controller (rev 10)
> >>>   ssh: # cat /sys/bus/i2c/devices/i2c-0/name
> >>>   ssh: SMBus PIIX4 adapter at 1100
> >>>   ssh: # cat /proc/mtd
> >>>   ssh: dev:    size   erasesize  name
> >>>   ssh: mtd0: 00100000 00010000 "YAMON"
> >>>   ssh: mtd1: 002e0000 00010000 "User FS"
> >>>   ssh: mtd2: 00020000 00010000 "Board Config"
> >>>   ssh: # md5sum /dev/mtd2ro
> >>>   ssh: 0dfbe8aa4c20b52e1b8bf3cb6cbdf193  /dev/mtd2ro
> >>>   ssh: # poweroff
>
> Aleksandar, do you think of other commands we should run? What commands
> do you usually try?
>

Philippe, I will leave to you the choice of commands. You know that I
have a very high opinion on this test that you designed and also
implemented, I am more than happy even without any additions. But,
by no means, add something whenever you think it is interesting
and useful.

However, I want to bring to your attention something that could also
be of tremendous importance: Can we try communicating with the
newly booted machine via gdb? And do some simple commands,
like load a binary, set a breakpoint, display register content, etc?

Merci mille fois.

Aleksandar

> I plan to later install more packages in the VM (in particular test
> packages, FPU extensive, device tests and so on).
>
> My rule about device testing is "if the device can be tested in a KVM
> guest, don't test it on TCG guest" for obvious reason of speed.


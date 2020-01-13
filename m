Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E57DC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1891A214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcNra/WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1891A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3wx-0001UP-8M
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ir3wH-0000mc-9B
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ir3wF-0000SP-MI
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:55:45 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ir3wF-0000Qn-Eu
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:55:43 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so10737991wmj.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ioY8W0qYvWStTxsIWopMiXVEBB+aQGN7aJKMG6c73pc=;
 b=QcNra/WCbDFcurGPptkS5waBqOu+GbPKNE/PMeS6eBl6vZfUD3Z62iCitb88E/x0a4
 oA/KJUj8uNBwZI8+MqFJFkeu2KviYSj6C7t5B6z4cy8p5jqq7828cEdZxqnEE1Qid77Y
 91PlT/uG5j8ZC8OghI69xwRMbzWZikJ7hYsjfQadqh3kA2NTmdAchYXLhGdwL9MIumKb
 sUOnkeCaZjuQ+l+vAU2Z8tneMBS87hPnbdVHl0J7mwvn3T2B88ePO0PUeZIKHHsD153z
 9+WhOxrv62AAQVNrfghKJ3wLLenD4E2N3DIZZouXyhr4vQIoHLZSROtTth4PRQgto60y
 B4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ioY8W0qYvWStTxsIWopMiXVEBB+aQGN7aJKMG6c73pc=;
 b=d7lgWkh6iUHQqks0kXoZB41sbMtKUxZa9fqGHfBWZyzYkNVNwqL8eWNiQccQ8pRMrM
 V3Hpc5ZJLCAWEJcVRZorXxrBciPGWqn5gFNXImfXDB0uJDiu+/QdwwgGJ8Hj8UzBwPe0
 eGX85KfKNUsSzS6y3Dm4iai6dxnd2ty49HL7ZzTRqHRiBw3R195wcFDtN/EcuwVjiVs6
 PVKKUDOk77HcIzL7RvoxPXfdhSyIXkqwn/0hHCGMJeTQPoovhWf/q1nQZ7xtLU1DTGj+
 Pq9V+f80GOOmBvuJsnJtp9nAi/DwnqwEh/AuhBauQPg+rfjsre2jKO+MVqbSXLi79WTf
 T5kA==
X-Gm-Message-State: APjAAAVciQprvWpSbd8dvP5yTIdjK8KWyqg6A3WEIDyQ833OlhdcGqnB
 CC9OvEBcEBS6tr0uuh0E2hPT7A==
X-Google-Smtp-Source: APXvYqxpJMwRvZNTqgwXh9zNzlnX02uSetL9AOsbONVBjKCvmrSwlSQ9e2V0XhWDRG8ZvSjDmAUETw==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr22290951wmf.56.1578938141812; 
 Mon, 13 Jan 2020 09:55:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z83sm15642685wmg.2.2020.01.13.09.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 09:55:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA97E1FF87;
 Mon, 13 Jan 2020 17:55:39 +0000 (GMT)
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <003a01d5c6b3$df62afd0$9e280f70$@ru>
 <20200109120038.GD9504@linux.fritz.box>
 <87k15v1z71.fsf@dusky.pond.sub.org> <000f01d5c9f4$cfbc1230$6f343690$@ru>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
In-reply-to: <000f01d5c9f4$cfbc1230$6f343690$@ru>
Date: Mon, 13 Jan 2020 17:55:39 +0000
Message-ID: <87v9pfmeas.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: 'Kevin Wolf' <kwolf@redhat.com>, peter.maydell@linaro.org,
 boost.lists@gmail.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, quintela@redhat.com,
 'Markus Armbruster' <armbru@redhat.com>, qemu-devel@nongnu.org,
 'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, pavel.dovgaluk@ispras.ru,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


(looping the list back in)

Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>=20
>> >> From: Markus Armbruster [mailto:armbru@redhat.com]
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >>
>> >> > Am 09.01.2020 um 07:13 hat Pavel Dovgalyuk geschrieben:
>> >> >> Ping.
>> >> >
>> >> > I think you have my Acked-by for the block-related patches in this
>> >> > series now. If I missed something, please let me know.
>> >>
>> >> Pavel, whom are you nudging to do what?
>> >
>> > I'm not sure.
>> > My prior patches for record/replay were pulled by Paolo.
>> > But reverse debugging is more like a modification of things,
>> > and not a completely new subsystem.
>> > Everything but gdbstub was already acked by the maintainers.
>>=20
>> I'm having a look at the series now. What would help is if we can have
>> some sort of test case to ensure expected behaviour is protected. We
>> have a basic smoke test for record/replay and my gdbstub series:
>>=20
>>   https://github.com/stsquad/qemu/tree/gdbstub/sve-registers-v5
>>=20
>> introduces some infrastructure for testing thing via gdbstub. The main
>> thing needed now is some sort of gdb capability test to ensure the gdb
>> we are using supports whatever extensions it needs to work.
>
> The smoke test may be rather easy:
> 1. Execute qemu record with qcow2 image and rrsnapshot
> 2. Start qemu replay with -S
> 3. Connect gdb to qemu
> 4. stepi
> 5. break $pc
> 6. Save pc to X
> 7. stepi 10
> 8. Save pc to Y
> 9. stepi
> 10. reverse-stepi
> 11. pc should be Y
> 12. reverse-continue
> 13. pc should be X
>
> Is it possible with your infrastructure?

I think so - even if the reverse step instructions are not in the python
API the script can always do:

 gdb.parse_and_eval("command")

The main thing is ensuring probing the gdb for a version/feature first
so we can safely exit and skip the test if the host gdb isn't capable.
For the SVE testing I've had to use my own compiled version of GDB which
is a little ugly:

 ~/lsrc/qemu.git/tests/guest-debug/run-test.py \
   --qemu ./aarch64-linux-user/qemu-aarch64 \
   --qargs "-cpu max" \
   --bin ./tests/tcg/aarch64-linux-user/sve-ioctls \
   --test ~/lsrc/qemu.git/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py \
   --gdb ~/src/tools/binutils-gdb.git/builds/all/install/bin/gdb

We should probably wrap that up into the tests/tcg configure.sh code so
the GDB used can persist with the build. Maybe via:

  ./configure --with-gdb=3D~/src/tools/binutils-gdb.git/builds/all/install/=
bin/gdb

--=20
Alex Benn=C3=A9e


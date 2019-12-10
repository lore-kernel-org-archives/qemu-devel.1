Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61385C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4862073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oys1prl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4862073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecFu-0000UP-Cw
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iecFG-0008TU-PT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iecFF-0000xQ-HG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:55:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iecFF-0000x0-Dn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575971752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tKRQsVllFvscUDR7mF6LhL+Q/LWbfJt6L3z9h+A3i8=;
 b=Oys1prl24bux2+62mpvhR5pzrO9GYpkfKFslNqGPHMYI2YSIyKHSmQZjwspMjB8p90OZOb
 woI00mj6UH1NLyN6TzGgcIJ08pHtcY3yHJvrfJ8xBGZW+mP6wQbLihYIvgyOXnpg6loLHC
 dC4XLMXeksDWwnwTkZe0K40nHnFC0IQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-s3hV-C4sPNiCMhngo2lbIg-1; Tue, 10 Dec 2019 04:55:51 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so8694550wrq.12
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 01:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a81rPjd07mHxVFghcgSd7i1KWVfF9StEsuZqDQi12YI=;
 b=c8DjodyHnXHgtCMo+35+Ob9QZ9LejJt+9VUtXLhDrYGkUfmOdi44wjjY/V6qjFR/kG
 5AnaIALoW8uWLtOUNsaW3HQaQM1xxXeaXowuqmCUKGkQRr89wJDBaq0KUM3UxQt4wKUJ
 S9w2inHNQyIt6MvLe183CxebEzeo7qkaEbMF9pUYfeVIZpkPWwJKv0gLaqSTfwc6r010
 KKO6ej5xwA2uWR7vdM+as0/3JqTy3JH+IBAlsJ7j/a4qIleVAXe+ZUg/jmUUusus7xKP
 2ILlRJyvUDrn7iEe0LwMyYh7T8ZnolJOlzAiOZPR4pbGGicfg2S5M/VL1zUlPqEvV/Zo
 i1Yw==
X-Gm-Message-State: APjAAAUxFq4rT4AUrsptCDi6slM2N2d6bWI0YCGYY/ZkaXIMIMQhQT/c
 Jtdi7m7P4X7QOtHEj4cCNq9BUUsIbjcbSeb4ZumfqA9i9qUjE33ucE17Iby/czU1hWN6Xdl4JmX
 HH2EKFkG0JtSa53c=
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr4259965wmj.58.1575971749909;
 Tue, 10 Dec 2019 01:55:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqye4uaN9Ix//nrF1QB0EBl28wJFN3l4l2y1ju4M+kJWKjzemXN4kKFh7fX/aYYkrK1kff4s9Q==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr4259929wmj.58.1575971749628;
 Tue, 10 Dec 2019 01:55:49 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x18sm2641991wrr.75.2019.12.10.01.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 01:55:49 -0800 (PST)
Subject: Re: BeagleBone support, omap1, omap2, omap3, etc.
To: Esteban Bosse <estebanbosse@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAGbAg_CAh-U-xRh+d6wNLQVWoHXEA0xcW6021Qd4WsMJBGfgOg@mail.gmail.com>
 <CAGbAg_A5G2trFWEuAL2da169v=XFrS44g64F6yZo5phLC+T=PQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a579e1c4-fe3f-d8d0-3064-96473eb24e3a@redhat.com>
Date: Tue, 10 Dec 2019 10:55:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGbAg_A5G2trFWEuAL2da169v=XFrS44g64F6yZo5phLC+T=PQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: s3hV-C4sPNiCMhngo2lbIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Markus Armbruster <armbru@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Esteban,

On 12/3/19 4:24 PM, Esteban Bosse wrote:
> Ping
>=20
> El mi=C3=A9., 6 nov. 2019 16:04, Esteban Bosse <estebanbosse@gmail.com=20
> <mailto:estebanbosse@gmail.com>> escribi=C3=B3:
>=20
>     Hello!
>=20
>     Some months ago I started to work trying to port the Beaglebone
>     support from the old qemu-linaro fork to the new QEMU mainstream.
>=20
>     During my work I found that the Beaglebone have an OMAP3 mpu this
>     mpu has very strong relation with the OMAP2 and OMAP1 in qemu, they
>     implement a lot of functions in common.
>=20
>     Then I understood that the omap1 and omap2 don't implement things
>     like QOM and needs a lot of work to upgrade it, at the same time
>     they are some boards like: omap1_sx, palm, nseries that implement
>     this mpus.
>=20
>     Looking the datasheet of the omap1 I realized that it's an very old
>     device and some questions like "make sense work with this old
>     device?" comes to my mind.

The OMAP3 reuse various components of the OMAP1/2.
Although in old shape, the OMAP1/2 are in the codebase and work.
It make sense to me to start upgrading the OMAP1/2 to new QOM standard,=20
then add the OMAP3 missing parts.

The previous recommendations from Peter are still valid:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg636936.html

Or you can use the schema followed by Niek when adding the Allwinner H3:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg662591.html

That is:

- Add tests using old code (booting Linux, network access in guest)
- Add an empty board
- Plug an empty OMAP SoC into the board, add the PoP LPDRAM
- Add a ARM926 core into the SoC
- Add most of the devices as UnimplementedDevice
- Add the interrupt controller in the SoC
- Add the UART in the SoC
- Add the Timers in the SoC
- Try to boot a Linux kernel (UART, TMR, then IRQ tested)
- Add the SD controller in the SoC
- Plug a drive to the SD in the board
- Try to boot u-boot
- You can now start the OMAP2 using a ARM1136 core
- Add the missing UNIMP devices (loop to previous steps)
- Add network controller
- Run tests (booting Linux, network access in guest)
- Remove old code

>     When I went to the KVM Forum the last week I talked with some of
>     you, and you help my with different ideas and proposal to make this
>     task, but I can't see the right way to make this work because it is
>     a lot of work.
>=20
>     My motivation is learn more about embedded devices, architecture,
>     kernel, etc. and of course contribute to the community.
>=20
>     I would love to hear your opinions about this 3 related devices with
>     they respected boards.
>=20
>     Maybe someone is interested to work with me.
>     I=C2=A0dream to make this work beautiful (like the musca board with t=
he
>     armsse and armv7m modules) with a good variety of tests. And in the
>     same time I would like to write some documentation about the process
>     with the final idea to "make an easier way for new contributors".

Very good idea.

Niek, since you recently did the same, do you mind sharing your=20
experience, tell us what was not clear or hard to understand, so we can=20
have a better idea what part of the documentation/process we should=20
improve first, to help and welcome new contributors?

>=20
>     If someone want to work with me in this task, should know that I
>     don't have to much experience and I'm doing this job in my free time
>     (this means that I work only in my free time).
>=20
>     I appreciate any kind of comment or advice.
>=20
>     Thanks for your time ;)
>     EstebanB
>=20



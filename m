Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E4C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB6220854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB6220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2ty-0000pa-6l
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iK2pB-0002qD-Vp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iK2pA-0006RF-LR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iK2pA-0006Q5-CT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:56 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A2C2C054C52
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 16:03:55 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n18so8671423wro.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t+KQeUdqW/tvtA05BBSixPN/oQRJVkrrlGyoHqPBegk=;
 b=HOB+h5dBEMEuG1+mihrL32uZDyMyjzOnm7BZhfmpkLEqPoosRF0PuFkSggFF3wjMU9
 18ww/HB2t0oRp6DSe8Ht8DOI972oP1wk2wxN/X4aXBf7+9zR3590MYOoGNFFYu5189kl
 n+pZeOtHm0GzmEkruOWpC0HSvFblOzb5yni5QLF8ubrgApOC5VFaI1BJvnRafOs+oQ9/
 cPzP1tcCQyUpfmuJBldzqWnjmb1wON6oUc8JwIuI/sayc21F2Jz/tXQOYcOqdRXIvfh1
 CUGPMRtizZSlvwmbu0pB+l959dWppkxRoyEmoAOsl/bomDM8VWxFWjokvA4wBYe/BiE+
 ILAg==
X-Gm-Message-State: APjAAAUaeKILcFj3lEswHsVQLiZltGzN7Etk1Hz8UbBHRAKGnXlo51dk
 +evmaA9/wfJxA83RmoB3Ypaok1Xm3yCqO4InjcxJnahbn4WQOq4kmm+AJZx4rOgTslnP/Zn1QPH
 YEqBh+XouNTo6jnA=
X-Received: by 2002:a1c:a8c7:: with SMTP id
 r190mr14433024wme.148.1571069034248; 
 Mon, 14 Oct 2019 09:03:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz71N7zYBBJHPCV3WwIoWxQisgx75575NmSICH5ctsPLQj9afiblx8jJeXjGelSnlL/RfMZ7A==
X-Received: by 2002:a1c:a8c7:: with SMTP id
 r190mr14433004wme.148.1571069034066; 
 Mon, 14 Oct 2019 09:03:54 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id u26sm18943457wrd.87.2019.10.14.09.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:03:53 -0700 (PDT)
Subject: Re: [PATCH 06/19] hw/char/bcm2835_aux: Add trace events
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-7-f4bug@amsat.org>
 <CAFEAcA-cbTqYaRr8epJVgUV+tkGgCuf__aM3GxRzbKuqgWfPYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15ddd2c9-3645-23a9-87e2-8e7d5637d290@redhat.com>
Date: Mon, 14 Oct 2019 18:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-cbTqYaRr8epJVgUV+tkGgCuf__aM3GxRzbKuqgWfPYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 5:36 PM, Peter Maydell wrote:
> On Thu, 26 Sep 2019 at 18:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
>>
>> The BCM2835 AUX UART is compatible with the 16650 model, when
>> the registers belong the the 16650 block, use its trace events,
>> else use bcm2835_aux_read/write.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>=20
>> +    if (is_16650(offset)) {
>> +        trace_serial_ioport_read((offset & 0x1f) >> 2, res);
>> +    } else {
>> +        trace_bcm2835_aux_read(offset, res);
>> +    }
>=20
> I'm not really a fan of this. I would expect that if I turn
> on the trace point for reads from the device that I see all
> the reads, not just a subset of them. The device may be
> minimally software-compatible with a 16650, but it isn't actually
> a 16650, and there doesn't seem to be much point in sharing
> the serial_ioport_read() tracepoint.

Yes, I posted a newer series for this device after review comments:
hw/arm/raspi: Split the UART block from the AUX block
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01498.html

I forgot to mention here this patch was obsolete, sorry :/


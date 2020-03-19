Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB5C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F9820663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbaMvBmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F9820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwKq-0001Uo-PH
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEwKG-000165-HX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEwKF-00050Z-0V
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:39:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEwKE-000509-OR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:39:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id f3so3311142wrw.7
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VgH9Z/7DXvwh8l5cEr+T4G3/4Utb1wyWEk9G8ugqHCg=;
 b=pbaMvBmC3YyOb+gGN6iRz0ba700D6nxhXml2DHrve0Yy9gAhtEqfXtMI4FrHyRqLgs
 6VjaKwXBQSy6cWXG1XF0WO34u3VVHCEBu7uhyFr7mmKmvhDU2tc2nvj+0SEQZAWk+7aN
 YMCfYg+CUHGQrnxdAMcl/Lm+GiExzJuN4tKufjQabb9UW9MrwcKBeDgXRMQabk7sUTqn
 EREKkVGEb7II69xXA69kTBOBbEsccpzNXYFPby3GOcDGokRYGwvSP04PUHkJc/+ZgF0D
 TI2A5b5xFQXHRySa5ecuiju4BirqvABSn8O1vfx7ul6lHgOYgenlhppeGCcnIDhpUKW3
 Fmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VgH9Z/7DXvwh8l5cEr+T4G3/4Utb1wyWEk9G8ugqHCg=;
 b=B8bY1fVWK11p6TnxZrnyJBN3gLVDFXqr5uAQ84dNvOwY5pWEpMUe2AbR1CQ1m3oMhb
 JnJarYlD5bu4THr1BVzIqalcf7etQXNh2ar0y8o7z4261VfT/b7SZBMk7R1QZED3YmIw
 W07wkk1CI3dHuBNKVtDIrJalSLumF7RqMHl143XSMAmxGItr4QJmygelIc3lsKkcoGzS
 2jDnZRcVY/T+sW5mIvosHOQuzn+mZAMeQlLNpzL/AU9y6h5LfqXI8zw8pMA9BsFHbGiR
 DIMqwtORuNr5w5g/mE1pTB9ip6JT3EfWt+hI5WwCuLfpBOEPA0B6UtgPa1zAzJsm/00f
 m4Bg==
X-Gm-Message-State: ANhLgQ2Sm8PI6USjn7Ja1IRFOUNXNcJ1OAJVSLobgYVBvJUSDozhW7pK
 qEZmROxVflmeSbTvmI1j6V8BIQ==
X-Google-Smtp-Source: ADFU+vuPdFPbcHTajPqy5c6oxUxdjQLeuP4AW+v1z7RtG4KlDxp0O6adwa6aVOXL2pZbgLuDD6w9cA==
X-Received: by 2002:adf:decc:: with SMTP id i12mr4726556wrn.27.1584628749207; 
 Thu, 19 Mar 2020 07:39:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm2684688wmb.3.2020.03.19.07.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 07:39:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 219F41FF7E;
 Thu, 19 Mar 2020 14:39:07 +0000 (GMT)
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
 <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Subject: Re: Qemu API documentation
In-reply-to: <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
Date: Thu, 19 Mar 2020 14:39:07 +0000
Message-ID: <871rpojto4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:

> Thanks John and Peter for guiding me, but still it will be hard to
> understand from source code for a newbie.
>
> I basically want to implement a trivial device for arm architecture which
> basically contains register for read/write operation with a program.So wh=
at
> are the references?

I would look at hw/misc/unimp.c as a useful template for implementing a
new device. Many boards instantiate the unimp devices for areas of SoC's
that are not yet implemented ;-)=20

>
> I am providing pointers about my device which I am trying to implement:
>  - I am implementing a device which will be attached to *versatilepb*
> board, that board has* ARM926 CPU*.
> - My device name is "*soc*" , whose description is in *qemu/hw/misc/soc.c*
> file attached below.
> - I have written below line to make my device available to qemu in
> *qemu/hw/misc/Makefile.objs*.
>
>> *$ common-obj-$(CONFIG_SOC) +=3D soc.o *
>>
> - I added following lines in *qemu/hw/arm/versatilepb.c* to attach my
> device to board.
>
>>
>> *#define DES_BASEADDR        0x101f5000*
>>
>>
>>
>> *    soc=3Dqdev_create(NULL, "soc");// +    qdev_init_nofail(soc);// +
>> sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// +*
>>
>
> - Run below commands to build my device
>
>> *$ make distclean*
>> *$ make -j8 -C build *
>>
>
> - Run below command to run a bare metal program on device.
>
>> *$ ./qemu-system-arm -M versatilepb -nographic -kernel
>> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf*
>>
>
> -I get following output in terminal shown below
>
>>
>>
>> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
>> -nographic -kernel
>> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
>> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
>> dumped)*
>>
>
> -Here des_demo.elf is our *bare metal program* executable for *arm(926ej-=
s)*
> processor.
>
> So how to resolve below issue to run executable
>
>>
>>
>> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
>> -nographic -kernel
>> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
>> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
>> dumped)*
>>
>
> test.s,test.ld,startup.S,Makefile,des_demo.c are files required for bare
>> metal program
>>
>
> References:
>
> https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-devi=
ce-in-qemu/
>
> Thanks,
> Priyamvad
>
> On Thu, 19 Mar 2020 at 01:19, John Snow <jsnow@redhat.com> wrote:
>
>>
>>
>> On 3/18/20 7:09 AM, Peter Maydell wrote:
>> > On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya
>> > <priyamvad.agnisys@gmail.com> wrote:
>> >>
>> >> Hello developer community,
>> >>
>> >> I am working on implementing a custom device in Qemu, so to implement
>> it I need documentation of functions which are used to emulate a hardware
>> model in Qemu.
>> >>
>> >> What are the references to get it ?
>> >
>> > QEMU has very little documentation of its internals;
>> > the usual practice is to figure things out by
>> > reading the source code. What we do have is in
>> > docs/devel. There are also often documentation comments
>> > for specific functions in the include files where
>> > those functions are declared, which form the API
>> > documentation for them.
>> >
>>
>> ^ Unfortunately true. One thing you can do is try to pick an existing
>> device that's close to yours -- some donor PCI, USB etc device and start
>> using that as a reference.
>>
>> If you can share (broad) details of what device you are trying to
>> implement, we might be able to point you to relevant examples to use as
>> a reference.
>>
>> --js
>>
>>


--=20
Alex Benn=C3=A9e


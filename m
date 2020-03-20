Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A79C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658DD20752
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 08:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZHVs/tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658DD20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDQV-0003ZI-HG
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jFDPv-0003AS-GC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jFDPt-0005uL-TB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:54:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jFDPt-0005pg-C8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 04:54:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so6440434wrd.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fyB1unt4xfL/kEjHUAYtxL9MN6H5RQcX9r9Wyrd56Ck=;
 b=lZHVs/tk9Tr3ac/avnEj71PJ90rPV9DwL0vNgWwJ8fH45uybzL4NlEMY7JDEes1Unv
 UgNuNetMIeGMV1aHBf1Zur75wXU22zei5JA5lsT8nwAOwfBPISKGAVDm5qTAm7QkqNfP
 Fs0x1vISQHEnRaGYkMpBy5MvKqVZG3XKRI7y3Unu7TfcP8JdpNH4fL57EYD6f/t+ZSJM
 F1aL23rj/XhVU5OCuXXUxaMYc1pfP3sBGIsq/N7zDhUm+gzNdlTtPszGIhTNzfLeA84j
 v73OUFXzlbymqxX1XvG6obUuzCsKOKYmvRWWkJVCAkzHFyhdNg7AImJcDPI0ckPuWmJI
 ArIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fyB1unt4xfL/kEjHUAYtxL9MN6H5RQcX9r9Wyrd56Ck=;
 b=SmjGE0gtvZp9TqIVLqK/ZZQEZdWrX/csnyQJ3P4QL9ugJakK1LtX9MG1QjZl+z0ziE
 QHh99aWb2l/KjM+nJ2kX7XoZe0kXYeLy57kMlpx6TBahMQ6gejJb8yzmDZ1GkhsGPByT
 CXR4yXDzGUAjYX3kea3c+NnPhxeo+RklFw5VQlKXm/iDmExuaZReUn9B3J9l5wgTcI2H
 EkNeCEiKFx6QrOLfklEw7fpkaMIuyxGsgCfq6GI9HbY85eDNjGYq0ZX6uJ6eTIg5jAE3
 Uiiy0ZM/rls5QMFrWw+4gkKj/dLq63dieCdydYMBXG3WehTQ3YYByU+pbDQ401i2vcsa
 JBOQ==
X-Gm-Message-State: ANhLgQ08I1tQSY3O9J03Pez5EMAseZp2xQA73Lb1/pMwY6GNj1UNLOPl
 ma9DFDpv0M01SJu9hyFFlqXaLg==
X-Google-Smtp-Source: ADFU+vtQ6sPlKQ7T4g43CtjtHundpgHwwn6HBHcsgvyi21OuizfuhgzAH+/yH+btBKUAsTH8zfD7MA==
X-Received: by 2002:adf:cc86:: with SMTP id p6mr10200642wrj.56.1584694447664; 
 Fri, 20 Mar 2020 01:54:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f22sm8482902wmf.2.2020.03.20.01.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 01:54:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C29541FF7E;
 Fri, 20 Mar 2020 08:54:05 +0000 (GMT)
References: <CAPV47zcqvNekcUN=fKu1-dN=Sip3XR3+ohaG22-oNDm1dceJkQ@mail.gmail.com>
 <CAFEAcA_CeGozr3MUA6N=cMQVXLjoLD0ca-gywm+MLU4unfgwGg@mail.gmail.com>
 <39f82991-6d80-ba42-c7e8-4f6120a196ac@redhat.com>
 <CAPV47zfQKCaKS3BQ4+zbFJ1KyATqgOZvtaY9n-Gh_wtFCn4trQ@mail.gmail.com>
 <871rpojto4.fsf@linaro.org>
 <CAPV47zeQFEUhFmE6jgsehUUQKrYqjtqnfUfBdaKqaEy_e=fM=g@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Subject: Re: Qemu API documentation
In-reply-to: <CAPV47zeQFEUhFmE6jgsehUUQKrYqjtqnfUfBdaKqaEy_e=fM=g@mail.gmail.com>
Date: Fri, 20 Mar 2020 08:54:05 +0000
Message-ID: <87lfnviez6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:

> Thanks Alex, I will check it out.
> Have you look at below issue which I mention in my previous email?

Without seeing the full code changes it's hard to make a determination.
But it looks like you haven't followed the template of defining the
device type.

Also have a look at tests/tcg/*/Makefile.softmmu-target for examples on
how we build executables suitable for loading into system emulation.

>
>
>>>> *>> qemu-system-arm: Unknown device 'soc' for default sysbusAborted
>>>> (core>> dumped)**
>>>>
>>>
>
> On Thu, 19 Mar 2020 at 20:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>>
>> Priyamvad Acharya <priyamvad.agnisys@gmail.com> writes:
>>
>> > Thanks John and Peter for guiding me, but still it will be hard to
>> > understand from source code for a newbie.
>> >
>> > I basically want to implement a trivial device for arm architecture wh=
ich
>> > basically contains register for read/write operation with a program.So
>> what
>> > are the references?
>>
>> I would look at hw/misc/unimp.c as a useful template for implementing a
>> new device. Many boards instantiate the unimp devices for areas of SoC's
>> that are not yet implemented ;-)
>>
>> >
>> > I am providing pointers about my device which I am trying to implement:
>> >  - I am implementing a device which will be attached to *versatilepb*
>> > board, that board has* ARM926 CPU*.
>> > - My device name is "*soc*" , whose description is in
>> *qemu/hw/misc/soc.c*
>> > file attached below.
>> > - I have written below line to make my device available to qemu in
>> > *qemu/hw/misc/Makefile.objs*.
>> >
>> >> *$ common-obj-$(CONFIG_SOC) +=3D soc.o *
>> >>
>> > - I added following lines in *qemu/hw/arm/versatilepb.c* to attach my
>> > device to board.
>> >
>> >>
>> >> *#define DES_BASEADDR        0x101f5000*
>> >>
>> >>
>> >>
>> >> *    soc=3Dqdev_create(NULL, "soc");// +    qdev_init_nofail(soc);// +
>> >> sysbus_mmio_map(SYS_BUS_DEVICE(soc), 0, DES_BASEADDR);// +*
>> >>
>> >
>> > - Run below commands to build my device
>> >
>> >> *$ make distclean*
>> >> *$ make -j8 -C build *
>> >>
>> >
>> > - Run below command to run a bare metal program on device.
>> >
>> >> *$ ./qemu-system-arm -M versatilepb -nographic -kernel
>> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf*
>> >>
>> >
>> > -I get following output in terminal shown below
>> >
>> >>
>> >>
>> >> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
>> >> -nographic -kernel
>> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
>> >> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
>> >> dumped)*
>> >>
>> >
>> > -Here des_demo.elf is our *bare metal program* executable for
>> *arm(926ej-s)*
>> > processor.
>> >
>> > So how to resolve below issue to run executable
>> >
>> >>
>> >>
>> >> *[priyamvad@predator arm-softmmu]$ ./qemu-system-arm -M versatilepb
>> >> -nographic -kernel
>> >> /lhome/priyamvad/debian_qemu_arm32/c_application/DES/des_demo.elf
>> >> qemu-system-arm: Unknown device 'soc' for default sysbusAborted (core
>> >> dumped)*
>> >>
>> >
>> > test.s,test.ld,startup.S,Makefile,des_demo.c are files required for ba=
re
>> >> metal program
>> >>
>> >
>> > References:
>> >
>> >
>> https://devkail.wordpress.com/2014/12/16/emulation-of-des-encryption-dev=
ice-in-qemu/
>> >
>> > Thanks,
>> > Priyamvad
>> >
>> > On Thu, 19 Mar 2020 at 01:19, John Snow <jsnow@redhat.com> wrote:
>> >
>> >>
>> >>
>> >> On 3/18/20 7:09 AM, Peter Maydell wrote:
>> >> > On Wed, 18 Mar 2020 at 09:55, Priyamvad Acharya
>> >> > <priyamvad.agnisys@gmail.com> wrote:
>> >> >>
>> >> >> Hello developer community,
>> >> >>
>> >> >> I am working on implementing a custom device in Qemu, so to implem=
ent
>> >> it I need documentation of functions which are used to emulate a
>> hardware
>> >> model in Qemu.
>> >> >>
>> >> >> What are the references to get it ?
>> >> >
>> >> > QEMU has very little documentation of its internals;
>> >> > the usual practice is to figure things out by
>> >> > reading the source code. What we do have is in
>> >> > docs/devel. There are also often documentation comments
>> >> > for specific functions in the include files where
>> >> > those functions are declared, which form the API
>> >> > documentation for them.
>> >> >
>> >>
>> >> ^ Unfortunately true. One thing you can do is try to pick an existing
>> >> device that's close to yours -- some donor PCI, USB etc device and st=
art
>> >> using that as a reference.
>> >>
>> >> If you can share (broad) details of what device you are trying to
>> >> implement, we might be able to point you to relevant examples to use =
as
>> >> a reference.
>> >>
>> >> --js
>> >>
>> >>
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e


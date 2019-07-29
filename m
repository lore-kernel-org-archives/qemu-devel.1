Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9763F206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9763F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs31o-0007VW-Qj
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 06:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hs31O-000774-60
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hs31M-0005fX-4r
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:36:50 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hs31L-0005f3-UU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:36:48 -0400
Received: by mail-wm1-f49.google.com with SMTP id u25so42625809wmc.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 03:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h/ClytvNZ9mWSbRHJgffsMBulpxNLENdO3IR6xAa7bo=;
 b=MHBV4W3jx5skN46yaflWOiZ3uc7FrOFEIlZk1mGitizLhWdWKQYErHU5MkOvpgPIkf
 /67wGZ1UYmqGvogqp2xwaTdOKWIhD9KWYPyR0nnaz3IgqwmxBU8bv49dXEWE8CMH4qe2
 T5RgeJxIKZaVqldXNgbSxNBxdOLowIsUcLZYgF9qN+GqMWlWYTaU4Uh14vC+xAUBhgR1
 1rlFBGs9lOIm4eI+MMlQU2z0Kv0UgTVsuWWhqPbPc0TnTemadXTQG0ihXZ++RJCJ2M2N
 Cwwo2SNUvpKq3XzrGY6kpTeUpCKYcNdPNEz/VuSEf9v4n6/1j6Z/Mripyryb1BJNKSnS
 kGAA==
X-Gm-Message-State: APjAAAVI/ybyCkMX/m2esiS8B7svcbu+YBTxeqzLlyoQhU+AJqfadbxS
 MxjSQEXi5fgcNVuaHfaY39v8jXF01BI=
X-Google-Smtp-Source: APXvYqy54LnFx5nJxYU4YkEdAbiR/1s12YWnipxCloR6qoFihrog/mNNNQS8LKxS6gSd/vif0yukjA==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr99372631wmi.38.1564396605751; 
 Mon, 29 Jul 2019 03:36:45 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id o3sm49681011wrs.59.2019.07.29.03.36.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 03:36:45 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <ff1c3cea-0de0-1717-44f2-f57b2c30a359@redhat.com>
 <fe175e72-48f3-1a20-f9f0-34fbbadcf4a4@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <516690e2-fe70-0ff5-cf5d-c087dffb2113@redhat.com>
Date: Mon, 29 Jul 2019 12:36:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fe175e72-48f3-1a20-f9f0-34fbbadcf4a4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 7/18/19 8:20 AM, Philippe Mathieu-Daudé wrote:
> On 7/16/19 8:20 PM, Philippe Mathieu-Daudé wrote:
>> Hi Aleksandar,
>>
>> On 7/16/19 7:09 PM, Aleksandar Markovic wrote:
>>> On Tue, Jul 16, 2019 at 1:54 PM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 16/07/2019 13.17, Aleksandar Markovic wrote:
>>>>> Hello, Gerd, Daniel, and others involved.
>>>>>
>>>>> I have multiple reports from end users that say that transition from
>>>>> SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
>>>>> In that light, they don't appreciate removing SDL 1.2 support from
>>>>> QEMU. The most notable example is Ubutnu 16.04, where it looks there
>>>>> is no way of installing SDL 2.0 that does not involve complete OS
>>>>> upgrade, which, for various reasons, many are not willing to do.
>>>>
>>>> What's the problem here? According to
>>>> https://packages.ubuntu.com/xenial/libsdl2-2.0-0 the library should be
>>>> available there.
>>>>
>>>
>>> Yes, we, as developers, are good at upgrading, we like flexibility in
>>> our development systems, and naturally want to try latest and greatest
>>> tools and libraries.
>>>
>>> However, in QA / build / test environments, the things seem to look
>>> different. Their main concern is stability and repeatibility of their
>>> systems. They don't like updates and upgrades. If a new of library
>>> is available for an OS, this does not mean it will be installed, or it
>>> will be desired to be installed.
>>>
>>> It appears that Ubuntu 16.04 came originally with SDL 1.2, and
>>> SDL 2.0 was made available later on.
>>
>> I am a bit confused, I checked the older Xenial image I can find is a
>> pre-release:
>>
>> 16.04.20151218.1-xenial-baseline
>>
[...]
> $ make
> [...]
>   GEN     util/trace.c
>         CHK version_gen.h
>          LEX convert-dtsv0-lexer.lex.c
> make[1]: flex: Command not found
>          BISON dtc-parser.tab.c
> make[1]: bison: Command not found
>          LEX dtc-lexer.lex.c
> make[1]: flex: Command not found
>   AR      libcapstone.a
> ar: creating /tmp/qemu-4.1.0-rc0/capstone/libcapstone.a
> [...]
>   CC      mipsel-softmmu/trace/generated-helpers.o
>   LINK    mipsel-softmmu/qemu-system-mipsel
> [...]
>   CC      mips64el-softmmu/target/mips/cp0_timer.o
>   GEN     trace/generated-helpers.c
>   CC      mips64el-softmmu/trace/control-target.o
>   CC      mips64el-softmmu/trace/generated-helpers.o
>   LINK    mips64el-softmmu/qemu-system-mips64el
> [...]
> 
> $ wget
> https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/generic_nano32r6el_page16k_up.xz
> 
> $ unxz generic_nano32r6el_page16k_up.xz
> 
> $ ./mipsel-softmmu/qemu-system-mipsel -M malta -cpu I7200 -kernel
> generic_nano32r6el_page16k_up -append console=ttyS0 -nographic
> [    0.000000] Linux version 4.15.18 (emubuild@mipscs567) (gcc version
> 6.3.0 (Codescape GNU Tools 2018.04-02 for nanoMIPS Linux)) #1 Wed Jun 27
> 11:13:09 PDT 2018
> [    0.000000] GCRs appear to have been moved (expected them at 0x1fbf8000)!
> [    0.000000] GCRs appear to have been moved (expected them at 0x1fbf8000)!
> [    0.000000] CPU0 revision is: 00010000 (MIPS GENERIC QEMU)
> [    0.000000] MIPS: machine is mti,malta
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 08000000 @ 00000000 (usable)
> [    0.000000] earlycon: ns16550a0 at I/O port 0x3f8 (options '38400n8')
> [...]
> 
> $ make check-tcg
> [...]
>   BUILD   TCG tests for mips-softmmu
>   BUILD   mips guest-tests SKIPPED
>   RUN     TCG tests for mips-softmmu
>   RUN     tests for mips SKIPPED
>   BUILD   TCG tests for mips64-softmmu
>   BUILD   mips64 guest-tests SKIPPED
>   RUN     TCG tests for mips64-softmmu
>   RUN     tests for mips64 SKIPPED
>   BUILD   TCG tests for mips64el-softmmu
>   BUILD   mips64el guest-tests SKIPPED
>   RUN     TCG tests for mips64el-softmmu
>   RUN     tests for mips64el SKIPPED
>   BUILD   TCG tests for mipsel-softmmu
>   BUILD   mipsel guest-tests SKIPPED
>   RUN     TCG tests for mipsel-softmmu
>   RUN     tests for mipsel SKIPPED
> [...]
>   BUILD   x86_64 guest-tests with cc
>   RUN     tests for x86_64
>   TEST    test-mmap (default) on x86_64
>   TEST    sha1 on x86_64
>   TEST    linux-test on x86_64
>   TEST    testthread on x86_64
>   TEST    test-x86_64 on x86_64
>   TEST    test-mmap (4096 byte pages) on x86_64
> [...]
> $
> 
> Ah, cross-target tests are skipped because I don't have Docker for
> cross-building tests.
> 
> Let's see how you use them:
> 
> $ cat tests/tcg/mips/user/ase/msa/README
> The tests in subdirectories of this directory are supposed to be
> compiled for
> mips64el MSA-enabled CPU (I6400, I6500), using an appropriate MIPS
> toolchain.
> For example:
> 
> /opt/img/bin/mips-img-linux-gnu-gcc <source file>                  \
> -EL -static -mabi=64 -march=mips64r6 -mmsa  -o <executable file>
> 
> They are to be executed using QEMU user mode, using command line:
> 
> mips64el-linux-user/qemu-mips64el -cpu I6400 <executable file>
> [...]
> 
> Googling I find this link:
> https://www.mips.com/develop/tools/codescape-mips-sdk/
> 
> The following host platforms are recommended:
>  Windows 10 (64-bit)
>  Linux: Ubuntu 16.04 (64-bit) and CentOS 7 (64-bit)
> 
> Offline Installer
> These are ~ 3Gbyte and include all components in one installer file.
> 
> OMG I'm not sure I want to continue with this...
> 
> Download in progress.
> 
> I already spent 2h on this today, I have to continue other tasks
> meanwhile, I might continue later.

I spent 1 more hour installing the CodeScape MIPS SDK, even trying to
install it in a Docker image to have it handy or use it in some CI.
However I reached the end of the spare time I could spend trying to
help, and nobody from the community is complaining except your customer.

Since 11 days passed and you haven't replied to my extensive testing, I
am assuming you could figure out how to help your customer with the
other answers to this thread.

Regards,

Phil.


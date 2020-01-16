Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B28CC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE4720663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE4720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is3qP-0003Yz-JE
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1is3p9-0002mL-2R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arnd@arndb.de>) id 1is3p5-0001Ff-G6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:00:30 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45485)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arnd@arndb.de>) id 1is3p5-0001Ed-6c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:00:27 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTzjI-1j1NTn0bBa-00R01q for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020
 13:00:25 +0100
Received: by mail-qk1-f170.google.com with SMTP id j9so18847651qkk.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 04:00:24 -0800 (PST)
X-Gm-Message-State: APjAAAWiQ1T5yUID8iW+ifkPqALsXilAXSbmwZWkoqJaAsVZyxY4kOrp
 0qWssEEOcazhHBh2soh+gYOFNab+r/QomJKTjYc=
X-Google-Smtp-Source: APXvYqwZg0b1IQ0r0jJ6sDi00Wg2zWkg4fUmnJ8edidSz/TTQ7xQ7/nLDF2iINrfHZDBmICSL1LtVcUuefRNPoW3xxk=
X-Received: by 2002:a37:a8d4:: with SMTP id
 r203mr27664873qke.394.1579176023627; 
 Thu, 16 Jan 2020 04:00:23 -0800 (PST)
MIME-Version: 1.0
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
 <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
 <cdcce2a3-00f5-f6d1-3083-dc36892ac5b4@vivier.eu>
 <CAL1e-=i3-nYJMo6ptA7fdcK8r6P4vv20x2+LLV6BA9ELO8H53w@mail.gmail.com>
 <CAL1e-=g8X___59zLPKLRjFNAP9bs3rVWhc8+OhMuF3TriBiynw@mail.gmail.com>
In-Reply-To: <CAL1e-=g8X___59zLPKLRjFNAP9bs3rVWhc8+OhMuF3TriBiynw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 16 Jan 2020 13:00:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3o1tM__gP0keo0Dg03tiJQt=5hRGhiXWga4B6gjsVbxA@mail.gmail.com>
Message-ID: <CAK8P3a3o1tM__gP0keo0Dg03tiJQt=5hRGhiXWga4B6gjsVbxA@mail.gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UMSsSX9LgmAzaEMyXzTXSPHlI7rH+IT7HNLLuhLp7jeGZZy0rcv
 GPlImt8kUeAPNQCG+Z4ylf4gF9P9+1J3ozpdwQyounPCLVWbgX3dVwan/FCv97TpUyZFFdE
 N763/cXJPLtDo0Qua3zVHmOb6kehwvLL077EnNms/sl+bnVecNQaLT7kGaIsdrZceJz1zQs
 q5ZuRoQbwzJpa/4OFiRqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2tRi3sy2+lY=:EV7CYfbF4mDh0nxu5SzHAy
 Tb0jIAHa0KYJfrHQ5MoEiJvZzQXiwiUW4g+MDe44ZvGiBxtmbJt31F9GzdYMN2yaCffHGTFjL
 DKf5lJ/xhnHPqCCkB7il3CgFOVQ2KA/OeyEOhzRT4DDRk2vEfYhjHQ2YERfi88JYRbOptq82v
 uLw3LC+JEbJl8e/F+GXjEwAdIpPUmqsw3LvPkSgu5ofNJSJVqZALwZ/Sf9Ne4t4bWt67mPv06
 mal8lihHncsCsl70BhmIi0H1dsnjhEYZP0J6xQ24C57VFakXCsCM58EM1rS0GgZ2OJ0jw6jHL
 qwvFmKVJRBIxiq6frib4xJXoS+MdFAd9ZjfSsogeBNuiI+CrjcHMMZklqblj7Sg2o637/4aJk
 1w8+1DyNVj69zp8eV8jkhKHEpOtslZdkE7vW8dFBgXpQGq2xgxkReToFBBCDUwF5vH3rfSGv9
 v9sYpLPnE78I1whKeJdlxkQNMcmpTH7DJfJXRMn1zpc3/9STR4wYEzXOTaaMO5iqcOn0pobPc
 d5bpcg5pF7Zjzcoi7KfQh9UBdre5wv9/EVJfu+OlR8o1vlZuifyayywhhd+oyVFdOeF6xbzJn
 YTpM9RACj2RqDvb/YVOYgkdh53oupVkuAd0lhgOrh+0WoJS/TX7h3BfSBwkTjeIKFT+Le+L2U
 jixbdssE3vjmlRVislFokVhW6tDHVRCfIhEh0iScXQhj0wxIfsx/gYKSaEHG4ranMzHf/UqW5
 vH32ZQS7Q/G8dGX5IDamNSb9ShuDNjzEEkoSfjSbiMFN6Aa0KDrbi0jDRszkuIdFl6RsXeSsu
 5/ooE9QNQaEKSAvrHGBie1X9WxzLUqZ7QHNJvyO20netpiljHIVlA1UP3N64Sbp6fjp6O1pWt
 PzRDbD0SAEGvE7f1pDzg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: linux-rtc@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 12:27 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> On Thursday, January 16, 2020, Aleksandar Markovic <aleksandar.m.mail@gma=
il.com> wrote:
>> On Wednesday, January 15, 2020, Laurent Vivier <laurent@vivier.eu> wrote=
:
>>> Le 15/01/2020 =C3=A0 20:17, Filip Bozuta a =C3=A9crit :
>>> > On 15.1.20. 17:37, Arnd Bergmann wrote:
>>> >> On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier <laurent@vivier.eu> w=
rote:
>>> >>> Le 15/01/2020 =C3=A0 17:18, Arnd Bergmann a =C3=A9crit :
>>> >>>> On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta
>>> >>>> <Filip.Bozuta@rt-rk.com> wrote:
>>> >>>>> This patch implements functionality of following ioctl:
>>> >>>>>
>>> >>>>> SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read
>>> >>>>>
>>> >>>>>      Sets enhanced time read which is used for reading time with
>>> >>>>> timestamps
>>> >>>>>      and events. The third ioctl's argument is a pointer to an
>>> >>>>> 'int'. Enhanced
>>> >>>>>      reading is set if the third argument is different than 0,
>>> >>>>> otherwise normal
>>> >>>>>      time reading is set.
>>> >>>>>
>>> >>>>> Implementation notes:
>>> >>>>>
>>> >>>>>      Because the implemented ioctl has 'int' as its third argumen=
t,
>>> >>>>> the
>>> >>>>>      implementation was straightforward.
>>> >>>>>
>>> >>>>> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
>>> >>>> I think this one is wrong when you go between 32-bit and 64-bit
>>> >>> kernel uses an "int" and "int" is always 32bit.
>>> >>> The problem is most likely with timespec I think.
>>> >>>
>>> >>>> targets, and it gets worse with the kernel patches that just got
>>> >>>> merged for linux-5.5, which extends the behavior to deal with
>>> >>>> 64-bit time_t on 32-bit architectures.
>>> >>>>
>>> >>>> Please have a look at
>>> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t/log/?h=3D80fe7430c70859
>>> >>>>
>>> >>> Yes, we already had the same kind of problem with SIOCGSTAMP and
>>> >>> SIOCGSTAMPNS.
>>> >>>
>>> >>> Do the kernel patches add new ioctl numbers to differentiate 32bit =
and
>>> >>> 64bit time_t?
>>> >> Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument
>>> >> is a pure 'int' that decides what format you get when you 'read' fro=
m the
>>> >> same file descriptor.
>>> >>
>>> >> For emulating 64-bit on 32-bit kernels, you have to use the new
>>> >> SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on
>>> >> 64-bit kernels, you probably have to return -ENOTTY to
>>> >> SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to
>>> >> emulate the read() behavior.
>>> >> When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,
>>> >> you can translate that into the 64-bit
>>> >> SNDRV_TIMER_IOCTL_TREAD_OLD.
>>> >
>>> > Thank you for bringing this up to my attention. Unfortunately i have
>>> > some duties of academic nature in next month so i won't have much tim=
e
>>> > fix this bug. I will try to fix this as soon as possible.
>>>
>>> Could you at least to try to have a mergeable series before you have to
>>> stop to work on this?
>>>
>>> You can only manage the case before the change reported by Arnd (I will
>>> manage the new case myself later).

>>
>> Sorry for interjecting myself into this discussion, but I just want to l=
et you know about some related practicalities.
>>
>> Filip is a student that is from time to time (usually between two exam s=
easons) an intern in our company, working 4 hours each work day. He spent h=
is internship in different teams in prevous years, and, from around mid-Oct=
ober 2019, was appointed to QEMU team. After some introductory tasks, he wa=
s assigned his main task: linux-user support for RTCs and ALSA timers. This=
 series is the result of his work, and, to my great pleasure, is virtually =
entirely his independant work. I am positive he can complete the series by =
himself, even in the light of additional complexities mentioned in this thr=
ead.
>>
>> However, his exam season just started (Jan. 15th), and lasts till Feb. 1=
5th. Our policy, in general, is not to burden the students during exam seas=
ons, and that is why we can't expect prompt updates from him for the time b=
eing.
>>
>> In view of this, Laurent, please take Filip's status into consideration.=
 As far as mergeability is concerned, my impression is that patches 1-6 and=
 13 are ready for merging, while patches 7-12 would require some additional=
 (netlink-support-like) work, that would unfortunately be possible only aft=
er Feb. 15th.
>>

> Laurent, hi again.
>
> I am not completely familiar with all details of Filip's work, since, as =
I said, he had
> large degree of independance (which was intentional, and is a desired and=
 good
> thing IMHO), but taking a closer look, a question starting lingering: Do =
we need
> special handling od read() even for RTC devices - not only ALSA timer dev=
ices?

Adding Alexandre Belloni and the RTC list to Cc for more expertise. Alexand=
re,
this question is about how qemu-user should emulate the rtc ioctl interface=
 when
running a user binary for a foreign architecture. The ioctl emulation seems=
 fine
to me, but read() from /dev/rtc is probably not.

As I understand it, reading from /dev/rtc is one of the more obscure featur=
es.
This would return either 32 bits or 64 bits of structured data from the ker=
nel,
depending on how much data was requested and whether the kernel runs
as 64 bit. A 32-bit process running on a 64-bit kernel will get the correct
result when it asks for 4 bytes, but probably not when it asks for 8 bytes.
(we could fix this with an explict check for in_compat_syscall() in the ker=
nel
function).

A process running on qemu with the opposite endianess will always get the
wrong result (unless the kernel returns 0), and emulating 64-bit task on
a 32-bit kernel will result in only four bytes to be read, which also likel=
y
results in incorrect behavior.

       Arnd


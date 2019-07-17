Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA917C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4062173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 10:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4062173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngqU-0001il-US
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 06:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hngqK-0001KE-Hs
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hngqJ-0000BF-6C
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:07:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hngqI-00008y-T9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 06:07:23 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N3KgE-1iUtXe0IuA-010IQv; Wed, 17 Jul 2019 12:07:12 +0200
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20190714134028.315-1-laurent@vivier.eu>
 <20190714134028.315-2-laurent@vivier.eu>
 <1F76A574-2A97-4070-8EE0-0EE83A4241E9@physik.fu-berlin.de>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <13f6aa89-e3f3-61e8-fa05-cde20b55daa0@vivier.eu>
Date: Wed, 17 Jul 2019 12:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1F76A574-2A97-4070-8EE0-0EE83A4241E9@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O8Cvytf3g0vZA+dwlWXhprxFtyt/lTjG3BkaS4yMGEZi24HX6/b
 mUaK38Jl8yAv/4XsFyIc4ucmgSD5b2L8UfmP64wdojYYONcNs/WS8ji/0djWAYYs+3OjL+L
 O5cXe16xroVbAQ8do+C4r7gP7pm3YgblgRsiRCDiAKtzJK3gwhvbxWpU7Znb2aKUksgIkbs
 AYEk9ImLtvc1grZdF8Dpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjumI6c0Gjo=:UJina9qYHjOE7aJ7O9VIRl
 aFU7bWu8aZZZG4aUF7FqDJD97BMIJCWWNpVEO2LHyks1R+p1rNhqeC27fVvoBp8aY3f5zhYWm
 aOvEs/7L75xN00ODDxrjtqTO7Wddqn/myJvFiMIxPdHbU0qWPffFUMI2mQZYR572MTG2U5k7u
 xfxkjcmnzWrH/ocnhZD6+wUc6EKSoWs/m9IVo1ukRS8RV4lAGa5apCAH0NkPNIzWKCHzxg1C2
 luXaHuKQ7tKN0tmj5Gh0A+gZcD1L/ajTgAFhjEMYwPf2MlnS8LBd3+lQzW3bonFGrtMeIsR9k
 hTv5Ftm6eju+YdiiLPch6c7ZAHr1v9lZGTbSQzZqWqT0BqUKTp+wQQKw24202WWceb//39vlb
 +lZAw8UCZSPNeAWMM795smYpBb37GJaSS0ZhvipzGbBjLzCPf8yOrMnw1TRdyfBRc8Nl5+21E
 28w4eszwZttFjlfD7OexRWqioG773AdcPpHNMjJBs9WyyVZVXUCqRataTV3TQfDxWhl1Ld6sW
 inyZ+awQCWljLHazUrqDOtldn4jC/MPOtN1xHjqJdj97adsite1KYy34caa6sjRVrwfeIXpkI
 H7UT7jZVZbkflYw9469oLxQcXjdXBDQixSzD1flnNEc0/0Ao0TGRb6gHNbz//E5zWrC4bKb/r
 Bep+oqv+GSwJyPZX82bmYG4eAnNWpyb1UWaLwQc6+/ZboScmhng12zmfKGKM+//lSmWjW/sL3
 V8erBcNpwvr5zC+lbrQzmZ3zD706NqWUx60RJ+TEaePYsbJnRXXVkgj5u4I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: manage binfmt-misc
 preserve-arg[0] flag
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/07/2019 à 18:19, John Paul Adrian Glaubitz a écrit :
> Hi!
> 
>> On Jul 14, 2019, at 3:40 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Add --preserve-arg0 in qemu-binfmt-conf.sh to configure the preserve-arg0
>> flag.
>>
>> Now, if QEMU is started with -0 or QEMU_ARGV0 and an empty parameter
>> argv[0] (the full pathname provided by binfmt-misc) is removed and
>> replaced by argv[1] (the original argv[0] provided by binfmt-misc when
>> 'P'/preserve-arg[0] is set)
>>
>> For instance:
>>
>>  $ sudo QEMU_ARGV0= chroot m68k-chroot sh -c 'echo $0'
>>  sh
>>
>> without this patch:
>>
>>  $ sudo chroot m68k-chroot sh -c 'echo $0'
>>  /usr/bin/sh
> 
> As a regular user of qemu-user (we’re using qemu-user to run Debian’s buildds for m68k and sh4), I would like to add that the idea of having to pass additional environment variables to make qemu behave as expected, i.e. as the real hardware, is sub-optimal.
> 
> I would prefer that enabling the preserve flag with the qemu-binfmt.sh script would make qemu-user behave correctly.

QEMU is not able to detect if it has been started by binfmt_misc with
the preserve-arg[0] enabled or not, so it can't adapt the args analysis
to get the correct list.

> 
> If I understand correctly, the current design with the environment variable was chosen because my preferred approach would break compatibility in certain cases. However, I think that correct emulation is more important than compatibility to an old broken behavior and I would therefore be in favor to make the correct behavior default.
> 
> This will also be necessary when using qemu-user with Debian’s sbuild to “cross”-build packages with qemu-user. This particular bug was actually discovered while building Debian packages for m68k and sh4 using qemu-user.

The problem we have here is we don't know how qemu-user is used in the
wild. In my knowledge you are the most involved user, but you're not the
only one reporting problem via launchpad. Moreover, distros provide
qemu-user statically linked and binfmt configuration files, so we can
guess we have other users.

And I don't like to break existing things...

What I can propose:

1- modify this patch to add a configure option:

   by default qemu will need the QEMU_ARGV0 but we will be able to
define at configure time it always runs with preserve-arg[0] flag
enabled (something like "--enable-preserve-arg0")

[So debian will be able to provide qemu-user-static with this enabled by
default if you're not afraid to break debian users environment]

2- try (again) to push in the kernel the binfmt_misc namespace that
allows to have per chroot basis binfmt configuration

3- once 3 done, enable preserve-arg[0] by default

Thanks,
Laurent


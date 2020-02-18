Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB72C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E220520679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E220520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j44j0-0003yx-4T
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j44fS-0008IM-PF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j44fR-0007IQ-Fi
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:20:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j44fO-0007Gu-Ot; Tue, 18 Feb 2020 10:20:06 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MBBCI-1jAAme2JGI-00CeRF; Tue, 18 Feb 2020 16:19:26 +0100
To: Cornelia Huck <cohuck@redhat.com>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200218152748.63d608af.cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
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
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
Message-ID: <0769c184-dc34-c022-1986-698c6650bac1@vivier.eu>
Date: Tue, 18 Feb 2020 16:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218152748.63d608af.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/CPlkvbGnvKVrvljzHRB9RMuPalXEbEGO6Xt1dAB8DtfjEXmIPb
 kiCyDeq6isTsBhqbN96AnTSo8ric96VAv5oGUFUlqh+3AFzPeFnSaAfCm0jv6/u1xt0w7xc
 WKuIQvALOVYPOogAYSqk3eeFShf3SrLIAbeKMegmEzVsmaMfpD8mSR6UhT4T4Bx6JTgUi28
 QozmqV0b39yTl9b1dshSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WWRYY8Dsjac=:3AWZXhMFMC1oZBYuU6u9t9
 UVCqzx3mOjZQz3WD8swa7yUlLg/nGSru+AAaLsV2NDXV3LUPjZzfLp9BWB0qPyggjv3Uy5BDe
 p88YrR1c72Z5dADeNZ3FcX8dJ5A1T4M50vgJZ+8PvNvsWYQfqPu+iuw4dE+VblvfgJO2cCgtG
 P01fsdbDWENA4/2VaD96VG0eBl0ijeBbc+DbnIHT1k7Q0c06fwMUG0sjraUttJuTa8BE1x16p
 S5fH/2ALouviXGT5Z1CxP3oRtFOV0HXmuiJXFJI3OwFtDI09+5opIiDC6UgJcigylV9jvThUm
 bTCtF6Xxz82w3vwpXCtgbcQFDLZrqYw8EQyLcD0oFXgd637bgwXRMFnlJvPUbYS4BkQIZ+wcE
 JCrkuNubzKoEpFAekjSWbZsRvCy8M1GRQm2VLlvUOGcte/cRv93vLeoryDkpN+PyO9Z0kWocl
 28q7vS/lomWQNdDsamKK3k+XTOzoInxLaNXbEA9ydb1B/WdlWyLV14iwHSAsMtydNWh1bl4Rp
 NGJOCVRrakmldmVDAa8YzphTfJgMYOaxuyQmqMh9Q7DiLOMJraTNuT0vgWEMHsv9dZal2VVxS
 51rfWbWYiRY8bYWKz0nAF2H3rQEaNfpW/lbKcoZIuXj1MpLXqbe+/LqIUA2YNudHVEQAiGr66
 +itrbUaBWPjppRaw7EzhrXeiaLBzR0qwQ+fb8sFpLW9XpEM0KuTSSQTrikWpaZj/3RJd5LK6H
 BYWNYLApsLUVwlPTnBxYwj9qn9SaWIkOEQsLpEp4IRqDjjdnA5/4oHrGefbNu20k11R+vtWZj
 vUI4+814J8rd+fbN8HXIXPG0hVYNEdk9/f2XXprSXKWyEYz8lPguEV/KoJyKpNeSd/aMrJI
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/02/2020 à 15:27, Cornelia Huck a écrit :
> On Mon, 17 Feb 2020 23:35:36 +0100
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> This series copies the files syscall.tbl from linux v5.5 and generates
>> the file syscall_nr.h from them.
>>
>> This is done for all the QEMU targets that have a syscall.tbl
>> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
>> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>>
>> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
>>
>> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
>>
>> It seems there is a bug in QEMU that forces to disable manually arch_prctl
>> with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
>> TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).
>>
>> I have also removed all syscalls in s390x/syscall_nr.h defined for
>> !defined(TARGET_S390X).
>>
>> I have added a script to copy all these files from linux and updated
>> them at the end of the series with their latest version for today.
>>
>> The two last patches manage the special case for mips O32 that needs
>> to know the number of arguments. We find them in strace sources.
> 
> I like the idea of generating those files, but I wonder if that should
> interact with linux-headers updates.
> 
> I plan to do a linux-headers update to 5.6-rc?, and I noticed that this
> will drag in two new syscalls (openat2 and pidfd_getfd). Now, just
> having the new #defines in the headers doesn't do anything, but should
> it be a trigger to update the syscall.tbl files as well? Or does that
> need manual inspection/updating?

I think it's a good idea to update the syscall.tbl when we update
linux-headers, and there will be no change at linux-user level while we
don't implement the syscall translation in syscall.c:do_syscall1().

But I think we should also check manually the difference between new and
old generated syscall_nr.h to be sure there is nothing broken in what we
introduce.

I always run a Linux Test Project testsuite for all architectures with a
debian distro when I do a pull request so I can detect regression.

In the end, updating linux-headers should trigger syscall.tbl update but
it needs manual inspection.

Thanks,
Laurent


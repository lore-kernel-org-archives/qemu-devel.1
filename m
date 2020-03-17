Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814B6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E54820663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E54820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE700-0005uP-GS
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 03:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jE6zI-0005Db-Aj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jE6zH-000101-82
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:50:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jE6zG-0000oe-Us
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:50:07 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MAOVx-1j8NgH0qYV-00Brsp; Tue, 17 Mar 2020 08:49:54 +0100
Subject: Re: [PULL 00/38] Linux user for 5.0 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200316161550.336150-1-laurent@vivier.eu>
 <CAFEAcA8L7S9LmXKr5mb5XmMiqUy_M4hCSL2jzxovoFNQdpHeeA@mail.gmail.com>
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
Message-ID: <d317fc9a-a0c0-fb64-34f8-d4c78813cf39@vivier.eu>
Date: Tue, 17 Mar 2020 08:49:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8L7S9LmXKr5mb5XmMiqUy_M4hCSL2jzxovoFNQdpHeeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+oncVA1UNzp0by5ezLA6uLMNOQ2FVZEMVkW4nNlXBhM4FfujjOF
 G6yAG4Rhc4nMt+twD2rcqeXmDkeN76JroH9lHORYqR7KCqnSaHkTwkjf4se2FND29QAU5wR
 lGFZGPWlcJsmty0FFPrUcDHN9A2FDmPM8Qy4fMmw2v1aVA3D9Z9KDSxLlxwxVRudKQMX+8Y
 KgOMKzPpkzPIKjv7zbBKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y9rI8wcvLaE=:6W27T6e1+c/fgGv6GsW7Nb
 Vu//ZypgpTkWO9elmezofKTpdeacn4qs02eA2EGFsWcmd9ZeP+4KTdKzeikju/K4LF8zlkku2
 wXiY1Y/aDBBWmNyrHPc6lPOS5Wmbcz+IeAXm5hh5B8E74yYq/zLTuFpbCSqUX5w888lK4sTOA
 dobkGMESAgZNczI8kovBho4TicM81AQnTdaybk2qhoov6W5sgA7+8+QbyVKqsw0CA7Vp6dBUg
 wMRpBwarCVVVyz1VRcTof9q6uFJk5ZXc6nG/c58Y7ngNgwLdeonHJ2btG29ajqgW6P8AIfIZ5
 7CyQ95RAI386Wd8T8j0f2O9mH8wpUF2wC+ifDDjSplfOCkTqPZ8D7uQuMbAoGmM7i0LvpD7Ys
 LibOy5+2SZx+Uhu5djiRDwR6r1nwYXIOOvtlF1XKimWyfSBlRgK55R/5e0GIsw6+g43YF0aaz
 fZYyqG1dC8qSvrvO0Alpcfx15MpapfHDCmK6BOUenp4Sb8Hy8FKO1K2pZcIFcyPwPBwfvf+kH
 PJmU4teRhykP56kvlkIPOg1raSwJSNBtORD5LitjS1cYA5br6h6ozJQF6aV2BIV/BD6e3CxAV
 D5Ds0f0pkNGr8a88VDDH+VNuPTQqlCPmnImNjMVK2BKypyqHqBXKkLAd+b/82M+J0xcYJRsLr
 8WD60yBsnUl7ZRoQhh+h4CtA3m1J1tONekUsX2ZuxgmSizNpM15j8x4qZdkL9HZmAiu+XniK2
 6NJaOFe23TMaNQtRD50G/FI0+7BEs5rGkopygMD2Pop3l25VWuGxnXSJ5oiU/RwmHGQUE1170
 bd2d0rJpTC8VQ2A1YSXxeB40yh8VfVzcBOk3GKujTegCthB2vPl4rufpme0VIhnTzVoKlHe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/03/2020 à 20:17, Peter Maydell a écrit :
> On Mon, 16 Mar 2020 at 17:43, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>>
>>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>>
>> for you to fetch changes up to 63e05b3db1e5f0560ae579050c53d1ee36ed5aca:
>>
>>   linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-16 14:20:07 +0100)
>>
>> ----------------------------------------------------------------
>> update syscall numbers to linux 5.5 (with scripts)
>> add futex_time64/clock_gettime64/clock_settime64
>> add AT_EXECFN
>> Emulate x86_64 vsyscalls
> 
> Compile failure, aarch32:
> 
> /home/peter.maydell/qemu/linux-user/syscall.c: In function 'do_sys_futex':
> /home/peter.maydell/qemu/linux-user/syscall.c:6946:16: error: implicit
> declaration of function 'sys_futex_time64'; did you mean
> 'safe_futex_time64'? [-Werror=implicit-function-declaration]
>          return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val3);
>                 ^~~~~~~~~~~~~~~~
>                 safe_futex_time64
> 
> 
> Compile failure, x86-64 with clang:
> 
> /home/petmay01/linaro/qemu-for-merges/linux-user/syscall.c:1291:24:
> error: unused function 'copy_to_user_timezone'
> [-Werror,-Wunused-function]
> static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
>                        ^
> 1 error generated.
> /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> 'linux-user/syscall.o' failed

Thank you.

I remove it from the list and re-send the pull request.

Laurent


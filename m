Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AEAC11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973E724672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973E724672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4qE2-0007CJ-Pm
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 13:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4qD9-0006GO-TJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4qD8-0001Bw-PD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:06:07 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53559)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4qD8-0001AE-GT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:06:06 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mt7Pt-1jKIj34ARt-00tT7g; Thu, 20 Feb 2020 19:06:01 +0100
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Changbin Du <changbin.du@gmail.com>, alex.bennee@linaro.org
References: <20200220155834.21905-1-changbin.du@gmail.com>
 <269f16b4-e843-1058-4c3b-f11de45b04e1@redhat.com>
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
Message-ID: <2f66143c-daa8-2f1d-0593-424791d81fd0@vivier.eu>
Date: Thu, 20 Feb 2020 19:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <269f16b4-e843-1058-4c3b-f11de45b04e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sfX0ginopF8569+98yRPErwhd/Q1TNai2TcoCQ1JzvV9dzyDLrI
 ZVLL8fjBRENbLTlofosa7AUe5uwjdBQynjaF3CKyVlgOueL/7ySPib9nTgVShV0LT9HQ8sP
 /6BeVMNeIG98F7A/I3bGqegEDvT6SMyR1vzMsp+nXCqjxu1apmoQltCRFB0gGTP7Kq8i6Fh
 i+mn8Z1LNTGyig2lRxUJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ii980DYwSjo=:0zcxhYBzI6UXf149d+ifDQ
 eyNBHbGZXjnONaaUKOvFs+TCKzrzuZ8BdJbiFlwnm4QdvShZeY9NDnGquMTItmLzUA5MTdN6G
 fGlIh+5hCXZcjsmvALs5fZrguPc15Abbh9/x86EwrHKRp0bQJ/x8FkswuoM5juAKQsqmh81tQ
 Tao+MBGB+r8rlUK8oib/LWmUbK14NqP04c83VbZUNb8yd9XUp5gtCpicVdB5c8yEBut7wda9G
 rqOcRSp2ykXxBFDeqQgzCCPYffxSqFnQGviP4QSUxXej+kau8IrsgbBSdK7yd9FKPuQWEuY+P
 N7o2hGkolM2MrRaOBMFN8YgISUMdlMmJ8joErOgUweP8HI9pxMseyHF9j0TV6wAgzFaoyKwOo
 mWufs4LPIwDBuMIopieP2BhkpxQLfZUPysVRMXe5UPW64BhRSwThXSJp68emtsCrbYtgluICf
 BvsG7VR7X4waAoqWup9N+1cQ/8SM7LWoPAk5sh/2Gl/yEi0sgcT/LwHq4So0TlkkON3HJ1JvQ
 AKAFs+fMBjF4L5gLAvmJpT5iF8fZwHZLvmcVwFuGhvVYBP5avGuobQCBHWqPeI3+N89IfPqzO
 J5yRa6lFfnF7rBNlbbL/0OiO5kX4cQzYRJJvWsEY1X0FI0P/1pIg9jYG85rSKMjxHEjqHqKzB
 1zv9rMunBpN/IWCnM1kS7RHJZlENIX8C4p/LL3awM+t33CBepwFiwdbL7SguksVoUZiKc6YbH
 6UpeEWWfCM+FWjvNS6wKyKue8gm2xKrGdW9dfNzadozzTrgVf8U3PN7HQWROB5K0y8WdrrolM
 q7mAhNVVt+8GDb8z7iJzd7BqEn+yvM2OUG+vSJtmZ0h6uMXNWWB7Q//5qTNS83A1dlEeAf6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/02/2020 à 18:47, Philippe Mathieu-Daudé a écrit :
> On 2/20/20 4:58 PM, Changbin Du wrote:
>> Recently when debugging an arm32 system on qemu, I found sometimes the
>> single-step command (stepi) is not working. This can be reproduced by
>> below steps:
>>   1) start qemu-system-arm -s -S .. and wait for gdb connection.
>>   2) start gdb and connect to qemu. In my case, gdb gets a wrong value
>>      (0x60) for PC.
>>   3) After connected, type 'stepi' and expect it will stop at next ins.
>>
>> But, it has never stopped. This because:
>>   1) We doesn't report ‘vContSupported’ feature to gdb explicitly and gdb
>>      think we do not support it. In this case, gdb use a software
>> breakpoint
>>      to emulate single-step.
>>   2) Since gdb gets a wrong initial value of PC, then gdb inserts a
>>      breakpoint to wrong place (PC+4).
>>
>> Since we do support ‘vContSupported’ query command, so let's tell gdb
>> that
>> we support it.
>>
>> Before this change, gdb send below 'Z0' packet to implement single-step:
>> gdb_handle_packet: Z0,4,4
>>
>> After this change, gdb send "vCont;s.." which is expected:
>> gdb_handle_packet: vCont?
>> put_packet: vCont;c;C;s;S
>> gdb_handle_packet: vCont;s:p1.1;c:p1.-1
> 
> You actually fixed this for all architectures :)
> 
> This has been annoying me on MIPS since more than a year...

The problem started with an update of QEMU or of GDB?

At one point it seemed to work, so what happened?

Thanks,
Laurent


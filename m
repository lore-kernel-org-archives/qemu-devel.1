Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB71C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCA82184C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCA82184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOHI-0006fT-Cs
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiNAO-0003zT-96
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiNAE-0007UK-H6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:06:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36421)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hiN9u-00078v-EH; Tue, 02 Jul 2019 14:05:38 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mtf7H-1iXAI50ERD-00v8L7; Tue, 02 Jul 2019 20:05:34 +0200
To: qemu-devel@nongnu.org
References: <156208710846.15457.11521609447031896814@c4a48874b076>
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
Message-ID: <3321812b-d7c9-d69d-a0af-8bb1da04e057@vivier.eu>
Date: Tue, 2 Jul 2019 20:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156208710846.15457.11521609447031896814@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6hPyhxHpDe3uVi9saubplJwE+B77tnqh1RB32iKIWGTuZMYpYY4
 U2gqaEsZYA4TAE5RdjguxcLsogysNHHt4hl6f9r7rE3VKpczkTf8FHDIEsDz5/T5shDKAuE
 m8TRXYCdEeBPJxHwMcXtUjcF75xhehjdr3WQTatIY1+ev/fUQTsNVwB34fn+YFFxYRIGsGS
 nXe/C2NLexyPNA/3ZzPRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:un12Chd4SJ8=:ZitwnzxVXyTLIqN33xINoC
 deh/nTEqZ/9pSFh16i5czmYe3Zj+TrRuwXWVpmRxKrUmRWlzpZhyxR26xwOlP+hVtbOJlV3Ah
 M475edqMc0peqjaAItPqN1lRH/Bgy7NQxXXgWwWjBea5yyi/Q8QQ3ooePkGggvJ03ezvwxEtu
 MEN7BOj9poeoBcyaeiQFOp6+vQdDqhbSWYVVoWKskQX/K6QhNxMIp5aKDZYxGO8qASrmWTuw1
 RRGwt6sq7+SZgRDQj6/mVjSnO84ENhEy2wiL+BPPKoKp6u5WBah6gqiPUblrX8nHb2y7DF+sc
 BBg2JmfCnXVXBML+yZziZTwoRVYiIL2h+tx+X1YnTmgB8IyGWavJ7AYxOlRehvcpjHj/AuOLv
 pCIF7a+sLgwvo9UWa6FFx0m18hj44wfncRiIbJbqaDfhPmaYp7WEqQApx1NgCjJr9vSo5CMY0
 uJR/hRseEGZaMP6bWW01rS7SGaTkKgwZ6p81uYRecG2VgHeewktUfMtuln1HU/8Wu1PCbSGXN
 b5p+7DNyN4zujf5UDj9PWsGz+22YgJGeaTw41BvaMSw1zhBHRM/9ruvnZKVRr0DMExBPy+sRx
 oiZ9EGwO2TJAmsPgq3u/icEzpcX0keP4wLQ7popvZBTyW+oNc6zfBCHLBvTc7NRDFc1UAbr0d
 5SXoQ6UIbWtP73qzVpq24yGbxNlK5cubu0FWXCcMwziL7KgLRepNc//VkTTA/gDXqd0gft6y1
 rN8iTA47aUD435svycfQc9pbFvV5sYbOoLYO9vakcQIfXmdN+5X3vb5y7QI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/07/2019 à 19:05, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/20190702123713.14396-1-laurent@vivier.eu/
...
> PASS 2 qmp-test /x86_64/qmp/oob
> PASS 3 qmp-test /x86_64/qmp/preconfig
> PASS 4 qmp-test /x86_64/qmp/missing-any-arg
> ---
> PASS 5 device-introspect-test /x86_64/device/introspect/abstract-interfaces
> 
> =================================================================
> ==10595==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x55b80fde5b1e in calloc (/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64+0x19f4b1e)

I don't see how this series can introduce a memory leak... all changes
are trivial and there is no memory allocation added.

So I guess it's a false positive. Any idea?

Thanks,
Laurent

> ---
> 
> SUMMARY: AddressSanitizer: 64 byte(s) leaked in 2 allocation(s).
> /tmp/qemu-test/src/tests/libqtest.c:137: kill_qemu() tried to terminate QEMU process but encountered exit status 1
> ERROR - too few tests run (expected 6, got 5)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:894: check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
> 
> 
> The full log is available at
> http://patchew.org/logs/20190702123713.14396-1-laurent@vivier.eu/testing.asan/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 



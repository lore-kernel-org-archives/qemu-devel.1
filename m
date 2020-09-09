Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D593AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B72206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B72206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0bJ-0001je-1n
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kG0ac-00010J-Nm; Wed, 09 Sep 2020 09:56:46 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kG0aa-0000LA-2q; Wed, 09 Sep 2020 09:56:46 -0400
Received: from [192.168.100.1] ([82.252.148.206]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MjjSt-1kwW4y1K9r-00lGba; Wed, 09 Sep 2020 15:56:31 +0200
Subject: Re: [PATCH v5 2/2] hw: hyperv: vmbus: Fix 32bit compilation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200715084326.678715-1-arilou@gmail.com>
 <20200715084326.678715-3-arilou@gmail.com>
 <87028ae2-f31e-a6ee-a4ba-c147837fc52d@amsat.org>
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
Message-ID: <fb8f1744-4c28-4171-2ffb-61d3ad39be88@vivier.eu>
Date: Wed, 9 Sep 2020 15:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87028ae2-f31e-a6ee-a4ba-c147837fc52d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9hfcNGCiuqVLR+Vz1zSgEILpVA71l5CRtNKbh7x8htpH9UrrxhP
 wre3eEc2EXYSjq4/z+lS3eU0a+Jm+mNjF9lT3Gkrlnxhi8E83p/Q5z1E9NnatUkqehKgqoK
 hwnPXXmIjJeZNebiSyTqsxRFeDL81En2JOIXVA2JiG+X/7f/iV4HkEP/qu7ztYLl1Hou2YG
 +rakC6Y5HpcyJ5T4WgDYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:up7XA78dkvs=:ZhSv6r9g4AsjgnXoskRri2
 APeXmna1ZdWlFom3Ql7iTTh9ZpgxwxwZnSmj+MVLchJFBghahAURKw3wH33m9uJ6J6SqqsyfF
 OWXTRqq1vjZxyfb6q+JEqHicfqWxd1zG8KFalgn0zWoXqmGtigo4xDCKWO6EhVQLoFS/ouG10
 9KqHYVn5HcCjGfBxuMWZSDE3r/R21nAtWdgk7OaVXoDK/ON1jXRSKi0FWH8UYhDd2Xagt8hvJ
 Eku9O5I5RHIefEpw3+KC0unhniJ0kBjuwx9uk0VJF/GJvTlvt/N5WkLON2xKPt1+qWgY+UmGp
 nuzMXCDm3x9FXjww6IeU/EAkmrqqrdaw4Qh1IrvcPdhpSCq5e6z7aNNIt7b/kGX3OWNjv6T3h
 g5FGqdd03sMXXNIeV6C7Ts1mVxjonYIPKtl3FbzKDJZnLs4jI6uP3mjhXQcANSHuOVLdG8JZ4
 C0h7JeHm4Vivewix+fFrRGP011v3lSrFb1Qi4cD2WZiuUl1mNj5Wz6G/SoQbtQvVFt015QpVN
 fsGfnk7JQLq54c2qDl9gabLlKVzgOUWIbQ0MFFmCxoFrBljrfMDrD5yLH/U6nlfiKFuqo8fA5
 vsi+7FP6f/ojFSVz93oiXQYFSdDUl3PjHBMeDfh6LegOQ3yoEyybnGFgIX8XHkD4gvI6BLdfO
 F1CW095zq9o7ZGOUlNhaa0n+/jvvTzhJGQNG4nn8CEde9avpCAKze/lrCAPrfDNr5lXknriKF
 F4jI7MHot4CWN7nKdf0e6ZQIK/1Vh60YJxsM7U5LKo+ZGMO2UBaXRVuXkVkhX714EyElQ+W/S
 GTM+Z3z/lE4MTb7eDWgYULYcoaGNslm2NeMTxYhEjVOLL5G/AETwJFnrhtK3x7KWvcRjvJn
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 09:56:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mail@maciej.szmigiero.name, QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, rvkagan@yandex-team.ru,
 pbonzini@redhat.com, imammedo@redhat.com, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/09/2020 à 12:14, Philippe Mathieu-Daudé a écrit :
> Cc'ing qemu-trivial@
> 
> Can we add the commit description Richard wrote?

I have no message from Richard regarding this patch.

Thanks,
Laurent
> 
> ---
> Fix 32-bit build error for vmbus:
> 
>   hw/hyperv/vmbus.c: In function ‘gpadl_iter_io’:
>   hw/hyperv/vmbus.c:383:13: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>   383 |         p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
> off_in_page);
>       |             ^
>   cc1: all warnings being treated as errors
> 
> Fixes: 0d71f7082d7 ("vmbus: vmbus implementation")
> ---
> 
> On 7/15/20 10:43 AM, Jon Doron wrote:
>> Signed-off-by: Jon Doron <arilou@gmail.com>
>> ---
>>  hw/hyperv/vmbus.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
>> index 34392e892a..c28bb4201b 100644
>> --- a/hw/hyperv/vmbus.c
>> +++ b/hw/hyperv/vmbus.c
>> @@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>              }
>>          }
>>  
>> -        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
>> +        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
>> +                off_in_page);
>>          if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
>>              memcpy(p, buf, cplen);
>>          } else {
>>
> 
> 



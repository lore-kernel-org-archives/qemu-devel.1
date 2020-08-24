Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1196A206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1196A206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIsq-0000R8-9i
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAIsA-00085l-Lr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:15:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:32793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAIs8-0005GU-Os
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:15:18 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MORN0-1jyn4547I6-00Pxm1; Mon, 24 Aug 2020 22:15:12 +0200
Subject: Re: [PATCH v3 1/2] linux-user: Fix 'mq_timedsend()' and
 'mq_timedreceive()'
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
 <20200824193752.67950-2-Filip.Bozuta@syrmia.com>
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
Message-ID: <ebfec51a-0ab6-a8f3-07b1-ceeffccffa33@vivier.eu>
Date: Mon, 24 Aug 2020 22:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824193752.67950-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HBQ8FD6eGQMlma0UxfNnflwegfYzNnNU2GPeYfZypTV/+LB+R/h
 Q5Bpv9vB8DzyUPOcUK3y2Z/zxuJweN+kuk4akXlZX7jgWMdQQRIbeeVxi8CSuP0pQ+WzDI5
 58Hl4zvj3rtd7j8+/40RMKYuNVbf0q5Jz4ZvFIoEnU5IonazmeSYy+e36aSedB988NpdC1q
 2I3tM5CypflVfyTwEDlHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/4QApNn+NX0=:HBL91tX2dHBo9356g9bgPe
 84nBLMp/HfUtjz0K3S6L3BZyTMbmfG5cO3+4iFqnbg2IjE+M4HFIp529PyIS5fDv26Evnh7E0
 9Kpsl1FTTOAOF5HLgvSXjdAbyqO1AIHP9BS7PnTFClf8642cqchq22zgvrJ+9ipJ3lUysyZ3d
 Phx5tmVwHzh6LhIRsDy7p9EM0k4DzxX3SEO/Rqk8wlRMun24/2puY3JvIXnbdj5WqSXk3dwo0
 ZpmVt5cWc4hPB4rAhRo87DSU/8iZzaUoB922Fq7IXit5STiuVsf1AYNtJfSl2X1G+2leV1BJ5
 QSmLEGjdNYuZfY4NPhWlUVLi7KBdACCA5XAQ83EK/1ZoIfdtVmqRdVnS8KQaZMg2/s5xHYxvq
 Z2z52pfdG+xeVouEJFNLYBrHQ3ohCm+iW5LtkdaPOx8LWQzMn8WLxhCqP0S/SqwBDIJqwQXNi
 6ph+lrrTgB/6oHLBP6zyB7rYsK9Y57CGRFCV3W4Mk/mhskqbn73+mVmHnUcE0voQ1TyWmRBfY
 dld24ChREt9qhanPiFWDzm+gD3xX+WUaI9xikQnfrQxAC5EM9H3a/mwDt6aknqxuvbzzEtwYn
 binRztnGfC4nMWhIC3tLarQXs//yJaSAagf+KBMi4rWBcZE2wHNRH2HeXkwES1vhdYX6JhDUZ
 RItayr6zLfNm783RVfx+jeVU63o/NfpYjVi+YtNSwJnl0PZaB0ifES3RfV8Rh2ZTigRIPC9RE
 f51ZLTLoHxbFo9rZ2MDMfhmVO4ep9kQj5222dI6iVa4883JoRrpKaQJEzzuy1BkvrDVvOoWo9
 McMaKyOjK/WwGqelS2hd0wkDYAbgIQUtLy0lc5kAW+KjVyOZwxk8WGUasaJxkyIYrds+6jb
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:35:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/08/2020 à 21:37, Filip Bozuta a écrit :
> Implementations of syscalls 'mq_timedsend()' and 'mq_timedreceive()'
> in 'syscall.c' use functions 'target_to_host_timespec()' and
> 'host_to_target_timespec()' to transfer the value of 'struct timespec'
> between target and host. However, the implementations don't check whether
> this conversion succeeds and thus can cause an unaproppriate error instead
> of the 'EFAULT (Bad address)' which is supposed to be set if the conversion
> from target to host fails. This was confirmed with the modified LTP
> test suite where test cases with a bad adress for 'timespec' were
> added. This modified test suite can be found at:
> https://github.com/bozutaf/ltp
> 
> Without the changes from this patch the bad adress testcase for 'mq_timedsend()'
> succeds unexpectedly, while the test returns errno 'ETIMEOUT' for
> 'mq_timedreceive()':
> 
> mq_timedsend01.c:190: FAIL: mq_timedsend() returned 0, expected -1: SUCCESS (0)
> mq_timedreceive01.c:178: FAIL: mq_timedreceive() failed unexpectedly,
> expected EFAULT: ETIMEDOUT (110)
> 
> After the changes from this patch, testcases for both syscalls fail with EFAULT
> as expected, which is the same test result that is received with native execution:
> 
> mq_timedsend01.c:187: PASS: mq_timedsend() failed expectedly: EFAULT (14)
> mq_timedreceive01.c:180: PASS: mq_timedreceive() failed expectedly: EFAULT (14)
> 
> (Patch with this new test case will be sent to LTP mailing list soon)
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..4ee1de6e65 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11817,9 +11817,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              p = lock_user (VERIFY_READ, arg2, arg3, 1);
>              if (arg5 != 0) {
> -                target_to_host_timespec(&ts, arg5);
> +                if (target_to_host_timespec(&ts, arg5)) {
> +                    return -TARGET_EFAULT;
> +                }
>                  ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
> -                host_to_target_timespec(arg5, &ts);
> +                if (!is_error(ret) && host_to_target_timespec(arg5, &ts)) {
> +                    return -TARGET_EFAULT;
> +                }
>              } else {
>                  ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
>              }
> @@ -11836,10 +11840,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              p = lock_user (VERIFY_READ, arg2, arg3, 1);
>              if (arg5 != 0) {
> -                target_to_host_timespec(&ts, arg5);
> +                if (target_to_host_timespec(&ts, arg5)) {
> +                    return -TARGET_EFAULT;
> +                }
>                  ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
>                                                       &prio, &ts));
> -                host_to_target_timespec(arg5, &ts);
> +                if (!is_error(ret) && host_to_target_timespec(arg5, &ts)) {
> +                    return -TARGET_EFAULT;
> +                }
>              } else {
>                  ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
>                                                       &prio, NULL));
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


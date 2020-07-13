Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F13C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A034220663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A034220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv41s-0005G9-To
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv418-0004LX-Ub
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:21:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv417-0006Uh-0a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:21:34 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHWvH-1k8UGf2S3N-00DbIz; Mon, 13 Jul 2020 21:21:20 +0200
Subject: Re: [PATCH v3 1/2] linux-user: refactor ipc syscall
From: Laurent Vivier <laurent@vivier.eu>
To: Matus Kysel <mkysel@tachyum.com>, riku.voipio@iki.fi, qemu-devel@nongnu.org
References: <20200626124612.58593-1-mkysel@tachyum.com>
 <20200626124612.58593-2-mkysel@tachyum.com>
 <b45a9fe1-ba32-8792-67e4-aececeee7227@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <de129f21-114e-2dd4-6ca6-89ce53e0c138@vivier.eu>
Date: Mon, 13 Jul 2020 21:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b45a9fe1-ba32-8792-67e4-aececeee7227@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rFIJsNHgkugRQJLP6YChm8hUgGkQ9Ovs7nH5o7Ga2iooT1XPyub
 bzI3tKQsbfqRQgKTJCqTjT1OpO1xr2z7VS+Z7SX9MGnnby+gnmNNdYwGi6Ls++EnbGLzxSk
 618TmK0glbqP4XQCCjyqnKpzalYf8xpaPypWEoqXTZLbhvF97FvvGsW55XDu6u6yNbRBAbn
 R/u9r0PQbzEOE5qtE8U2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezLIlKruMOU=:OrNAO1zi4V1bWX08CSfAXx
 K5T6YJrniG/FW1tazE53yYzQ7GcpNJqXjXQoOjZF57f5AaTCuavEOqEzoN+45WFMDlGXCBfoE
 hnVXhOi9YSQ3n0BhQyb5ci5YU8BnQynR5Y+33IYvPHuOwvToO7TMvTBriMo85erAbEwzgI1LU
 JspwwI8VyjOw0icKytnZfr7Rpmf3j7SbC8xllu7TcEXgfmfc54eKWSHri6vuiPqcKIwMDA6uh
 c4hJqpKHWpuq14NLejaM8dRsAO0DBPxs1HMZQYC2AmtYGhIaDYaAUzAJjEx2W2n/Og/b7XzL1
 0QwyBfSatVMaan9278cd+pvj5VfQvbLjQZS7YbeN3GJp5gGkxAaZyJvdDpxMVL0ozOLRduZZP
 f84qlajAyzts5/jknavFemKScwOsg4lrR483KwI6eGgDeTBVjxv1vVYHX50WZcEBwS/CHtmpK
 97R/wMQNwtz3sNwwsrz+Jypl39nh6uJneUPzOTaQhmNCbzWgJklABpTnPHtN5lz4QyNXKywb0
 jHWfY1U3E7Iu8Z6pWTNNCjnFOkLOL/VE/D3HPu1cr7RUbBe/KndbGnhdpZYc8EbhbVx6y1YEn
 uXqg4mpsYFnW49XlQYJsUKrUgZdK5JuUUFIR0bMSFdgb0ugI445sigkMPjIEfI2dLwCiWDbhu
 S7uKqortvGSYh6rbzqSZMhzx8bG6EoAf7JB4zkvQHFtyB22KYf/kFvECpH3lMPjSUx51VPcA9
 glPLRTFiYGK/gis1shx7kZnHCyZK+aB8EVpY1/8/vMsXh14QaWR0Kdl+g5DdM4goGvjMh2XsP
 WJBFrq9Zl4gVcL333G33YP04foL7DVhhbeRPJ7fl/ca/DTsD+SiMNiT3rzoPiPE6AUImwwR
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:21:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/07/2020 à 14:46, Laurent Vivier a écrit :
> Le 26/06/2020 à 14:46, Matus Kysel a écrit :
>> Refactoring ipc syscall for s390x and SPARC, so it matches glibc implementation
>>
>> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
>> ---
>>  linux-user/syscall.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 97de9fb5c9..990412733b 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -814,9 +814,14 @@ safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>>                const struct timespec *, req, struct timespec *, rem)
>>  #endif
>>  #ifdef __NR_ipc
>> +#ifdef __s390x__
>> +safe_syscall5(int, ipc, int, call, long, first, long, second, long, third,
>> +              void *, ptr)
>> +#else
>>  safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
>>                void *, ptr, long, fifth)
>>  #endif
>> +#endif
>>  #ifdef __NR_msgsnd
>>  safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
>>                int, flags)
>> @@ -4053,8 +4058,13 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
>>  #endif
>>  #ifdef __NR_ipc
>>      if (ret == -TARGET_ENOSYS) {
>> +#ifdef __s390x__
>> +        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
>> +                                 host_mb));
>> +#else
>>          ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
>>                                   host_mb, 0));
>> +#endif
>>      }
>>  #endif
>>      g_free(host_mb);
>> @@ -4063,6 +4073,20 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
>>      return ret;
>>  }
>>  
>> +#ifdef __NR_ipc
>> +#if defined(__sparc__)
>> +/* SPARC for msgrcv it does not use the kludge on final 2 arguments.  */
>> +#define MSGRCV_ARGS(__msgp, __msgtyp) __msgp, __msgtyp
>> +#elif defined(__s390x__)
>> +/* The s390 sys_ipc variant has only five parameters.  */
>> +#define MSGRCV_ARGS(__msgp, __msgtyp) \
>> +    ((long int[]){(long int)__msgp, __msgtyp})
>> +#else
>> +#define MSGRCV_ARGS(__msgp, __msgtyp) \
>> +    ((long int[]){(long int)__msgp, __msgtyp}), 0
>> +#endif
>> +#endif
>> +
>>  static inline abi_long do_msgrcv(int msqid, abi_long msgp,
>>                                   ssize_t msgsz, abi_long msgtyp,
>>                                   int msgflg)
>> @@ -4091,7 +4115,7 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
>>  #ifdef __NR_ipc
>>      if (ret == -TARGET_ENOSYS) {
>>          ret = get_errno(safe_ipc(IPCOP_CALL(1, IPCOP_msgrcv), msqid, msgsz,
>> -                        msgflg, host_mb, msgtyp));
>> +                        msgflg, MSGRCV_ARGS(host_mb, msgtyp)));
>>      }
>>  #endif
>>  
>>
> 
> This patch breaks build because there is safe_ipc() that is not updated
> to use only 5 arguments with s390x. This is updated in the next patch so
> the build in the end works, but it breaks bisect so you should fix that.
> 
> Otherwise:
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> Thanks,
> Laurent
> 

I have merged PATH 1 and 2 and applied to my linux-user-for-5.1 branch.

Thanks,
Laurent


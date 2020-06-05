Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F318207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F318207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8o8-00025g-AQ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jh8ke-0003OM-Vl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:35:01 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jh8kd-0004hN-AS
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:35:00 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MvrRB-1irNbn19F9-00svWj; Fri, 05 Jun 2020 11:34:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Matus Kysel <mkysel@tachyum.com>
References: <20200512074510.40215-1-mkysel@tachyum.com>
 <caea3425-af6f-0857-3a81-f51dfb63f5b6@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2] linux-user: support of semtimedop syscall
Message-ID: <12bfbe6c-80f8-1af7-0172-454cdc7d2c40@vivier.eu>
Date: Fri, 5 Jun 2020 11:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <caea3425-af6f-0857-3a81-f51dfb63f5b6@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ygm9VipzB6epaXOTmn7DFJNrXZFf9Rzo+2sOk4FxrBkHIg09EqJ
 BZDlhaiMdyI74hmwYiGZlESnLRKT/gITQ6eC1XcXfQEUrym7+nwwfaop1XjjDSHsYSfqJHa
 hsnSVlMNQDHA8L9jicP+nmGkMlfir/pCMOnNUVa+meRDE6lipMO9GuHr5eTDCks3jf+e3Aq
 N/fYPrM3WE5f3ma1+utYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZVILbgbabR0=:4DbTKoqgaOyXX3VSV0itBE
 DVaPJch26PrT93klp6f9VRRrj2j88KSP9YjfZYI9FpVgFUsZgGM6XxwsysBvktO7stjCXDoTT
 +9ABLCMrv2FKRDpBOtIpAUHxnsbwlWSct2jvOxISfs4Pgf6OtlcKtcjWpQd8nJ5yPvvO9x/Xj
 fS+Z/y/J422lGpARjhUAfwIg0mpyfh7EYSQYJtBtlb/Jizm/cJDPbYRX12Gac3rAh++Gc+E/J
 KhbV1kl1mARsuwS4CNBD6kJHCUK5pD7XeNDdAo6DxYVkD14/CXf/iJm+mwJcYBcbNCK1AgvKR
 EvoV9UTYEINCp7PGmJBe8NaY4+dz2wSwo31JBsG5Hf5cc6FxnpTj9mnYtx6SW6fUo1eLZrK6A
 A/gRvOaOBrdE46HDFYC/u2rmSnp/XcR0baZF0LQ2B3YXCzTE3rJoVK+GbmJMMtLdqVVtVatl5
 XWGpz2q5laVxnqz1K0MO/bYxPlelOn7z1VNtLsGZBoH1bpqBBaR7RuBbdyrX7xrI7vRbOUVA9
 /Qym1WhbSusABed+J3EGUarBMjnAZE4uK+UWFSldZ3YST/UmOqftHr7hmAHiJTdAszkQXcvtM
 ZsAn4oL86ctgD0P35k4GXj9xmGXih2/RkYOv2nN0d11schkx1jAkSFLb7CwHBi8MtlG0UCC9x
 EOVLm9b4TsmKyIVSJ2CcW6wrVt3SoOPBc5v1UHGsJpaFxhP2lfMkxhU5ErLymC49/SbFUaWpx
 iJkioQF9ERNyZKZqqyx1XqUw6z+5WazhQCS7KC0eVoZlmVY14OGHN/mTYSG7iOm+PA38a+g+z
 B8wDIXlAQOmnGcuq3fvyLj1pogTG6GvjJM8aQF30ahH1T1CcvAZmTfcNQy/sz5rOB/yOXMW
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 05:34:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/05/2020 à 19:10, Laurent Vivier a écrit :
> Le 12/05/2020 à 09:45, Matus Kysel a écrit :
>> We should add support of semtimedop syscall as new version of
>> glibc 2.31 uses semop based on semtimedop (commit: https://gitlab.com/freedesktop-sdk/mirrors/sourceware/glibc/-/commit/765cdd0bffd77960ae852104fc4ea5edcdb8aed3 ).
>>
>> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
>> ---
>>  linux-user/syscall.c | 34 ++++++++++++++++++++++++++++------
>>  1 file changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 05f03919ff..7c6f9439e0 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -1227,7 +1227,8 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
>>      defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
>>      defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
>>      defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
>> -    defined(TARGET_NR_mq_timedreceive)
>> +    defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
>> +    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
>>  static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>>                                                 abi_ulong target_addr)
>>  {
>> @@ -3875,25 +3876,39 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>>      return 0;
>>  }
>>
>> -static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
>> +#if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
>> +    defined(TARGET_NR_semtimedop)
>> +static inline abi_long do_semtimedop(int semid,
>> +                                     abi_long ptr,
>> +                                     unsigned nsops,
>> +                                     abi_long timeout)
>>  {
>>      struct sembuf sops[nsops];
>> +    struct timespec ts, *pts = NULL;
>>      abi_long ret;
>>
>> +    if (timeout) {
>> +        pts = &ts;
>> +        if (target_to_host_timespec(pts, timeout)) {
>> +            return -TARGET_EFAULT;
>> +        }
>> +    }
>> +
>>      if (target_to_host_sembuf(sops, ptr, nsops))
>>          return -TARGET_EFAULT;
>>
>>      ret = -TARGET_ENOSYS;
>>  #ifdef __NR_semtimedop
>> -    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
>> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
>>  #endif
>>  #ifdef __NR_ipc
>>      if (ret == -TARGET_ENOSYS) {
>> -        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
>> +        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, pts));
>>      }
>>  #endif
>>      return ret;
>>  }
>> +#endif
>>
>>  struct target_msqid_ds
>>  {
>> @@ -4369,7 +4384,10 @@ static abi_long do_ipc(CPUArchState *cpu_env,
>>
>>      switch (call) {
>>      case IPCOP_semop:
>> -        ret = do_semop(first, ptr, second);
>> +        ret = do_semtimedop(first, ptr, second, 0);
>> +        break;
>> +    case IPCOP_semtimedop:
>> +        ret = do_semtimedop(first, ptr, second, third);
>>          break;
>>
>>      case IPCOP_semget:
>> @@ -9594,7 +9612,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>>  #endif
>>  #ifdef TARGET_NR_semop
>>      case TARGET_NR_semop:
>> -        return do_semop(arg1, arg2, arg3);
>> +        return do_semtimedop(arg1, arg2, arg3, 0);
>> +#endif
>> +#ifdef TARGET_NR_semtimedop
>> +    case TARGET_NR_semtimedop:
>> +        return do_semtimedop(arg1, arg2, arg3, arg4);
>>  #endif
>>  #ifdef TARGET_NR_semctl
>>      case TARGET_NR_semctl:
>> --
>> 2.17.1
>>
>>
> 
> Applied to my linux-user branch.

I'm sorry I have to remove this patch from my queue as it fails to build
on ppc64 and s390x:

ppc64: https://travis-ci.com/github/vivier/qemu/jobs/342816606
s390x: https://travis-ci.com/github/vivier/qemu/jobs/342816607

For ppc64 (and other targets in fact), I think we just need a (long)
cast on pts.

For s390x, it is clearly because ipc() has arguments in a different
order. In glibc we have:

sysdeps/unix/sysv/linux/semtimedop.c:

  return INLINE_SYSCALL_CALL (ipc, IPCOP_semtimedop, semid,
                              SEMTIMEDOP_IPC_ARGS (nsops, sops, timeout));

sysdeps/unix/sysv/linux/ipc_priv.h:

/* This macro is required to handle the s390 variants, which passes the
   arguments in a different order than default.  */
#define SEMTIMEDOP_IPC_ARGS(__nsops, __sops, __timeout) \
  (__nsops), 0, (__sops), (__timeout)

sysdeps/unix/sysv/linux/s390/ipc_priv.h:

/* The s390 sys_ipc variant has only five parameters instead of six
   (as for default variant).  The difference is the handling of
   SEMTIMEDOP where on s390 the third parameter is used as a pointer
   to a struct timespec where the generic variant uses fifth parameter.  */
#undef SEMTIMEDOP_IPC_ARGS
#define SEMTIMEDOP_IPC_ARGS(__nsops, __sops, __timeout) \
  (__nsops), (__timeout), (__sops)

To be really clean the do_ipc() function should be also updated for the
s390x target side.

Thanks,
Laurent


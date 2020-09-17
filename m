Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B187C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BAF22205
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BAF22205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyqG-0003Qh-Ss
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIyom-0002Ji-0k; Thu, 17 Sep 2020 14:39:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIyoj-0002CO-UV; Thu, 17 Sep 2020 14:39:39 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N7iGi-1kVXsm0N6Y-014kpQ; Thu, 17 Sep 2020 20:39:30 +0200
Subject: Re: [PATCH V3 06/10] linux-user/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-7-zhaolichang@huawei.com>
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
Message-ID: <2736342d-21a1-e611-f462-87a497e76a03@vivier.eu>
Date: Thu, 17 Sep 2020 20:39:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917075029.313-7-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OpUf0UlFlUhZQy+f9EfQMN3nBfPMtJTASoPK4dvSGlw4gbCrVSL
 gmDHiXxfUbx57Acb2QakI9FLfjCOW6ouHSXP+6KauftETgcIjPAdMRGRFJxzQpRmQQkBuPt
 Ph6rs+ETBZ3TdX4drojzIpsZO0dkJGEccVRQqizlJmcmf1e6ERtmuEe+LYriP1pLct26pw2
 N0KMhEbc71Hi15hhvHxnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BXRvxzLDuf8=:9oxbtn3rLRbzHPrKU6A5HT
 RewGldrMi0vMHEtJdmrXAOI2yHdzYlDZpAvF6YPCHtTZlUaEcJzZKdNUa1rs76AQFWPXSpheS
 ntMkK9fSQyaNqy1iGlpF2HHB5OvXXBvBQdtDZ4tm809IqkVCLJlrKWbdixVeX+nDF2uqpdqFF
 4IrWmj5TivEMSlGCsMmTAW1c0WLmDnil4jla8CblfS58RdJgJ7MU0dnkG2rrwtdMcVfWlCIF8
 LePMynEVd2Uz2D7KY8dbmk1ikPM4xM9LQUWbxBtODJJsXi1wEY09TUZ5DEIM0I5+URieNCAeh
 eBgfC1S82mfCMLPsfd4xAEL5nCztAKrjqxMMAJl8s6HS0sZtkY3CxZNbb502qeMTb5vSr0mxC
 4n95y3f9ojmCUzXOx95OnxEPJm+WCSBSzd8DoN+sD7W5Jzphnxg4PPB3EH6vYDHrVDgvN+o9A
 o+Q1QrGRg5P0Vcn2uSZkYkMTuiNLo4aBiXu9463z2zd2qe5fh7AvYcYqqioHx16mhdeUQXnCl
 04FYuqKayenvvAmmPYjPBtfLPV0HPt7HP8OaIDt2EtcL31OAYhEeGL3KkW4g+4Q+74tTjP4DS
 eN5hmwLCe8u1XcYTk8mERWPgv6pV+FZ2B0e9f6az1BZjssn8QI0yo60vBJ49qVi2zVlIHcwSa
 W473RUvkL/P9vYhWUg/+j3DqtS22N6IOleJRIveJMvWHwLaF2RY99+d8BjMjf1pnCIzKmPnNO
 swRZm8bT1WclNSp7kZkc5hAuLeHdInZYWLQFR82/HnnYaHoiJ2igNJZKTuGXCcMYMUnPrrFIA
 keOev0vyxZ824gexj0NTybcDrrkji+Yl7wBjmqmiznWphXJnhGpqdQ9lrai00FWeGs9Ruz4
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:39:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/09/2020 à 09:50, zhaolichang a écrit :
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the linux-user folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
> ---
>  linux-user/aarch64/signal.c              | 2 +-
>  linux-user/cris/target_syscall.h         | 4 ++--
>  linux-user/flat.h                        | 2 +-
>  linux-user/flatload.c                    | 4 ++--
>  linux-user/host/ppc64/safe-syscall.inc.S | 2 +-
>  linux-user/syscall.c                     | 4 ++--
>  6 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
> index cd521ee42d..d50c1ae583 100644
> --- a/linux-user/aarch64/signal.c
> +++ b/linux-user/aarch64/signal.c
> @@ -78,7 +78,7 @@ struct target_sve_context {
>      struct target_aarch64_ctx head;
>      uint16_t vl;
>      uint16_t reserved[3];
> -    /* The actual SVE data immediately follows.  It is layed out
> +    /* The actual SVE data immediately follows.  It is laid out
>       * according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of
>       * the original struct pointer.
>       */
> diff --git a/linux-user/cris/target_syscall.h b/linux-user/cris/target_syscall.h
> index d109a6b42a..19e1281403 100644
> --- a/linux-user/cris/target_syscall.h
> +++ b/linux-user/cris/target_syscall.h
> @@ -4,7 +4,7 @@
>  #define UNAME_MACHINE "cris"
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>  
> -/* pt_regs not only specifices the format in the user-struct during
> +/* pt_regs not only specifies the format in the user-struct during
>   * ptrace but is also the frame format used in the kernel prologue/epilogues
>   * themselves
>   */
> @@ -32,7 +32,7 @@ struct target_pt_regs {
>          unsigned long spc;
>          unsigned long ccs;
>          unsigned long srp;
> -        unsigned long erp; /* This is actually the debugged process' PC */
> +        unsigned long erp; /* This is actually the debugged process's PC */
>          /* For debugging purposes; saved only when needed. */
>          unsigned long exs;
>          unsigned long eda;
> diff --git a/linux-user/flat.h b/linux-user/flat.h
> index 1e44b33443..ed518e2013 100644
> --- a/linux-user/flat.h
> +++ b/linux-user/flat.h
> @@ -43,7 +43,7 @@ struct flat_hdr {
>  	abi_ulong reloc_count;  /* Number of relocation records */
>  	abi_ulong flags;
>  	abi_ulong build_date;   /* When the program/library was built */
> -	abi_ulong filler[5];    /* Reservered, set to zero */
> +	abi_ulong filler[5];    /* Reserved, set to zero */
>  };
>  
>  #define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 8fb448f0bf..14d2999d15 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -442,7 +442,7 @@ static int load_flat_file(struct linux_binprm * bprm,
>      indx_len = (indx_len + 15) & ~(abi_ulong)15;
>  
>      /*
> -     * Alloate the address space.
> +     * Allocate the address space.
>       */
>      probe_guest_base(bprm->filename, 0,
>                       text_len + data_len + extra + indx_len);
> @@ -794,7 +794,7 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
>  #error here
>      for (i = MAX_SHARED_LIBS-1; i>0; i--) {
>              if (libinfo[i].loaded) {
> -                    /* Push previos first to call address */
> +                    /* Push previous first to call address */
>                      --sp;
>                      if (put_user_ual(start_addr, sp))
>                          return -EFAULT;
> diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S
> index 8ed73a5b86..875133173b 100644
> --- a/linux-user/host/ppc64/safe-syscall.inc.S
> +++ b/linux-user/host/ppc64/safe-syscall.inc.S
> @@ -84,7 +84,7 @@ safe_syscall_end:
>  
>  	/* code path when we didn't execute the syscall */
>  0:	addi	3, 0, -TARGET_ERESTARTSYS
> -	ld 14, 16(1) /* restore r14 to its orginal value */
> +	ld 14, 16(1) /* restore r14 to its original value */
>  	blr
>  	.cfi_endproc
>  
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 55ac5c3208..897d20c076 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -481,7 +481,7 @@ _syscall4(int, sys_prlimit64, pid_t, pid, int, resource,
>  
>  
>  #if defined(TARGET_NR_timer_create)
> -/* Maxiumum of 32 active POSIX timers allowed at any one time. */
> +/* Maximum of 32 active POSIX timers allowed at any one time. */
>  static timer_t g_posix_timers[32] = { 0, } ;
>  
>  static inline int next_free_host_timer(void)
> @@ -8180,7 +8180,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      switch(num) {
>      case TARGET_NR_exit:
>          /* In old applications this may be used to implement _exit(2).
> -           However in threaded applictions it is used for thread termination,
> +           However in threaded applications it is used for thread termination,
>             and _exit_group is used for application termination.
>             Do thread termination if we have more then one thread.  */
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent



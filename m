Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F259C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5A22067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5A22067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJLj-0003FW-Vr
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJKt-0002jF-DZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:44:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJKo-0008OF-PI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:44:59 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M4Je5-1kAaRu0wCn-000Ktr; Mon, 24 Aug 2020 22:44:51 +0200
Subject: Re: [PATCH v4 1/5] linux-user: Make cpu_env accessible in strace.c
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
 <20200811164553.27713-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7bf69d48-9c23-06b7-c457-d3cc6e92049f@vivier.eu>
Date: Mon, 24 Aug 2020 22:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811164553.27713-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5zcO8qFGAqhaTk/v0l+MadBC4lo0FEZBdCH5EJFEl4sGqyMolIU
 xYlofXR1Qup/I7AMyenu528uRc8GNWlT8sky4xxXPwfa5jNdpMBSeSAbrj+h8xYZh+F1nv4
 w6FQRJrHbciLfi/stE568xJgjUwa17wH9IjVfm5MCyXB8HdABse0KCis64JbErz0RjfcoTv
 AqGC1kfKQcE/UaUmbxzCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:suktkGQm7IA=:+7+xI2kvebnbMeVqWK4SKQ
 9+jZXynl+goHIekLfZYTBVjMqKH4/oGLyZ1N+hnt2XaNhviNx++Dib4gq91/AaPb8QR71yFYb
 znxrphbK+TZHqc+ciCYtE3nMY67b3gguOvSN22JoOI+v3S56iwSOQj8oo4UO5dOuAN+XAQbAv
 OoXEPQv8gq/kLU6jmCOfS2e5Dj8ARnTK8jLG07EuDxdR9d79UrmvVjFoILnShn6A9hat/auVX
 rKWJJnWupXdbvf4pf/ghrI8OcnL+67TVjYqCVJ6bN8x7D2eziMtUFUIllYeed63DITjQ8g6k1
 TDq1VtDDboewaSn2S958ptC5nGqJH1buiKFlCPIpk0KOR9TGZr8ZrgWR93ZaGELlAxZwSe8rp
 JNBm39RUI7yZbc12ms/YQkfktliQTTXT9NoaxaBhp2HRR+GsT8753Rmg2309BXHZ8DltJRpVs
 UsFoEkqzDQQdlJmk2qMFhmd/p5xS4q9HH6NaG4B/G899nG2lXoAIQhx7gz9XvpxgxQT3klbdK
 sTtgaGy/rBv2xQobvl9ZYuLLoipRiN03tD1aACcvUgj8uOOMEH/oiXAqcbX1Hao/m8863/mSV
 jBv3JmsTdMNj9X2PosMeGY7bXJYI8uVCybkfZoub3xIO/XKbwI8Cr8xPTyMErcV4WJF3UdZCx
 CiEyMcp47TCowlxRS/OHTjTmFhOuZnqPaKhfeG9+1uvikWDy432xMJLUtUuV2dkPnSCiBafVk
 L60s++IlSZZDpZZrg3f8PzDkXx/KZKXRIGHK8KrlcBWepk9LQUJ6ZAXr09oBZJnUxOKTiTjkZ
 g2/nRY/wSlTnkZ9QWDCnexsZ96yuZUj8cfhG3p8funMUyg2B1pIxrXiVEGhqgcY2JA2zqLC
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:28:49
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/08/2020 à 18:45, Filip Bozuta a écrit :
> Variable "cpu_env" is used in file "syscall.c" to store
> the information about the cpu environment. This variable
> is used because values of some syscalls can vary between
> cpu architectures. This patch makes the "cpu_env" accessible
> in "strace.c" so it can enable aproppriate "-strace" argument
> printing for these syscalls. This will be a useful addition
> for future "-strace" implementation in QEMU.
> 
> Implementation notes:
> 
>     Functions "print_syscall()" and "print_syscall_ret()" which
>     are stated and defined in "qemu.h" and "strace.c" respectively
>     are used to print syscall arguments before and after syscall
>     execution. These functions were changed with addition of a
>     new argument "void *cpu_env". Strucute "struct syscallname"
>     in "strace.c" is used to store the information about syscalls.
>     Fields "call" and "result" represent pointers to functions which
>     are used to print syscall arguments before and after execution.
>     These fields were also changed with addition of a new "void *"
>     argumetn.
>     Also, all defined "print_*" and "print_syscall_ret*" functions
>     in "strace.c" were changed to have the new "void *cpu_env".
>     This was done to not cause build errors (even though none of
>     these functions use this argument).
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/qemu.h    |   4 +-
>  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
>  linux-user/syscall.c |   5 +-
>  3 files changed, 247 insertions(+), 241 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 5c964389c1..63ddfe86fd 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -400,10 +400,10 @@ extern long safe_syscall_base(int *pending, long number, ...);
>  int host_to_target_waitstatus(int status);
>  
>  /* strace.c */
> -void print_syscall(int num,
> +void print_syscall(void *cpu_env, int num,
>                     abi_long arg1, abi_long arg2, abi_long arg3,
>                     abi_long arg4, abi_long arg5, abi_long arg6);
> -void print_syscall_ret(int num, abi_long ret,
> +void print_syscall_ret(void *cpu_env, int num, abi_long ret,
>                         abi_long arg1, abi_long arg2, abi_long arg3,
>                         abi_long arg4, abi_long arg5, abi_long arg6);
>  /**
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 13981341b3..f0624b6206 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -16,10 +16,10 @@ struct syscallname {
>      int nr;
>      const char *name;
>      const char *format;
> -    void (*call)(const struct syscallname *,
> +    void (*call)(void *, const struct syscallname *,
>                   abi_long, abi_long, abi_long,
>                   abi_long, abi_long, abi_long);
> -    void (*result)(const struct syscallname *, abi_long,
> +    void (*result)(void *, const struct syscallname *, abi_long,
>                     abi_long, abi_long, abi_long,
>                     abi_long, abi_long, abi_long);
>  };
> @@ -634,7 +634,7 @@ print_clockid(int clockid, int last)
>  /* select */
>  #ifdef TARGET_NR__newselect
>  static void
> -print_newselect(const struct syscallname *name,
> +print_newselect(void *cpu_env, const struct syscallname *name,
>                  abi_long arg1, abi_long arg2, abi_long arg3,
>                  abi_long arg4, abi_long arg5, abi_long arg6)
>  {
> @@ -652,7 +652,7 @@ print_newselect(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_semctl
>  static void
> -print_semctl(const struct syscallname *name,
> +print_semctl(void *cpu_env, const struct syscallname *name,
>               abi_long arg1, abi_long arg2, abi_long arg3,
>               abi_long arg4, abi_long arg5, abi_long arg6)
>  {
> @@ -664,7 +664,7 @@ print_semctl(const struct syscallname *name,
>  #endif
>  
>  static void
> -print_execve(const struct syscallname *name,
> +print_execve(void *cpu_env, const struct syscallname *name,
>               abi_long arg1, abi_long arg2, abi_long arg3,
>               abi_long arg4, abi_long arg5, abi_long arg6)
>  {
> @@ -697,7 +697,7 @@ print_execve(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_ipc
>  static void
> -print_ipc(const struct syscallname *name,
> +print_ipc(void *cpu_env, const struct syscallname *name,
>            abi_long arg1, abi_long arg2, abi_long arg3,
>            abi_long arg4, abi_long arg5, abi_long arg6)
>  {
> @@ -741,9 +741,10 @@ print_syscall_err(abi_long ret)
>  }
>  
>  static void
> -print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
> -                       abi_long arg0, abi_long arg1, abi_long arg2,
> -                       abi_long arg3, abi_long arg4, abi_long arg5)
> +print_syscall_ret_addr(void *cpu_env, const struct syscallname *name,
> +                       abi_long ret, abi_long arg0, abi_long arg1,
> +                       abi_long arg2, abi_long arg3, abi_long arg4,
> +                       abi_long arg5)
>  {
>      if (!print_syscall_err(ret)) {
>          qemu_log("0x" TARGET_ABI_FMT_lx, ret);
> @@ -761,9 +762,10 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
>  
>  #ifdef TARGET_NR__newselect
>  static void
> -print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
> -                            abi_long arg0, abi_long arg1, abi_long arg2,
> -                            abi_long arg3, abi_long arg4, abi_long arg5)
> +print_syscall_ret_newselect(void *cpu_env, const struct syscallname *name,
> +                            abi_long ret, abi_long arg0, abi_long arg1,
> +                            abi_long arg2, abi_long arg3, abi_long arg4,
> +                            abi_long arg5)
>  {
>      if (!print_syscall_err(ret)) {
>          qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
> @@ -790,9 +792,10 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
>  #define TARGET_TIME_ERROR    5   /* clock not synchronized */
>  #ifdef TARGET_NR_adjtimex
>  static void
> -print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
> -                           abi_long arg0, abi_long arg1, abi_long arg2,
> -                           abi_long arg3, abi_long arg4, abi_long arg5)
> +print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
> +                           abi_long ret, abi_long arg0, abi_long arg1,
> +                           abi_long arg2, abi_long arg3, abi_long arg4,
> +                           abi_long arg5)
>  {
>      if (!print_syscall_err(ret)) {
>          qemu_log(TARGET_ABI_FMT_ld, ret);
> @@ -825,9 +828,10 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
>  #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
>   || defined(TARGGET_NR_flistxattr)
>  static void
> -print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
> -                            abi_long arg0, abi_long arg1, abi_long arg2,
> -                            abi_long arg3, abi_long arg4, abi_long arg5)
> +print_syscall_ret_listxattr(void *cpu_env, const struct syscallname *name,
> +                            abi_long ret, abi_long arg0, abi_long arg1,
> +                            abi_long arg2, abi_long arg3, abi_long arg4,
> +                            abi_long arg5)
>  {
>      if (!print_syscall_err(ret)) {
>          qemu_log(TARGET_ABI_FMT_ld, ret);
> @@ -856,9 +860,10 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
>  
>  #ifdef TARGET_NR_ioctl
>  static void
> -print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
> -                        abi_long arg0, abi_long arg1, abi_long arg2,
> -                        abi_long arg3, abi_long arg4, abi_long arg5)
> +print_syscall_ret_ioctl(void *cpu_env, const struct syscallname *name,
> +                        abi_long ret, abi_long arg0, abi_long arg1,
> +                        abi_long arg2, abi_long arg3, abi_long arg4,
> +                        abi_long arg5)
>  {
>      if (!print_syscall_err(ret)) {
>          qemu_log(TARGET_ABI_FMT_ld, ret);
> @@ -1420,9 +1425,9 @@ print_timezone(abi_ulong tz_addr, int last)
>  
>  #ifdef TARGET_NR_accept
>  static void
> -print_accept(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_accept(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1434,9 +1439,9 @@ print_accept(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_access
>  static void
> -print_access(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_access(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1447,9 +1452,9 @@ print_access(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_acct
>  static void
> -print_acct(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_acct(void *cpu_env, const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 1);
> @@ -1459,9 +1464,9 @@ print_acct(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_brk
>  static void
> -print_brk(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_brk(void *cpu_env, const struct syscallname *name,
> +          abi_long arg0, abi_long arg1, abi_long arg2,
> +          abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_pointer(arg0, 1);
> @@ -1471,9 +1476,9 @@ print_brk(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_chdir
>  static void
> -print_chdir(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_chdir(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 1);
> @@ -1483,9 +1488,9 @@ print_chdir(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_chroot
>  static void
> -print_chroot(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_chroot(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 1);
> @@ -1495,9 +1500,9 @@ print_chroot(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_chmod
>  static void
> -print_chmod(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_chmod(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1508,9 +1513,9 @@ print_chmod(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
>  static void
> -print_chown(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_chown(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1523,9 +1528,9 @@ print_chown(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_clock_adjtime
>  static void
> -print_clock_adjtime(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_clock_adjtime(void *cpu_env, const struct syscallname *name,
> +                    abi_long arg0, abi_long arg1, abi_long arg2,
> +                    abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_clockid(arg0, 0);
> @@ -1547,9 +1552,9 @@ static void do_print_clone(unsigned int flags, abi_ulong newsp,
>  }
>  
>  static void
> -print_clone(const struct syscallname *name,
> -    abi_long arg1, abi_long arg2, abi_long arg3,
> -    abi_long arg4, abi_long arg5, abi_long arg6)
> +print_clone(void *cpu_env, const struct syscallname *name,
> +            abi_long arg1, abi_long arg2, abi_long arg3,
> +            abi_long arg4, abi_long arg5, abi_long arg6)
>  {
>      print_syscall_prologue(name);
>  #if defined(TARGET_MICROBLAZE)
> @@ -1567,9 +1572,9 @@ print_clone(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_creat
>  static void
> -print_creat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_creat(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1580,9 +1585,9 @@ print_creat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_execv
>  static void
> -print_execv(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_execv(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1593,9 +1598,9 @@ print_execv(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_faccessat
>  static void
> -print_faccessat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_faccessat(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -1608,9 +1613,9 @@ print_faccessat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_fallocate
>  static void
> -print_fallocate(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fallocate(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1628,9 +1633,9 @@ print_fallocate(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_fchmodat
>  static void
> -print_fchmodat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fchmodat(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -1643,9 +1648,9 @@ print_fchmodat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_fchownat
>  static void
> -print_fchownat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fchownat(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -1659,9 +1664,9 @@ print_fchownat(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_fcntl) || defined(TARGET_NR_fcntl64)
>  static void
> -print_fcntl(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fcntl(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1758,9 +1763,9 @@ print_fcntl(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_fgetxattr
>  static void
> -print_fgetxattr(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fgetxattr(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1773,9 +1778,9 @@ print_fgetxattr(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_flistxattr
>  static void
> -print_flistxattr(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_flistxattr(void *cpu_env, const struct syscallname *name,
> +                 abi_long arg0, abi_long arg1, abi_long arg2,
> +                 abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1787,9 +1792,9 @@ print_flistxattr(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_getxattr) || defined(TARGET_NR_lgetxattr)
>  static void
> -print_getxattr(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_getxattr(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1803,9 +1808,9 @@ print_getxattr(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr)
>  static void
> -print_listxattr(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_listxattr(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1818,9 +1823,9 @@ print_listxattr(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_fremovexattr)
>  static void
> -print_fremovexattr(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fremovexattr(void *cpu_env, const struct syscallname *name,
> +                   abi_long arg0, abi_long arg1, abi_long arg2,
> +                   abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1831,9 +1836,9 @@ print_fremovexattr(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_removexattr) || defined(TARGET_NR_lremovexattr)
>  static void
> -print_removexattr(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_removexattr(void *cpu_env, const struct syscallname *name,
> +                  abi_long arg0, abi_long arg1, abi_long arg2,
> +                  abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1845,9 +1850,9 @@ print_removexattr(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_futimesat
>  static void
> -print_futimesat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_futimesat(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -1860,9 +1865,9 @@ print_futimesat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_settimeofday
>  static void
> -print_settimeofday(const struct syscallname *name,
> -                abi_long arg0, abi_long arg1, abi_long arg2,
> -                abi_long arg3, abi_long arg4, abi_long arg5)
> +print_settimeofday(void *cpu_env, const struct syscallname *name,
> +                   abi_long arg0, abi_long arg1, abi_long arg2,
> +                   abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_timeval(arg0, 0);
> @@ -1873,9 +1878,9 @@ print_settimeofday(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_link
>  static void
> -print_link(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_link(void *cpu_env, const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -1886,9 +1891,9 @@ print_link(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_linkat
>  static void
> -print_linkat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_linkat(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -1902,9 +1907,9 @@ print_linkat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR__llseek
>  static void
> -print__llseek(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print__llseek(void *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      const char *whence = "UNKNOWN";
>      print_syscall_prologue(name);
> @@ -1924,9 +1929,9 @@ print__llseek(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_lseek
>  static void
> -print_lseek(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_lseek(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -1955,7 +1960,7 @@ print_lseek(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_socket)
>  static void
> -print_socket(const struct syscallname *name,
> +print_socket(void *cpu_env, const struct syscallname *name,
>               abi_long arg0, abi_long arg1, abi_long arg2,
>               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> @@ -2304,7 +2309,7 @@ static struct {
>  };
>  
>  static void
> -print_socketcall(const struct syscallname *name,
> +print_socketcall(void *cpu_env, const struct syscallname *name,
>                   abi_long arg0, abi_long arg1, abi_long arg2,
>                   abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> @@ -2325,7 +2330,7 @@ print_socketcall(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_bind)
>  static void
> -print_bind(const struct syscallname *name,
> +print_bind(void *cpu_env, const struct syscallname *name,
>             abi_long arg0, abi_long arg1, abi_long arg2,
>             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> @@ -2339,9 +2344,9 @@ print_bind(const struct syscallname *name,
>  #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
>      defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
>  static void
> -print_stat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_stat(void *cpu_env, const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2355,9 +2360,9 @@ print_stat(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
>  static void
> -print_fstat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fstat(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -2369,9 +2374,9 @@ print_fstat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mkdir
>  static void
> -print_mkdir(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mkdir(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2382,9 +2387,9 @@ print_mkdir(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mkdirat
>  static void
> -print_mkdirat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mkdirat(void *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -2396,9 +2401,9 @@ print_mkdirat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_rmdir
>  static void
> -print_rmdir(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_rmdir(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2408,9 +2413,9 @@ print_rmdir(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_rt_sigaction
>  static void
> -print_rt_sigaction(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_rt_sigaction(void *cpu_env, const struct syscallname *name,
> +                   abi_long arg0, abi_long arg1, abi_long arg2,
> +                   abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_signal(arg0, 0);
> @@ -2422,9 +2427,9 @@ print_rt_sigaction(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_rt_sigprocmask
>  static void
> -print_rt_sigprocmask(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_rt_sigprocmask(void *cpu_env, const struct syscallname *name,
> +                     abi_long arg0, abi_long arg1, abi_long arg2,
> +                     abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      const char *how = "UNKNOWN";
>      print_syscall_prologue(name);
> @@ -2442,9 +2447,9 @@ print_rt_sigprocmask(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_rt_sigqueueinfo
>  static void
> -print_rt_sigqueueinfo(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_rt_sigqueueinfo(void *cpu_env, const struct syscallname *name,
> +                      abi_long arg0, abi_long arg1, abi_long arg2,
> +                      abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      void *p;
>      target_siginfo_t uinfo;
> @@ -2467,9 +2472,9 @@ print_rt_sigqueueinfo(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_rt_tgsigqueueinfo
>  static void
> -print_rt_tgsigqueueinfo(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_rt_tgsigqueueinfo(void *cpu_env, const struct syscallname *name,
> +                        abi_long arg0, abi_long arg1, abi_long arg2,
> +                        abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      void *p;
>      target_siginfo_t uinfo;
> @@ -2551,9 +2556,9 @@ print_syslog_action(abi_ulong arg, int last)
>  }
>  
>  static void
> -print_syslog(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_syslog(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_syslog_action(arg0, 0);
> @@ -2565,9 +2570,9 @@ print_syslog(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mknod
>  static void
> -print_mknod(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mknod(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      int hasdev = (arg1 & (S_IFCHR|S_IFBLK));
>  
> @@ -2584,9 +2589,9 @@ print_mknod(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mknodat
>  static void
> -print_mknodat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mknodat(void *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      int hasdev = (arg2 & (S_IFCHR|S_IFBLK));
>  
> @@ -2604,9 +2609,9 @@ print_mknodat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mq_open
>  static void
> -print_mq_open(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mq_open(void *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      int is_creat = (arg1 & TARGET_O_CREAT);
>  
> @@ -2623,9 +2628,9 @@ print_mq_open(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_open
>  static void
> -print_open(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_open(void *cpu_env, const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      int is_creat = (arg1 & TARGET_O_CREAT);
>  
> @@ -2640,9 +2645,9 @@ print_open(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_openat
>  static void
> -print_openat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_openat(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      int is_creat = (arg2 & TARGET_O_CREAT);
>  
> @@ -2658,9 +2663,9 @@ print_openat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mq_unlink
>  static void
> -print_mq_unlink(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mq_unlink(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 1);
> @@ -2670,9 +2675,9 @@ print_mq_unlink(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_fstatat64) || defined(TARGET_NR_newfstatat)
>  static void
> -print_fstatat64(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_fstatat64(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -2686,9 +2691,9 @@ print_fstatat64(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_readlink
>  static void
> -print_readlink(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_readlink(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2700,9 +2705,9 @@ print_readlink(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_readlinkat
>  static void
> -print_readlinkat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_readlinkat(void *cpu_env, const struct syscallname *name,
> +                 abi_long arg0, abi_long arg1, abi_long arg2,
> +                 abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -2715,9 +2720,9 @@ print_readlinkat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_rename
>  static void
> -print_rename(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_rename(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2728,9 +2733,9 @@ print_rename(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_renameat
>  static void
> -print_renameat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_renameat(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -2743,9 +2748,9 @@ print_renameat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_statfs
>  static void
> -print_statfs(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_statfs(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2756,9 +2761,9 @@ print_statfs(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_statfs64
>  static void
> -print_statfs64(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_statfs64(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2769,9 +2774,9 @@ print_statfs64(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_symlink
>  static void
> -print_symlink(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_symlink(void *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2782,9 +2787,9 @@ print_symlink(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_symlinkat
>  static void
> -print_symlinkat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_symlinkat(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2796,9 +2801,9 @@ print_symlinkat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mount
>  static void
> -print_mount(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mount(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2812,9 +2817,9 @@ print_mount(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_umount
>  static void
> -print_umount(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_umount(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 1);
> @@ -2824,9 +2829,9 @@ print_umount(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_umount2
>  static void
> -print_umount2(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_umount2(void *cpu_env, const struct syscallname *name,
> +              abi_long arg0, abi_long arg1, abi_long arg2,
> +              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2837,9 +2842,9 @@ print_umount2(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_unlink
>  static void
> -print_unlink(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_unlink(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 1);
> @@ -2849,9 +2854,9 @@ print_unlink(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_unlinkat
>  static void
> -print_unlinkat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_unlinkat(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -2863,9 +2868,9 @@ print_unlinkat(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_utime
>  static void
> -print_utime(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_utime(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2876,9 +2881,9 @@ print_utime(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_utimes
>  static void
> -print_utimes(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_utimes(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_string(arg0, 0);
> @@ -2889,9 +2894,9 @@ print_utimes(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_utimensat
>  static void
> -print_utimensat(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_utimensat(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_at_dirfd(arg0, 0);
> @@ -2904,9 +2909,9 @@ print_utimensat(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_mmap) || defined(TARGET_NR_mmap2)
>  static void
> -print_mmap(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mmap(void *cpu_env, const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_pointer(arg0, 0);
> @@ -2922,9 +2927,9 @@ print_mmap(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_mprotect
>  static void
> -print_mprotect(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_mprotect(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_pointer(arg0, 0);
> @@ -2936,9 +2941,9 @@ print_mprotect(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_munmap
>  static void
> -print_munmap(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_munmap(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_pointer(arg0, 0);
> @@ -2989,9 +2994,9 @@ if( cmd == val ) { \
>  }
>  
>  static void
> -print_futex(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_futex(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_pointer(arg0, 0);
> @@ -3006,9 +3011,9 @@ print_futex(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_kill
>  static void
> -print_kill(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_kill(void *cpu_env, const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -3019,9 +3024,9 @@ print_kill(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_tkill
>  static void
> -print_tkill(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_tkill(void *cpu_env, const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -3032,9 +3037,9 @@ print_tkill(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_tgkill
>  static void
> -print_tgkill(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> +print_tgkill(void *cpu_env, const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
>      print_raw_param("%d", arg0, 0);
> @@ -3046,7 +3051,7 @@ print_tgkill(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_statx
>  static void
> -print_statx(const struct syscallname *name,
> +print_statx(void *cpu_env, const struct syscallname *name,
>              abi_long arg0, abi_long arg1, abi_long arg2,
>              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> @@ -3062,7 +3067,7 @@ print_statx(const struct syscallname *name,
>  
>  #ifdef TARGET_NR_ioctl
>  static void
> -print_ioctl(const struct syscallname *name,
> +print_ioctl(void *cpu_env, const struct syscallname *name,
>              abi_long arg0, abi_long arg1, abi_long arg2,
>              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> @@ -3147,7 +3152,7 @@ static int nsyscalls = ARRAY_SIZE(scnames);
>   * The public interface to this module.
>   */
>  void
> -print_syscall(int num,
> +print_syscall(void *cpu_env, int num,
>                abi_long arg1, abi_long arg2, abi_long arg3,
>                abi_long arg4, abi_long arg5, abi_long arg6)
>  {
> @@ -3160,7 +3165,7 @@ print_syscall(int num,
>          if( scnames[i].nr == num ) {
>              if( scnames[i].call != NULL ) {
>                  scnames[i].call(
> -                    &scnames[i], arg1, arg2, arg3, arg4, arg5, arg6);
> +                    cpu_env, &scnames[i], arg1, arg2, arg3, arg4, arg5, arg6);
>              } else {
>                  /* XXX: this format system is broken because it uses
>                     host types and host pointers for strings */
> @@ -3176,7 +3181,7 @@ print_syscall(int num,
>  
>  
>  void
> -print_syscall_ret(int num, abi_long ret,
> +print_syscall_ret(void *cpu_env, int num, abi_long ret,
>                    abi_long arg1, abi_long arg2, abi_long arg3,
>                    abi_long arg4, abi_long arg5, abi_long arg6)
>  {
> @@ -3185,7 +3190,7 @@ print_syscall_ret(int num, abi_long ret,
>      for(i=0;i<nsyscalls;i++)
>          if( scnames[i].nr == num ) {
>              if( scnames[i].result != NULL ) {
> -                scnames[i].result(&scnames[i], ret,
> +                scnames[i].result(cpu_env, &scnames[i], ret,
>                                    arg1, arg2, arg3,
>                                    arg4, arg5, arg6);
>              } else {
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..cc76ac61ba 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12594,14 +12594,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>  
>      if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
> -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
>      }
>  
>      ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>                        arg5, arg6, arg7, arg8);
>  
>      if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
> -        print_syscall_ret(num, ret, arg1, arg2, arg3, arg4, arg5, arg6);
> +        print_syscall_ret(cpu_env, num, ret, arg1, arg2,
> +                          arg3, arg4, arg5, arg6);
>      }
>  
>      record_syscall_return(cpu, num, ret);
> 


Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent



Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE63520729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE63520729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hTD-0001G8-TJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k7goZ-0007Nt-5Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:12:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k7goV-00038M-ST
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:12:46 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mj831-1kdhmU21ht-00fCj8; Mon, 17 Aug 2020 17:12:39 +0200
To: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>, qemu-devel@nongnu.org
References: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] fixed proc myself (linux user) for musl
Message-ID: <71bcfa69-0423-0388-354d-ef35b204d28b@vivier.eu>
Date: Mon, 17 Aug 2020 17:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:prkG4iKhjBBC2a0BZ745dLbvj/U/TYV7YOwQSbBiWI3m8JNJJrQ
 eL/Ya7OKR4BLuGyF6wslPGdYn5OE0/fwL1wUAEo79DfReEIRhaXH7O3jn5E5eV7xb0MZ+xi
 0Bnp+jEuC6Hh+sq5X6TS4ReM4jgtrfz/fSikEiFpZPq2DyZvz0pf74uuOF/fnwaL4AHz2yS
 h+bcMdFaJJEXaD8TRUl2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KuQ/lNND4Xs=:XIV/epmqq2ToktVuY5U5a0
 G7XEuX00+caxWZ2AE1lAUT8oA7O39TfYz4maGFksZGTsUIfqFvau2inntMhgHidCIYFCdGARr
 C3f3zO/9QcxHLLSiRn2YJCAUVit+jOA6rAAel3n3UaHfmKQhHGV1WtPpRjcJc329J6sLD8JKI
 XgZpAnh4JFDsA4DDrQBqg/kWZh2Z1UbmNgxhDGYG7yCcelFB0zVD66FOEKkGhnyAc+ZhrVxDZ
 w9PNSJeX8vIueHU0aRJkqaUofvlsihSqw6yaptfMqo2LbbZJBJHeYYTqvfiI9s7uId2xXngQD
 L/HzUk+a0H52zBPHG2TsyySiwwRq2q/RsLuGJ7OEuPvWGlkHewet7JCTTUfk53Avqed8fMPXX
 0ViS+awX414XuIMPv8Pn7L8+xnmpsLgCkkvbJPiZHOhch8MdkUx7O75HiLSK6FqAWRPEFQ39m
 OqwynX2lk084UEBTow9TiOXB0COLYFe4sktpzCV1OXX4KZb2YF9NJ4YS4E9h03iDWx6YBmSSJ
 KJWdejW2FMitlkSRTkSx19GWnvKGNYi4Ms91NP6pv8aevCiIbRNg/toZiEQmpOuGMC6eeTmUr
 SNS2LG64Nab6NoqU/GLKm83XlGtlVu+TFn5toUkd6fCS4lxDoQNXnWK4Q4/kL1YvQSsQeVDSL
 hb6gHnMlvtLKHps5Ay5dmEQJV+66MEcsJXhe+p7CqUuvjmPPlPjqEI/dGQOl2DJHmO58vHixG
 +0hrYcDzZNBlAcxBfIJzlRi7y3c3q0H0JhtrHeGBLHbV0EYAR2mEueepu6YvtNJb5QIXWUXRM
 DkmjhP6XbihGoU8YGgqAjriws/y+W/6HkF4qmMfNXVsm7I+pWAsGtGW2yG1/e+T40cWPJFT
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 11:12:40
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

Hi,

it seems your patch does several things.

Could you split it into several patches?
Could you add a description of what the patches do?
Could you use a tool like "git send-email" or "git publish" to send your
series?

For the patch moving code from syscall.c to syscall_proc.c, write a
patch that moves the code without modifying it. And then you can follow
with a patch fixing what you want.

Thanks,
Laurent

Le 16/08/2020 à 21:58, Андрей Аладьев a écrit :
> From: Andrew Aladjev <aladjev.andrew@gmail.com
> <mailto:aladjev.andrew@gmail.com>>
> Date: Sun, 16 Aug 2020 22:50:13 +0300
> Subject: [PATCH] fixed proc myself (linux user) for musl
> Buglink: https://bugs.gentoo.org/587230
> Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com
> <mailto:aladjev.andrew@gmail.com>>
> ---
>  linux-user/Makefile.objs  |  5 +-
>  linux-user/elfload.c      |  7 ++-
>  linux-user/exit.c         |  7 ++-
>  linux-user/main.c         |  2 +-
>  linux-user/qemu.h         |  1 +
>  linux-user/syscall.c      | 85 +++++++++++++---------------------
>  linux-user/syscall_proc.c | 96 +++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_proc.h |  8 ++++
>  8 files changed, 150 insertions(+), 61 deletions(-)
>  create mode 100644 linux-user/syscall_proc.c
>  create mode 100644 linux-user/syscall_proc.h
> 
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 1940910a73..ad84380738 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -1,7 +1,8 @@
>  obj-y = main.o syscall.o strace.o mmap.o signal.o \
>   elfload.o linuxload.o uaccess.o uname.o \
> - safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> -        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
> + safe-syscall.o syscall_proc.o \
> + $(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
> + exit.o fd-trans.o
>  
>  obj-$(TARGET_HAS_BFLT) += flatload.o
>  obj-$(TARGET_I386) += vm86.o
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 619c054cc4..201db61d91 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2319,7 +2319,10 @@ exit_errmsg:
>     buffer is sufficiently aligned to present no problems to the host
>     in accessing data at aligned offsets within the buffer.
>  
> -   On return: INFO values will be filled in, as necessary or available.  */
> +   On return: INFO values will be filled in, as necessary or available.
> +
> +   WARNING: this function won't close "image_fd".
> +*/
>  
>  static void load_elf_image(const char *image_name, int image_fd,
>                             struct image_info *info, char **pinterp_name,
> @@ -2576,7 +2579,6 @@ static void load_elf_image(const char *image_name,
> int image_fd,
>  
>      mmap_unlock();
>  
> -    close(image_fd);
>      return;
>  
>   exit_read:
> @@ -2610,6 +2612,7 @@ static void load_elf_interp(const char *filename,
> struct image_info *info,
>      }
>  
>      load_elf_image(filename, fd, info, NULL, bprm_buf);
> +    close(fd);
>      return;
>  
>   exit_perror:
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index 1594015444..f0626fc432 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -28,12 +28,15 @@ extern void __gcov_dump(void);
>  
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
> +    close(execfd);
> +
>  #ifdef CONFIG_GPROF
>          _mcleanup();
>  #endif
>  #ifdef CONFIG_GCOV
>          __gcov_dump();
>  #endif
> -        gdb_exit(env, code);
> -        qemu_plugin_atexit_cb();
> +
> +    gdb_exit(env, code);
> +    qemu_plugin_atexit_cb();
>  }
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 22578b1633..9cc6c1e6da 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -48,6 +48,7 @@
>  #include "crypto/init.h"
>  
>  char *exec_path;
> +int execfd;
>  
>  int singlestep;
>  static const char *argv0;
> @@ -628,7 +629,6 @@ int main(int argc, char **argv, char **envp)
>      int target_argc;
>      int i;
>      int ret;
> -    int execfd;
>      int log_mask;
>      unsigned long max_reserved_va;
>  
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 792c74290f..d822f2b9df 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -156,6 +156,7 @@ typedef struct TaskState {
>  } __attribute__((aligned(16))) TaskState;
>  
>  extern char *exec_path;
> +extern int execfd;
>  void init_task_state(TaskState *ts);
>  void task_settid(TaskState *);
>  void stop_all_tasks(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..483a735c1a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -122,6 +122,7 @@
>  #include "qapi/error.h"
>  #include "fd-trans.h"
>  #include "tcg/tcg.h"
> +#include "syscall_proc.h"
>  
>  #ifndef CLONE_IO
>  #define CLONE_IO                0x80000000      /* Clone io context */
> @@ -1104,7 +1105,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong
> target_rlim)
>  {
>      abi_ulong target_rlim_swap;
>      rlim_t result;
> -    
> +
>      target_rlim_swap = tswapal(target_rlim);
>      if (target_rlim_swap == TARGET_RLIM_INFINITY)
>          return RLIM_INFINITY;
> @@ -1112,7 +1113,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong
> target_rlim)
>      result = target_rlim_swap;
>      if (target_rlim_swap != (rlim_t)result)
>          return RLIM_INFINITY;
> -    
> +
>      return result;
>  }
>  #endif
> @@ -1122,13 +1123,13 @@ static inline abi_ulong
> host_to_target_rlim(rlim_t rlim)
>  {
>      abi_ulong target_rlim_swap;
>      abi_ulong result;
> -    
> +
>      if (rlim == RLIM_INFINITY || rlim != (abi_long)rlim)
>          target_rlim_swap = TARGET_RLIM_INFINITY;
>      else
>          target_rlim_swap = rlim;
>      result = tswapal(target_rlim_swap);
> -    
> +
>      return result;
>  }
>  #endif
> @@ -1615,9 +1616,9 @@ static inline abi_long target_to_host_cmsg(struct
> msghdr *msgh,
>      abi_ulong target_cmsg_addr;
>      struct target_cmsghdr *target_cmsg, *target_cmsg_start;
>      socklen_t space = 0;
> -    
> +
>      msg_controllen = tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))
> +    if (msg_controllen < sizeof (struct target_cmsghdr))
>          goto the_end;
>      target_cmsg_addr = tswapal(target_msgh->msg_control);
>      target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr,
> msg_controllen, 1);
> @@ -1703,7 +1704,7 @@ static inline abi_long host_to_target_cmsg(struct
> target_msghdr *target_msgh,
>      socklen_t space = 0;
>  
>      msg_controllen = tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))
> +    if (msg_controllen < sizeof (struct target_cmsghdr))
>          goto the_end;
>      target_cmsg_addr = tswapal(target_msgh->msg_control);
>      target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr,
> msg_controllen, 0);
> @@ -5750,7 +5751,7 @@ abi_long do_set_thread_area(CPUX86State *env,
> abi_ulong ptr)
>      }
>      unlock_user_struct(target_ldt_info, ptr, 1);
>  
> -    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
> +    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
>          ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
>             return -TARGET_EINVAL;
>      seg_32bit = ldt_info.flags & 1;
> @@ -5828,7 +5829,7 @@ static abi_long do_get_thread_area(CPUX86State
> *env, abi_ulong ptr)
>      lp = (uint32_t *)(gdt_table + idx);
>      entry_1 = tswap32(lp[0]);
>      entry_2 = tswap32(lp[1]);
> -    
> +
>      read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
>      contents = (entry_2 >> 10) & 3;
>      seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
> @@ -5844,8 +5845,8 @@ static abi_long do_get_thread_area(CPUX86State
> *env, abi_ulong ptr)
>          (read_exec_only << 3) | (limit_in_pages << 4) |
>          (seg_not_present << 5) | (useable << 6) | (lm << 7);
>      limit = (entry_1 & 0xffff) | (entry_2  & 0xf0000);
> -    base_addr = (entry_1 >> 16) |
> -        (entry_2 & 0xff000000) |
> +    base_addr = (entry_1 >> 16) |
> +        (entry_2 & 0xff000000) |
>          ((entry_2 & 0xff) << 16);
>      target_ldt_info->base_addr = tswapal(base_addr);
>      target_ldt_info->limit = tswap32(limit);
> @@ -7353,38 +7354,6 @@ static int open_self_auxv(void *cpu_env, int fd)
>      return 0;
>  }
>  
> -static int is_proc_myself(const char *filename, const char *entry)
> -{
> -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> -        filename += strlen("/proc/");
> -        if (!strncmp(filename, "self/", strlen("self/"))) {
> -            filename += strlen("self/");
> -        } else if (*filename >= '1' && *filename <= '9') {
> -            char myself[80];
> -            snprintf(myself, sizeof(myself), "%d/", getpid());
> -            if (!strncmp(filename, myself, strlen(myself))) {
> -                filename += strlen(myself);
> -            } else {
> -                return 0;
> -            }
> -        } else {
> -            return 0;
> -        }
> -        if (!strcmp(filename, entry)) {
> -            return 1;
> -        }
> -    }
> -    return 0;
> -}
> -
> -#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
> -    defined(TARGET_SPARC) || defined(TARGET_M68K)
> -static int is_proc(const char *filename, const char *entry)
> -{
> -    return strcmp(filename, entry) == 0;
> -}
> -#endif
> -
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
>  static int open_net_route(void *cpu_env, int fd)
>  {
> @@ -7460,20 +7429,19 @@ static int do_openat(void *cpu_env, int dirfd,
> const char *pathname, int flags,
>          { "auxv", open_self_auxv, is_proc_myself },
>          { "cmdline", open_self_cmdline, is_proc_myself },
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
> -        { "/proc/net/route", open_net_route, is_proc },
> +        { "net/route", open_net_route, is_proc },
>  #endif
>  #if defined(TARGET_SPARC)
> -        { "/proc/cpuinfo", open_cpuinfo, is_proc },
> +        { "cpuinfo", open_cpuinfo, is_proc },
>  #endif
>  #if defined(TARGET_M68K)
> -        { "/proc/hardware", open_hardware, is_proc },
> +        { "hardware", open_hardware, is_proc },
>  #endif
>          { NULL, NULL, NULL }
>      };
>  
> -    if (is_proc_myself(pathname, "exe")) {
> -        int execfd = qemu_getauxval(AT_EXECFD);
> -        return execfd ? execfd : safe_openat(dirfd, exec_path, flags,
> mode);
> +    if (is_proc_myself_exe(pathname)) {
> +        return execfd;
>      }
>  
>      for (fake_open = fakes; fake_open->filename; fake_open++) {
> @@ -7728,8 +7696,17 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          return ret;
>  #endif
>      case TARGET_NR_close:
> -        fd_trans_unregister(arg1);
> -        return get_errno(close(arg1));
> +        {
> +            int fd = arg1;
> +            if (fd == execfd) {
> +                // We don't need to close execfd.
> +                // It will be closed on qemu exit.
> +                return 0;
> +            }
> +
> +            fd_trans_unregister(fd);
> +            return get_errno(close(fd));
> +        }
>  
>      case TARGET_NR_brk:
>          return do_brk(arg1);
> @@ -9031,7 +9008,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>              } else if (!arg3) {
>                  /* Short circuit this for the magic exe check. */
>                  ret = -TARGET_EINVAL;
> -            } else if (is_proc_myself((const char *)p, "exe")) {
> +            } else if (is_proc_myself_exe((const char *)p)) {
>                  char real[PATH_MAX], *temp;
>                  temp = realpath(exec_path, real);
>                  /* Return value is # of bytes that we wrote to the
> buffer. */
> @@ -9060,7 +9037,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>              p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
>              if (!p || !p2) {
>                  ret = -TARGET_EFAULT;
> -            } else if (is_proc_myself((const char *)p, "exe")) {
> +            } else if (is_proc_myself_exe((const char *)p)) {
>                  char real[PATH_MAX], *temp;
>                  temp = realpath(exec_path, real);
>                  ret = temp == NULL ? get_errno(-1) : strlen(real) ;
> @@ -10847,7 +10824,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          return get_errno(fchown(arg1, low2highuid(arg2),
> low2highgid(arg3)));
>  #if defined(TARGET_NR_fchownat)
>      case TARGET_NR_fchownat:
> -        if (!(p = lock_user_string(arg2)))
> +        if (!(p = lock_user_string(arg2)))
>              return -TARGET_EFAULT;
>          ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
>                                   low2highgid(arg4), arg5));
> diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
> new file mode 100644
> index 0000000000..e85ca99c16
> --- /dev/null
> +++ b/linux-user/syscall_proc.c
> @@ -0,0 +1,96 @@
> +#include "qemu/osdep.h"
> +#include "elf.h"
> +
> +#include "syscall_proc.h"
> +#include "qemu.h"
> +
> +#define PROC "/proc/"
> +#define SELF "self/"
> +
> +#define STARTS_WITH(path, CONSTANT) \
> +  strlen(path) >= strlen(CONSTANT) && strncmp(path, CONSTANT,
> strlen(CONSTANT)) == 0
> +
> +static inline char *scope_to_proc(const char *path)
> +{
> +    if (STARTS_WITH(path, PROC)) {
> +        return (char *)path + strlen(PROC);
> +    }
> +
> +    return NULL;
> +}
> +
> +static inline char *scope_to_proc_myself(const char *path)
> +{
> +    char *scope_path = scope_to_proc(path);
> +    if (scope_path == NULL) {
> +        return NULL;
> +    }
> +
> +    if (STARTS_WITH(scope_path, SELF)) {
> +        return scope_path + strlen(SELF);
> +    }
> +
> +    if (strlen(scope_path) >= 1 && *scope_path >= '1' && *scope_path <=
> '9') {
> +        char pid_path[80];
> +        snprintf(pid_path, sizeof(pid_path), "%d/", getpid());
> +        if (STARTS_WITH(scope_path, pid_path)) {
> +            return scope_path + strlen(pid_path);
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +int is_proc(const char *path, const char *entry)
> +{
> +    char *scope_path = scope_to_proc(path);
> +    if (scope_path == NULL) {
> +        return 0;
> +    }
> +
> +    return strcmp(scope_path, entry) == 0;
> +}
> +
> +int is_proc_myself(const char *path, const char *entry)
> +{
> +    char *scope_path = scope_to_proc_myself(path);
> +    if (scope_path == NULL) {
> +        return 0;
> +    }
> +
> +    return strcmp(scope_path, entry) == 0;
> +}
> +
> +int is_proc_myself_exe(const char *path)
> +{
> +    char *scope_path = scope_to_proc_myself(path);
> +    if (scope_path == NULL) {
> +        return 0;
> +    }
> +
> +    // Kernel creates "fd/#{number}" link after opening "exe" link.
> +    // Both "exe" and "fd/#{number}" can be used by application.
> +
> +    // Kernel can provide infinite amount of fd numbers.
> +    // Qemu is going to always return single global execfd.
> +
> +    // So we need to check "exe" and "fd/#{execfd}" only.
> +
> +    if (strcmp(scope_path, "exe") == 0) {
> +        return 1;
> +    }
> +
> +    if (STARTS_WITH(scope_path, "fd/")) {
> +        scope_path += strlen("fd/");
> +
> +        if (strlen(scope_path) >= 1 && *scope_path >= '1' &&
> *scope_path <= '9') {
> +            char execfd_path[80];
> +            snprintf(execfd_path, sizeof(execfd_path), "%d", execfd);
> +            if (strcmp(scope_path, execfd_path) == 0) {
> +                return 1;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
> new file mode 100644
> index 0000000000..f0e59c0e96
> --- /dev/null
> +++ b/linux-user/syscall_proc.h
> @@ -0,0 +1,8 @@
> +#ifndef SYSCALL_PROC_H
> +#define SYSCALL_PROC_H
> +
> +int is_proc(const char *path, const char *entry);
> +int is_proc_myself(const char *path, const char *entry);
> +int is_proc_myself_exe(const char *path);
> +
> +#endif
> -- 
> 2.26.2
> 



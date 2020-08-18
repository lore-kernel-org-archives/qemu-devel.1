Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E70C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B573207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khJMMJXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B573207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7y52-0001Iw-Ez
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7y4Q-0000t2-3d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:38:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k7y4M-0002Z4-Aa
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:38:17 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so8968856plt.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KfJUkCv/FGHSP5N4N+Up3R693N6FMf/j8IzoxNZ24Fo=;
 b=khJMMJXA0p2wsvN+vf51x8F7Q2lCQvuG/8CVpHpYlQFWJmo5nbHIamxyN7WnOiFKaM
 /EBOhA5X/vUaUyMEUzsl3h7+qp1tSx7d83cDrzDQnYHlZrk8+sKeGGA+FkE00POEPnxx
 uY0loEHE2OPclU+MwIU9KdZXNDbVVOknJs9wMOQP/xzu8Z1vnRqKAYZ1ygxUuJSN27gv
 gJOmXymFY2V7d+HmkmsBsq88WM0v0mH2TLarcuaWUlm8kt1txElXMFqlBRIcQcOW9GpN
 FhCfigfjHEA2/ma4FWDbRKI3PXLVfrAzBSMxl1wa4HAeQwHEXXoiMwY86sTb9HySCMaC
 WE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KfJUkCv/FGHSP5N4N+Up3R693N6FMf/j8IzoxNZ24Fo=;
 b=DWBZrlDpOc5X8nu5+A+o6QkYLDC7Ow4riCjmrICb8rdohyeSw1tCUd6mm8z5eQAoLP
 9FTGgXHCtfUeRbRpGNgU4r1XubVd86P7hNwC+eCB3Zi3kLiRGTf/V+PVLlu19VM2jOvY
 jMSZUbsHEut3EJtSlaztAhLBZLtaNAr90tyAK8T0/+5w+ZMumOMSTAvIXKV3+tnSgaHW
 e7pgUXkyrdRYHYqMZ2JUqscsLc6dXdbDIKCTmeNgUqXDImPlId6sYPixT7/FTq9GoZMP
 XDkJ0keCK3R7BFBPAlb8xLyQIzItN9qrlxxoDyMhA5YUSd5lPuYus+Yig9NQNVRLe9X/
 vlTg==
X-Gm-Message-State: AOAM533LGJjmPkuLlGujrq4rtYQCBuHJHSH8X+VEqCJcFvnXUz0SjbZN
 HkuNGS7AKHkN+ljU31mHS/RxZTqVnZy5DsQXLJSS+k0X
X-Google-Smtp-Source: ABdhPJzuspOZe3KcJ8K6jqhd3oFo6CgXX+mfJfrk22XTs91JCLdPzV5Ibau+GiP3reQPKrCavGNioilw9DUpdZJURPs=
X-Received: by 2002:a17:902:b616:: with SMTP id
 b22mr14259917pls.246.1597743492411; 
 Tue, 18 Aug 2020 02:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
 <71bcfa69-0423-0388-354d-ef35b204d28b@vivier.eu>
In-Reply-To: <71bcfa69-0423-0388-354d-ef35b204d28b@vivier.eu>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>
Date: Tue, 18 Aug 2020 12:38:01 +0300
Message-ID: <CAMw0sz+FY6gWz1oK6jtKC3B5iA-46T8fuqB7YG0x=bt6LOYFig@mail.gmail.com>
Subject: Re: [PATCH] fixed proc myself (linux user) for musl
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000004eb5ce05ad23a574"
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004eb5ce05ad23a574
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've sent 3 separate patches using "git send email", please review.

=D0=BF=D0=BD, 17 =D0=B0=D0=B2=D0=B3. 2020 =D0=B3. =D0=B2 18:12, Laurent Viv=
ier <laurent@vivier.eu>:

> Hi,
>
> it seems your patch does several things.
>
> Could you split it into several patches?
> Could you add a description of what the patches do?
> Could you use a tool like "git send-email" or "git publish" to send your
> series?
>
> For the patch moving code from syscall.c to syscall_proc.c, write a
> patch that moves the code without modifying it. And then you can follow
> with a patch fixing what you want.
>
> Thanks,
> Laurent
>
> Le 16/08/2020 =C3=A0 21:58, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=90=
=D0=BB=D0=B0=D0=B4=D1=8C=D0=B5=D0=B2 a =C3=A9crit :
> > From: Andrew Aladjev <aladjev.andrew@gmail.com
> > <mailto:aladjev.andrew@gmail.com>>
> > Date: Sun, 16 Aug 2020 22:50:13 +0300
> > Subject: [PATCH] fixed proc myself (linux user) for musl
> > Buglink: https://bugs.gentoo.org/587230
> > Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com
> > <mailto:aladjev.andrew@gmail.com>>
> > ---
> >  linux-user/Makefile.objs  |  5 +-
> >  linux-user/elfload.c      |  7 ++-
> >  linux-user/exit.c         |  7 ++-
> >  linux-user/main.c         |  2 +-
> >  linux-user/qemu.h         |  1 +
> >  linux-user/syscall.c      | 85 +++++++++++++---------------------
> >  linux-user/syscall_proc.c | 96 +++++++++++++++++++++++++++++++++++++++
> >  linux-user/syscall_proc.h |  8 ++++
> >  8 files changed, 150 insertions(+), 61 deletions(-)
> >  create mode 100644 linux-user/syscall_proc.c
> >  create mode 100644 linux-user/syscall_proc.h
> >
> > diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> > index 1940910a73..ad84380738 100644
> > --- a/linux-user/Makefile.objs
> > +++ b/linux-user/Makefile.objs
> > @@ -1,7 +1,8 @@
> >  obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
> >   elfload.o linuxload.o uaccess.o uname.o \
> > - safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> > -        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
> > + safe-syscall.o syscall_proc.o \
> > + $(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
> > + exit.o fd-trans.o
> >
> >  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
> >  obj-$(TARGET_I386) +=3D vm86.o
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index 619c054cc4..201db61d91 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -2319,7 +2319,10 @@ exit_errmsg:
> >     buffer is sufficiently aligned to present no problems to the host
> >     in accessing data at aligned offsets within the buffer.
> >
> > -   On return: INFO values will be filled in, as necessary or available=
.
>  */
> > +   On return: INFO values will be filled in, as necessary or available=
.
> > +
> > +   WARNING: this function won't close "image_fd".
> > +*/
> >
> >  static void load_elf_image(const char *image_name, int image_fd,
> >                             struct image_info *info, char **pinterp_nam=
e,
> > @@ -2576,7 +2579,6 @@ static void load_elf_image(const char *image_name=
,
> > int image_fd,
> >
> >      mmap_unlock();
> >
> > -    close(image_fd);
> >      return;
> >
> >   exit_read:
> > @@ -2610,6 +2612,7 @@ static void load_elf_interp(const char *filename,
> > struct image_info *info,
> >      }
> >
> >      load_elf_image(filename, fd, info, NULL, bprm_buf);
> > +    close(fd);
> >      return;
> >
> >   exit_perror:
> > diff --git a/linux-user/exit.c b/linux-user/exit.c
> > index 1594015444..f0626fc432 100644
> > --- a/linux-user/exit.c
> > +++ b/linux-user/exit.c
> > @@ -28,12 +28,15 @@ extern void __gcov_dump(void);
> >
> >  void preexit_cleanup(CPUArchState *env, int code)
> >  {
> > +    close(execfd);
> > +
> >  #ifdef CONFIG_GPROF
> >          _mcleanup();
> >  #endif
> >  #ifdef CONFIG_GCOV
> >          __gcov_dump();
> >  #endif
> > -        gdb_exit(env, code);
> > -        qemu_plugin_atexit_cb();
> > +
> > +    gdb_exit(env, code);
> > +    qemu_plugin_atexit_cb();
> >  }
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 22578b1633..9cc6c1e6da 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -48,6 +48,7 @@
> >  #include "crypto/init.h"
> >
> >  char *exec_path;
> > +int execfd;
> >
> >  int singlestep;
> >  static const char *argv0;
> > @@ -628,7 +629,6 @@ int main(int argc, char **argv, char **envp)
> >      int target_argc;
> >      int i;
> >      int ret;
> > -    int execfd;
> >      int log_mask;
> >      unsigned long max_reserved_va;
> >
> > diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> > index 792c74290f..d822f2b9df 100644
> > --- a/linux-user/qemu.h
> > +++ b/linux-user/qemu.h
> > @@ -156,6 +156,7 @@ typedef struct TaskState {
> >  } __attribute__((aligned(16))) TaskState;
> >
> >  extern char *exec_path;
> > +extern int execfd;
> >  void init_task_state(TaskState *ts);
> >  void task_settid(TaskState *);
> >  void stop_all_tasks(void);
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 05f03919ff..483a735c1a 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -122,6 +122,7 @@
> >  #include "qapi/error.h"
> >  #include "fd-trans.h"
> >  #include "tcg/tcg.h"
> > +#include "syscall_proc.h"
> >
> >  #ifndef CLONE_IO
> >  #define CLONE_IO                0x80000000      /* Clone io context */
> > @@ -1104,7 +1105,7 @@ static inline rlim_t target_to_host_rlim(abi_ulon=
g
> > target_rlim)
> >  {
> >      abi_ulong target_rlim_swap;
> >      rlim_t result;
> > -
> > +
> >      target_rlim_swap =3D tswapal(target_rlim);
> >      if (target_rlim_swap =3D=3D TARGET_RLIM_INFINITY)
> >          return RLIM_INFINITY;
> > @@ -1112,7 +1113,7 @@ static inline rlim_t target_to_host_rlim(abi_ulon=
g
> > target_rlim)
> >      result =3D target_rlim_swap;
> >      if (target_rlim_swap !=3D (rlim_t)result)
> >          return RLIM_INFINITY;
> > -
> > +
> >      return result;
> >  }
> >  #endif
> > @@ -1122,13 +1123,13 @@ static inline abi_ulong
> > host_to_target_rlim(rlim_t rlim)
> >  {
> >      abi_ulong target_rlim_swap;
> >      abi_ulong result;
> > -
> > +
> >      if (rlim =3D=3D RLIM_INFINITY || rlim !=3D (abi_long)rlim)
> >          target_rlim_swap =3D TARGET_RLIM_INFINITY;
> >      else
> >          target_rlim_swap =3D rlim;
> >      result =3D tswapal(target_rlim_swap);
> > -
> > +
> >      return result;
> >  }
> >  #endif
> > @@ -1615,9 +1616,9 @@ static inline abi_long target_to_host_cmsg(struct
> > msghdr *msgh,
> >      abi_ulong target_cmsg_addr;
> >      struct target_cmsghdr *target_cmsg, *target_cmsg_start;
> >      socklen_t space =3D 0;
> > -
> > +
> >      msg_controllen =3D tswapal(target_msgh->msg_controllen);
> > -    if (msg_controllen < sizeof (struct target_cmsghdr))
> > +    if (msg_controllen < sizeof (struct target_cmsghdr))
> >          goto the_end;
> >      target_cmsg_addr =3D tswapal(target_msgh->msg_control);
> >      target_cmsg =3D lock_user(VERIFY_READ, target_cmsg_addr,
> > msg_controllen, 1);
> > @@ -1703,7 +1704,7 @@ static inline abi_long host_to_target_cmsg(struct
> > target_msghdr *target_msgh,
> >      socklen_t space =3D 0;
> >
> >      msg_controllen =3D tswapal(target_msgh->msg_controllen);
> > -    if (msg_controllen < sizeof (struct target_cmsghdr))
> > +    if (msg_controllen < sizeof (struct target_cmsghdr))
> >          goto the_end;
> >      target_cmsg_addr =3D tswapal(target_msgh->msg_control);
> >      target_cmsg =3D lock_user(VERIFY_WRITE, target_cmsg_addr,
> > msg_controllen, 0);
> > @@ -5750,7 +5751,7 @@ abi_long do_set_thread_area(CPUX86State *env,
> > abi_ulong ptr)
> >      }
> >      unlock_user_struct(target_ldt_info, ptr, 1);
> >
> > -    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
> > +    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
> >          ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
> >             return -TARGET_EINVAL;
> >      seg_32bit =3D ldt_info.flags & 1;
> > @@ -5828,7 +5829,7 @@ static abi_long do_get_thread_area(CPUX86State
> > *env, abi_ulong ptr)
> >      lp =3D (uint32_t *)(gdt_table + idx);
> >      entry_1 =3D tswap32(lp[0]);
> >      entry_2 =3D tswap32(lp[1]);
> > -
> > +
> >      read_exec_only =3D ((entry_2 >> 9) & 1) ^ 1;
> >      contents =3D (entry_2 >> 10) & 3;
> >      seg_not_present =3D ((entry_2 >> 15) & 1) ^ 1;
> > @@ -5844,8 +5845,8 @@ static abi_long do_get_thread_area(CPUX86State
> > *env, abi_ulong ptr)
> >          (read_exec_only << 3) | (limit_in_pages << 4) |
> >          (seg_not_present << 5) | (useable << 6) | (lm << 7);
> >      limit =3D (entry_1 & 0xffff) | (entry_2  & 0xf0000);
> > -    base_addr =3D (entry_1 >> 16) |
> > -        (entry_2 & 0xff000000) |
> > +    base_addr =3D (entry_1 >> 16) |
> > +        (entry_2 & 0xff000000) |
> >          ((entry_2 & 0xff) << 16);
> >      target_ldt_info->base_addr =3D tswapal(base_addr);
> >      target_ldt_info->limit =3D tswap32(limit);
> > @@ -7353,38 +7354,6 @@ static int open_self_auxv(void *cpu_env, int fd)
> >      return 0;
> >  }
> >
> > -static int is_proc_myself(const char *filename, const char *entry)
> > -{
> > -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> > -        filename +=3D strlen("/proc/");
> > -        if (!strncmp(filename, "self/", strlen("self/"))) {
> > -            filename +=3D strlen("self/");
> > -        } else if (*filename >=3D '1' && *filename <=3D '9') {
> > -            char myself[80];
> > -            snprintf(myself, sizeof(myself), "%d/", getpid());
> > -            if (!strncmp(filename, myself, strlen(myself))) {
> > -                filename +=3D strlen(myself);
> > -            } else {
> > -                return 0;
> > -            }
> > -        } else {
> > -            return 0;
> > -        }
> > -        if (!strcmp(filename, entry)) {
> > -            return 1;
> > -        }
> > -    }
> > -    return 0;
> > -}
> > -
> > -#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)=
 ||
> \
> > -    defined(TARGET_SPARC) || defined(TARGET_M68K)
> > -static int is_proc(const char *filename, const char *entry)
> > -{
> > -    return strcmp(filename, entry) =3D=3D 0;
> > -}
> > -#endif
> > -
> >  #if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)
> >  static int open_net_route(void *cpu_env, int fd)
> >  {
> > @@ -7460,20 +7429,19 @@ static int do_openat(void *cpu_env, int dirfd,
> > const char *pathname, int flags,
> >          { "auxv", open_self_auxv, is_proc_myself },
> >          { "cmdline", open_self_cmdline, is_proc_myself },
> >  #if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN)
> > -        { "/proc/net/route", open_net_route, is_proc },
> > +        { "net/route", open_net_route, is_proc },
> >  #endif
> >  #if defined(TARGET_SPARC)
> > -        { "/proc/cpuinfo", open_cpuinfo, is_proc },
> > +        { "cpuinfo", open_cpuinfo, is_proc },
> >  #endif
> >  #if defined(TARGET_M68K)
> > -        { "/proc/hardware", open_hardware, is_proc },
> > +        { "hardware", open_hardware, is_proc },
> >  #endif
> >          { NULL, NULL, NULL }
> >      };
> >
> > -    if (is_proc_myself(pathname, "exe")) {
> > -        int execfd =3D qemu_getauxval(AT_EXECFD);
> > -        return execfd ? execfd : safe_openat(dirfd, exec_path, flags,
> > mode);
> > +    if (is_proc_myself_exe(pathname)) {
> > +        return execfd;
> >      }
> >
> >      for (fake_open =3D fakes; fake_open->filename; fake_open++) {
> > @@ -7728,8 +7696,17 @@ static abi_long do_syscall1(void *cpu_env, int
> > num, abi_long arg1,
> >          return ret;
> >  #endif
> >      case TARGET_NR_close:
> > -        fd_trans_unregister(arg1);
> > -        return get_errno(close(arg1));
> > +        {
> > +            int fd =3D arg1;
> > +            if (fd =3D=3D execfd) {
> > +                // We don't need to close execfd.
> > +                // It will be closed on qemu exit.
> > +                return 0;
> > +            }
> > +
> > +            fd_trans_unregister(fd);
> > +            return get_errno(close(fd));
> > +        }
> >
> >      case TARGET_NR_brk:
> >          return do_brk(arg1);
> > @@ -9031,7 +9008,7 @@ static abi_long do_syscall1(void *cpu_env, int
> > num, abi_long arg1,
> >              } else if (!arg3) {
> >                  /* Short circuit this for the magic exe check. */
> >                  ret =3D -TARGET_EINVAL;
> > -            } else if (is_proc_myself((const char *)p, "exe")) {
> > +            } else if (is_proc_myself_exe((const char *)p)) {
> >                  char real[PATH_MAX], *temp;
> >                  temp =3D realpath(exec_path, real);
> >                  /* Return value is # of bytes that we wrote to the
> > buffer. */
> > @@ -9060,7 +9037,7 @@ static abi_long do_syscall1(void *cpu_env, int
> > num, abi_long arg1,
> >              p2 =3D lock_user(VERIFY_WRITE, arg3, arg4, 0);
> >              if (!p || !p2) {
> >                  ret =3D -TARGET_EFAULT;
> > -            } else if (is_proc_myself((const char *)p, "exe")) {
> > +            } else if (is_proc_myself_exe((const char *)p)) {
> >                  char real[PATH_MAX], *temp;
> >                  temp =3D realpath(exec_path, real);
> >                  ret =3D temp =3D=3D NULL ? get_errno(-1) : strlen(real=
) ;
> > @@ -10847,7 +10824,7 @@ static abi_long do_syscall1(void *cpu_env, int
> > num, abi_long arg1,
> >          return get_errno(fchown(arg1, low2highuid(arg2),
> > low2highgid(arg3)));
> >  #if defined(TARGET_NR_fchownat)
> >      case TARGET_NR_fchownat:
> > -        if (!(p =3D lock_user_string(arg2)))
> > +        if (!(p =3D lock_user_string(arg2)))
> >              return -TARGET_EFAULT;
> >          ret =3D get_errno(fchownat(arg1, p, low2highuid(arg3),
> >                                   low2highgid(arg4), arg5));
> > diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
> > new file mode 100644
> > index 0000000000..e85ca99c16
> > --- /dev/null
> > +++ b/linux-user/syscall_proc.c
> > @@ -0,0 +1,96 @@
> > +#include "qemu/osdep.h"
> > +#include "elf.h"
> > +
> > +#include "syscall_proc.h"
> > +#include "qemu.h"
> > +
> > +#define PROC "/proc/"
> > +#define SELF "self/"
> > +
> > +#define STARTS_WITH(path, CONSTANT) \
> > +  strlen(path) >=3D strlen(CONSTANT) && strncmp(path, CONSTANT,
> > strlen(CONSTANT)) =3D=3D 0
> > +
> > +static inline char *scope_to_proc(const char *path)
> > +{
> > +    if (STARTS_WITH(path, PROC)) {
> > +        return (char *)path + strlen(PROC);
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static inline char *scope_to_proc_myself(const char *path)
> > +{
> > +    char *scope_path =3D scope_to_proc(path);
> > +    if (scope_path =3D=3D NULL) {
> > +        return NULL;
> > +    }
> > +
> > +    if (STARTS_WITH(scope_path, SELF)) {
> > +        return scope_path + strlen(SELF);
> > +    }
> > +
> > +    if (strlen(scope_path) >=3D 1 && *scope_path >=3D '1' && *scope_pa=
th <=3D
> > '9') {
> > +        char pid_path[80];
> > +        snprintf(pid_path, sizeof(pid_path), "%d/", getpid());
> > +        if (STARTS_WITH(scope_path, pid_path)) {
> > +            return scope_path + strlen(pid_path);
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +int is_proc(const char *path, const char *entry)
> > +{
> > +    char *scope_path =3D scope_to_proc(path);
> > +    if (scope_path =3D=3D NULL) {
> > +        return 0;
> > +    }
> > +
> > +    return strcmp(scope_path, entry) =3D=3D 0;
> > +}
> > +
> > +int is_proc_myself(const char *path, const char *entry)
> > +{
> > +    char *scope_path =3D scope_to_proc_myself(path);
> > +    if (scope_path =3D=3D NULL) {
> > +        return 0;
> > +    }
> > +
> > +    return strcmp(scope_path, entry) =3D=3D 0;
> > +}
> > +
> > +int is_proc_myself_exe(const char *path)
> > +{
> > +    char *scope_path =3D scope_to_proc_myself(path);
> > +    if (scope_path =3D=3D NULL) {
> > +        return 0;
> > +    }
> > +
> > +    // Kernel creates "fd/#{number}" link after opening "exe" link.
> > +    // Both "exe" and "fd/#{number}" can be used by application.
> > +
> > +    // Kernel can provide infinite amount of fd numbers.
> > +    // Qemu is going to always return single global execfd.
> > +
> > +    // So we need to check "exe" and "fd/#{execfd}" only.
> > +
> > +    if (strcmp(scope_path, "exe") =3D=3D 0) {
> > +        return 1;
> > +    }
> > +
> > +    if (STARTS_WITH(scope_path, "fd/")) {
> > +        scope_path +=3D strlen("fd/");
> > +
> > +        if (strlen(scope_path) >=3D 1 && *scope_path >=3D '1' &&
> > *scope_path <=3D '9') {
> > +            char execfd_path[80];
> > +            snprintf(execfd_path, sizeof(execfd_path), "%d", execfd);
> > +            if (strcmp(scope_path, execfd_path) =3D=3D 0) {
> > +                return 1;
> > +            }
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
> > new file mode 100644
> > index 0000000000..f0e59c0e96
> > --- /dev/null
> > +++ b/linux-user/syscall_proc.h
> > @@ -0,0 +1,8 @@
> > +#ifndef SYSCALL_PROC_H
> > +#define SYSCALL_PROC_H
> > +
> > +int is_proc(const char *path, const char *entry);
> > +int is_proc_myself(const char *path, const char *entry);
> > +int is_proc_myself_exe(const char *path);
> > +
> > +#endif
> > --
> > 2.26.2
> >
>
>

--0000000000004eb5ce05ad23a574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve=C2=A0sent 3 separate patches using &quot;git send=
 email&quot;, please review.<br></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 17 =D0=B0=D0=B2=D0=B3. 2020 =
=D0=B3. =D0=B2 18:12, Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.e=
u">laurent@vivier.eu</a>&gt;:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi,<br>
<br>
it seems your patch does several things.<br>
<br>
Could you split it into several patches?<br>
Could you add a description of what the patches do?<br>
Could you use a tool like &quot;git send-email&quot; or &quot;git publish&q=
uot; to send your<br>
series?<br>
<br>
For the patch moving code from syscall.c to syscall_proc.c, write a<br>
patch that moves the code without modifying it. And then you can follow<br>
with a patch fixing what you want.<br>
<br>
Thanks,<br>
Laurent<br>
<br>
Le 16/08/2020 =C3=A0 21:58, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=90=D0=
=BB=D0=B0=D0=B4=D1=8C=D0=B5=D0=B2 a =C3=A9crit=C2=A0:<br>
&gt; From: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@gmail.com" t=
arget=3D"_blank">aladjev.andrew@gmail.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:aladjev.andrew@gmail.com" target=3D"_blan=
k">aladjev.andrew@gmail.com</a>&gt;&gt;<br>
&gt; Date: Sun, 16 Aug 2020 22:50:13 +0300<br>
&gt; Subject: [PATCH] fixed proc myself (linux user) for musl<br>
&gt; Buglink: <a href=3D"https://bugs.gentoo.org/587230" rel=3D"noreferrer"=
 target=3D"_blank">https://bugs.gentoo.org/587230</a><br>
&gt; Signed-off-by: Andrew Aladjev &lt;<a href=3D"mailto:aladjev.andrew@gma=
il.com" target=3D"_blank">aladjev.andrew@gmail.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:aladjev.andrew@gmail.com" target=3D"_blan=
k">aladjev.andrew@gmail.com</a>&gt;&gt;<br>
&gt; ---<br>
&gt; =C2=A0linux-user/Makefile.objs =C2=A0| =C2=A05 +-<br>
&gt; =C2=A0linux-user/elfload.c =C2=A0 =C2=A0 =C2=A0| =C2=A07 ++-<br>
&gt; =C2=A0linux-user/exit.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A07 ++-<br>
&gt; =C2=A0linux-user/main.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A02 +-<br>
&gt; =C2=A0linux-user/qemu.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 +<br>
&gt; =C2=A0linux-user/syscall.c =C2=A0 =C2=A0 =C2=A0| 85 +++++++++++++-----=
----------------<br>
&gt; =C2=A0linux-user/syscall_proc.c | 96 +++++++++++++++++++++++++++++++++=
++++++<br>
&gt; =C2=A0linux-user/syscall_proc.h | =C2=A08 ++++<br>
&gt; =C2=A08 files changed, 150 insertions(+), 61 deletions(-)<br>
&gt; =C2=A0create mode 100644 linux-user/syscall_proc.c<br>
&gt; =C2=A0create mode 100644 linux-user/syscall_proc.h<br>
&gt; <br>
&gt; diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs<br>
&gt; index 1940910a73..ad84380738 100644<br>
&gt; --- a/linux-user/Makefile.objs<br>
&gt; +++ b/linux-user/Makefile.objs<br>
&gt; @@ -1,7 +1,8 @@<br>
&gt; =C2=A0obj-y =3D main.o syscall.o strace.o mmap.o signal.o \<br>
&gt; =C2=A0 elfload.o linuxload.o uaccess.o uname.o \<br>
&gt; - safe-syscall.o $(TARGET_ABI_DIR)/signal.o \<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0$(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-tr=
ans.o<br>
&gt; + safe-syscall.o syscall_proc.o \<br>
&gt; + $(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \<br>
&gt; + exit.o fd-trans.o<br>
&gt; =C2=A0<br>
&gt; =C2=A0obj-$(TARGET_HAS_BFLT) +=3D flatload.o<br>
&gt; =C2=A0obj-$(TARGET_I386) +=3D vm86.o<br>
&gt; diff --git a/linux-user/elfload.c b/linux-user/elfload.c<br>
&gt; index 619c054cc4..201db61d91 100644<br>
&gt; --- a/linux-user/elfload.c<br>
&gt; +++ b/linux-user/elfload.c<br>
&gt; @@ -2319,7 +2319,10 @@ exit_errmsg:<br>
&gt; =C2=A0 =C2=A0 buffer is sufficiently aligned to present no problems to=
 the host<br>
&gt; =C2=A0 =C2=A0 in accessing data at aligned offsets within the buffer.<=
br>
&gt; =C2=A0<br>
&gt; - =C2=A0 On return: INFO values will be filled in, as necessary or ava=
ilable. =C2=A0*/<br>
&gt; + =C2=A0 On return: INFO values will be filled in, as necessary or ava=
ilable.<br>
&gt; +<br>
&gt; + =C2=A0 WARNING: this function won&#39;t close &quot;image_fd&quot;.<=
br>
&gt; +*/<br>
&gt; =C2=A0<br>
&gt; =C2=A0static void load_elf_image(const char *image_name, int image_fd,=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct image_info *info, char **pinterp_name,<b=
r>
&gt; @@ -2576,7 +2579,6 @@ static void load_elf_image(const char *image_nam=
e,<br>
&gt; int image_fd,<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0mmap_unlock();<br>
&gt; =C2=A0<br>
&gt; - =C2=A0 =C2=A0close(image_fd);<br>
&gt; =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; =C2=A0<br>
&gt; =C2=A0 exit_read:<br>
&gt; @@ -2610,6 +2612,7 @@ static void load_elf_interp(const char *filename=
,<br>
&gt; struct image_info *info,<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0load_elf_image(filename, fd, info, NULL, bprm_buf)=
;<br>
&gt; + =C2=A0 =C2=A0close(fd);<br>
&gt; =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; =C2=A0<br>
&gt; =C2=A0 exit_perror:<br>
&gt; diff --git a/linux-user/exit.c b/linux-user/exit.c<br>
&gt; index 1594015444..f0626fc432 100644<br>
&gt; --- a/linux-user/exit.c<br>
&gt; +++ b/linux-user/exit.c<br>
&gt; @@ -28,12 +28,15 @@ extern void __gcov_dump(void);<br>
&gt; =C2=A0<br>
&gt; =C2=A0void preexit_cleanup(CPUArchState *env, int code)<br>
&gt; =C2=A0{<br>
&gt; + =C2=A0 =C2=A0close(execfd);<br>
&gt; +<br>
&gt; =C2=A0#ifdef CONFIG_GPROF<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_mcleanup();<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0#ifdef CONFIG_GCOV<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__gcov_dump();<br>
&gt; =C2=A0#endif<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_exit(env, code);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_plugin_atexit_cb();<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0gdb_exit(env, code);<br>
&gt; + =C2=A0 =C2=A0qemu_plugin_atexit_cb();<br>
&gt; =C2=A0}<br>
&gt; diff --git a/linux-user/main.c b/linux-user/main.c<br>
&gt; index 22578b1633..9cc6c1e6da 100644<br>
&gt; --- a/linux-user/main.c<br>
&gt; +++ b/linux-user/main.c<br>
&gt; @@ -48,6 +48,7 @@<br>
&gt; =C2=A0#include &quot;crypto/init.h&quot;<br>
&gt; =C2=A0<br>
&gt; =C2=A0char *exec_path;<br>
&gt; +int execfd;<br>
&gt; =C2=A0<br>
&gt; =C2=A0int singlestep;<br>
&gt; =C2=A0static const char *argv0;<br>
&gt; @@ -628,7 +629,6 @@ int main(int argc, char **argv, char **envp)<br>
&gt; =C2=A0 =C2=A0 =C2=A0int target_argc;<br>
&gt; =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; - =C2=A0 =C2=A0int execfd;<br>
&gt; =C2=A0 =C2=A0 =C2=A0int log_mask;<br>
&gt; =C2=A0 =C2=A0 =C2=A0unsigned long max_reserved_va;<br>
&gt; =C2=A0<br>
&gt; diff --git a/linux-user/qemu.h b/linux-user/qemu.h<br>
&gt; index 792c74290f..d822f2b9df 100644<br>
&gt; --- a/linux-user/qemu.h<br>
&gt; +++ b/linux-user/qemu.h<br>
&gt; @@ -156,6 +156,7 @@ typedef struct TaskState {<br>
&gt; =C2=A0} __attribute__((aligned(16))) TaskState;<br>
&gt; =C2=A0<br>
&gt; =C2=A0extern char *exec_path;<br>
&gt; +extern int execfd;<br>
&gt; =C2=A0void init_task_state(TaskState *ts);<br>
&gt; =C2=A0void task_settid(TaskState *);<br>
&gt; =C2=A0void stop_all_tasks(void);<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index 05f03919ff..483a735c1a 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -122,6 +122,7 @@<br>
&gt; =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt; =C2=A0#include &quot;fd-trans.h&quot;<br>
&gt; =C2=A0#include &quot;tcg/tcg.h&quot;<br>
&gt; +#include &quot;syscall_proc.h&quot;<br>
&gt; =C2=A0<br>
&gt; =C2=A0#ifndef CLONE_IO<br>
&gt; =C2=A0#define CLONE_IO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x80000000 =C2=A0 =C2=A0 =C2=A0/* Clone io context */<br>
&gt; @@ -1104,7 +1105,7 @@ static inline rlim_t target_to_host_rlim(abi_ulo=
ng<br>
&gt; target_rlim)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0abi_ulong target_rlim_swap;<br>
&gt; =C2=A0 =C2=A0 =C2=A0rlim_t result;<br>
&gt; - =C2=A0 =C2=A0<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0target_rlim_swap =3D tswapal(target_rlim);<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (target_rlim_swap =3D=3D TARGET_RLIM_INFINITY)<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RLIM_INFINITY;<br>
&gt; @@ -1112,7 +1113,7 @@ static inline rlim_t target_to_host_rlim(abi_ulo=
ng<br>
&gt; target_rlim)<br>
&gt; =C2=A0 =C2=A0 =C2=A0result =3D target_rlim_swap;<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (target_rlim_swap !=3D (rlim_t)result)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RLIM_INFINITY;<br>
&gt; - =C2=A0 =C2=A0<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0return result;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0#endif<br>
&gt; @@ -1122,13 +1123,13 @@ static inline abi_ulong<br>
&gt; host_to_target_rlim(rlim_t rlim)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0abi_ulong target_rlim_swap;<br>
&gt; =C2=A0 =C2=A0 =C2=A0abi_ulong result;<br>
&gt; - =C2=A0 =C2=A0<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0if (rlim =3D=3D RLIM_INFINITY || rlim !=3D (abi_lo=
ng)rlim)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_rlim_swap =3D TARGET_RLIM_INF=
INITY;<br>
&gt; =C2=A0 =C2=A0 =C2=A0else<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_rlim_swap =3D rlim;<br>
&gt; =C2=A0 =C2=A0 =C2=A0result =3D tswapal(target_rlim_swap);<br>
&gt; - =C2=A0 =C2=A0<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0return result;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0#endif<br>
&gt; @@ -1615,9 +1616,9 @@ static inline abi_long target_to_host_cmsg(struc=
t<br>
&gt; msghdr *msgh,<br>
&gt; =C2=A0 =C2=A0 =C2=A0abi_ulong target_cmsg_addr;<br>
&gt; =C2=A0 =C2=A0 =C2=A0struct target_cmsghdr *target_cmsg, *target_cmsg_s=
tart;<br>
&gt; =C2=A0 =C2=A0 =C2=A0socklen_t space =3D 0;<br>
&gt; - =C2=A0 =C2=A0<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0msg_controllen =3D tswapal(target_msgh-&gt;msg_con=
trollen);<br>
&gt; - =C2=A0 =C2=A0if (msg_controllen &lt; sizeof (struct target_cmsghdr))=
<br>
&gt; + =C2=A0 =C2=A0if (msg_controllen &lt; sizeof (struct target_cmsghdr))=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto the_end;<br>
&gt; =C2=A0 =C2=A0 =C2=A0target_cmsg_addr =3D tswapal(target_msgh-&gt;msg_c=
ontrol);<br>
&gt; =C2=A0 =C2=A0 =C2=A0target_cmsg =3D lock_user(VERIFY_READ, target_cmsg=
_addr,<br>
&gt; msg_controllen, 1);<br>
&gt; @@ -1703,7 +1704,7 @@ static inline abi_long host_to_target_cmsg(struc=
t<br>
&gt; target_msghdr *target_msgh,<br>
&gt; =C2=A0 =C2=A0 =C2=A0socklen_t space =3D 0;<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0msg_controllen =3D tswapal(target_msgh-&gt;msg_con=
trollen);<br>
&gt; - =C2=A0 =C2=A0if (msg_controllen &lt; sizeof (struct target_cmsghdr))=
<br>
&gt; + =C2=A0 =C2=A0if (msg_controllen &lt; sizeof (struct target_cmsghdr))=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto the_end;<br>
&gt; =C2=A0 =C2=A0 =C2=A0target_cmsg_addr =3D tswapal(target_msgh-&gt;msg_c=
ontrol);<br>
&gt; =C2=A0 =C2=A0 =C2=A0target_cmsg =3D lock_user(VERIFY_WRITE, target_cms=
g_addr,<br>
&gt; msg_controllen, 0);<br>
&gt; @@ -5750,7 +5751,7 @@ abi_long do_set_thread_area(CPUX86State *env,<br=
>
&gt; abi_ulong ptr)<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0unlock_user_struct(target_ldt_info, ptr, 1);<br>
&gt; =C2=A0<br>
&gt; - =C2=A0 =C2=A0if (ldt_info.entry_number &lt; TARGET_GDT_ENTRY_TLS_MIN=
 ||<br>
&gt; + =C2=A0 =C2=A0if (ldt_info.entry_number &lt; TARGET_GDT_ENTRY_TLS_MIN=
 ||<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ldt_info.entry_number &gt; TARGET_GD=
T_ENTRY_TLS_MAX)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; =C2=A0 =C2=A0 =C2=A0seg_32bit =3D ldt_info.flags &amp; 1;<br>
&gt; @@ -5828,7 +5829,7 @@ static abi_long do_get_thread_area(CPUX86State<b=
r>
&gt; *env, abi_ulong ptr)<br>
&gt; =C2=A0 =C2=A0 =C2=A0lp =3D (uint32_t *)(gdt_table + idx);<br>
&gt; =C2=A0 =C2=A0 =C2=A0entry_1 =3D tswap32(lp[0]);<br>
&gt; =C2=A0 =C2=A0 =C2=A0entry_2 =3D tswap32(lp[1]);<br>
&gt; - =C2=A0 =C2=A0<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0read_exec_only =3D ((entry_2 &gt;&gt; 9) &amp; 1) =
^ 1;<br>
&gt; =C2=A0 =C2=A0 =C2=A0contents =3D (entry_2 &gt;&gt; 10) &amp; 3;<br>
&gt; =C2=A0 =C2=A0 =C2=A0seg_not_present =3D ((entry_2 &gt;&gt; 15) &amp; 1=
) ^ 1;<br>
&gt; @@ -5844,8 +5845,8 @@ static abi_long do_get_thread_area(CPUX86State<b=
r>
&gt; *env, abi_ulong ptr)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(read_exec_only &lt;&lt; 3) | (limit=
_in_pages &lt;&lt; 4) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(seg_not_present &lt;&lt; 5) | (usea=
ble &lt;&lt; 6) | (lm &lt;&lt; 7);<br>
&gt; =C2=A0 =C2=A0 =C2=A0limit =3D (entry_1 &amp; 0xffff) | (entry_2 =C2=A0=
&amp; 0xf0000);<br>
&gt; - =C2=A0 =C2=A0base_addr =3D (entry_1 &gt;&gt; 16) |<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0(entry_2 &amp; 0xff000000) |<br>
&gt; + =C2=A0 =C2=A0base_addr =3D (entry_1 &gt;&gt; 16) |<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0(entry_2 &amp; 0xff000000) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((entry_2 &amp; 0xff) &lt;&lt; 16);<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0target_ldt_info-&gt;base_addr =3D tswapal(base_add=
r);<br>
&gt; =C2=A0 =C2=A0 =C2=A0target_ldt_info-&gt;limit =3D tswap32(limit);<br>
&gt; @@ -7353,38 +7354,6 @@ static int open_self_auxv(void *cpu_env, int fd=
)<br>
&gt; =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -static int is_proc_myself(const char *filename, const char *entry)<br=
>
&gt; -{<br>
&gt; - =C2=A0 =C2=A0if (!strncmp(filename, &quot;/proc/&quot;, strlen(&quot=
;/proc/&quot;))) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0filename +=3D strlen(&quot;/proc/&quot;);=
<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strncmp(filename, &quot;self/&quot;,=
 strlen(&quot;self/&quot;))) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename +=3D strlen(&quot;=
self/&quot;);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (*filename &gt;=3D &#39;1&#39; =
&amp;&amp; *filename &lt;=3D &#39;9&#39;) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char myself[80];<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(myself, sizeof(mys=
elf), &quot;%d/&quot;, getpid());<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strncmp(filename, myse=
lf, strlen(myself))) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename +=3D=
 strlen(myself);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(filename, entry)) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; - =C2=A0 =C2=A0}<br>
&gt; - =C2=A0 =C2=A0return 0;<br>
&gt; -}<br>
&gt; -<br>
&gt; -#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGENDIAN=
) || \<br>
&gt; - =C2=A0 =C2=A0defined(TARGET_SPARC) || defined(TARGET_M68K)<br>
&gt; -static int is_proc(const char *filename, const char *entry)<br>
&gt; -{<br>
&gt; - =C2=A0 =C2=A0return strcmp(filename, entry) =3D=3D 0;<br>
&gt; -}<br>
&gt; -#endif<br>
&gt; -<br>
&gt; =C2=A0#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGE=
NDIAN)<br>
&gt; =C2=A0static int open_net_route(void *cpu_env, int fd)<br>
&gt; =C2=A0{<br>
&gt; @@ -7460,20 +7429,19 @@ static int do_openat(void *cpu_env, int dirfd,=
<br>
&gt; const char *pathname, int flags,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;auxv&quot;, open_self_auxv, =
is_proc_myself },<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;cmdline&quot;, open_self_cmd=
line, is_proc_myself },<br>
&gt; =C2=A0#if defined(HOST_WORDS_BIGENDIAN) !=3D defined(TARGET_WORDS_BIGE=
NDIAN)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/net/route&quot;, open_net_r=
oute, is_proc },<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;net/route&quot;, open_net_route, =
is_proc },<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0#if defined(TARGET_SPARC)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/cpuinfo&quot;, open_cpuinfo=
, is_proc },<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;cpuinfo&quot;, open_cpuinfo, is_p=
roc },<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0#if defined(TARGET_M68K)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;/proc/hardware&quot;, open_hardwa=
re, is_proc },<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;hardware&quot;, open_hardware, is=
_proc },<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, NULL, NULL }<br>
&gt; =C2=A0 =C2=A0 =C2=A0};<br>
&gt; =C2=A0<br>
&gt; - =C2=A0 =C2=A0if (is_proc_myself(pathname, &quot;exe&quot;)) {<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0int execfd =3D qemu_getauxval(AT_EXECFD);=
<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0return execfd ? execfd : safe_openat(dirf=
d, exec_path, flags,<br>
&gt; mode);<br>
&gt; + =C2=A0 =C2=A0if (is_proc_myself_exe(pathname)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return execfd;<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0for (fake_open =3D fakes; fake_open-&gt;filename; =
fake_open++) {<br>
&gt; @@ -7728,8 +7696,17 @@ static abi_long do_syscall1(void *cpu_env, int<=
br>
&gt; num, abi_long arg1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; =C2=A0#endif<br>
&gt; =C2=A0 =C2=A0 =C2=A0case TARGET_NR_close:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_trans_unregister(arg1);<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_errno(close(arg1));<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd =3D arg1;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D execfd) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// We don&#39=
;t need to close execfd.<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// It will be=
 closed on qemu exit.<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_trans_unregister(fd);<br=
>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_errno(close(fd))=
;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 =C2=A0case TARGET_NR_brk:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return do_brk(arg1);<br>
&gt; @@ -9031,7 +9008,7 @@ static abi_long do_syscall1(void *cpu_env, int<b=
r>
&gt; num, abi_long arg1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!arg3) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Short=
 circuit this for the magic exe check. */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
-TARGET_EINVAL;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself((=
const char *)p, &quot;exe&quot;)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself_e=
xe((const char *)p)) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char rea=
l[PATH_MAX], *temp;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D=
 realpath(exec_path, real);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Retur=
n value is # of bytes that we wrote to the<br>
&gt; buffer. */<br>
&gt; @@ -9060,7 +9037,7 @@ static abi_long do_syscall1(void *cpu_env, int<b=
r>
&gt; num, abi_long arg1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p2 =3D lock_user(VERIF=
Y_WRITE, arg3, arg4, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!p || !p2) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
-TARGET_EFAULT;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself((=
const char *)p, &quot;exe&quot;)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (is_proc_myself_e=
xe((const char *)p)) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char rea=
l[PATH_MAX], *temp;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D=
 realpath(exec_path, real);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
temp =3D=3D NULL ? get_errno(-1) : strlen(real) ;<br>
&gt; @@ -10847,7 +10824,7 @@ static abi_long do_syscall1(void *cpu_env, int=
<br>
&gt; num, abi_long arg1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_errno(fchown(arg1, low2hi=
ghuid(arg2),<br>
&gt; low2highgid(arg3)));<br>
&gt; =C2=A0#if defined(TARGET_NR_fchownat)<br>
&gt; =C2=A0 =C2=A0 =C2=A0case TARGET_NR_fchownat:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(p =3D lock_user_string(arg2)))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(p =3D lock_user_string(arg2)))<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D get_errno(fchownat(arg1, p, =
low2highuid(arg3),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 low2highgid(arg4), arg5));=
<br>
&gt; diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..e85ca99c16<br>
&gt; --- /dev/null<br>
&gt; +++ b/linux-user/syscall_proc.c<br>
&gt; @@ -0,0 +1,96 @@<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;elf.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;syscall_proc.h&quot;<br>
&gt; +#include &quot;qemu.h&quot;<br>
&gt; +<br>
&gt; +#define PROC &quot;/proc/&quot;<br>
&gt; +#define SELF &quot;self/&quot;<br>
&gt; +<br>
&gt; +#define STARTS_WITH(path, CONSTANT) \<br>
&gt; + =C2=A0strlen(path) &gt;=3D strlen(CONSTANT) &amp;&amp; strncmp(path,=
 CONSTANT,<br>
&gt; strlen(CONSTANT)) =3D=3D 0<br>
&gt; +<br>
&gt; +static inline char *scope_to_proc(const char *path)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0if (STARTS_WITH(path, PROC)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return (char *)path + strlen(PROC);<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline char *scope_to_proc_myself(const char *path)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0char *scope_path =3D scope_to_proc(path);<br>
&gt; + =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0if (STARTS_WITH(scope_path, SELF)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return scope_path + strlen(SELF);<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0if (strlen(scope_path) &gt;=3D 1 &amp;&amp; *scope_path=
 &gt;=3D &#39;1&#39; &amp;&amp; *scope_path &lt;=3D<br>
&gt; &#39;9&#39;) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0char pid_path[80];<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(pid_path, sizeof(pid_path), &quo=
t;%d/&quot;, getpid());<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (STARTS_WITH(scope_path, pid_path)) {<=
br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return scope_path + strlen(=
pid_path);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int is_proc(const char *path, const char *entry)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0char *scope_path =3D scope_to_proc(path);<br>
&gt; + =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0return strcmp(scope_path, entry) =3D=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int is_proc_myself(const char *path, const char *entry)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0char *scope_path =3D scope_to_proc_myself(path);<br>
&gt; + =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0return strcmp(scope_path, entry) =3D=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int is_proc_myself_exe(const char *path)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0char *scope_path =3D scope_to_proc_myself(path);<br>
&gt; + =C2=A0 =C2=A0if (scope_path =3D=3D NULL) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0// Kernel creates &quot;fd/#{number}&quot; link after o=
pening &quot;exe&quot; link.<br>
&gt; + =C2=A0 =C2=A0// Both &quot;exe&quot; and &quot;fd/#{number}&quot; ca=
n be used by application.<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0// Kernel can provide infinite amount of fd numbers.<br=
>
&gt; + =C2=A0 =C2=A0// Qemu is going to always return single global execfd.=
<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0// So we need to check &quot;exe&quot; and &quot;fd/#{e=
xecfd}&quot; only.<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0if (strcmp(scope_path, &quot;exe&quot;) =3D=3D 0) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0if (STARTS_WITH(scope_path, &quot;fd/&quot;)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0scope_path +=3D strlen(&quot;fd/&quot;);<=
br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strlen(scope_path) &gt;=3D 1 &amp;&am=
p; *scope_path &gt;=3D &#39;1&#39; &amp;&amp;<br>
&gt; *scope_path &lt;=3D &#39;9&#39;) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char execfd_path[80];<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(execfd_path, sizeo=
f(execfd_path), &quot;%d&quot;, execfd);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(scope_path, exec=
fd_path) =3D=3D 0) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..f0e59c0e96<br>
&gt; --- /dev/null<br>
&gt; +++ b/linux-user/syscall_proc.h<br>
&gt; @@ -0,0 +1,8 @@<br>
&gt; +#ifndef SYSCALL_PROC_H<br>
&gt; +#define SYSCALL_PROC_H<br>
&gt; +<br>
&gt; +int is_proc(const char *path, const char *entry);<br>
&gt; +int is_proc_myself(const char *path, const char *entry);<br>
&gt; +int is_proc_myself_exe(const char *path);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; -- <br>
&gt; 2.26.2<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000004eb5ce05ad23a574--


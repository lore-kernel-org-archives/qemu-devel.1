Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC4C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 13:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B7C2073F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2umQeKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B7C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYs0k-0002pp-7G
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 08:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYrzf-0002Pu-Fb
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 08:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYrzc-0004Rf-1c
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 08:32:03 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYrzb-0004RX-Nz
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 08:31:59 -0500
Received: by mail-oi1-x242.google.com with SMTP id 128so2643389oih.4
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2019 05:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=A3T0jjVY4ySks3MBD4s863ZvRwctujX5BldjxP/rzAA=;
 b=L2umQeKrVthLtMBmIO8xfzMnX3sQ3/WcWyjfMpTzTI8evTgGuJc43KNDR/YC8TSXRs
 AMkxpVPxFZRiaw5imEP6r0+aKT5FTDj5Q7kVmgp7S4jUfLgFQT5dMDpm/OCt6hbHYQR6
 0ZeRZPdS1puQrkTDpA24tviwgS9GkY9zaFRzHpF/OYK54PeHnfJ1BIfkrBGLTUEURDBx
 LAF/MhV+FV+M3gXHGRAWa4dfvQTR+smTNQ0evOLlbj1nwj847DdYmSJuucivQXT2t31F
 ctJVeX9VD5P/1kMrKPUVDWDY+N5eBYzY5jTxVS0IODjymq7KiEcQiC1t3c2UpHmaCxim
 l6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=A3T0jjVY4ySks3MBD4s863ZvRwctujX5BldjxP/rzAA=;
 b=PMjLOX29DKfdZivsEtaZyWm9EErgCbz5s+r5OkGQmico9ry12jQbKna9IK6jhAE3gU
 VA8m0ISpODyFzgSPSidfQI5USQv1f0DGPOhA1DUagUCgMiIPhxO7tj/axFUgsCv/gcVA
 sW3WO+zTQ1D9035E9w7TuNQexCn138WYwRQ6wQRTP1qhKjPRz3Q+CloZubUudIUITXAT
 5dyk246vkAk6zTRb7bxhNTTVD4uzI0j3Vsfm8cV++PqXpu0i72ZI7REw40G2abTtmuVq
 2WD0bi8SahVahYssVGUSajiv6MsTdwFgLnJzYHAGy5O1wnTwrkw5KGrzq02l4Cpxs+S/
 TeKw==
X-Gm-Message-State: APjAAAUg1zdKaK1f9LiFRwgpaFOmVNOAOwyu6gJxChFBeckXKuLa281U
 A/xbqpNnn+pnei4ymP5LjlECnnMMO2F6yHmZVlo=
X-Google-Smtp-Source: APXvYqyledHxIRp2LYiZguETSc1Q4Szae9yyg56nKQ8CvhZm0npDwgC9kFDwIqyggKpzL89kxKGdrQAInEHQUs1P0yw=
X-Received: by 2002:aca:6287:: with SMTP id w129mr4583830oib.106.1574602318244; 
 Sun, 24 Nov 2019 05:31:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 24 Nov 2019 05:31:57
 -0800 (PST)
In-Reply-To: <e547f389-7281-4091-5bfb-a0aea265128d@gmx.de>
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
 <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
 <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
 <e547f389-7281-4091-5bfb-a0aea265128d@gmx.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 24 Nov 2019 14:31:57 +0100
Message-ID: <CAL1e-=ig8j+omFrdRGB1uf1mE8_9nJbt87=oAX3brbr34_cDMA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Helge Deller <deller@gmx.de>
Content-Type: multipart/alternative; boundary="000000000000d7705d059817abbc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d7705d059817abbc
Content-Type: text/plain; charset="UTF-8"

On Sunday, November 24, 2019, Helge Deller <deller@gmx.de> wrote:

> On 24.11.19 13:10, Aleksandar Markovic wrote:
> >
> >
> > On Sunday, November 24, 2019, Helge Deller <deller@gmx.de <mailto:
> deller@gmx.de>> wrote:
> >
> >     On 23.11.19 12:34, Aleksandar Markovic wrote:
> >     > On Thursday, November 21, 2019, Helge Deller <deller@gmx.de
> <mailto:deller@gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>>
> wrote:
> >     >
> >     >     The strace functionality in qemu-user lacks the possibility to
> trace
> >     >     which real values get returned to pointers in userspace by
> syscalls.
> >     >
> >     >     For example, the read() and getcwd() syscalls currently only
> show the
> >     >     destination address where the syscalls should put the return
> values:
> >     >     2532 read(3,0xff80038c,512) = 512
> >     >     2532 getcwd(0x18180,4096) = 9
> >     >
> >     >     With the patch below, one now can specify in
> print_syscall_late() which
> >     >     syscalls should be executed first, before they get printed.
> >     >     After adding the read() and getcwd() syscalls, we now get this
> output in
> >     >     with strace instead:
> >     >     1708 read(3,"\177ELF\1\2\1\3\0\0\0\
> 0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"...,512) = 512
> >     >     1708 getcwd("/usr/bin",4096) = 9
> >     >
> >     >     This patch adds just the framework with the respective
> implemenations for
> >     >     read() and getcwd(). If applied, more functions can be added
> easily later.
> >     >
> >     >
> >     > Great out-of-the-box idea! However, there are some things that are
> >     > not thought over yet. There is a good reason why strace happens
> >     > "early": if something crash-like happens during syscall
> translation,
> >     > we still have trace of original target syscall. In case of "late"
> >     > flavor, we don't have anything. Another potentially problematic
> >     > aspect is that end user certainly should know whether the trace was
> >     > done "early" or "late" - otherwise, there will be, for certain,
> cases
> >     > of misinterpretation / misleading / confusion of end users.
> >
> >     Thanks for the feedback - I'm shortly sending a v2 version which
> >     prints the syscall name with an open parenthesis, e.g. "read(" or
> "getcwd(",
> >     before calling the syscall. That way you can see where it
> crashed/hangs...
> >
> >
> > ... but I cannot see passed arguments (for example, whether NULL is
> passed, or somrthing that looks like a real address)...
>
> Right.
> And you won't see that in native strace either...
> If you have an idea, just let me know.
>
>
Helge, I do have an idea how to amend your proposal that should give
us, believe it or not, "best of both worlds", but let's wait few days, I
don't have any dev setup ar hand at the moment to check it in action, and
on top of that I am swamped with other unrelated tasks. In the meantime,
maybe other guys will say something too, or perhaps you would have
something new as well.

Still, by no means, I see this as a (potential) *huge* improvement of QEMU
strace. Thanks!

Yours,
Aleksandar



> Helge
>
> >
> >
> >
> >     Helge
> >
> >     >
> >     > Yours,
> >     > Aleksandar
> >     >
> >     >
> >     >
> >     >
> >     >     Signed-off-by: Helge Deller <deller@gmx.de <mailto:
> deller@gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>>
> >     >
> >     >     diff --git a/linux-user/strace.c b/linux-user/strace.c
> >     >     index de43238fa4..ff254732af 100644
> >     >     --- a/linux-user/strace.c
> >     >     +++ b/linux-user/strace.c
> >     >     @@ -61,6 +61,7 @@ UNUSED static void
> print_open_flags(abi_long, int);
> >     >      UNUSED static void print_syscall_prologue(const struct
> syscallname *);
> >     >      UNUSED static void print_syscall_epilogue(const struct
> syscallname *);
> >     >      UNUSED static void print_string(abi_long, int);
> >     >     +UNUSED static void print_encoded_string(abi_long addr,
> unsigned int maxlen, int last);
> >     >      UNUSED static void print_buf(abi_long addr, abi_long len, int
> last);
> >     >      UNUSED static void print_raw_param(const char *, abi_long,
> int);
> >     >      UNUSED static void print_timeval(abi_ulong, int);
> >     >     @@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct
> syscallname *sc)
> >     >          gemu_log(")");
> >     >      }
> >     >
> >     >     +#define MAX_ENCODED_CHARS 32
> >     >     +static void
> >     >     +print_encoded_string(abi_long addr, unsigned int maxlen, int
> last)
> >     >     +{
> >     >     +    unsigned int maxout;
> >     >     +    char *s, *str;
> >     >     +
> >     >     +    s = lock_user_string(addr);
> >     >     +    if (s == NULL) {
> >     >     +        /* can't get string out of it, so print it as pointer
> */
> >     >     +        print_pointer(addr, last);
> >     >     +        return;
> >     >     +    }
> >     >     +
> >     >     +    str = s;
> >     >     +    gemu_log("\"");
> >     >     +    maxout = MIN(maxlen, MAX_ENCODED_CHARS);
> >     >     +    while (maxout--) {
> >     >     +        unsigned char c = *str++;
> >     >     +        if (isprint(c)) {
> >     >     +            gemu_log("%c", c);
> >     >     +        } else {
> >     >     +            gemu_log("\\%o", (unsigned int) c);
> >     >     +        }
> >     >     +    }
> >     >     +    unlock_user(s, addr, 0);
> >     >     +
> >     >     +    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..." :
> "",
> >     >     +                    get_comma(last));
> >     >     +}
> >     >     +
> >     >      static void
> >     >      print_string(abi_long addr, int last)
> >     >      {
> >     >     @@ -1633,6 +1665,19 @@ print_futimesat(const struct
> syscallname *name,
> >     >      }
> >     >      #endif
> >     >
> >     >     +#ifdef TARGET_NR_getcwd
> >     >     +static void
> >     >     +print_getcwd(const struct syscallname *name,
> >     >     +    abi_long arg0, abi_long arg1, abi_long arg2,
> >     >     +    abi_long arg3, abi_long arg4, abi_long arg5)
> >     >     +{
> >     >     +    print_syscall_prologue(name);
> >     >     +    print_string(arg0, 0);
> >     >     +    print_raw_param("%u", arg1, 1);
> >     >     +    print_syscall_epilogue(name);
> >     >     +}
> >     >     +#endif
> >     >     +
> >     >      #ifdef TARGET_NR_settimeofday
> >     >      static void
> >     >      print_settimeofday(const struct syscallname *name,
> >     >     @@ -2428,6 +2473,20 @@ print_fstatat64(const struct
> syscallname *name,
> >     >      #define print_newfstatat    print_fstatat64
> >     >      #endif
> >     >
> >     >     +#ifdef TARGET_NR_read
> >     >     +static void
> >     >     +print_read(const struct syscallname *name,
> >     >     +    abi_long arg0, abi_long arg1, abi_long arg2,
> >     >     +    abi_long arg3, abi_long arg4, abi_long arg5)
> >     >     +{
> >     >     +    print_syscall_prologue(name);
> >     >     +    print_raw_param("%d", arg0, 0);
> >     >     +    print_encoded_string(arg1, arg2, 0);
> >     >     +    print_raw_param("%u", arg2, 1);
> >     >     +    print_syscall_epilogue(name);
> >     >     +}
> >     >     +#endif
> >     >     +
> >     >      #ifdef TARGET_NR_readlink
> >     >      static void
> >     >      print_readlink(const struct syscallname *name,
> >     >     diff --git a/linux-user/strace.list b/linux-user/strace.list
> >     >     index d49a1e92a8..220b1f4c46 100644
> >     >     --- a/linux-user/strace.list
> >     >     +++ b/linux-user/strace.list
> >     >     @@ -272,7 +272,7 @@
> >     >      { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
> >     >      #endif
> >     >      #ifdef TARGET_NR_getcwd
> >     >     -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
> >     >     +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
> >     >      #endif
> >     >      #ifdef TARGET_NR_getdents
> >     >      { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
> >     >     @@ -1080,7 +1080,7 @@
> >     >      { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
> >     >      #endif
> >     >      #ifdef TARGET_NR_read
> >     >     -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> >     >     +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
> >     >      #endif
> >     >      #ifdef TARGET_NR_readahead
> >     >      { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> >     >     diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >     >     index ce399a55f0..c0079ca2b7 100644
> >     >     --- a/linux-user/syscall.c
> >     >     +++ b/linux-user/syscall.c
> >     >     @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void
> *cpu_env, int num, abi_long arg1,
> >     >          return ret;
> >     >      }
> >     >
> >     >     +/*
> >     >     + * True if this syscall should be printed after having called
> the native
> >     >     + * syscall, so that values which are fed back to userspace
> gets printed.
> >     >     + */
> >     >     +static int print_syscall_late(int syscall)
> >     >     +{
> >     >     +    switch (syscall) {
> >     >     +    case TARGET_NR_getcwd:
> >     >     +    case TARGET_NR_read:
> >     >     +        return 1;
> >     >     +    default:
> >     >     +        return 0;
> >     >     +    }
> >     >     +}
> >     >     +
> >     >      abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> >     >                          abi_long arg2, abi_long arg3, abi_long
> arg4,
> >     >                          abi_long arg5, abi_long arg6, abi_long
> arg7,
> >     >     @@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env,
> int num, abi_long arg1,
> >     >                               arg2, arg3, arg4, arg5, arg6, arg7,
> arg8);
> >     >
> >     >          if (unlikely(do_strace)) {
> >     >     -        print_syscall(num, arg1, arg2, arg3, arg4, arg5,
> arg6);
> >     >     +        int late_printing;
> >     >     +        late_printing = print_syscall_late(num);
> >     >     +        if (!late_printing) {
> >     >     +            print_syscall(num, arg1, arg2, arg3, arg4, arg5,
> arg6);
> >     >     +        }
> >     >              ret = do_syscall1(cpu_env, num, arg1, arg2, arg3,
> arg4,
> >     >                                arg5, arg6, arg7, arg8);
> >     >     +        if (late_printing) {
> >     >     +            print_syscall(num, arg1, arg2, arg3, arg4, arg5,
> arg6);
> >     >     +        }
> >     >              print_syscall_ret(num, ret);
> >     >          } else {
> >     >              ret = do_syscall1(cpu_env, num, arg1, arg2, arg3,
> arg4,
> >     >
> >
>
>

--000000000000d7705d059817abbc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBTdW5kYXksIE5vdmVtYmVyIDI0LCAyMDE5LCBIZWxnZSBEZWxsZXIgJmx0Ozxh
IGhyZWY9Im1haWx0bzpkZWxsZXJAZ214LmRlIj5kZWxsZXJAZ214LmRlPC9hPiZndDsgd3JvdGU6
PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPk9uIDI0LjEx
LjE5IDEzOjEwLCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7
PGJyPg0KJmd0OyBPbiBTdW5kYXksIE5vdmVtYmVyIDI0LCAyMDE5LCBIZWxnZSBEZWxsZXIgJmx0
OzxhIGhyZWY9Im1haWx0bzpkZWxsZXJAZ214LmRlIj5kZWxsZXJAZ214LmRlPC9hPiAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzpkZWxsZXJAZ214LmRlIj5kZWxsZXJAZ214LmRlPC9hPiZndDsm
Z3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqBPbiAyMy4xMS4xOSAxMjozNCwg
QWxla3NhbmRhciBNYXJrb3ZpYyB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IE9uIFRodXJz
ZGF5LCBOb3ZlbWJlciAyMSwgMjAxOSwgSGVsZ2UgRGVsbGVyICZsdDs8YSBocmVmPSJtYWlsdG86
ZGVsbGVyQGdteC5kZSI+ZGVsbGVyQGdteC5kZTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWls
dG86ZGVsbGVyQGdteC5kZSI+ZGVsbGVyQGdteC5kZTwvYT4mZ3Q7ICZsdDttYWlsdG86PGEgaHJl
Zj0ibWFpbHRvOmRlbGxlckBnbXguZGUiPmRlbGxlckBnbXguZGU8L2E+ICZsdDttYWlsdG86PGEg
aHJlZj0ibWFpbHRvOmRlbGxlckBnbXguZGUiPmRlbGxlckBnbXguZGU8L2E+Jmd0OyZndDsmZ3Q7
IHdyb3RlOjxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqBUaGUgc3RyYWNlIGZ1bmN0aW9uYWxpdHkgaW4gcWVtdS11c2VyIGxhY2tzIHRoZSBwb3NzaWJp
bGl0eSB0byB0cmFjZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoHdoaWNoIHJlYWwgdmFs
dWVzIGdldCByZXR1cm5lZCB0byBwb2ludGVycyBpbiB1c2Vyc3BhY2UgYnkgc3lzY2FsbHMuPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoEZvciBleGFt
cGxlLCB0aGUgcmVhZCgpIGFuZCBnZXRjd2QoKSBzeXNjYWxscyBjdXJyZW50bHkgb25seSBzaG93
IHRoZTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoGRlc3RpbmF0aW9uIGFkZHJlc3Mgd2hl
cmUgdGhlIHN5c2NhbGxzIHNob3VsZCBwdXQgdGhlIHJldHVybiB2YWx1ZXM6PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgMjUzMiByZWFkKDMsMHhmZjgwMDM4Yyw1MTIpID0gNTEyPGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgMjUzMiBnZXRjd2QoMHgxODE4MCw0MDk2KSA9IDk8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgV2l0aCB0aGUg
cGF0Y2ggYmVsb3csIG9uZSBub3cgY2FuIHNwZWNpZnkgaW4gcHJpbnRfc3lzY2FsbF9sYXRlKCkg
d2hpY2g8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBzeXNjYWxscyBzaG91bGQgYmUgZXhl
Y3V0ZWQgZmlyc3QsIGJlZm9yZSB0aGV5IGdldCBwcmludGVkLjxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoEFmdGVyIGFkZGluZyB0aGUgcmVhZCgpIGFuZCBnZXRjd2QoKSBzeXNjYWxscywg
d2Ugbm93IGdldCB0aGlzIG91dHB1dCBpbjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoHdp
dGggc3RyYWNlIGluc3RlYWQ6PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgMTcwOCByZWFk
KDMsJnF1b3Q7XDE3N0VMRlwxXDJcMVwzXDBcMFwwXDx3YnI+MFwwXDBcMFwwXDBcM1wwXDE3XDBc
MFwwXDFcMFw8d2JyPjJibFwwXDBcMDQmcXVvdDsuLi4sNTEyKSA9IDUxMjxicj4NCiZndDvCoCDC
oCDCoCZndDvCoCDCoCDCoDE3MDggZ2V0Y3dkKCZxdW90Oy91c3IvYmluJnF1b3Q7LDQwOTYpID0g
OTxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBUaGlz
IHBhdGNoIGFkZHMganVzdCB0aGUgZnJhbWV3b3JrIHdpdGggdGhlIHJlc3BlY3RpdmUgaW1wbGVt
ZW5hdGlvbnMgZm9yPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgcmVhZCgpIGFuZCBnZXRj
d2QoKS4gSWYgYXBwbGllZCwgbW9yZSBmdW5jdGlvbnMgY2FuIGJlIGFkZGVkIGVhc2lseSBsYXRl
ci48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCZndDsgR3JlYXQgb3V0LW9mLXRoZS1ib3ggaWRlYSEgSG93ZXZlciwgdGhlcmUgYXJl
IHNvbWUgdGhpbmdzIHRoYXQgYXJlPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBub3QgdGhvdWdodCBv
dmVyIHlldC4gVGhlcmUgaXMgYSBnb29kIHJlYXNvbiB3aHkgc3RyYWNlIGhhcHBlbnM8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7ICZxdW90O2Vhcmx5JnF1b3Q7OiBpZiBzb21ldGhpbmcgY3Jhc2gtbGlr
ZSBoYXBwZW5zIGR1cmluZyBzeXNjYWxsIHRyYW5zbGF0aW9uLDxicj4NCiZndDvCoCDCoCDCoCZn
dDsgd2Ugc3RpbGwgaGF2ZSB0cmFjZSBvZiBvcmlnaW5hbCB0YXJnZXQgc3lzY2FsbC4gSW4gY2Fz
ZSBvZiAmcXVvdDtsYXRlJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBmbGF2b3IsIHdlIGRv
biYjMzk7dCBoYXZlIGFueXRoaW5nLiBBbm90aGVyIHBvdGVudGlhbGx5IHByb2JsZW1hdGljPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0OyBhc3BlY3QgaXMgdGhhdCBlbmQgdXNlciBjZXJ0YWlubHkgc2hv
dWxkIGtub3cgd2hldGhlciB0aGUgdHJhY2Ugd2FzPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBkb25l
ICZxdW90O2Vhcmx5JnF1b3Q7IG9yICZxdW90O2xhdGUmcXVvdDsgLSBvdGhlcndpc2UsIHRoZXJl
IHdpbGwgYmUsIGZvciBjZXJ0YWluLCBjYXNlczxicj4NCiZndDvCoCDCoCDCoCZndDsgb2YgbWlz
aW50ZXJwcmV0YXRpb24gLyBtaXNsZWFkaW5nIC8gY29uZnVzaW9uIG9mIGVuZCB1c2Vycy48YnI+
DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgVGhhbmtzIGZvciB0aGUgZmVlZGJhY2sgLSBJJiMzOTtt
IHNob3J0bHkgc2VuZGluZyBhIHYyIHZlcnNpb24gd2hpY2g8YnI+DQomZ3Q7wqAgwqAgwqBwcmlu
dHMgdGhlIHN5c2NhbGwgbmFtZSB3aXRoIGFuIG9wZW4gcGFyZW50aGVzaXMsIGUuZy4gJnF1b3Q7
cmVhZCgmcXVvdDsgb3IgJnF1b3Q7Z2V0Y3dkKCZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqBiZWZv
cmUgY2FsbGluZyB0aGUgc3lzY2FsbC4gVGhhdCB3YXkgeW91IGNhbiBzZWUgd2hlcmUgaXQgY3Jh
c2hlZC9oYW5ncy4uLjxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0OyAuLi4gYnV0IEkgY2Fu
bm90IHNlZSBwYXNzZWQgYXJndW1lbnRzIChmb3IgZXhhbXBsZSwgd2hldGhlciBOVUxMIGlzIHBh
c3NlZCwgb3Igc29tcnRoaW5nIHRoYXQgbG9va3MgbGlrZSBhIHJlYWwgYWRkcmVzcykuLi48YnI+
DQo8YnI+DQpSaWdodC48YnI+DQpBbmQgeW91IHdvbiYjMzk7dCBzZWUgdGhhdCBpbiBuYXRpdmUg
c3RyYWNlIGVpdGhlci4uLjxicj4NCklmIHlvdSBoYXZlIGFuIGlkZWEsIGp1c3QgbGV0IG1lIGtu
b3cuPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkhlbGdlLCBJIGRv
IGhhdmUgYW4gaWRlYSBob3cgdG8gYW1lbmQgeW91ciBwcm9wb3NhbCB0aGF0IHNob3VsZCBnaXZl
IHVzLMKgYmVsaWV2ZSBpdCBvciBub3QswqAmcXVvdDtiZXN0IG9mIGJvdGjCoHdvcmxkcyZxdW90
OywgYnV0IGxldCYjMzk7cyB3YWl0IGZldyBkYXlzLCBJIGRvbiYjMzk7dCBoYXZlIGFueSBkZXYg
c2V0dXAgYXIgaGFuZCBhdCB0aGUgbW9tZW50IHRvIGNoZWNrIGl0IGluIGFjdGlvbiwgYW5kIG9u
IHRvcCBvZiB0aGF0IEkgYW0gc3dhbXBlZCB3aXRoIG90aGVyIHVucmVsYXRlZCB0YXNrcy4gSW4g
dGhlIG1lYW50aW1lLCBtYXliZSBvdGhlciBndXlzIHdpbGwgc2F5IHNvbWV0aGluZyB0b28sIG9y
IHBlcmhhcHMgeW91IHdvdWxkIGhhdmUgc29tZXRoaW5nIG5ldyBhcyB3ZWxsLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+U3RpbGwsIGJ5IG5vIG1lYW5zLCBJIHNlZSB0aGlzIGFzIGEgKHBvdGVu
dGlhbCkgKmh1Z2UqIGltcHJvdmVtZW50IG9mIFFFTVUgc3RyYWNlLiBUaGFua3MhPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5Zb3Vycyw8L2Rpdj48ZGl2PkFsZWtzYW5kYXI8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+DQpIZWxnZTxicj4NCjxicj4NCiZndDs8YnI+DQomZ3Q7IMKgPGJyPg0KJmd0Ozxi
cj4NCiZndDvCoCDCoCDCoEhlbGdlPGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7IFlvdXJzLDxicj4NCiZndDvCoCDCoCDCoCZndDsgQWxla3NhbmRh
cjxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0OyDCoDxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqBTaWduZWQtb2ZmLWJ5OiBIZWxnZSBEZWxsZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpk
ZWxsZXJAZ214LmRlIj5kZWxsZXJAZ214LmRlPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpkZWxsZXJAZ214LmRlIj5kZWxsZXJAZ214LmRlPC9hPiZndDsgJmx0O21haWx0bzo8YSBocmVm
PSJtYWlsdG86ZGVsbGVyQGdteC5kZSI+ZGVsbGVyQGdteC5kZTwvYT4gJmx0O21haWx0bzo8YSBo
cmVmPSJtYWlsdG86ZGVsbGVyQGdteC5kZSI+ZGVsbGVyQGdteC5kZTwvYT4mZ3Q7Jmd0OyZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgZGlmZiAt
LWdpdCBhL2xpbnV4LXVzZXIvc3RyYWNlLmMgYi9saW51eC11c2VyL3N0cmFjZS5jPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgaW5kZXggZGU0MzIzOGZhNC4uZmYyNTQ3MzJhZiAxMDA2NDQ8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAtLS0gYS9saW51eC11c2VyL3N0cmFjZS5jPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKysrIGIvbGludXgtdXNlci9zdHJhY2UuYzxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoEBAIC02MSw2ICs2MSw3IEBAIFVOVVNFRCBzdGF0aWMg
dm9pZCBwcmludF9vcGVuX2ZsYWdzKGFiaV9sb25nLCBpbnQpOzxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoMKgVU5VU0VEIHN0YXRpYyB2b2lkIHByaW50X3N5c2NhbGxfcHJvbG9ndWUoY29u
c3Qgc3RydWN0IHN5c2NhbGxuYW1lICopOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoMKg
VU5VU0VEIHN0YXRpYyB2b2lkIHByaW50X3N5c2NhbGxfZXBpbG9ndWUoY29uc3Qgc3RydWN0IHN5
c2NhbGxuYW1lICopOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoMKgVU5VU0VEIHN0YXRp
YyB2b2lkIHByaW50X3N0cmluZyhhYmlfbG9uZywgaW50KTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqArVU5VU0VEIHN0YXRpYyB2b2lkIHByaW50X2VuY29kZWRfc3RyaW5nKGFiaV9sb25n
IGFkZHIsIHVuc2lnbmVkIGludCBtYXhsZW4sIGludCBsYXN0KTs8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqDCoFVOVVNFRCBzdGF0aWMgdm9pZCBwcmludF9idWYoYWJpX2xvbmcgYWRkciwg
YWJpX2xvbmcgbGVuLCBpbnQgbGFzdCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqBV
TlVTRUQgc3RhdGljIHZvaWQgcHJpbnRfcmF3X3BhcmFtKGNvbnN0IGNoYXIgKiwgYWJpX2xvbmcs
IGludCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqBVTlVTRUQgc3RhdGljIHZvaWQg
cHJpbnRfdGltZXZhbChhYmlfdWxvbmcsIGludCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgQEAgLTEyMDQsNiArMTIwNSwzNyBAQCBwcmludF9zeXNjYWxsX2VwaWxvZ3VlKGNvbnN0IHN0
cnVjdCBzeXNjYWxsbmFtZSAqc2MpPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAgwqAg
wqBnZW11X2xvZygmcXVvdDspJnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDC
oH08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgTUFYX0VOQ09ERURfQ0hBUlMgMzI8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAr
c3RhdGljIHZvaWQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArcHJpbnRfZW5jb2RlZF9z
dHJpbmcoYWJpXzx3YnI+bG9uZyBhZGRyLCB1bnNpZ25lZCBpbnQgbWF4bGVuLCBpbnQgbGFzdCk8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCvCoCDCoCB1bnNpZ25lZCBpbnQgbWF4b3V0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCvCoCDCoCBjaGFyICpzLCAqc3RyOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgcyA9IGxvY2tfdXNlcl9zdHJpbmco
YWRkcik7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIGlmIChzID09IE5VTEwp
IHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLyogY2FuJiMzOTt0
IGdldCBzdHJpbmcgb3V0IG9mIGl0LCBzbyBwcmludCBpdCBhcyBwb2ludGVyICovPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHByaW50X3BvaW50ZXIoYWRkciwgbGFz
dCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgc3RyID0gczs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgZ2VtdV9sb2coJnF1b3Q7XCZxdW90OyZx
dW90Oyk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIG1heG91dCA9IE1JTiht
YXhsZW4sIE1BWF9FTkNPREVEX0NIQVJTKTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAr
wqAgwqAgd2hpbGUgKG1heG91dC0tKSB7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIHVuc2lnbmVkIGNoYXIgYyA9ICpzdHIrKzs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgaWYgKGlzcHJpbnQoYykpIHs8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgZ2VtdV9sb2coJnF1b3Q7JWMmcXVvdDssIGMp
Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBnZW11X2xvZygmcXVv
dDtcXCVvJnF1b3Q7LCAodW5zaWduZWQgaW50KSBjKTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCB9
PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIHVubG9ja191c2VyKHMsIGFkZHIs
IDApOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqArwqAgwqAgZ2VtdV9sb2coJnF1b3Q7XCZxdW90OyVzJXMmcXVvdDssIG1heGxlbiAm
Z3Q7IE1BWF9FTkNPREVEX0NIQVJTID8gJnF1b3Q7Li4uJnF1b3Q7IDogJnF1b3Q7JnF1b3Q7LDxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBnZXRfY29tbWEobGFzdCkpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCt9PGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoMKg
c3RhdGljIHZvaWQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoHByaW50X3N0cmluZyhh
YmlfbG9uZyBhZGRyLCBpbnQgbGFzdCk8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoHs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBAQCAtMTYzMyw2ICsxNjY1LDE5IEBAIHByaW50
X2Z1dGltZXNhdChjb25zdCBzdHJ1Y3Qgc3lzY2FsbG5hbWUgKm5hbWUsPGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgIMKgIMKgwqB9PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAjZW5kaWY8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKyNpZmRl
ZiBUQVJHRVRfTlJfZ2V0Y3dkPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK3N0YXRpYyB2
b2lkPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK3ByaW50X2dldGN3ZChjb25zdCBzdHJ1
Y3Qgc3lzY2FsbG5hbWUgKm5hbWUsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKg
IGFiaV9sb25nIGFyZzAsIGFiaV9sb25nIGFyZzEsIGFiaV9sb25nIGFyZzIsPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIGFiaV9sb25nIGFyZzMsIGFiaV9sb25nIGFyZzQsIGFi
aV9sb25nIGFyZzUpPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgcHJpbnRfc3lzY2FsbF9wcm9sb2d1ZShuYW1lKTs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgcHJpbnRfc3RyaW5nKGFyZzAsIDApOzxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCBwcmludF9yYXdfcGFyYW0oJnF1b3Q7
JXUmcXVvdDssIGFyZzEsIDEpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCBw
cmludF9zeXNjYWxsX2VwaWxvZ3VlKG5hbWUpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCt9PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKyNlbmRpZjxicj4NCiZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoCNpZmRlZiBUQVJH
RVRfTlJfc2V0dGltZW9mZGF5PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqBzdGF0aWMg
dm9pZDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoMKgcHJpbnRfc2V0dGltZW9mZGF5KGNv
bnN0IHN0cnVjdCBzeXNjYWxsbmFtZSAqbmFtZSw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqBAQCAtMjQyOCw2ICsyNDczLDIwIEBAIHByaW50X2ZzdGF0YXQ2NChjb25zdCBzdHJ1Y3Qgc3lz
Y2FsbG5hbWUgKm5hbWUsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAjZGVmaW5lIHBy
aW50X25ld2ZzdGF0YXTCoCDCoCBwcmludF9mc3RhdGF0NjQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqDCoCNlbmRpZjxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqArI2lmZGVmIFRBUkdFVF9OUl9yZWFkPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgK3N0YXRpYyB2b2lkPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK3ByaW50X3Jl
YWQoY29uc3Qgc3RydWN0IHN5c2NhbGxuYW1lICpuYW1lLDxicj4NCiZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoCvCoCDCoCBhYmlfbG9uZyBhcmcwLCBhYmlfbG9uZyBhcmcxLCBhYmlfbG9uZyBhcmcy
LDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCBhYmlfbG9uZyBhcmczLCBhYmlf
bG9uZyBhcmc0LCBhYmlfbG9uZyBhcmc1KTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCt7
PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIHByaW50X3N5c2NhbGxfcHJvbG9n
dWUobmFtZSk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIHByaW50X3Jhd19w
YXJhbSgmcXVvdDslZCZxdW90OywgYXJnMCwgMCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgK8KgIMKgIHByaW50X2VuY29kZWRfc3RyaW5nKGFyZzEsIGFyZzIsIDApOzxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCBwcmludF9yYXdfcGFyYW0oJnF1b3Q7JXUmcXVvdDss
IGFyZzIsIDEpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCBwcmludF9zeXNj
YWxsX2VwaWxvZ3VlKG5hbWUpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCt9PGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKyNlbmRpZjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoCNpZmRlZiBUQVJHRVRfTlJfcmVh
ZGxpbms8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoHN0YXRpYyB2b2lkPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqBwcmludF9yZWFkbGluayhjb25zdCBzdHJ1Y3Qgc3lzY2Fs
bG5hbWUgKm5hbWUsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgZGlmZiAtLWdpdCBhL2xp
bnV4LXVzZXIvc3RyYWNlLmxpc3QgYi9saW51eC11c2VyL3N0cmFjZS5saXN0PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgaW5kZXggZDQ5YTFlOTJhOC4uMjIwYjFmNGM0NiAxMDA2NDQ8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAtLS0gYS9saW51eC11c2VyL3N0cmFjZS5saXN0PGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKysrIGIvbGludXgtdXNlci9zdHJhY2UubGlzdDxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoEBAIC0yNzIsNyArMjcyLDcgQEA8YnI+DQomZ3Q7
wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoHsgVEFSR0VUX05SX2dldGNwdSwgJnF1b3Q7Z2V0Y3B1JnF1
b3Q7ICwgJnF1b3Q7JXMoJXAsJWQpJnF1b3Q7LCBOVUxMLCBOVUxMIH0sPGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgIMKgIMKgwqAjZW5kaWY8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoCNp
ZmRlZiBUQVJHRVRfTlJfZ2V0Y3dkPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgLXsgVEFS
R0VUX05SX2dldGN3ZCwgJnF1b3Q7Z2V0Y3dkJnF1b3Q7ICwgJnF1b3Q7JXMoJXAsJWQpJnF1b3Q7
LCBOVUxMLCBOVUxMIH0sPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK3sgVEFSR0VUX05S
X2dldGN3ZCwgJnF1b3Q7Z2V0Y3dkJnF1b3Q7ICwgTlVMTCwgcHJpbnRfZ2V0Y3dkLCBOVUxMIH0s
PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAjZW5kaWY8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqDCoCNpZmRlZiBUQVJHRVRfTlJfZ2V0ZGVudHM8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqDCoHsgVEFSR0VUX05SX2dldGRlbnRzLCAmcXVvdDtnZXRkZW50cyZxdW90OyAs
IE5VTEwsIE5VTEwsIE5VTEwgfSw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBAQCAtMTA4
MCw3ICsxMDgwLDcgQEA8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoHsgVEFSR0VUX05S
X3F1b3RhY3RsLCAmcXVvdDtxdW90YWN0bCZxdW90OyAsIE5VTEwsIE5VTEwsIE5VTEwgfSw8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoCNlbmRpZjxicj4NCiZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoMKgI2lmZGVmIFRBUkdFVF9OUl9yZWFkPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgLXsgVEFSR0VUX05SX3JlYWQsICZxdW90O3JlYWQmcXVvdDsgLCAmcXVvdDslcyglZCwlI3gs
JWQpJnF1b3Q7LCBOVUxMLCBOVUxMIH0sPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK3sg
VEFSR0VUX05SX3JlYWQsICZxdW90O3JlYWQmcXVvdDsgLCBOVUxMLCBwcmludF9yZWFkLCBOVUxM
IH0sPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAjZW5kaWY8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7wqAgwqAgwqDCoCNpZmRlZiBUQVJHRVRfTlJfcmVhZGFoZWFkPGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgIMKgIMKgwqB7IFRBUkdFVF9OUl9yZWFkYWhlYWQsICZxdW90O3JlYWRhaGVhZCZx
dW90OyAsIE5VTEwsIE5VTEwsIE5VTEwgfSw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBk
aWZmIC0tZ2l0IGEvbGludXgtdXNlci9zeXNjYWxsLmMgYi9saW51eC11c2VyL3N5c2NhbGwuYzxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoGluZGV4IGNlMzk5YTU1ZjAuLmMwMDc5Y2EyYjcg
MTAwNjQ0PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgLS0tIGEvbGludXgtdXNlci9zeXNj
YWxsLmM8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArKysgYi9saW51eC11c2VyL3N5c2Nh
bGwuYzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoEBAIC0xMjA2OSw2ICsxMjA2OSwyMSBA
QCBzdGF0aWMgYWJpX2xvbmcgZG9fc3lzY2FsbDEodm9pZCAqY3B1X2VudiwgaW50IG51bSwgYWJp
X2xvbmcgYXJnMSw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoCDCoCDCoHJldHVybiBy
ZXQ7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqB9PGJyPg0KJmd0O8KgIMKgIMKgJmd0
Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCsvKjxicj4NCiZndDvCoCDCoCDCoCZndDvC
oCDCoCDCoCsgKiBUcnVlIGlmIHRoaXMgc3lzY2FsbCBzaG91bGQgYmUgcHJpbnRlZCBhZnRlciBo
YXZpbmcgY2FsbGVkIHRoZSBuYXRpdmU8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArICog
c3lzY2FsbCwgc28gdGhhdCB2YWx1ZXMgd2hpY2ggYXJlIGZlZCBiYWNrIHRvIHVzZXJzcGFjZSBn
ZXRzIHByaW50ZWQuPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgKyAqLzxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCtzdGF0aWMgaW50IHByaW50X3N5c2NhbGxfbGF0ZShpbnQgc3lz
Y2FsbCk8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoCvCoCDCoCBzd2l0Y2ggKHN5c2NhbGwpIHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqArwqAgwqAgY2FzZSBUQVJHRVRfTlJfZ2V0Y3dkOjxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoCvCoCDCoCBjYXNlIFRBUkdFVF9OUl9yZWFkOjxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXR1cm4gMTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAg
wqAgwqArwqAgwqAgZGVmYXVsdDo8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgcmV0dXJuIDA7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqDCoGFiaV9sb25nIGRvX3N5c2NhbGwodm9p
ZCAqY3B1X2VudiwgaW50IG51bSwgYWJpX2xvbmcgYXJnMSw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFiaV9sb25nIGFyZzIsIGFi
aV9sb25nIGFyZzMsIGFiaV9sb25nIGFyZzQsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhYmlfbG9uZyBhcmc1LCBhYmlfbG9uZyBh
cmc2LCBhYmlfbG9uZyBhcmc3LDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoEBAIC0xMjA5
NSw5ICsxMjExMCwxNiBAQCBhYmlfbG9uZyBkb19zeXNjYWxsKHZvaWQgKmNwdV9lbnYsIGludCBu
dW0sIGFiaV9sb25nIGFyZzEsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXJnMiwgYXJnMywgYXJnNCwgYXJnNSwgYXJn
NiwgYXJnNywgYXJnOCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZn
dDvCoCDCoCDCoMKgIMKgIMKgaWYgKHVubGlrZWx5KGRvX3N0cmFjZSkpIHs8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7wqAgwqAgwqAtwqAgwqAgwqAgwqAgcHJpbnRfc3lzY2FsbChudW0sIGFyZzEsIGFy
ZzIsIGFyZzMsIGFyZzQsIGFyZzUsIGFyZzYpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBpbnQgbGF0ZV9wcmludGluZzs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgbGF0ZV9wcmludGluZyA9IHByaW50X3N5c2NhbGxfbGF0ZShudW0p
Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBpZiAoIWxhdGVfcHJp
bnRpbmcpIHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
cHJpbnRfc3lzY2FsbChudW0sIGFyZzEsIGFyZzIsIGFyZzMsIGFyZzQsIGFyZzUsIGFyZzYpOzxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqByZXQgPSBkb19zeXNjYWxsMShjcHVfZW52LCBu
dW0sIGFyZzEsIGFyZzIsIGFyZzMsIGFyZzQsPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhcmc1LCBhcmc2LCBhcmc3
LCBhcmc4KTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgaWYgKGxh
dGVfcHJpbnRpbmcpIHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
wqAgwqAgcHJpbnRfc3lzY2FsbChudW0sIGFyZzEsIGFyZzIsIGFyZzMsIGFyZzQsIGFyZzUsIGFy
ZzYpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAgwqAgwqAgwqAgwqBwcmludF9zeXNjYWxsX3JldChudW0s
IHJldCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgwqAgwqAgwqB9IGVsc2Ugezxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoMKgIMKgIMKgIMKgIMKgcmV0ID0gZG9fc3lzY2FsbDEo
Y3B1X2VudiwgbnVtLCBhcmcxLCBhcmcyLCBhcmczLCBhcmc0LDxicj4NCiZndDvCoCDCoCDCoCZn
dDs8YnI+DQomZ3Q7PGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPg0K
--000000000000d7705d059817abbc--


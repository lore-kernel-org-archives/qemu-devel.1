Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F44C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 20:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDE320678
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 20:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEcmSQaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDE320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZLPM-0000xd-Gl
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 15:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZLNy-0000SI-C9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZLNw-0000Rn-BC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:55:06 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZLNw-0000Ra-3q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:55:04 -0500
Received: by mail-oi1-x243.google.com with SMTP id o12so14453188oic.9
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0eQcNoIwgAggiffFLGD8dOoeB8HnP6t1GO/4ZsEoM6I=;
 b=CEcmSQaO1moU1E8OthXRflBrYN4XsQc4twO/80GAJmlpHV+TGvcI5PvdaGOh91rnH2
 E0RxVQwNTjXcmTO28OY0WEhoJKDr11OvKK5KJg2ajEIkwxI7TZs/KEax1CdZ0uRuH9Rv
 WhtoG+8a4/RirjNNxKGou0SIMjlAMwzBzCEmqHV80uFi5PKy91xbKe9ohv0BI+MzlRP5
 fIrMKcJFTk3UZRlUTnwZ4TGDu5oWZNbV9wFll4euRemu7zTVbgFfN7vd/RfgHJW+2Y61
 E3SDAS+/YGWYzBpMCzKI+6XFEWZFMkEYG1E2PqninBX5ynppq3ChiXCJrLXvlFLS98TB
 2Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0eQcNoIwgAggiffFLGD8dOoeB8HnP6t1GO/4ZsEoM6I=;
 b=ep3/giAyp2GmyUcjMYUpG4UVT7tNIr/LpK8c0lkZrTHtzqHZEXTLuw5DBO6/UGL5xA
 QAyJ844TefIJFreJ2B2J5RzKW+v0faUBA7Qihb7tJ4rQkxbR0vjJmq6vOJwIzyDYJ4Az
 KTXLxnJvToMH+u293loVow2dFILLElCc/Z0j7EWOwbSVCr+utFCSisHpbVaYl8cLM7UO
 GCt59jW8Mva52XtQfL58x3eqITqYJj8ZIkaNSppY529B5OgxPImgH9pOXMr8W4jIiIXJ
 wd1dD/pakZsyZ7vp+gDXLF0H1bEZHj+J5HgoussOzlkh9ip1Jfz7yTqrerKDpAOXJauZ
 tLow==
X-Gm-Message-State: APjAAAUFhkk8/2ZBHzLskx5NLnAu+QvwBNC+EAqG5DF49wG8hRMDVfYX
 Cf+YUpTELQJsQldVbOqa78erNsmvzhI7/C4Y+uw=
X-Google-Smtp-Source: APXvYqywWSl50HP2LEielIzMu+g+2aITYCjGD7OXZjuCgYcIYW9cgBrAPxbiR7dDg/5K0F08B0ovVccJbRKr91xampA=
X-Received: by 2002:aca:5786:: with SMTP id l128mr676082oib.53.1574715302925; 
 Mon, 25 Nov 2019 12:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
 <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
 <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
 <e547f389-7281-4091-5bfb-a0aea265128d@gmx.de>
 <CAL1e-=ig8j+omFrdRGB1uf1mE8_9nJbt87=oAX3brbr34_cDMA@mail.gmail.com>
 <CAL1e-=hBvL0a8CDuD2Ok0U7vh8t0f-VQmi671OoudXnqLagFsg@mail.gmail.com>
 <d4815598-954b-4b4f-61cd-24611de04c56@gmx.de>
In-Reply-To: <d4815598-954b-4b4f-61cd-24611de04c56@gmx.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 21:54:52 +0100
Message-ID: <CAL1e-=itFFWZW9b2B=oL3ZOKOgKq6+TO+f0WU9vWh8pjNY9k0g@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 9:40 PM Helge Deller <deller@gmx.de> wrote:
>
> On 25.11.19 14:46, Aleksandar Markovic wrote:
> > On Sun, Nov 24, 2019 at 2:31 PM Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com> wrote:
> >>
> >>
> >>
> >> On Sunday, November 24, 2019, Helge Deller <deller@gmx.de> wrote:
> >>>
> >>> On 24.11.19 13:10, Aleksandar Markovic wrote:
> >>>>
> >>>>
> >>>> On Sunday, November 24, 2019, Helge Deller <deller@gmx.de <mailto:de=
ller@gmx.de>> wrote:
> >>>>
> >>>>     On 23.11.19 12:34, Aleksandar Markovic wrote:
> >>>>     > On Thursday, November 21, 2019, Helge Deller <deller@gmx.de <m=
ailto:deller@gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>> wrote:
> >>>>     >
> >>>>     >     The strace functionality in qemu-user lacks the possibilit=
y to trace
> >>>>     >     which real values get returned to pointers in userspace by=
 syscalls.
> >>>>     >
> >>>>     >     For example, the read() and getcwd() syscalls currently on=
ly show the
> >>>>     >     destination address where the syscalls should put the retu=
rn values:
> >>>>     >     2532 read(3,0xff80038c,512) =3D 512
> >>>>     >     2532 getcwd(0x18180,4096) =3D 9
> >>>>     >
> >>>>     >     With the patch below, one now can specify in print_syscall=
_late() which
> >>>>     >     syscalls should be executed first, before they get printed=
.
> >>>>     >     After adding the read() and getcwd() syscalls, we now get =
this output in
> >>>>     >     with strace instead:
> >>>>     >     1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\=
0\1\0\2bl\0\0\04"...,512) =3D 512
> >>>>     >     1708 getcwd("/usr/bin",4096) =3D 9
> >>>>     >
> >>>>     >     This patch adds just the framework with the respective imp=
lemenations for
> >>>>     >     read() and getcwd(). If applied, more functions can be add=
ed easily later.
> >>>>     >
> >>>>     >
> >>>>     > Great out-of-the-box idea! However, there are some things that=
 are
> >>>>     > not thought over yet. There is a good reason why strace happen=
s
> >>>>     > "early": if something crash-like happens during syscall transl=
ation,
> >>>>     > we still have trace of original target syscall. In case of "la=
te"
> >>>>     > flavor, we don't have anything. Another potentially problemati=
c
> >>>>     > aspect is that end user certainly should know whether the trac=
e was
> >>>>     > done "early" or "late" - otherwise, there will be, for certain=
, cases
> >>>>     > of misinterpretation / misleading / confusion of end users.
> >>>>
> >>>>     Thanks for the feedback - I'm shortly sending a v2 version which
> >>>>     prints the syscall name with an open parenthesis, e.g. "read(" o=
r "getcwd(",
> >>>>     before calling the syscall. That way you can see where it crashe=
d/hangs...
> >>>>
> >>>>
> >>>> ... but I cannot see passed arguments (for example, whether NULL is =
passed, or somrthing that looks like a real address)...
> >>>
> >>> Right.
> >>> And you won't see that in native strace either...
> >>> If you have an idea, just let me know.
> >>>
> >>
> >> Helge, I do have an idea how to amend your proposal that should give u=
s, believe it or not, "best of both worlds", but let's wait few days, I don=
't have any dev setup ar hand at the moment to check it in action, and on t=
op of that I am swamped with other unrelated tasks. In the meantime, maybe =
other guys will say something too, or perhaps you would have something new =
as well.
> >>
> >> Still, by no means, I see this as a (potential) *huge* improvement of =
QEMU strace. Thanks!
> >>
> >
> > Helge, Laurent,
> >
> > I don't have time to experiment, but I will write down here my
> > suggestion to extending Helge's system in a textual form, based on
> > example from prevous Helge's patches:
> >
> > 1. CURRENT STATE:
> >
> > early: read(3,0xff80038c,512)
> > late: =3D 512
> >
> > early: getcwd(0x18180,4096)
> > late: =3D 9
> >
> > 2. HELGE'S PROPOSAL 1:
> >
> > late: read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\=
0\04"...,512)
> > =3D 512
> > late: getcwd("/usr/bin",4096) =3D 9
> >
> > 3. HELGE'S PROPOSAL 2:
> >
> > early: read
> > late: (3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04=
"...,512)
> > =3D 512
> > early: getcwd
> > late: ("/usr/bin",4096) =3D 9
>
> My v2 patch actually includes the opening parenthesis in the early part:
> early: read(
> late: 3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"..=
.,512) =3D 512
>
> The open parenthesis should make it visible, that the call hasn't happene=
d yet.
>

Helge, with due respect, you are mixed up here. The purpose of QEMU
strace is to trace *target* syscalls, not *host* syscalls. Target
syscall read() happened.

> > 4. NEW PROPOSAL :
> >
> > early: read(3,0xff80038c,512)
> > late: =3D 512  [(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\=
2bl\0\0\04"...,512)]
> > early: getcwd(0x18180,4096)
> > late: =3D 9  [("/usr/bin",4096)]
> >
> > In other words, we would print for (selected) system calls content of
> > the parameters both before and after actual ioctl
> > translation/execution.
>
> I don't like this.
> IMHO it just adds unnecessary noise and differs from what a native strace=
 shows.
>

QEMU strace doesn't have to be the same as native strace. Actually,
they could be used even at the same time: QEMU provides info on target
syscall, strace on host syscall. Do not forget that not all syscalls
are implemeted as one-to-one-correspondence between target and host
syscalls - combination of QEMU strace and native strace is precious at
some moments.

In any case, I think that requiring QEMU strace to look exactly like
native strace is a self-imposed limitation, that does not have enough
justification. Think of it, wouldn't it be nice to surpass strace,
like in these cases above?

Yours,
Aleksandar

> Helge
>
>
> >>>>     >
> >>>>     >     Signed-off-by: Helge Deller <deller@gmx.de <mailto:deller@=
gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>>
> >>>>     >
> >>>>     >     diff --git a/linux-user/strace.c b/linux-user/strace.c
> >>>>     >     index de43238fa4..ff254732af 100644
> >>>>     >     --- a/linux-user/strace.c
> >>>>     >     +++ b/linux-user/strace.c
> >>>>     >     @@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_=
long, int);
> >>>>     >      UNUSED static void print_syscall_prologue(const struct sy=
scallname *);
> >>>>     >      UNUSED static void print_syscall_epilogue(const struct sy=
scallname *);
> >>>>     >      UNUSED static void print_string(abi_long, int);
> >>>>     >     +UNUSED static void print_encoded_string(abi_long addr, un=
signed int maxlen, int last);
> >>>>     >      UNUSED static void print_buf(abi_long addr, abi_long len,=
 int last);
> >>>>     >      UNUSED static void print_raw_param(const char *, abi_long=
, int);
> >>>>     >      UNUSED static void print_timeval(abi_ulong, int);
> >>>>     >     @@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct=
 syscallname *sc)
> >>>>     >          gemu_log(")");
> >>>>     >      }
> >>>>     >
> >>>>     >     +#define MAX_ENCODED_CHARS 32
> >>>>     >     +static void
> >>>>     >     +print_encoded_string(abi_long addr, unsigned int maxlen, =
int last)
> >>>>     >     +{
> >>>>     >     +    unsigned int maxout;
> >>>>     >     +    char *s, *str;
> >>>>     >     +
> >>>>     >     +    s =3D lock_user_string(addr);
> >>>>     >     +    if (s =3D=3D NULL) {
> >>>>     >     +        /* can't get string out of it, so print it as poi=
nter */
> >>>>     >     +        print_pointer(addr, last);
> >>>>     >     +        return;
> >>>>     >     +    }
> >>>>     >     +
> >>>>     >     +    str =3D s;
> >>>>     >     +    gemu_log("\"");
> >>>>     >     +    maxout =3D MIN(maxlen, MAX_ENCODED_CHARS);
> >>>>     >     +    while (maxout--) {
> >>>>     >     +        unsigned char c =3D *str++;
> >>>>     >     +        if (isprint(c)) {
> >>>>     >     +            gemu_log("%c", c);
> >>>>     >     +        } else {
> >>>>     >     +            gemu_log("\\%o", (unsigned int) c);
> >>>>     >     +        }
> >>>>     >     +    }
> >>>>     >     +    unlock_user(s, addr, 0);
> >>>>     >     +
> >>>>     >     +    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..."=
 : "",
> >>>>     >     +                    get_comma(last));
> >>>>     >     +}
> >>>>     >     +
> >>>>     >      static void
> >>>>     >      print_string(abi_long addr, int last)
> >>>>     >      {
> >>>>     >     @@ -1633,6 +1665,19 @@ print_futimesat(const struct syscal=
lname *name,
> >>>>     >      }
> >>>>     >      #endif
> >>>>     >
> >>>>     >     +#ifdef TARGET_NR_getcwd
> >>>>     >     +static void
> >>>>     >     +print_getcwd(const struct syscallname *name,
> >>>>     >     +    abi_long arg0, abi_long arg1, abi_long arg2,
> >>>>     >     +    abi_long arg3, abi_long arg4, abi_long arg5)
> >>>>     >     +{
> >>>>     >     +    print_syscall_prologue(name);
> >>>>     >     +    print_string(arg0, 0);
> >>>>     >     +    print_raw_param("%u", arg1, 1);
> >>>>     >     +    print_syscall_epilogue(name);
> >>>>     >     +}
> >>>>     >     +#endif
> >>>>     >     +
> >>>>     >      #ifdef TARGET_NR_settimeofday
> >>>>     >      static void
> >>>>     >      print_settimeofday(const struct syscallname *name,
> >>>>     >     @@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscal=
lname *name,
> >>>>     >      #define print_newfstatat    print_fstatat64
> >>>>     >      #endif
> >>>>     >
> >>>>     >     +#ifdef TARGET_NR_read
> >>>>     >     +static void
> >>>>     >     +print_read(const struct syscallname *name,
> >>>>     >     +    abi_long arg0, abi_long arg1, abi_long arg2,
> >>>>     >     +    abi_long arg3, abi_long arg4, abi_long arg5)
> >>>>     >     +{
> >>>>     >     +    print_syscall_prologue(name);
> >>>>     >     +    print_raw_param("%d", arg0, 0);
> >>>>     >     +    print_encoded_string(arg1, arg2, 0);
> >>>>     >     +    print_raw_param("%u", arg2, 1);
> >>>>     >     +    print_syscall_epilogue(name);
> >>>>     >     +}
> >>>>     >     +#endif
> >>>>     >     +
> >>>>     >      #ifdef TARGET_NR_readlink
> >>>>     >      static void
> >>>>     >      print_readlink(const struct syscallname *name,
> >>>>     >     diff --git a/linux-user/strace.list b/linux-user/strace.li=
st
> >>>>     >     index d49a1e92a8..220b1f4c46 100644
> >>>>     >     --- a/linux-user/strace.list
> >>>>     >     +++ b/linux-user/strace.list
> >>>>     >     @@ -272,7 +272,7 @@
> >>>>     >      { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
> >>>>     >      #endif
> >>>>     >      #ifdef TARGET_NR_getcwd
> >>>>     >     -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
> >>>>     >     +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL }=
,
> >>>>     >      #endif
> >>>>     >      #ifdef TARGET_NR_getdents
> >>>>     >      { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
> >>>>     >     @@ -1080,7 +1080,7 @@
> >>>>     >      { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
> >>>>     >      #endif
> >>>>     >      #ifdef TARGET_NR_read
> >>>>     >     -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> >>>>     >     +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
> >>>>     >      #endif
> >>>>     >      #ifdef TARGET_NR_readahead
> >>>>     >      { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> >>>>     >     diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >>>>     >     index ce399a55f0..c0079ca2b7 100644
> >>>>     >     --- a/linux-user/syscall.c
> >>>>     >     +++ b/linux-user/syscall.c
> >>>>     >     @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void =
*cpu_env, int num, abi_long arg1,
> >>>>     >          return ret;
> >>>>     >      }
> >>>>     >
> >>>>     >     +/*
> >>>>     >     + * True if this syscall should be printed after having ca=
lled the native
> >>>>     >     + * syscall, so that values which are fed back to userspac=
e gets printed.
> >>>>     >     + */
> >>>>     >     +static int print_syscall_late(int syscall)
> >>>>     >     +{
> >>>>     >     +    switch (syscall) {
> >>>>     >     +    case TARGET_NR_getcwd:
> >>>>     >     +    case TARGET_NR_read:
> >>>>     >     +        return 1;
> >>>>     >     +    default:
> >>>>     >     +        return 0;
> >>>>     >     +    }
> >>>>     >     +}
> >>>>     >     +
> >>>>     >      abi_long do_syscall(void *cpu_env, int num, abi_long arg1=
,
> >>>>     >                          abi_long arg2, abi_long arg3, abi_lon=
g arg4,
> >>>>     >                          abi_long arg5, abi_long arg6, abi_lon=
g arg7,
> >>>>     >     @@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env=
, int num, abi_long arg1,
> >>>>     >                               arg2, arg3, arg4, arg5, arg6, ar=
g7, arg8);
> >>>>     >
> >>>>     >          if (unlikely(do_strace)) {
> >>>>     >     -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, =
arg6);
> >>>>     >     +        int late_printing;
> >>>>     >     +        late_printing =3D print_syscall_late(num);
> >>>>     >     +        if (!late_printing) {
> >>>>     >     +            print_syscall(num, arg1, arg2, arg3, arg4, ar=
g5, arg6);
> >>>>     >     +        }
> >>>>     >              ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg=
3, arg4,
> >>>>     >                                arg5, arg6, arg7, arg8);
> >>>>     >     +        if (late_printing) {
> >>>>     >     +            print_syscall(num, arg1, arg2, arg3, arg4, ar=
g5, arg6);
> >>>>     >     +        }
> >>>>     >              print_syscall_ret(num, ret);
> >>>>     >          } else {
> >>>>     >              ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg=
3, arg4,
> >>>>     >
> >>>>
> >>>
>


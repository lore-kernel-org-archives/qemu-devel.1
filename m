Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B5AC432C3
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 11:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC38F20748
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AWZuuZRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC38F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYqXo-0006DV-Kn
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 06:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iYqTh-0004nJ-OI
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 06:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iYqTf-0007Dx-Uj
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 06:54:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:35387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iYqTe-0007Cw-7p
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 06:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574596490;
 bh=1kZAy9gMICozO0RCt4Ha40SPF2cYOc3tln4q+AIz67Y=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=AWZuuZRcEr4OFhpw3RX65s5djU1WrSrF1wf2YtA8SMB8lHIzvdUrRZQbapjdZ2pMk
 NTyZpSAz8UVuxL4AuBfHIMJPcQdjo+jLhEzd4+RBOl00q2bCQvv21sQlqsO4q4vGKF
 hiKClQtnuWzgVp9ZDmEp6t0MSFPwtsWU5KmSjscA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.140.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1hctbb1QZ3-00yv9Q; Sun, 24
 Nov 2019 12:54:50 +0100
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
Date: Sun, 24 Nov 2019 12:54:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0IxPh/6z8fIgwmjnznm/pyUZot5wPhgIQG50/hUbY2DXK8N3yEN
 9gHeuG6GTnAorRHU+ajN+oLY8Kyw1Q9QjIzWMtDhkcPsEe64J0yo9AAwSWn36tc3kOLSl7V
 lEqLmzcX1uwe4Do+CuD66IWRst99CU8tXrk3R7urK7TF/qP6XAqFpfnQN6EQHEVd14bVDCo
 HRPM3JtaR3z4xbVJ/09fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nNbltAHaBc0=:YU/t5OueqbgUF0uhxElF1z
 aLUeiIISAvzVHHYdnuai+A1EkVhkG1EKZp7RvbnokDhd6nxosfBVSU/UZxWfyXUCOYx6nzIIy
 0meWxzNueyYsDphysrydaRV7FFmmLpMC3cqt9sTCze9g+8pEe6WqLG3euMWBvZbmc0U7QCQX+
 ZCxpoLo1itxZwoUgAfqM70OKac+zRJDEJ3ha4L04JqFE/l0H4LtALO+Fs/+S//InDvb3XMOY5
 Xy/dKrO+fDHdQVpNdVs1BkstGllPWzcHemzWc8TccGEws5eMNWc/2NeUu2PcESQKmLAImXta3
 /5psnQi46OX/Mkn06vCBWYYurzFjvP/F/Q8zIdSHmXnb2otQafXNgN/0XNd6GiJ9b4rDBom9E
 PIew79etDFN3CaYOZug29YDRHm0bEQJ/SWqRGRMV68b+x6I0XELumXJx2sXpjt7+hXBKcGPFX
 yPnHC68fB5V1iyl1Lfcx0LQyvLFHMUXwKcXXamYG6lU5lqYbWMIplRo1VMcTAKEFGdK3Jd8dJ
 QmD7bLiXFyFYBVn5L8WFhigadkvnFvdcqwyXt59wEIgx0ed/vdVajGeyGTusMj9dkPSk9WVs+
 BbHQAqYi8tdAY7ajs/pvHrBeWhPBE6UwkYq+G/aFva8acn5KF2FRbFTGk1ibeHL2ptwrJTcK6
 oCxCw+qGC4/1iWd5pnFQCEad79rEHhtCM30ufo45OES19yBP3NAn0lgWApSLAh1YBgrn96Poi
 jj++rFtURWpXGkGcsRSjahs6fdAPLuuYVuE4kfIV1Qo6O/BJSIAmEOYdclqkPBPcUZh9/zvXF
 BpdiHbu1ustqGHH03+Vbm4oFpmP5EmUYNGPoycSt+dPPta+xwm6F7BsdIK3eKzns7yzSD41rm
 YKIJNvPUTn73Iy6yo/mzC+LZ3oFKG75a4bpLxHRIi4vGkgp2eAq/Fe/yUtgLZ2zlBsZj5NLkK
 JYpUVlTi8A7NczP/KjQmTkoa7fthDavmH9dKDvQr8G2dx0idTy6hzPtJI/26chISAvPtOZrTF
 mEcdWKm8PsPI7ZOEoPPyE58TcWIJu3mFMdgIhJf1bXBA1NXzHWckvfkNYPgGyiedEfjj7k9TK
 V0Rxjm67fUMdEiDHQZDQbDYXd90ZFJo3yiPk2VIAq237Kmy8vGgj3Id3vkK3ZiAs9K1aTY6xC
 KA+xF27JQ7A/L+1NHOtCxXVEl2Ay5stiZGRkdC0mUbbG486XUuEgmihpSs2N87/e1+nsnTkx2
 pso4NUFGcCxgxwByKJxUgB4y23yATWxRqvQL3XA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.15
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

On 23.11.19 12:34, Aleksandar Markovic wrote:
> On Thursday, November 21, 2019, Helge Deller <deller@gmx.de <mailto:dell=
er@gmx.de>> wrote:
>
>     The strace functionality in qemu-user lacks the possibility to trace
>     which real values get returned to pointers in userspace by syscalls.
>
>     For example, the read() and getcwd() syscalls currently only show th=
e
>     destination address where the syscalls should put the return values:
>     2532 read(3,0xff80038c,512) =3D 512
>     2532 getcwd(0x18180,4096) =3D 9
>
>     With the patch below, one now can specify in print_syscall_late() wh=
ich
>     syscalls should be executed first, before they get printed.
>     After adding the read() and getcwd() syscalls, we now get this outpu=
t in
>     with strace instead:
>     1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\=
0\0\04"...,512) =3D 512
>     1708 getcwd("/usr/bin",4096) =3D 9
>
>     This patch adds just the framework with the respective implemenation=
s for
>     read() and getcwd(). If applied, more functions can be added easily =
later.
>
>
> Great out-of-the-box idea! However, there are some things that are
> not thought over yet. There is a good reason why strace happens
> "early": if something crash-like happens during syscall translation,
> we still have trace of original target syscall. In case of "late"
> flavor, we don't have anything. Another potentially problematic
> aspect is that end user certainly should know whether the trace was
> done "early" or "late" - otherwise, there will be, for certain, cases
> of misinterpretation / misleading / confusion of end users.

Thanks for the feedback - I'm shortly sending a v2 version which
prints the syscall name with an open parenthesis, e.g. "read(" or "getcwd(=
",
before calling the syscall. That way you can see where it crashed/hangs...

Helge

>
> Yours,
> Aleksandar
>
>
> =C2=A0
>
>     Signed-off-by: Helge Deller <deller@gmx.de <mailto:deller@gmx.de>>
>
>     diff --git a/linux-user/strace.c b/linux-user/strace.c
>     index de43238fa4..ff254732af 100644
>     --- a/linux-user/strace.c
>     +++ b/linux-user/strace.c
>     @@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int)=
;
>     =C2=A0UNUSED static void print_syscall_prologue(const struct syscall=
name *);
>     =C2=A0UNUSED static void print_syscall_epilogue(const struct syscall=
name *);
>     =C2=A0UNUSED static void print_string(abi_long, int);
>     +UNUSED static void print_encoded_string(abi_long addr, unsigned int=
 maxlen, int last);
>     =C2=A0UNUSED static void print_buf(abi_long addr, abi_long len, int =
last);
>     =C2=A0UNUSED static void print_raw_param(const char *, abi_long, int=
);
>     =C2=A0UNUSED static void print_timeval(abi_ulong, int);
>     @@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct syscallna=
me *sc)
>     =C2=A0 =C2=A0 =C2=A0gemu_log(")");
>     =C2=A0}
>
>     +#define MAX_ENCODED_CHARS 32
>     +static void
>     +print_encoded_string(abi_long addr, unsigned int maxlen, int last)
>     +{
>     +=C2=A0 =C2=A0 unsigned int maxout;
>     +=C2=A0 =C2=A0 char *s, *str;
>     +
>     +=C2=A0 =C2=A0 s =3D lock_user_string(addr);
>     +=C2=A0 =C2=A0 if (s =3D=3D NULL) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can't get string out of it, so print=
 it as pointer */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(addr, last);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 str =3D s;
>     +=C2=A0 =C2=A0 gemu_log("\"");
>     +=C2=A0 =C2=A0 maxout =3D MIN(maxlen, MAX_ENCODED_CHARS);
>     +=C2=A0 =C2=A0 while (maxout--) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char c =3D *str++;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isprint(c)) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log("%c", c);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log("\\%o", (unsigne=
d int) c);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 }
>     +=C2=A0 =C2=A0 unlock_user(s, addr, 0);
>     +
>     +=C2=A0 =C2=A0 gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..."=
 : "",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 get_comma(last));
>     +}
>     +
>     =C2=A0static void
>     =C2=A0print_string(abi_long addr, int last)
>     =C2=A0{
>     @@ -1633,6 +1665,19 @@ print_futimesat(const struct syscallname *nam=
e,
>     =C2=A0}
>     =C2=A0#endif
>
>     +#ifdef TARGET_NR_getcwd
>     +static void
>     +print_getcwd(const struct syscallname *name,
>     +=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, abi_long arg2,
>     +=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_long arg5)
>     +{
>     +=C2=A0 =C2=A0 print_syscall_prologue(name);
>     +=C2=A0 =C2=A0 print_string(arg0, 0);
>     +=C2=A0 =C2=A0 print_raw_param("%u", arg1, 1);
>     +=C2=A0 =C2=A0 print_syscall_epilogue(name);
>     +}
>     +#endif
>     +
>     =C2=A0#ifdef TARGET_NR_settimeofday
>     =C2=A0static void
>     =C2=A0print_settimeofday(const struct syscallname *name,
>     @@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscallname *nam=
e,
>     =C2=A0#define print_newfstatat=C2=A0 =C2=A0 print_fstatat64
>     =C2=A0#endif
>
>     +#ifdef TARGET_NR_read
>     +static void
>     +print_read(const struct syscallname *name,
>     +=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, abi_long arg2,
>     +=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_long arg5)
>     +{
>     +=C2=A0 =C2=A0 print_syscall_prologue(name);
>     +=C2=A0 =C2=A0 print_raw_param("%d", arg0, 0);
>     +=C2=A0 =C2=A0 print_encoded_string(arg1, arg2, 0);
>     +=C2=A0 =C2=A0 print_raw_param("%u", arg2, 1);
>     +=C2=A0 =C2=A0 print_syscall_epilogue(name);
>     +}
>     +#endif
>     +
>     =C2=A0#ifdef TARGET_NR_readlink
>     =C2=A0static void
>     =C2=A0print_readlink(const struct syscallname *name,
>     diff --git a/linux-user/strace.list b/linux-user/strace.list
>     index d49a1e92a8..220b1f4c46 100644
>     --- a/linux-user/strace.list
>     +++ b/linux-user/strace.list
>     @@ -272,7 +272,7 @@
>     =C2=A0{ TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
>     =C2=A0#endif
>     =C2=A0#ifdef TARGET_NR_getcwd
>     -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
>     +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
>     =C2=A0#endif
>     =C2=A0#ifdef TARGET_NR_getdents
>     =C2=A0{ TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
>     @@ -1080,7 +1080,7 @@
>     =C2=A0{ TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>     =C2=A0#endif
>     =C2=A0#ifdef TARGET_NR_read
>     -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
>     +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
>     =C2=A0#endif
>     =C2=A0#ifdef TARGET_NR_readahead
>     =C2=A0{ TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
>     diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>     index ce399a55f0..c0079ca2b7 100644
>     --- a/linux-user/syscall.c
>     +++ b/linux-user/syscall.c
>     @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *cpu_env, =
int num, abi_long arg1,
>     =C2=A0 =C2=A0 =C2=A0return ret;
>     =C2=A0}
>
>     +/*
>     + * True if this syscall should be printed after having called the n=
ative
>     + * syscall, so that values which are fed back to userspace gets pri=
nted.
>     + */
>     +static int print_syscall_late(int syscall)
>     +{
>     +=C2=A0 =C2=A0 switch (syscall) {
>     +=C2=A0 =C2=A0 case TARGET_NR_getcwd:
>     +=C2=A0 =C2=A0 case TARGET_NR_read:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>     +=C2=A0 =C2=A0 default:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>     +=C2=A0 =C2=A0 }
>     +}
>     +
>     =C2=A0abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_long arg2, abi_long arg3, abi_long arg4,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0abi_long arg5, abi_long arg6, abi_long arg7,
>     @@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env, int num,=
 abi_long arg1,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>
>     =C2=A0 =C2=A0 =C2=A0if (unlikely(do_strace)) {
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg1, arg2, arg3, ar=
g4, arg5, arg6);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int late_printing;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 late_printing =3D print_syscall_late(nu=
m);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!late_printing) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg1, =
arg2, arg3, arg4, arg5, arg6);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_syscall1(cpu_env, num, =
arg1, arg2, arg3, arg4,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg5, arg6, arg7, arg8);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (late_printing) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg1, =
arg2, arg3, arg4, arg5, arg6);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_syscall_ret(num, ret);
>     =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_syscall1(cpu_env, num, =
arg1, arg2, arg3, arg4,
>



Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD940C18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9F621D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyS2A2f4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9F621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMp0-0000mD-Nj
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jBMoB-0000GD-JN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jBMo9-0003WO-1g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:07:19 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jBMo8-0003Vj-OU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:07:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id l12so11079208oil.9
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U0A+5EVKCzegWw34uZ965O9NrF0Cy9g/LnEm58t5NWI=;
 b=hyS2A2f49BaP5tLnUZItrCih+Du0koHw8vfUgYMlBVagBaiJaE186S6S837150l/K4
 y/AkG9kxuvQlqCpvk9tYR4xsYpVrkoCBc4LzoiViI5d/sXE953R1X5RPe5KFhrT1n4UO
 stGVBwTcvoxhVyMndRoUZvb4PkFskB9cvkUQNEL9ODt97Ckg+3RrDC5Jv4GuGun2Ivsk
 7V/2dyqZ3mhw4U7EQ3bcd8C0VyZcN783xx9S/wg5qcV1fdiTNoKuxQ/mhcXVUlLengmK
 pK5NW2m5lG5JRLxYljPXdXzrYYg7qhhXgae308iXyF8zbQAyciumPrYUK5Vtpca3Kc1y
 YFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U0A+5EVKCzegWw34uZ965O9NrF0Cy9g/LnEm58t5NWI=;
 b=cFQ+XaBHVQNE9qEzdrnXGm8BwHkc6d5sJahpsFyI+HGI+7niIDGDECsu9B5zzc8ob0
 0KM0SSiQN8dx6Umr/5Z4gDdWJQib1VWuIT5pdCxSgzUNgCE+JG580F/5c4R+Pb05Tbjt
 8LKlIzrlCcPdlvl5oGmMYCPlD0nCzeAVGE15uvUovwAjPAfucsyO8jCoizTKpCD+jSCw
 sZ0Itk5P9Ip7YzykZK67jFcDgR9pZU1Vn0jSaTUO0w4wMm9G9lGMVYheLo70s5rO+S5x
 7VbNJvu/jYo+X0sX3rlahnNmFQtE9hyxbqMzTxQGSB+PWe7ndx5cZYYifAPPHNmL/eqv
 mElg==
X-Gm-Message-State: ANhLgQ0gGaDU3SuYZwrgrbatLF0fzil1Jqw5zUpUnNvQsOslgFX4hZEP
 FVDcm/LmERWWmJy5o+gDrib5FCrQdE4B7dluUu4otA==
X-Google-Smtp-Source: ADFU+vvv6Uf6ubvqt5C6FXd3XMjY9b5LjPpkaP0W2+sDS/BOsZSYuvPNVG+QZWjm9ArxWjsUzleF2vdvs4G81sCWKOY=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr329043oif.131.1583777234931; 
 Mon, 09 Mar 2020 11:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200222010925.32858-1-yuanzi@google.com>
 <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
 <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
 <CADjx4CJSDkA3aDxhp2yZJBnKtUe4YntfpdEKp91VS0JiUhE+2Q@mail.gmail.com>
 <0f138812-b036-f99b-3d50-b871863d22f2@vivier.eu>
 <CADjx4CJ1Z7kbntP+QH6WOiZSSa7g0nU596e6iiHWWbCAqebP+A@mail.gmail.com>
In-Reply-To: <CADjx4CJ1Z7kbntP+QH6WOiZSSa7g0nU596e6iiHWWbCAqebP+A@mail.gmail.com>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 9 Mar 2020 11:07:03 -0700
Message-ID: <CADjx4C+wS-1dpTiJDULs09y1T8yYSLTBJ7E6LZYoUqZbW-cfxQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Content-Type: multipart/alternative; boundary="0000000000007e42a405a06fdf8b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

--0000000000007e42a405a06fdf8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2020 at 11:51 AM Lirong Yuan <yuanzi@google.com> wrote:

> On Mon, Mar 2, 2020 at 10:39 AM Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > Le 02/03/2020 =C3=A0 18:53, Lirong Yuan a =C3=A9crit :
> > > On Mon, Mar 2, 2020 at 6:56 AM Laurent Vivier <laurent@vivier.eu>
> wrote:
> > >>
> > >> Le 29/02/2020 =C3=A0 01:43, Lirong Yuan a =C3=A9crit :
> > >>> On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.com>
> wrote:
> > >>>>
> > >>>> This change allows us to set custom base address for guest
> programs. It is needed to allow qemu to work with Thread Sanitizer (TSan)=
,
> which has specific boundary definitions for memory mappings on different
> platforms:
> > >>>>
> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl=
/tsan_platform.h
> > >>
> > >> Could you give more details and some examples?
> > >>
> > >> Thanks,
> > >> Laurent
> > >>
> > >>>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> > >>>> ---
> > >>>>  linux-user/main.c | 12 ++++++++++++
> > >>>>  linux-user/mmap.c |  3 ++-
> > >>>>  linux-user/qemu.h |  5 +++++
> > >>>>  3 files changed, 19 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/linux-user/main.c b/linux-user/main.c
> > >>>> index fba833aac9..c01af6bfee 100644
> > >>>> --- a/linux-user/main.c
> > >>>> +++ b/linux-user/main.c
> > >>>> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const char
> *arg)
> > >>>>      have_guest_base =3D 1;
> > >>>>  }
> > >>>>
> > >>>> +static void handle_arg_mmap_base(const char *arg)
> > >>>> +{
> > >>>> +    int err =3D qemu_strtoul(arg, NULL, 0, &mmap_base);
> > >>>> +    if (err) {
> > >>>> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n", arg,
> err);
> > >>>> +        exit(EXIT_FAILURE);
> > >>>> +    }
> > >>>> +    mmap_next_start =3D mmap_base;
> > >>>> +}
> > >>>> +
> > >>>>  static void handle_arg_reserved_va(const char *arg)
> > >>>>  {
> > >>>>      char *p;
> > >>>> @@ -440,6 +450,8 @@ static const struct qemu_argument arg_table[] =
=3D
> {
> > >>>>       "uname",      "set qemu uname release string to 'uname'"},
> > >>>>      {"B",          "QEMU_GUEST_BASE",  true,
> handle_arg_guest_base,
> > >>>>       "address",    "set guest_base address to 'address'"},
> > >>>> +    {"mmap_base",  "QEMU_MMAP_BASE",   true,  handle_arg_mmap_bas=
e,
> > >>>> +     "",           "begin allocating guest pages at this host
> address"},
> > >>>>      {"R",          "QEMU_RESERVED_VA", true,
> handle_arg_reserved_va,
> > >>>>       "size",       "reserve 'size' bytes for guest virtual addres=
s
> space"},
> > >>>>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
> > >>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> > >>>> index 8685f02e7e..3f35543acf 100644
> > >>>> --- a/linux-user/mmap.c
> > >>>> +++ b/linux-user/mmap.c
> > >>>> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
> > >>>>  # define TASK_UNMAPPED_BASE  0x40000000
> > >>>>  #endif
> > >>>>  abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
> > >>>> +abi_ulong mmap_base =3D TASK_UNMAPPED_BASE;
> > >>>>
> > >>>>  unsigned long last_brk;
> > >>>>
> > >>>> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start,
> abi_ulong size, abi_ulong align)
> > >>>>
> > >>>>              if ((addr & (align - 1)) =3D=3D 0) {
> > >>>>                  /* Success.  */
> > >>>> -                if (start =3D=3D mmap_next_start && addr >=3D
> TASK_UNMAPPED_BASE) {
> > >>>> +                if (start =3D=3D mmap_next_start && addr >=3D mma=
p_base)
> {
> > >>>>                      mmap_next_start =3D addr + size;
> > >>>>                  }
> > >>>>                  return addr;
> > >>>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> > >>>> index 560a68090e..83c00cfea2 100644
> > >>>> --- a/linux-user/qemu.h
> > >>>> +++ b/linux-user/qemu.h
> > >>>> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
> > >>>>  void stop_all_tasks(void);
> > >>>>  extern const char *qemu_uname_release;
> > >>>>  extern unsigned long mmap_min_addr;
> > >>>> +/*
> > >>>> + * mmap_base is minimum address to use when allocating guest
> pages. All guest
> > >>>> + * pages will be allocated at this (guest) address or higher
> addresses.
> > >>>> + */
> > >>>> +extern abi_ulong mmap_base;
> > >>>>
> > >>>>  /* ??? See if we can avoid exposing so much of the loader
> internals.  */
> > >>>>
> > >>>> --
> > >>>> 2.25.0.265.gbab2e86ba0-goog
> > >>>>
> > >>>
> > >>> Friendly ping~
> > >>>
> > >>> Link to the page for the patch on patchwork:
> > >>> http://patchwork.ozlabs.org/patch/1242370/
> > >>>
> > >>
> > >
> > > Hi Laurent,
> > >
> > > Sure! We tried to run a program with TSAN enabled
> > > (https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual)
> > > in qemu, and got this error message:
> > > "FATAL: ThreadSanitizer: unexpected memory mapping
> > > 0x004000000000-0x004000253000"
> > >
> > > The root cause is that the default guest base address that qemu uses
> > > is 0x4000000000 (1ul<<38), and does not align with TSAN's expectation=
:
> > >
> https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27=
c/linux-user/mmap.c#L187
> > >
> https://github.com/llvm/llvm-project/blob/e7de00cf974a4e30d4900518ae8473a=
117efbd6c/compiler-rt/lib/tsan/rtl/tsan_platform.h#L150
> > >
> > > By setting QEMU_GUEST_BASE, we can place the guest program at a
> > > different base address in the host program. However, the h2g function
> > > (in |open_self_maps| in syscall.c) translates the address back to be
> > > based at 0x4000000000. E.g. the base address
> > > 0x4000000000+QEMU_GUEST_BASE will be converted to 0x4000000000 with
> > > function h2g:
> > >
> https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27=
c/linux-user/syscall.c#L7076
> > >
> > > One solution then, is to update |open_self_maps| in syscall.c to not
> > > use h2g. However this changes the meaning of QEMU_GUEST_BASE and coul=
d
> > > break existing programs that set non-zero QEMU_GUEST_BASE.
> > >
> > > So, how did qemu pick the base address 0x4000000000 then? Looking at
> > > the blame output in github, one recent change for the base address wa=
s
> > > committed 10 years ago:
> > > https://github.com/qemu/qemu/c|open_self_maps| in
> > > syscall.commit/14f24e1465edc44b9b4d89fbbea66e06088154e1
> > >
> > > Another one was committed 12 years ago:
> > >
> https://github.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b18=
d53
> > >
> > > The description of the first change is "place the default mapping bas=
e
> > > for 64-bit guests (on 64-bit hosts) outside the low 4G". It would see=
m
> > > that minimum requirements for the base address are:
> > > 1) addr >=3D 4G (for 64-bit)
> > > 2) addr < lowest address used by the host qemu program by some margin
> > >
> > > Given that
> > > 1) only TSAN explicitly check for the validity of addresses
> > > 2) 0x4000000000 is not a valid address for programs on aarch64
> > > (according to TSAN)
> > > 3) different architectures have different valid addresses,
> > > it would seem that adding an argument for changing the hard-coded bas=
e
> > > address is a viable solution.
> >
> > Thank you for the detailed explanation.
> >
> > Could you show me an example of the QEMU command line you use?
> >
> > I'm wondering if hardcoding directly the good value would be a better
> > solution?
> >
> > Richard, do you have some thoughts on this?
> >
> > Thanks,
> > Laurent
>
> Sure! First we compile a simple race program with TSAN enabled:
> ( Simple race program is here:
> https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual#usage
> )
> $ clang++ simple_race.cc -fsanitize=3Dthread -fPIE -pie -g -o simple_race
>
> Next we run a script for executing the program, and it exports
> environment variables:
> QEMU_CPU=3Dmax
> QEMU_MMAP_BASE=3D0x0000005500000000
>
> And runs the QEMU program:
> $ qemu-aarch64 simple_race
>
> I changed the default value for all other programs that I am working
> with, and so far we haven't seen any problems.
> For the patch, it might be better to err on the safe side and not
> change the hard-coded value, as it might cause potential breakages for
> other users.
> Though I don't know much about how the default value might be used or
> depended on by other programs, so if you see no concerns for updating
> the value, I'd be happy to change it too.
>

Friendly ping~

Link to the page for the patch on patchwork:
http://patchwork.ozlabs.org/patch/1242370/

--0000000000007e42a405a06fdf8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 11:51 AM Lirong Yu=
an &lt;<a href=3D"mailto:yuanzi@google.com">yuanzi@google.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar 2,=
 2020 at 10:39 AM Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" t=
arget=3D"_blank">laurent@vivier.eu</a>&gt; wrote:<br>
&gt;<br>
&gt; Le 02/03/2020 =C3=A0 18:53, Lirong Yuan a =C3=A9crit :<br>
&gt; &gt; On Mon, Mar 2, 2020 at 6:56 AM Laurent Vivier &lt;<a href=3D"mail=
to:laurent@vivier.eu" target=3D"_blank">laurent@vivier.eu</a>&gt; wrote:<br=
>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Le 29/02/2020 =C3=A0 01:43, Lirong Yuan a =C3=A9crit :<br>
&gt; &gt;&gt;&gt; On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan &lt;<a href=
=3D"mailto:yuanzi@google.com" target=3D"_blank">yuanzi@google.com</a>&gt; w=
rote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; This change allows us to set custom base address for =
guest programs. It is needed to allow qemu to work with Thread Sanitizer (T=
San), which has specific boundary definitions for memory mappings on differ=
ent platforms:<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"https://github.com/llvm/llvm-project/blob/=
master/compiler-rt/lib/tsan/rtl/tsan_platform.h" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/llvm/llvm-project/blob/master/compiler-rt/li=
b/tsan/rtl/tsan_platform.h</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Could you give more details and some examples?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Laurent<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Signed-off-by: Lirong Yuan &lt;<a href=3D"mailto:yuan=
zi@google.com" target=3D"_blank">yuanzi@google.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 linux-user/main.c | 12 ++++++++++++<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 linux-user/mmap.c |=C2=A0 3 ++-<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 linux-user/qemu.h |=C2=A0 5 +++++<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 3 files changed, 19 insertions(+), 1 deletion(-=
)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; diff --git a/linux-user/main.c b/linux-user/main.c<br=
>
&gt; &gt;&gt;&gt;&gt; index fba833aac9..c01af6bfee 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/linux-user/main.c<br>
&gt; &gt;&gt;&gt;&gt; +++ b/linux-user/main.c<br>
&gt; &gt;&gt;&gt;&gt; @@ -336,6 +336,16 @@ static void handle_arg_guest_bas=
e(const char *arg)<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 have_guest_base =3D 1;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; +static void handle_arg_mmap_base(const char *arg)<br=
>
&gt; &gt;&gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int err =3D qemu_strtoul(arg, NULL, 0,=
 &amp;mmap_base);<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;In=
valid mmap_base: %s, err: %d\n&quot;, arg, err);<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 mmap_next_start =3D mmap_base;<br>
&gt; &gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 static void handle_arg_reserved_va(const char *=
arg)<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 char *p;<br>
&gt; &gt;&gt;&gt;&gt; @@ -440,6 +450,8 @@ static const struct qemu_argument=
 arg_table[] =3D {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;uname&quot;,=C2=A0 =
=C2=A0 =C2=A0 &quot;set qemu uname release string to &#39;uname&#39;&quot;}=
,<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {&quot;B&quot;,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;QEMU_GUEST_BASE&quot;,=C2=A0 true,=C2=A0 handle_arg=
_guest_base,<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;address&quot;,=C2=A0 =
=C2=A0 &quot;set guest_base address to &#39;address&#39;&quot;},<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 {&quot;mmap_base&quot;,=C2=A0 &quot;QE=
MU_MMAP_BASE&quot;,=C2=A0 =C2=A0true,=C2=A0 handle_arg_mmap_base,<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;begin allocating guest pages at this host add=
ress&quot;},<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {&quot;R&quot;,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;QEMU_RESERVED_VA&quot;, true,=C2=A0 handle_arg_rese=
rved_va,<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;size&quot;,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;reserve &#39;size&#39; bytes for guest virtual addre=
ss space&quot;},<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {&quot;d&quot;,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;QEMU_LOG&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tr=
ue,=C2=A0 handle_arg_log,<br>
&gt; &gt;&gt;&gt;&gt; diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br=
>
&gt; &gt;&gt;&gt;&gt; index 8685f02e7e..3f35543acf 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/linux-user/mmap.c<br>
&gt; &gt;&gt;&gt;&gt; +++ b/linux-user/mmap.c<br>
&gt; &gt;&gt;&gt;&gt; @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong re=
al_start,<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 # define TASK_UNMAPPED_BASE=C2=A0 0x40000000<br=
>
&gt; &gt;&gt;&gt;&gt;=C2=A0 #endif<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 abi_ulong mmap_next_start =3D TASK_UNMAPPED_BAS=
E;<br>
&gt; &gt;&gt;&gt;&gt; +abi_ulong mmap_base =3D TASK_UNMAPPED_BASE;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 unsigned long last_brk;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong=
 start, abi_ulong size, abi_ulong align)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((=
addr &amp; (align - 1)) =3D=3D 0) {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Success.=C2=A0 */<br>
&gt; &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (start =3D=3D mmap_next_start &amp;&amp; addr &gt;=3D TASK_UNMAPPED_=
BASE) {<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (start =3D=3D mmap_next_start &amp;&amp; addr &gt;=3D mmap_base) {<b=
r>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 mmap_next_start =3D addr + size;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return addr;<br>
&gt; &gt;&gt;&gt;&gt; diff --git a/linux-user/qemu.h b/linux-user/qemu.h<br=
>
&gt; &gt;&gt;&gt;&gt; index 560a68090e..83c00cfea2 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/linux-user/qemu.h<br>
&gt; &gt;&gt;&gt;&gt; +++ b/linux-user/qemu.h<br>
&gt; &gt;&gt;&gt;&gt; @@ -161,6 +161,11 @@ void task_settid(TaskState *);<b=
r>
&gt; &gt;&gt;&gt;&gt;=C2=A0 void stop_all_tasks(void);<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 extern const char *qemu_uname_release;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 extern unsigned long mmap_min_addr;<br>
&gt; &gt;&gt;&gt;&gt; +/*<br>
&gt; &gt;&gt;&gt;&gt; + * mmap_base is minimum address to use when allocati=
ng guest pages. All guest<br>
&gt; &gt;&gt;&gt;&gt; + * pages will be allocated at this (guest) address o=
r higher addresses.<br>
&gt; &gt;&gt;&gt;&gt; + */<br>
&gt; &gt;&gt;&gt;&gt; +extern abi_ulong mmap_base;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 /* ??? See if we can avoid exposing so much of =
the loader internals.=C2=A0 */<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;&gt; 2.25.0.265.gbab2e86ba0-goog<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Friendly ping~<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Link to the page for the patch on patchwork:<br>
&gt; &gt;&gt;&gt; <a href=3D"http://patchwork.ozlabs.org/patch/1242370/" re=
l=3D"noreferrer" target=3D"_blank">http://patchwork.ozlabs.org/patch/124237=
0/</a><br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi Laurent,<br>
&gt; &gt;<br>
&gt; &gt; Sure! We tried to run a program with TSAN enabled<br>
&gt; &gt; (<a href=3D"https://github.com/google/sanitizers/wiki/ThreadSanit=
izerCppManual" rel=3D"noreferrer" target=3D"_blank">https://github.com/goog=
le/sanitizers/wiki/ThreadSanitizerCppManual</a>)<br>
&gt; &gt; in qemu, and got this error message:<br>
&gt; &gt; &quot;FATAL: ThreadSanitizer: unexpected memory mapping<br>
&gt; &gt; 0x004000000000-0x004000253000&quot;<br>
&gt; &gt;<br>
&gt; &gt; The root cause is that the default guest base address that qemu u=
ses<br>
&gt; &gt; is 0x4000000000 (1ul&lt;&lt;38), and does not align with TSAN&#39=
;s expectation:<br>
&gt; &gt; <a href=3D"https://github.com/qemu/qemu/blob/c81acb643a61db199b91=
98add7972d8a8496b27c/linux-user/mmap.c#L187" rel=3D"noreferrer" target=3D"_=
blank">https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a84=
96b27c/linux-user/mmap.c#L187</a><br>
&gt; &gt; <a href=3D"https://github.com/llvm/llvm-project/blob/e7de00cf974a=
4e30d4900518ae8473a117efbd6c/compiler-rt/lib/tsan/rtl/tsan_platform.h#L150"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/llvm/llvm-project/=
blob/e7de00cf974a4e30d4900518ae8473a117efbd6c/compiler-rt/lib/tsan/rtl/tsan=
_platform.h#L150</a><br>
&gt; &gt;<br>
&gt; &gt; By setting QEMU_GUEST_BASE, we can place the guest program at a<b=
r>
&gt; &gt; different base address in the host program. However, the h2g func=
tion<br>
&gt; &gt; (in |open_self_maps| in syscall.c) translates the address back to=
 be<br>
&gt; &gt; based at 0x4000000000. E.g. the base address<br>
&gt; &gt; 0x4000000000+QEMU_GUEST_BASE will be converted to 0x4000000000 wi=
th<br>
&gt; &gt; function h2g:<br>
&gt; &gt; <a href=3D"https://github.com/qemu/qemu/blob/c81acb643a61db199b91=
98add7972d8a8496b27c/linux-user/syscall.c#L7076" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972=
d8a8496b27c/linux-user/syscall.c#L7076</a><br>
&gt; &gt;<br>
&gt; &gt; One solution then, is to update |open_self_maps| in syscall.c to =
not<br>
&gt; &gt; use h2g. However this changes the meaning of QEMU_GUEST_BASE and =
could<br>
&gt; &gt; break existing programs that set non-zero QEMU_GUEST_BASE.<br>
&gt; &gt;<br>
&gt; &gt; So, how did qemu pick the base address 0x4000000000 then? Looking=
 at<br>
&gt; &gt; the blame output in github, one recent change for the base addres=
s was<br>
&gt; &gt; committed 10 years ago:<br>
&gt; &gt; <a href=3D"https://github.com/qemu/qemu/c%7Copen_self_maps%7C" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/c|open_self=
_maps|</a> in<br>
&gt; &gt; syscall.commit/14f24e1465edc44b9b4d89fbbea66e06088154e1<br>
&gt; &gt;<br>
&gt; &gt; Another one was committed 12 years ago:<br>
&gt; &gt; <a href=3D"https://github.com/qemu/qemu/commit/a03e2d421e7f333167=
50d6b7396d1a7e14b18d53" rel=3D"noreferrer" target=3D"_blank">https://github=
.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b18d53</a><br>
&gt; &gt;<br>
&gt; &gt; The description of the first change is &quot;place the default ma=
pping base<br>
&gt; &gt; for 64-bit guests (on 64-bit hosts) outside the low 4G&quot;. It =
would seem<br>
&gt; &gt; that minimum requirements for the base address are:<br>
&gt; &gt; 1) addr &gt;=3D 4G (for 64-bit)<br>
&gt; &gt; 2) addr &lt; lowest address used by the host qemu program by some=
 margin<br>
&gt; &gt;<br>
&gt; &gt; Given that<br>
&gt; &gt; 1) only TSAN explicitly check for the validity of addresses<br>
&gt; &gt; 2) 0x4000000000 is not a valid address for programs on aarch64<br=
>
&gt; &gt; (according to TSAN)<br>
&gt; &gt; 3) different architectures have different valid addresses,<br>
&gt; &gt; it would seem that adding an argument for changing the hard-coded=
 base<br>
&gt; &gt; address is a viable solution.<br>
&gt;<br>
&gt; Thank you for the detailed explanation.<br>
&gt;<br>
&gt; Could you show me an example of the QEMU command line you use?<br>
&gt;<br>
&gt; I&#39;m wondering if hardcoding directly the good value would be a bet=
ter<br>
&gt; solution?<br>
&gt;<br>
&gt; Richard, do you have some thoughts on this?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Laurent<br>
<br>
Sure! First we compile a simple race program with TSAN enabled:<br>
( Simple race program is here:<br>
<a href=3D"https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManu=
al#usage" rel=3D"noreferrer" target=3D"_blank">https://github.com/google/sa=
nitizers/wiki/ThreadSanitizerCppManual#usage</a><br>
)<br>
$ clang++ simple_race.cc -fsanitize=3Dthread -fPIE -pie -g -o simple_race<b=
r>
<br>
Next we run a script for executing the program, and it exports<br>
environment variables:<br>
QEMU_CPU=3Dmax<br>
QEMU_MMAP_BASE=3D0x0000005500000000<br>
<br>
And runs the QEMU program:<br>
$ qemu-aarch64 simple_race<br>
<br>
I changed the default value for all other programs that I am working<br>
with, and so far we haven&#39;t seen any problems.<br>
For the patch, it might be better to err on the safe side and not<br>
change the hard-coded value, as it might cause potential breakages for<br>
other users.<br>
Though I don&#39;t know much about how the default value might be used or<b=
r>
depended on by other programs, so if you see no concerns for updating<br>
the value, I&#39;d be happy to change it too.<br></blockquote><div><br></di=
v>Friendly ping~<br><br>Link to the page for the patch on patchwork:<br><di=
v><a href=3D"http://patchwork.ozlabs.org/patch/1242370/" rel=3D"noreferrer"=
 target=3D"_blank">http://patchwork.ozlabs.org/patch/1242370/</a>=C2=A0</di=
v></div></div>

--0000000000007e42a405a06fdf8b--


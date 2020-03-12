Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE23C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FBF206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FBF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJQe-0006KY-Q4
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCJQ1-0005nQ-JC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCJPz-0006Ki-Gj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:42:17 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jCJPt-0006Fz-32; Thu, 12 Mar 2020 04:42:09 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N6sWd-1jOQuy19ah-018LAM; Thu, 12 Mar 2020 09:42:03 +0100
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
To: Lirong Yuan <yuanzi@google.com>
References: <20200222010925.32858-1-yuanzi@google.com>
 <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
 <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
 <CADjx4CJSDkA3aDxhp2yZJBnKtUe4YntfpdEKp91VS0JiUhE+2Q@mail.gmail.com>
 <0f138812-b036-f99b-3d50-b871863d22f2@vivier.eu>
 <CADjx4CJ1Z7kbntP+QH6WOiZSSa7g0nU596e6iiHWWbCAqebP+A@mail.gmail.com>
 <CADjx4C+wS-1dpTiJDULs09y1T8yYSLTBJ7E6LZYoUqZbW-cfxQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <19f04b9a-866f-9529-4f89-bf88cf487738@vivier.eu>
Date: Thu, 12 Mar 2020 09:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADjx4C+wS-1dpTiJDULs09y1T8yYSLTBJ7E6LZYoUqZbW-cfxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OxKT9P/8T6rTyvSiHH4v8jv2HOL2X8vIwkWU0yQvucKV6JH/Ruo
 HqSsJ/gIgM4HTxpFiWZKlY79MC70ycIhE2GrEQULoX5hi6nJp/R+7RXz1YkLcHDnlno3AXb
 gbVN1jx4kHuyVr6cE00dWdJHzoju9CdunKAm+MY0XdcvEuDMQceTyF7+hzuMAD5xneU6ppI
 cAJ12iyW5fKqYt8V0tHXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ye/RBfxiGdQ=:BcRe4G31IrZTMTtzCgv4Tp
 YYym+8ttLJ/dJjSTOT2k/45xxKNoT4gvS8L1Y+b/K/WQOVDHRhou05w8MZnxX0EY5gQylP7bL
 dCdW10rlJFQ3TcZizNJIt10+QC6CQBMvdCHNW4f/hp3Hf4NHhhAlDUktZc9lzIMXMbUCqgksk
 5y/1MjiE5LDVv1eRsYRmBVcEGS2OX1+69arOnW/26aN7CkWEM75o7qznI9CHNxFxIR5DYFePR
 UMVAvAvvpD8O0j0SZAPlAwXVIOmN01mn29uvAZzDfagjHRnArPWUAoYvSoXtB0Ua05nmeZVeJ
 ZB49Ei6wHHm8eXArxeWrYF2CT93G1cMiYj5ECHOpaAzVt9YseGiGgu8TEttsjypOk+lfwcgdI
 HB83Nm5zhVlv8wUX7deegkANWxGpEj+azdEn2G6OVt9MBLzzw9mF6hzEpseaCXYrubR3j8Sh2
 RTWUwMjLHm+T1fWLLZruA0u4ux+th/9OJIO9HMIljN5VzSmG77ojwgiDESOHvIp8BXKIHe1X3
 3hTlM52XY2h2dHDzgiJ1OBo30kWRCdANIGbcb21rgu2ycQJfUVLSShLo3azGCP7RMsqVLC1q3
 ddfmfE4waOiOLhqvN8RhOUMorgREq8aLpi16UbcskqicZUhOzqyPjxg9/OlgHvlp53RGY+VUt
 aGctXTZqIWFDZtw61gY0l3SFni5w46LKJI+JGHp8Gv1hUSW2k5AdtFKx2otoHdYMAu7cGsaXg
 bxre+LDFfIlGUaFwM/BImsW6ouTEMuN8Jb5gyoeoqNZbWelQjs7P2XD71rDtjuQnOFMyNzwmF
 Z7zr5VhWy2+cUQ+YrEycx3YKhOCTMQuZIJ3iSFCf8WzHR5g9MScP6+n/+lqvENLfBGZ89lT
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/03/2020 à 19:07, Lirong Yuan a écrit :
> 
> On Mon, Mar 2, 2020 at 11:51 AM Lirong Yuan <yuanzi@google.com
> <mailto:yuanzi@google.com>> wrote:
> 
>     On Mon, Mar 2, 2020 at 10:39 AM Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>> wrote:
>     >
>     > Le 02/03/2020 à 18:53, Lirong Yuan a écrit :
>     > > On Mon, Mar 2, 2020 at 6:56 AM Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>> wrote:
>     > >>
>     > >> Le 29/02/2020 à 01:43, Lirong Yuan a écrit :
>     > >>> On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.com
>     <mailto:yuanzi@google.com>> wrote:
>     > >>>>
>     > >>>> This change allows us to set custom base address for guest
>     programs. It is needed to allow qemu to work with Thread Sanitizer
>     (TSan), which has specific boundary definitions for memory mappings
>     on different platforms:
>     > >>>>
>     https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h
>     > >>
>     > >> Could you give more details and some examples?
>     > >>
>     > >> Thanks,
>     > >> Laurent
>     > >>
>     > >>>> Signed-off-by: Lirong Yuan <yuanzi@google.com
>     <mailto:yuanzi@google.com>>
>     > >>>> ---
>     > >>>>  linux-user/main.c | 12 ++++++++++++
>     > >>>>  linux-user/mmap.c |  3 ++-
>     > >>>>  linux-user/qemu.h |  5 +++++
>     > >>>>  3 files changed, 19 insertions(+), 1 deletion(-)
>     > >>>>
>     > >>>> diff --git a/linux-user/main.c b/linux-user/main.c
>     > >>>> index fba833aac9..c01af6bfee 100644
>     > >>>> --- a/linux-user/main.c
>     > >>>> +++ b/linux-user/main.c
>     > >>>> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const
>     char *arg)
>     > >>>>      have_guest_base = 1;
>     > >>>>  }
>     > >>>>
>     > >>>> +static void handle_arg_mmap_base(const char *arg)
>     > >>>> +{
>     > >>>> +    int err = qemu_strtoul(arg, NULL, 0, &mmap_base);
>     > >>>> +    if (err) {
>     > >>>> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n",
>     arg, err);
>     > >>>> +        exit(EXIT_FAILURE);
>     > >>>> +    }
>     > >>>> +    mmap_next_start = mmap_base;
>     > >>>> +}
>     > >>>> +
>     > >>>>  static void handle_arg_reserved_va(const char *arg)
>     > >>>>  {
>     > >>>>      char *p;
>     > >>>> @@ -440,6 +450,8 @@ static const struct qemu_argument
>     arg_table[] = {
>     > >>>>       "uname",      "set qemu uname release string to 'uname'"},
>     > >>>>      {"B",          "QEMU_GUEST_BASE",  true, 
>     handle_arg_guest_base,
>     > >>>>       "address",    "set guest_base address to 'address'"},
>     > >>>> +    {"mmap_base",  "QEMU_MMAP_BASE",   true, 
>     handle_arg_mmap_base,
>     > >>>> +     "",           "begin allocating guest pages at this
>     host address"},
>     > >>>>      {"R",          "QEMU_RESERVED_VA", true, 
>     handle_arg_reserved_va,
>     > >>>>       "size",       "reserve 'size' bytes for guest virtual
>     address space"},
>     > >>>>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
>     > >>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>     > >>>> index 8685f02e7e..3f35543acf 100644
>     > >>>> --- a/linux-user/mmap.c
>     > >>>> +++ b/linux-user/mmap.c
>     > >>>> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
>     > >>>>  # define TASK_UNMAPPED_BASE  0x40000000
>     > >>>>  #endif
>     > >>>>  abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
>     > >>>> +abi_ulong mmap_base = TASK_UNMAPPED_BASE;
>     > >>>>
>     > >>>>  unsigned long last_brk;
>     > >>>>
>     > >>>> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start,
>     abi_ulong size, abi_ulong align)
>     > >>>>
>     > >>>>              if ((addr & (align - 1)) == 0) {
>     > >>>>                  /* Success.  */
>     > >>>> -                if (start == mmap_next_start && addr >=
>     TASK_UNMAPPED_BASE) {
>     > >>>> +                if (start == mmap_next_start && addr >=
>     mmap_base) {
>     > >>>>                      mmap_next_start = addr + size;
>     > >>>>                  }
>     > >>>>                  return addr;
>     > >>>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>     > >>>> index 560a68090e..83c00cfea2 100644
>     > >>>> --- a/linux-user/qemu.h
>     > >>>> +++ b/linux-user/qemu.h
>     > >>>> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
>     > >>>>  void stop_all_tasks(void);
>     > >>>>  extern const char *qemu_uname_release;
>     > >>>>  extern unsigned long mmap_min_addr;
>     > >>>> +/*
>     > >>>> + * mmap_base is minimum address to use when allocating guest
>     pages. All guest
>     > >>>> + * pages will be allocated at this (guest) address or higher
>     addresses.
>     > >>>> + */
>     > >>>> +extern abi_ulong mmap_base;
>     > >>>>
>     > >>>>  /* ??? See if we can avoid exposing so much of the loader
>     internals.  */
>     > >>>>
>     > >>>> --
>     > >>>> 2.25.0.265.gbab2e86ba0-goog
>     > >>>>
>     > >>>
>     > >>> Friendly ping~
>     > >>>
>     > >>> Link to the page for the patch on patchwork:
>     > >>> http://patchwork.ozlabs.org/patch/1242370/
>     > >>>
>     > >>
>     > >
>     > > Hi Laurent,
>     > >
>     > > Sure! We tried to run a program with TSAN enabled
>     > > (https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual)
>     > > in qemu, and got this error message:
>     > > "FATAL: ThreadSanitizer: unexpected memory mapping
>     > > 0x004000000000-0x004000253000"
>     > >
>     > > The root cause is that the default guest base address that qemu uses
>     > > is 0x4000000000 (1ul<<38), and does not align with TSAN's
>     expectation:
>     > >
>     https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27c/linux-user/mmap.c#L187
>     > >
>     https://github.com/llvm/llvm-project/blob/e7de00cf974a4e30d4900518ae8473a117efbd6c/compiler-rt/lib/tsan/rtl/tsan_platform.h#L150
>     > >
>     > > By setting QEMU_GUEST_BASE, we can place the guest program at a
>     > > different base address in the host program. However, the h2g
>     function
>     > > (in |open_self_maps| in syscall.c) translates the address back to be
>     > > based at 0x4000000000. E.g. the base address
>     > > 0x4000000000+QEMU_GUEST_BASE will be converted to 0x4000000000 with
>     > > function h2g:
>     > >
>     https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27c/linux-user/syscall.c#L7076
>     > >
>     > > One solution then, is to update |open_self_maps| in syscall.c to not
>     > > use h2g. However this changes the meaning of QEMU_GUEST_BASE and
>     could
>     > > break existing programs that set non-zero QEMU_GUEST_BASE.
>     > >
>     > > So, how did qemu pick the base address 0x4000000000 then? Looking at
>     > > the blame output in github, one recent change for the base
>     address was
>     > > committed 10 years ago:
>     > > https://github.com/qemu/qemu/c|open_self_maps|
>     <https://github.com/qemu/qemu/c%7Copen_self_maps%7C> in
>     > > syscall.commit/14f24e1465edc44b9b4d89fbbea66e06088154e1
>     > >
>     > > Another one was committed 12 years ago:
>     > >
>     https://github.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b18d53
>     > >
>     > > The description of the first change is "place the default
>     mapping base
>     > > for 64-bit guests (on 64-bit hosts) outside the low 4G". It
>     would seem
>     > > that minimum requirements for the base address are:
>     > > 1) addr >= 4G (for 64-bit)
>     > > 2) addr < lowest address used by the host qemu program by some
>     margin
>     > >
>     > > Given that
>     > > 1) only TSAN explicitly check for the validity of addresses
>     > > 2) 0x4000000000 is not a valid address for programs on aarch64
>     > > (according to TSAN)
>     > > 3) different architectures have different valid addresses,
>     > > it would seem that adding an argument for changing the
>     hard-coded base
>     > > address is a viable solution.
>     >
>     > Thank you for the detailed explanation.
>     >
>     > Could you show me an example of the QEMU command line you use?
>     >
>     > I'm wondering if hardcoding directly the good value would be a better
>     > solution?
>     >
>     > Richard, do you have some thoughts on this?
>     >
>     > Thanks,
>     > Laurent
> 
>     Sure! First we compile a simple race program with TSAN enabled:
>     ( Simple race program is here:
>     https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual#usage
>     )
>     $ clang++ simple_race.cc -fsanitize=thread -fPIE -pie -g -o simple_race
> 
>     Next we run a script for executing the program, and it exports
>     environment variables:
>     QEMU_CPU=max
>     QEMU_MMAP_BASE=0x0000005500000000
> 
>     And runs the QEMU program:
>     $ qemu-aarch64 simple_race
> 
>     I changed the default value for all other programs that I am working
>     with, and so far we haven't seen any problems.
>     For the patch, it might be better to err on the safe side and not
>     change the hard-coded value, as it might cause potential breakages for
>     other users.
>     Though I don't know much about how the default value might be used or
>     depended on by other programs, so if you see no concerns for updating
>     the value, I'd be happy to change it too.
> 
> 
> Friendly ping~
> 
> Link to the page for the patch on patchwork:
> http://patchwork.ozlabs.org/patch/1242370/ 

I would prefer if you hardcode the value for aarch64 rather than adding
a new parameter.

Thanks,
Laurent


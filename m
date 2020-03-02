Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0009720863
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0009720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8mVv-00007e-7i
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j8mUu-0007xY-Dz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j8mUt-0007l7-8v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:56:44 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j8mUq-0007hE-8e; Mon, 02 Mar 2020 09:56:40 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLRgp-1irWcr3k6l-00IXt8; Mon, 02 Mar 2020 15:56:35 +0100
To: Lirong Yuan <yuanzi@google.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200222010925.32858-1-yuanzi@google.com>
 <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
Message-ID: <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
Date: Mon, 2 Mar 2020 15:56:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8KpmKQYmJZolQ3kGR/j5e/nf+OLWg/zMQFyAhRH3xxcTDm50AFz
 pVKv7wgutbJg/q/i8CTuRIHIjoTyhQddYlhAhKkSJA+h8lNzgizIedRcQQ6SVczDCIMSoFu
 wbs1CyJS2iGl98A3oCKKG/GKsKj0+kKiR+vBhEBUbPIiU+Q+I1urVanhINO42FmArUJ+91+
 6htHxbVMMwLb1TPuRaTCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qhvy+nXr5eY=:uf4SPpftey6uUvf8SUdp9X
 Rm4O6/4j5hu6uFpECUbwQAmHDNtuXidQwdebp6nsnJs5NxVQ5gN477x1CkD/WRuDVFU/4a3tD
 KIs1yclRbhnEELPsrHxI4P3kwZiWy3TbJkTIGtfE1ksuLaz6AKc1wV76rUf6171veDP1nRE18
 VDfpMn4OgMbh8maAUwSQVFuaEUk4ypLqYU9HUtc1OAm5GcKix8If7qm+5B41Xk4OyUEfXJi0D
 2OBtU4eK+NWkTIXSZ786LL67zl7tVCrNzrvrmWhqwLZFDAFCK07lRZo9YJKDCxYOQOeBnVgHT
 3xBWzLaBzDZeaZwBFRuaRJrx5gucwse1mpw+hpeZCSs5MlqYEuZ4phI5w8XXILmUEr22he5PX
 LSLPGq0js92niT+zDFQGQHcL64dlvMjMOjjaF+Yk64KV1VDi+klvmNNpd5xsaGSYFXq6N9znf
 BFv9/wPRddw+xGfcvatfIvD8GBu9cHlC38mmM2SvG//yboby9wHjV+bRcGPituI1qh6P4EMxm
 2ej0aE3FXYI1Dfm1pACSXcMRf89adkNcLbkKlo4wSuuf+Xga3XhUg8qGqBXDHSjc7Tx60M5Qz
 7tRKKYM9QqyfZfgXsysye+Bu1qUohMcPRpcYGdubdReu3DDJ7eI+iYzRUzbCDeqeA4CXMjrmN
 YgGfRRTDSB0Cy8BYW+kGYz+2ehF7kAXasjjUHFJVsD/LcYaNDisJiGd616i5e6LnnqTvgQGAN
 na3w/5094pDukcvMzgY78+hQ+ghZuTMm/D1NxrnVffcO3OSSUfa8gYtWmrcams70O7V2dYZqX
 c+bLM3BI2Goo8xgt5cSFN85OJmBO/f292fH4XObBv3DMBUKt1rWR5WqeWJ/LVmY//x1cPpm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/02/2020 à 01:43, Lirong Yuan a écrit :
> On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.com> wrote:
>>
>> This change allows us to set custom base address for guest programs. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
>> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h

Could you give more details and some examples?

Thanks,
Laurent

>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
>> ---
>>  linux-user/main.c | 12 ++++++++++++
>>  linux-user/mmap.c |  3 ++-
>>  linux-user/qemu.h |  5 +++++
>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/main.c b/linux-user/main.c
>> index fba833aac9..c01af6bfee 100644
>> --- a/linux-user/main.c
>> +++ b/linux-user/main.c
>> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const char *arg)
>>      have_guest_base = 1;
>>  }
>>
>> +static void handle_arg_mmap_base(const char *arg)
>> +{
>> +    int err = qemu_strtoul(arg, NULL, 0, &mmap_base);
>> +    if (err) {
>> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n", arg, err);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    mmap_next_start = mmap_base;
>> +}
>> +
>>  static void handle_arg_reserved_va(const char *arg)
>>  {
>>      char *p;
>> @@ -440,6 +450,8 @@ static const struct qemu_argument arg_table[] = {
>>       "uname",      "set qemu uname release string to 'uname'"},
>>      {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
>>       "address",    "set guest_base address to 'address'"},
>> +    {"mmap_base",  "QEMU_MMAP_BASE",   true,  handle_arg_mmap_base,
>> +     "",           "begin allocating guest pages at this host address"},
>>      {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
>>       "size",       "reserve 'size' bytes for guest virtual address space"},
>>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index 8685f02e7e..3f35543acf 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
>>  # define TASK_UNMAPPED_BASE  0x40000000
>>  #endif
>>  abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
>> +abi_ulong mmap_base = TASK_UNMAPPED_BASE;
>>
>>  unsigned long last_brk;
>>
>> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>>
>>              if ((addr & (align - 1)) == 0) {
>>                  /* Success.  */
>> -                if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
>> +                if (start == mmap_next_start && addr >= mmap_base) {
>>                      mmap_next_start = addr + size;
>>                  }
>>                  return addr;
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>> index 560a68090e..83c00cfea2 100644
>> --- a/linux-user/qemu.h
>> +++ b/linux-user/qemu.h
>> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
>>  void stop_all_tasks(void);
>>  extern const char *qemu_uname_release;
>>  extern unsigned long mmap_min_addr;
>> +/*
>> + * mmap_base is minimum address to use when allocating guest pages. All guest
>> + * pages will be allocated at this (guest) address or higher addresses.
>> + */
>> +extern abi_ulong mmap_base;
>>
>>  /* ??? See if we can avoid exposing so much of the loader internals.  */
>>
>> --
>> 2.25.0.265.gbab2e86ba0-goog
>>
> 
> Friendly ping~
> 
> Link to the page for the patch on patchwork:
> http://patchwork.ozlabs.org/patch/1242370/
> 



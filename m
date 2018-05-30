Received: from eggs.gnu.org ([2001:4830:134:3::10]:46035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOA9h-0004MZ-Oj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOA9e-0008J1-BK
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:21 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:40391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOA9e-0008IZ-15
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:18 -0400
Received: by mail-pl0-x235.google.com with SMTP id t12-v6so11980631plo.7
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:05:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
Message-ID: <ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
Date: Wed, 30 May 2018 16:05:14 -0700
MIME-Version: 1.0
In-Reply-To: <ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 05/30/2018 03:46 PM, Richard Henderson wrote:
> Thanks.  Queued to tcg-next.
Hmph.  Unqueued, at least for now.

ERROR:/home/rth/work/qemu/qemu/accel/tcg/translate-all.c:615:page_unlock__debug:
assertion failed: (page_is_locked(pd))

#3  0x00007ffff4b6915e in g_assertion_message_expr ()
    at /lib64/libglib-2.0.so.0
#4  0x000055555583c088 in page_unlock__debug (pd=0x7fffa423aa80)
    at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:615
#5  0x000055555583c1be in page_unlock (pd=0x7fffa423aa80)
    at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:661
#6  0x000055555583c2ef in page_entry_destroy (p=0x7fffa8024460)
    at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:694
#7  0x00007ffff4b6f448 in  () at /lib64/libglib-2.0.so.0
#8  0x00007ffff4b6fea2 in g_tree_destroy () at /lib64/libglib-2.0.so.0
#9  0x000055555583c791 in page_collection_unlock (set=0x7fffa802eba0)
    at /home/rth/work/qemu/qemu/accel/tcg/translate-all.c:842
#10 0x00005555557b301a in memory_notdirty_write_complete (ndi=0x7fffd9cf6050)
    at /home/rth/work/qemu/qemu/exec.c:2495
#11 0x00005555557b317f in notdirty_mem_write (opaque=0x0, ram_addr=12334096,
val=18446739675675374544, size=8) at /home/rth/work/qemu/qemu/exec.c:2535
#12 0x000055555580f14b in memory_region_write_accessor (mr=0x5555562a38a0
<io_mem_notdirty>, addr=12334096, value=0x7fffd9cf6178, size=8, shift=0,
mask=18446744073709551615, attrs=...) at /home/rth/work/qemu/qemu/memory.c:530
#13 0x000055555580f360 in access_with_adjusted_size (addr=12334096,
value=0x7fffd9cf6178, size=8, access_size_min=1, access_size_max=8, access_fn=
    0x55555580f061 <memory_region_write_accessor>, mr=0x5555562a38a0
<io_mem_notdirty>, attrs=...) at /home/rth/work/qemu/qemu/memory.c:597
#14 0x0000555555811cef in memory_region_dispatch_write (mr=0x5555562a38a0
<io_mem_notdirty>, addr=12334096, data=18446739675675374544, size=8, attrs=...)
    at /home/rth/work/qemu/qemu/memory.c:1474
#15 0x0000555555825d73 in io_writex (env=0x555556869090,
iotlbentry=0x555556870520, mmu_idx=0, val=18446739675675374544,
addr=18446739675675374608, retaddr=140736231479305, size=8) at
/home/rth/work/qemu/qemu/accel/tcg/cputlb.c:813
#16 0x0000555555828b6d in io_writeq (env=0x555556869090, mmu_idx=0, index=225,
val=18446739675675374544, addr=18446739675675374608, retaddr=140736231479305)
    at /home/rth/work/qemu/qemu/accel/tcg/softmmu_template.h:265
#17 0x0000555555828d2c in helper_le_stq_mmu (env=0x555556869090,
addr=18446739675675374608, val=18446739675675374544, oi=48,
retaddr=140736231479305)
    at /home/rth/work/qemu/qemu/accel/tcg/softmmu_template.h:301
#18 0x00007fffb5159809 in code_gen_buffer ()

I can invoke similar crashes with just about every image I try.


r~

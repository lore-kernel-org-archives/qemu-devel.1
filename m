Received: from eggs.gnu.org ([2001:4830:134:3::10]:36324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9wuP-00044f-ET
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 13:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9wuO-0004og-BZ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 13:34:33 -0400
References: <20171025093535.10175-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ab3bd81-925c-a281-614c-2cd87fce38b5@redhat.com>
Date: Wed, 1 Nov 2017 18:34:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/51] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>, qemu-arm@nongnu.org

On 25.10.2017 11:34, Richard Henderson wrote:
> Primarily Emilio's work toward removing tb_lock, with fixes.
> But there are some other tcg-related patches that are queued.
> 
> r~
> 
> The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20171025
> 
> for you to fetch changes up to cc689485ee3e9dca05765326ee8fd619a6ec48f0:
> 
>   translate-all: exit from tb_phys_invalidate if qht_remove fails (2017-10-24 13:53:42 -0700)
> 
> ----------------------------------------------------------------
> TCG patch queue
> 
> ----------------------------------------------------------------
> Emilio G. Cota (25):
>       tcg: define CF_PARALLEL and use it for TB hashing along with CF_COUNT_MASK
>       tcg: convert tb->cflags reads to tb_cflags(tb)
>       target/arm: check CF_PARALLEL instead of parallel_cpus
>       target/hppa: check CF_PARALLEL instead of parallel_cpus
>       target/i386: check CF_PARALLEL instead of parallel_cpus
>       target/m68k: check CF_PARALLEL instead of parallel_cpus
>       target/s390x: check CF_PARALLEL instead of parallel_cpus
>       target/sh4: check CF_PARALLEL instead of parallel_cpus
>       target/sparc: check CF_PARALLEL instead of parallel_cpus
>       tcg: check CF_PARALLEL instead of parallel_cpus
>       cpu-exec: lookup/generate TB outside exclusive region during step_atomic
>       translate-all: use a binary search tree to track TBs in TBContext
>       exec-all: rename tb_free to tb_remove
>       translate-all: report correct avg host TB size
>       tcg: take tb_ctx out of TCGContext
>       tcg: define tcg_init_ctx and make tcg_ctx a pointer
>       gen-icount: fold exitreq_label into TCGContext
>       tcg: introduce **tcg_ctxs to keep track of all TCGContext's
>       tcg: distribute profiling counters across TCGContext's
>       tcg: allocate optimizer temps with tcg_malloc
>       osdep: introduce qemu_mprotect_rwx/none
>       translate-all: use qemu_protect_rwx/none helpers
>       tcg: introduce regions to split code_gen_buffer
>       tcg: enable multiple TCG contexts in softmmu

Seems like something in this patch series broke a couple of ARM boards
(smdkc210, nuri, raspi2, xlnx-ep108 and xlnx-zcu102). With current
master branch, I just get this error:

$ aarch64-softmmu/qemu-system-aarch64  -machine raspi2
**
ERROR:/home/thuth/devel/qemu/tcg/tcg.c:537:tcg_register_thread:
assertion failed: (n < max_cpus)
Aborted (core dumped)

Could you please have a look at this?

 Thanks,
  Thomas

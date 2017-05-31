Received: from eggs.gnu.org ([2001:4830:134:3::10]:33244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG38i-0000Ok-Ad
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dG38f-0008NA-5B
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:54:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dG38e-0008N2-V1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:54:13 -0400
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
Date: Wed, 31 May 2017 14:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, eblake@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com



On 31/05/2017 08:28, Yang Zhong wrote:
> Move the tcg related files into tcg/ subdirectory, which will make
> the code more clean in qemu. Next step, we will base on those changes 
> to disable tcg.

You should also move cpu-exec.c, cpu-exec-common.c and cputlb.c.

Also, feel free to squash everything in a single patch.
Thanks,

Paolo

> Yang Zhong (6):
>   tcg: move tcg-runtime.c to tcg/ subdirectory
>   tcg: move translate-all.c to tcg/ subdirectory
>   tcg: move tcg header file
>   tcg: move translate-common.c to tcg/ subdirectory
>   tcg: move tci.c to tcg/ subdirectory
>   tcg: change tcg related file's compile definition
> 
>  Makefile.objs                                | 1 +
>  Makefile.target                              | 8 ++------
>  tcg/Makefile.objs                            | 2 ++
>  tcg-runtime.c => tcg/tcg-runtime.c           | 0
>  tci.c => tcg/tci.c                           | 0
>  tcg/trace-events                             | 6 ++++++
>  translate-all.c => tcg/translate-all.c       | 2 +-
>  translate-all.h => tcg/translate-all.h       | 0
>  translate-common.c => tcg/translate-common.c | 0
>  trace-events                                 | 3 ---
>  10 files changed, 12 insertions(+), 10 deletions(-)
>  create mode 100644 tcg/Makefile.objs
>  rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
>  rename tci.c => tcg/tci.c (100%)
>  create mode 100644 tcg/trace-events
>  rename translate-all.c => tcg/translate-all.c (99%)
>  rename translate-all.h => tcg/translate-all.h (100%)
>  rename translate-common.c => tcg/translate-common.c (100%)
> 

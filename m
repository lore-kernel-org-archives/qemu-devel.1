Received: from eggs.gnu.org ([2001:4830:134:3::10]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fwTYF-00087D-9J
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 10:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fwTU2-0004BX-2k
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 10:36:14 -0400
References: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ed79ac89-4b05-c235-8a24-8eb403045ade@redhat.com>
Date: Sun, 2 Sep 2018 16:36:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org

On 02.09.2018 02:33, Pavel Zbitskiy wrote:
> Changes since v4:
> 
> * Simplified alignment checks by using tcg_gen_qemu_ld_i64 and
>   MO_ALIGN*.
> 
> Pavel Zbitskiy (3):
>   target/s390x: use regular spaces in translate.c
>   target/s390x: exception on non-aligned LPSW(E)
>   target/s390x: implement CVB, CVBY and CVBG
> 
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 +++
>  target/s390x/int_helper.c       | 52 +++++++++++++++++++++++++++++++++
>  target/s390x/translate.c        | 21 ++++++++++---
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/cvb.c           | 18 ++++++++++++
>  6 files changed, 93 insertions(+), 4 deletions(-)
>  create mode 100644 tests/tcg/s390x/cvb.c
> 

Hi Pavel,

I'm leaving for vacation tomorrow and will have a look in two weeks when
I'm back. Also, Conny is on vacation, so expect ~2 weeks until this gets
reviewed / picked up.

Thanks!

-- 

Thanks,

David / dhildenb

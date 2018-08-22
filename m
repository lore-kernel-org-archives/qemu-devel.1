Received: from eggs.gnu.org ([2001:4830:134:3::10]:39731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsUrt-00029f-0B
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsUro-0004yi-2p
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:16:20 -0400
References: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3fdd72fa-6482-3e96-fe66-9c124b84bce8@redhat.com>
Date: Wed, 22 Aug 2018 17:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180822144039.5796-1-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Some improvements in z/Arch
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

On 22.08.2018 16:40, Pavel Zbitskiy wrote:
> Changes since v3:
> * Patches 1-6 were accepted, thanks!
> * Use in1_la2 in op_cvb().
> * Free a temp in op_cvb().
> * Make ra const in helper_cvb().
> * Use wrap_address() in helper_cvb().
> * Add a minor formatting patch.
> * Add LPSW(E) alignment check.
> 

Keep the patches coming, happy to see some activity :)

> Pavel Zbitskiy (3):
>   target/s390x: use regular spaces in translate.c
>   target/s390x: exception on non-aligned LPSW(E)
>   target/s390x: implement CVB, CVBY and CVBG
> 
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  4 +++
>  target/s390x/int_helper.c       | 52 +++++++++++++++++++++++++++++++++
>  target/s390x/mem_helper.c       | 19 +++++++-----
>  target/s390x/translate.c        | 23 +++++++++++++--
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/cvb.c           | 18 ++++++++++++
>  7 files changed, 110 insertions(+), 9 deletions(-)
>  create mode 100644 tests/tcg/s390x/cvb.c
> 


-- 

Thanks,

David / dhildenb

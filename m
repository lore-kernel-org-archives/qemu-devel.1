Received: from eggs.gnu.org ([2001:4830:134:3::10]:44976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fmh5V-0008Tp-BX
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fmh5U-0005kZ-J1
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:06:25 -0400
Date: Mon, 6 Aug 2018 17:06:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180806170616.2064e677.cohuck@redhat.com>
In-Reply-To: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org

On Sun,  5 Aug 2018 14:28:25 -0400
Pavel Zbitskiy <pavel.zbitskiy@gmail.com> wrote:

Meta note #1: please add the s390x maintainers on cc: for the cover
              letter as well; that makes tracking easier
Meta note #2: I don't think this really fits trivial? I'll be happy to
              take the end result via the s390x tree, anyway.

> Add BAL, BALR, CVB instructions
> Fix few bugs in PACK, CSST
> 
> Pavel Zbitskiy (6):
>   target/s390x: add BAL and BALR instructions
>   target/s390x: fix CSST decoding and runtime alignment check
>   target/s390x: fix ipm polluting irrelevant bits
>   target/s390x: add EX support for TRT and TRTR
>   target/s390x: fix PACK reading 1 byte less and writing 1 byte more
>   target/s390x: implement CVB, CVBY and CVBG
> 
>  target/s390x/helper.h      |  2 ++
>  target/s390x/insn-data.def |  7 ++++++
>  target/s390x/int_helper.c  | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/mem_helper.c  | 24 +++++++++++++++----
>  target/s390x/translate.c   | 52 +++++++++++++++++++++++++++++++++++++----
>  5 files changed, 135 insertions(+), 8 deletions(-)
> 

Out of curiousity: Do you have some code that actually makes use of
these instructions (especially BAL/BALR), or have you found this by
looking at the documentation?

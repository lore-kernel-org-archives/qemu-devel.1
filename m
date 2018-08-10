Received: from eggs.gnu.org ([2001:4830:134:3::10]:51769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fo76K-0003tW-Az
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fo76G-0007Yo-8t
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:05:08 -0400
Date: Fri, 10 Aug 2018 15:04:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180810150459.79c6b4e0.cohuck@redhat.com>
In-Reply-To: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Some improvements in z/Arch
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, richard.henderson@linaro.org

On Thu,  9 Aug 2018 23:01:32 -0400
Pavel Zbitskiy <pavel.zbitskiy@gmail.com> wrote:

> Found while attempting to run an old tool in qemu.
> 
> * BAL and BALR:    Added.
> * CSST:            Qemu crashed after an accidental jump to garbage.
> * IPM:             A tool produced an incorrect output.
> * EX TRT/TRTR:     A tool ran quite slow.
> * PACK:            A tool produced an incorrect output.
> * CVB, CVBY, CVBG: Added.
> 
> Changes since v1:
> * Tests.

Nice, thanks for adding these.

> * Call pc_to_link_info() instead of op_bas().
> * Clarified CSST commit message.
> * Rewrote IPM using extract/deposit.
> * Clarified PACK commit message.
> * Do not use LowCore for CONFIG_USER_ONLY.
> * Reduce duplication in CVB code.
> 
> Pavel Zbitskiy (7):
>   tests/tcg: add a simple s390x test
>   target/s390x: add BAL and BALR instructions
>   target/s390x: fix CSST decoding and runtime alignment check
>   target/s390x: fix IPM polluting irrelevant bits
>   target/s390x: add EX support for TRT and TRTR
>   target/s390x: fix PACK reading 1 byte less and writing 1 byte more
>   target/s390x: implement CVB, CVBY and CVBG

I'll wait for some acks/reviews before applying these.

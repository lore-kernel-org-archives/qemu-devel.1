Received: from eggs.gnu.org ([2001:4830:134:3::10]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVzTY-0002Vf-UB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVzTT-00077T-TG
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:18:12 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-7-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8da98f5c-8ddd-5dda-b930-7ca8fd04acf7@redhat.com>
Date: Thu, 21 Jun 2018 15:18:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180620100825.22476-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] s390x/tcg: rearm the CKC timer
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 20.06.2018 12:08, David Hildenbrand wrote:
> If the CPU data is migrated after the TOD clock, the CKC timer of a CPU
> is not rearmed. Let's rearm it when loading the CPU state.
> 
> Introduce tcg-stub.c just like kvm-stub.c for tcg specific stubs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/Makefile.objs |  1 +
>  target/s390x/machine.c     |  6 ++++++
>  target/s390x/tcg-stub.c    | 20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 target/s390x/tcg-stub.c

Reviewed-by: Thomas Huth <thuth@redhat.com>

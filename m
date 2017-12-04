Received: from eggs.gnu.org ([2001:4830:134:3::10]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuSF-00010h-MN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuSC-0003Vs-HZ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:22:55 -0500
Date: Mon, 4 Dec 2017 18:22:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204182244.2b789717.cohuck@redhat.com>
In-Reply-To: <20171204125505.29203-6-david@redhat.com>
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 5/5] s390x/tcg: wire up STORE
 CHANNEL REPORT WORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon,  4 Dec 2017 13:55:05 +0100
David Hildenbrand <david@redhat.com> wrote:

> We somehow missed that, new kernels require it.

Why _new_ kernels? I think we have unconditionally issued stcrw since
back in 2.2?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      | 1 +
>  target/s390x/insn-data.def | 1 +
>  target/s390x/misc_helper.c | 9 +++++++++
>  target/s390x/translate.c   | 8 ++++++++
>  4 files changed, 19 insertions(+)

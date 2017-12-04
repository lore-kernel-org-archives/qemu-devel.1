Received: from eggs.gnu.org ([2001:4830:134:3::10]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuUV-0004pv-45
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuUL-0004FE-2u
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:25:10 -0500
Date: Mon, 4 Dec 2017 18:24:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204182454.5e397739.cohuck@redhat.com>
In-Reply-To: <20171204140150.20483-5-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 4/9] s390x/tcg: wire up SET
 CHANNEL MONITOR
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

On Mon,  4 Dec 2017 15:01:45 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's just wire it up like KVM.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      | 1 +
>  target/s390x/insn-data.def | 1 +
>  target/s390x/misc_helper.c | 9 +++++++++
>  target/s390x/translate.c   | 7 +++++++
>  4 files changed, 18 insertions(+)

So we would have generated an exception before if someone tried to
enable channel measurements under tcg?

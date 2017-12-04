Received: from eggs.gnu.org ([2001:4830:134:3::10]:44536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuYl-0000hV-15
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eLuYh-00065y-TX
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:29:39 -0500
Date: Mon, 4 Dec 2017 18:29:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171204182928.236d7a76.cohuck@redhat.com>
In-Reply-To: <20171204140150.20483-7-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 6/9] s390x/tcg: Implement SIGA
 instruction
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

On Mon,  4 Dec 2017 15:01:47 +0100
David Hildenbrand <david@redhat.com> wrote:

> I have no idea what that instruction does, but KVM seems to suppress it,
> setting cc=3 (and as it seems to be an io instruction, it should be
> protected). Let's do the same for TCG, so we're at least equal.
> 
> (it is used in the kernel for qdio, I wasn't even able to find the real
>  name of that instruction)

<arcane knowledge from previous life>
It's called SIGNAL ADAPTER, and we don't indicate qdio in the chsc
stuff.
</arcane knowledge from previous life>

Following the KVM lead for undocumented stuff is the way to go,
unsatisfying though it is.

[Don't binutils etc. know the name?]

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 1 +
>  target/s390x/translate.c   | 8 ++++++++
>  2 files changed, 9 insertions(+)

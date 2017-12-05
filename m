Received: from eggs.gnu.org ([2001:4830:134:3::10]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMEmS-0002Ki-75
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMEmM-00028b-G2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:05:08 -0500
Date: Tue, 5 Dec 2017 16:04:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205160456.6a2923e0.cohuck@redhat.com>
In-Reply-To: <20171204140150.20483-6-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 5/9] s390x/tcg: Implement STORE
 CHANNEL PATH STATUS
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

On Mon,  4 Dec 2017 15:01:46 +0100
David Hildenbrand <david@redhat.com> wrote:

> Just like KVM does, we should suppress this instruction:
>     When this instruction is not provided, it is
>     checked for privileged operation exception and the
>     instruction is suppressed by the machine
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 1 +
>  target/s390x/translate.c   | 7 +++++++
>  2 files changed, 8 insertions(+)

Yes, given that we don't support real channel paths, we can't implement
it in a useful way anyway.

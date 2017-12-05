Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMB2r-00029w-3J
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMB2n-0004Wk-Tj
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:05:49 -0500
Date: Tue, 5 Dec 2017 12:05:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205120538.7697d3e8.cohuck@redhat.com>
In-Reply-To: <20171204125505.29203-4-david@redhat.com>
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 3/5] s390x/tcg: implement SET
 CLOCK PROGRAMMABLE FIELD
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

On Mon,  4 Dec 2017 13:55:03 +0100
David Hildenbrand <david@redhat.com> wrote:

> Needed for machine check handling inside Linux (when restoring registers).
> 
> Except for SIGP and machine checks, we don't make use of the register
> yet. Suficient for now.

s/Suficient/Sufficient/

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/misc_helper.c | 11 +++++++++++
>  target/s390x/translate.c   |  7 +++++++
>  4 files changed, 21 insertions(+)

Looks good to me.

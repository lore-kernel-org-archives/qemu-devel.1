Received: from eggs.gnu.org ([2001:4830:134:3::10]:49872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMboT-0001RV-EY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMboO-0006Vs-Fq
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:40:45 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-6-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <de5e7915-56eb-a5fb-0ef3-4b54c22052fe@redhat.com>
Date: Wed, 6 Dec 2017 16:40:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171204125505.29203-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 04.12.2017 13:55, David Hildenbrand wrote:
> We somehow missed that, new kernels require it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      | 1 +
>  target/s390x/insn-data.def | 1 +
>  target/s390x/misc_helper.c | 9 +++++++++
>  target/s390x/translate.c   | 8 ++++++++
>  4 files changed, 19 insertions(+)

IANATE again, but the patch looks right to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>

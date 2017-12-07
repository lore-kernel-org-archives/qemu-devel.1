Received: from eggs.gnu.org ([2001:4830:134:3::10]:56244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5pL-0005Gq-1f
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5pG-00057n-34
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:43:39 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-3-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <155a4b3e-dea0-ff2f-5e04-43fdd4bcd473@twiddle.net>
Date: Thu, 7 Dec 2017 15:43:30 -0800
MIME-Version: 1.0
In-Reply-To: <20171207165355.7559-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 02/10] s390x/tcg: ALSI/ALSGI
 are atomic with interlocked-acccess facility 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 12/07/2017 08:53 AM, David Hildenbrand wrote:
> We can simply reuse our ASI implementation. Only the way CC is
> calculated differs.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Squash with previous?


r~

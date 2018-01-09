Received: from eggs.gnu.org ([2001:4830:134:3::10]:38794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYyrV-0000A8-Lp
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYyrU-0007mf-Rf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:43:01 -0500
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-13-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b69625b2-f5bb-2206-3002-9b74923ba16c@redhat.com>
Date: Tue, 9 Jan 2018 19:42:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171211134740.8235-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2-12 12/15] s390x/tcg:
 fix size + content of STSI blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11.12.2017 14:47, David Hildenbrand wrote:
> All blocks are 4k in size, which is only true for two of them right now.
> Also some reserved fields were wrong, fix it and convert all reserved
> fields to u8.
> 
> This also fixes the LPAR part output in /proc/sysinfo under TCG. (for
> now, everything was indicated as 0)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNWJ-0004Rb-8n
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNWD-00016l-MG
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:00:47 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-16-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b7b17513-5a6f-cef9-8c71-e0058885e042@redhat.com>
Date: Thu, 30 Nov 2017 13:00:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 for-2.12 15/16] s390x/tcg:
 drop program_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 29.11.2017 21:27, David Hildenbrand wrote:
> All users are gone, we can finally drop it and make sure that all new
> program interrupt injections are reminded of the retaddr - as they have to
> use s390_program_interrupt() now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h       |  1 -
>  target/s390x/interrupt.c | 22 +++++-----------------
>  2 files changed, 5 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

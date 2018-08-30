Received: from eggs.gnu.org ([2001:4830:134:3::10]:40082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSMS-0001WL-1H
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSMR-0004lX-GO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:12:08 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-3-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <05ce75c9-7e7c-1425-46e9-0306d73a7ae8@twiddle.net>
Date: Thu, 30 Aug 2018 12:12:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/9] s390x/tcg: factor out and fix DATA
 exception injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08/30/2018 05:27 AM, David Hildenbrand wrote:
> The DXC is to be stored in the low core, and only in the FPC in case AFP
> is enabled in CR0. Stub is not required in current code, but this way
> we never run into problems.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         |  1 +
>  target/s390x/excp_helper.c | 23 +++++++++++++++++++++++
>  target/s390x/fpu_helper.c  | 13 +++----------
>  target/s390x/helper.h      |  1 +
>  target/s390x/tcg-stub.c    |  5 +++++
>  target/s390x/tcg_s390x.h   |  2 ++
>  target/s390x/translate.c   | 19 +++++++++----------
>  7 files changed, 44 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

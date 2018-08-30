Received: from eggs.gnu.org ([2001:4830:134:3::10]:50369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSvu-0005QC-PD
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSvu-0005q6-6I
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:48:46 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-8-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <35465f5d-93f0-16d1-e484-0a709260e657@twiddle.net>
Date: Thu, 30 Aug 2018 12:48:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/9] s390x/tcg: handle privileged
 instructions via flags
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
> Let's check this also at a central place.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 138 ++++++++++++++++++-------------------
>  target/s390x/translate.c   |  83 ++--------------------
>  2 files changed, 76 insertions(+), 145 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

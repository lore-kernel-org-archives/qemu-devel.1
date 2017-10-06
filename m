Received: from eggs.gnu.org ([2001:4830:134:3::10]:60999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SWo-0002Nl-0X
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0SWn-00026Q-6k
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:18:57 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:45387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0SWn-00026D-1N
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:18:57 -0400
Received: by mail-qt0-x236.google.com with SMTP id k1so20317545qti.2
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:18:57 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e11d0a79-5bf5-cca3-c652-478ede7117e2@linaro.org>
Date: Fri, 6 Oct 2017 09:18:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/30] s390x/tcg: injection of emergency
 signals and external calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/28/2017 04:36 PM, David Hildenbrand wrote:
> Preparation for new TCG SIGP code. Especially also prepare for
> indicating that another external call is already pending.
> 
> Take care of interrupt priority.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         |  8 +++++++-
>  target/s390x/excp_helper.c | 16 +++++++++++++++-
>  target/s390x/internal.h    |  2 ++
>  target/s390x/interrupt.c   | 26 ++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

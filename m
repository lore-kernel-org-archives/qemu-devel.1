Received: from eggs.gnu.org ([2001:4830:134:3::10]:47946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TEh-0004pS-R9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TEh-0002kv-1F
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:04:19 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:43331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0TEg-0002kK-T8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:04:18 -0400
Received: by mail-qt0-x22e.google.com with SMTP id a43so25653403qta.0
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:04:18 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-29-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74cfbc0c-db53-ee87-7fa7-909cfde5367b@linaro.org>
Date: Fri, 6 Oct 2017 10:04:15 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-29-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/30] s390x/tcg: unlock NMI
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

On 09/28/2017 04:37 PM, David Hildenbrand wrote:
> Nothing hindering us anymore from unlocking the restart code (used for
> NMI).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 4 +---
>  target/s390x/sigp.c        | 5 -----
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

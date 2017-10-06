Received: from eggs.gnu.org ([2001:4830:134:3::10]:40544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0StR-0005a1-LZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0StR-0004nh-0A
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:42:21 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:44506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0StQ-0004nU-Ry
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:42:20 -0400
Received: by mail-qt0-x22b.google.com with SMTP id v28so22607151qtv.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:42:20 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf33690c-a785-2886-dbc6-80a52bbfaee5@linaro.org>
Date: Fri, 6 Oct 2017 09:42:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/30] s390x/kvm: factor out actual
 handling of STOP interrupts
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
> For KVM, the KVM module decides when a STOP can be performed (when the
> STOP interrupt can be processed). Factor it out so we can use it
> later for TCG.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/internal.h |  1 +
>  target/s390x/kvm.c      |  8 +-------
>  target/s390x/sigp.c     | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

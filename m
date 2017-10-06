Received: from eggs.gnu.org ([2001:4830:134:3::10]:39795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sqi-0003nE-1L
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sqe-0001gY-9A
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:39:32 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:52935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Sqe-0001gE-4J
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:39:28 -0400
Received: by mail-qt0-x22b.google.com with SMTP id o52so31409735qtc.9
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:39:28 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90afbe06-c83e-b5e1-c126-0064366b6664@linaro.org>
Date: Fri, 6 Oct 2017 09:39:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/30] s390x/kvm: factor out storing of
 CPU status
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
> Factor it out into s390_store_status(), to be used also by TCG later on.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c   | 60 ++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/internal.h |  2 ++
>  target/s390x/kvm.c      | 69 +++----------------------------------------------
>  3 files changed, 65 insertions(+), 66 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dvOwZ-00032H-2T
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dvOwV-0002Ia-4v
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:28:39 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:48097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dvOwU-0002Hs-Vs
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:28:35 -0400
Received: by mail-io0-x229.google.com with SMTP id e189so3454152ioa.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:28:33 -0700 (PDT)
References: <20170922140338.6068-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <156237eb-1f40-9dbc-02b5-9827332bd432@linaro.org>
Date: Fri, 22 Sep 2017 09:28:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170922140338.6068-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/kvm: fix and cleanup storing CPU
 status
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

On 09/22/2017 09:03 AM, David Hildenbrand wrote:
> env->psa is a 64bit value, while we copy 4 bytes into the save area,
> resulting always in 0 getting stored.
> 
> Let's try to reduce such errors by using a proper structure. While at
> it, use correct cpu->be conversion (and get_psw_mask()), as we will be
> reusing this code for TCG soon.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
>  - dropped QEMU_PACKED
>  - Moved QEMU_BUILD_BUG_ON()
>  - Retested if it works now
> 
>  target/s390x/kvm.c | 62 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

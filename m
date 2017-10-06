Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TI3-0007ex-Fn
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0TI2-0007GT-O9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:07:47 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:48546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0TI2-0007G3-J8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:07:46 -0400
Received: by mail-qt0-x22d.google.com with SMTP id d13so30913132qta.5
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:07:46 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-30-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0b8c18f-9637-b9e8-ffba-fbebae49b359@linaro.org>
Date: Fri, 6 Oct 2017 10:07:43 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-30-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 29/30] s390x/tcg: refactor stfl(e) to
 use s390_get_feat_block()
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
> Refactor it to use s390_get_feat_block(). Directly write into the mapped
> lowcore with stfl and make sure it is really only compiled if needed.
> 
> While at it, add an alignment check for STFLE and avoid
> potential_page_fault() by properly restoring the CPU state.
> 
> Due to s390_get_feat_block(), we will now also indicate the
> "Configuration-z-architectural-mode", which is with new SIGP code the
> right thing to do.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 67 ++++++++++++++++++++--------------------------
>  target/s390x/translate.c   |  1 -
>  2 files changed, 29 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

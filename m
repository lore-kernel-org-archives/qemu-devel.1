Received: from eggs.gnu.org ([2001:4830:134:3::10]:39333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sp8-0002qi-BF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Sp7-0000dB-Jh
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:37:54 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:47321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Sp7-0000co-Ee
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:37:53 -0400
Received: by mail-qt0-x22d.google.com with SMTP id z50so26396557qtj.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:37:53 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66437f93-072b-fd65-e350-8de55bbdd016@linaro.org>
Date: Fri, 6 Oct 2017 09:37:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/30] target/s390x: interpret
 PSW_MASK_WAIT only for TCG
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
> KVM handles the wait PSW itself and triggers a WAIT ICPT in case it
> really want to sleep (disabled wait).
> 
> This will later allow us to change the order of loading a restart
> interrupt and setting a CPU to OPERATING on SIGP RESTART without
> changing KVM behavior.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

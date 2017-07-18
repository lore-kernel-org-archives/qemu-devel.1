Received: from eggs.gnu.org ([2001:4830:134:3::10]:57978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXNY6-0006OT-JT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXNY1-00060U-MX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXNY1-0005zb-Fz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 04:08:01 -0400
Date: Tue, 18 Jul 2017 10:07:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170718100756.70af3ca3@gondolin>
In-Reply-To: <1500310706-36211-3-git-send-email-borntraeger@de.ibm.com>
References: <1500310706-36211-1-git-send-email-borntraeger@de.ibm.com>
	<1500310706-36211-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/cpumodel: z14 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, "Jason
	J. Herne" <jjherne@linux.vnet.ibm.com>

On Mon, 17 Jul 2017 18:58:26 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> This patch introduces the CPU model for z14, along with all base and
> optional features.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_models.c   |  1 +
>  target/s390x/gen-features.c | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 

> @@ -442,6 +450,23 @@ static uint16_t full_GEN13_GA1[] = {
>  
>  #define full_GEN13_GA2 EmptyFeat
>  
> +static uint16_t full_GEN14_GA1[] = {
> +    S390_FEAT_INSTRUCTION_EXEC_PROT,
> +    S390_FEAT_GUARDED_STORAGE,
> +    S390_FEAT_VECTOR_PACKED_DECIMAL,
> +    S390_FEAT_VECTOR_ENH,
> +    S390_FEAT_MULTIPLE_EPOCH,
> +    S390_FEAT_TEST_PENDING_EXT_INTERRUPTION,

Quick question: Is this a new instruction that does for external
interrupts what tpi does for I/O interrupts? If yes, is this an
intercept in kvm?

> +    S390_FEAT_INSERT_REFERENCE_BITS_MULT,
> +    S390_FEAT_GROUP_MSA_EXT_6,
> +    S390_FEAT_GROUP_MSA_EXT_7,
> +    S390_FEAT_GROUP_MSA_EXT_8,
> +    S390_FEAT_CMM_NT,
> +    S390_FEAT_HPMA2,
> +    S390_FEAT_SIE_KSS,
> +    S390_FEAT_ORDER_PRESERVING_COMPRESSION,
> +};
> +
>  /* Default features (in order of release)
>   * Automatically includes corresponding base features.
>   * Default features are all features this version of QEMU supports for this

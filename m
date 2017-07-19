Received: from eggs.gnu.org ([2001:4830:134:3::10]:51670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXlpF-0002yu-K3
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXlpA-0007cK-J0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:03:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXlpA-0007c0-9V
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:03:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6JA12wR012786
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:03:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsxwjqa7n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:03:18 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 19 Jul 2017 06:03:17 -0400
References: <20170719095033.20482-1-david@redhat.com>
	<20170719095033.20482-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 19 Jul 2017 12:03:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170719095033.20482-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <663438bd-49d5-0905-2cd0-1c196a836e72@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] target/s390x: drop BE_BIT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com

On 07/19/2017 11:50 AM, David Hildenbrand wrote:
> Unused and broken, let's just get rid of it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/cpu_features.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 14bc311..770435e 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -92,6 +92,5 @@ typedef struct {
>  const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
> 
>  #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
> -#define BE_BIT(BIT) (1ULL < BE_BIT_NR(BIT))
> 
>  #endif /* TARGET_S390X_CPU_FEATURES_H */
> 

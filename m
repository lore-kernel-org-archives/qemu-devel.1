Received: from eggs.gnu.org ([2001:4830:134:3::10]:53765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eyH8k-0003VC-JA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eyH8g-0001g8-9v
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eyH8f-0001fB-Ue
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:17:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2KDFPqI046093
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 09:17:16 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gu1q9m047-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 09:17:15 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 20 Mar 2018 13:17:13 -0000
References: <20180320130702.188689-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Mar 2018 14:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180320130702.188689-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c3d189be-29ae-9500-f1b1-c573c842a307@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/cpumodel: fix feature groups and
 breakage of MSA8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>

David, Jason, Michael,

the cpumodel code is somewhat fragile as we have to add maintain things
in multiple places. I would like to have more robust code, e.g. by either
generating more or by having build bug_ons or something like that. 
Any idea is highly welcome.

Christian


On 03/20/2018 02:07 PM, Christian Borntraeger wrote:
> Since commit 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions
> for Multiple-epoch facility") -cpu help no longer shows the MSA8
> feature group. Turns out that we forgot to add the new MEPOCH_PTFF
> group enum.
> 
> Fixes: 46a99c9f73c7 ("s390x/cpumodel: model PTFF subfunctions for Multiple-epoch facility")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index e306aa7ab2..968b12fdfe 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -78,6 +78,7 @@ typedef enum {
>      S390_FEAT_GROUP_MSA_EXT_6,
>      S390_FEAT_GROUP_MSA_EXT_7,
>      S390_FEAT_GROUP_MSA_EXT_8,
> +    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
>      S390_FEAT_GROUP_MAX,
>  } S390FeatGroup;
> 

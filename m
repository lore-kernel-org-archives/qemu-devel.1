Received: from eggs.gnu.org ([209.51.188.92]:44408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtbT4-00059p-Cn
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtbT2-0004oJ-Es
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:03:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gtbT0-0004jk-CP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:03:32 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CGsERv141142
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:03:27 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qkys6yemb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:03:27 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 12 Feb 2019 17:03:26 -0000
References: <20190212011657.18324-1-walling@linux.ibm.com>
	<d2f76b19-bc36-6200-1a2f-7af3cf5fdabf@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 12 Feb 2019 12:03:22 -0500
MIME-Version: 1.0
In-Reply-To: <d2f76b19-bc36-6200-1a2f-7af3cf5fdabf@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <65d9fde7-1d63-cad6-55bc-6841597c1f7f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/cpumodel: mepochptff: warn
 when no mepoch and re-align group init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com, rth@twiddle.net

On 2/12/19 5:09 AM, Christian Borntraeger wrote:
> 
> 
> On 12.02.2019 02:16, Collin Walling wrote:
>> The extended PTFF features (qsie, qtoue, stoe, stoue) are dependent
>> on the multiple-epoch facility (mepoch). Let's print a warning if these
>> features are enabled without mepoch.
>>
>> While we're at it, let's move the FEAT_GROUP_INIT for mepochptff down
>> the s390_feature_groups list so it can be properly indexed with its
>> generated S390FeatGroup enum.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> 
> Looks sane. 
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks!

-- 
Respectfully,
- Collin Walling

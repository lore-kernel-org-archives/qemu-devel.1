Received: from eggs.gnu.org ([209.51.188.92]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtbSW-0004qn-Mz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtbSU-0003iY-IJ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:02:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36056
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gtbSU-0003hZ-C8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:02:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CGsAO9148947
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:02:57 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qm0xvm2v1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:02:56 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 12 Feb 2019 17:02:56 -0000
References: <20190212011657.18324-1-walling@linux.ibm.com>
	<20190212110439.38e3fbb2.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 12 Feb 2019 12:02:50 -0500
MIME-Version: 1.0
In-Reply-To: <20190212110439.38e3fbb2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bfa7b77d-9c01-0bba-ec25-7b4162a35de3@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/3] s390x/cpumodel:
 mepochptff: warn when no mepoch and re-align group init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On 2/12/19 5:04 AM, Cornelia Huck wrote:
> On Mon, 11 Feb 2019 20:16:55 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> The extended PTFF features (qsie, qtoue, stoe, stoue) are dependent
>> on the multiple-epoch facility (mepoch). Let's print a warning if these
>> features are enabled without mepoch.
>>
>> While we're at it, let's move the FEAT_GROUP_INIT for mepochptff down
>> the s390_feature_groups list so it can be properly indexed with its
>> generated S390FeatGroup enum.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  target/s390x/cpu_features.c | 2 +-
>>  target/s390x/cpu_models.c   | 4 ++++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Not a comment for this patch (looks fine to me), but more general:
> Could you please add a cover letter if you send more than one patch?
> It's easy to miss that there are three patches and not two :)
> 

Noted. Thanks for the advice!

-- 
Respectfully,
- Collin Walling

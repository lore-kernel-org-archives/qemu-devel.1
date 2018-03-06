Received: from eggs.gnu.org ([2001:4830:134:3::10]:56486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1etAzV-0008NP-Ar
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1etAzS-0007N4-64
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1etAzR-0007MT-U8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w26BcsTw111828
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 06:42:40 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ght7b0bat-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:42:40 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 11:42:37 -0000
References: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
	<CAFEAcA-M1smCAVg3OwK0W7vNXiJBadh8sehHbLmDa7NuYb7tLA@mail.gmail.com>
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue, 6 Mar 2018 17:12:32 +0530
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-M1smCAVg3OwK0W7vNXiJBadh8sehHbLmDa7NuYb7tLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ce312b56-8e2d-a59f-649a-b7ed167c04bf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH risu 1/3] ppc64.risu: Add missing byte and
 dword loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, naveen.n.rao@linux.vnet.ibm.com, QEMU Developers <qemu-devel@nongnu.org>


On 03/06/2018 05:09 PM, Peter Maydell wrote:
> On 6 March 2018 at 06:42, Sandipan Das <sandipan@linux.vnet.ibm.com> wrote:
>> The patterns for the following instructions are added:
>>  * Load Byte and Zero (lbz)
>>  * Load Byte and Zero with Update (lbzu)
>>  * Load Byte and Zero Indexed (lbzx)
>>  * Load Byte and Zero with Update Indexed (lbzux)
>>  * Load Doubleword (ld)
>>
>> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> 
> Hi -- this patchset doesn't seem to have a cover letter. Could
> you resend it with one, please? Our automated patch handling
> tools all expect a cover letter if there's more than one patch
> in a set.
> 
> thanks
> -- PMM
> 
> 

Sure

--
With Regards,
Sandipan

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cjmOb-0008DV-5v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cjmOY-0008BE-2f
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cjmOX-0008Aq-Pu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:33:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v23CT4pJ110911
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 07:33:11 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8envwe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:33:11 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 3 Mar 2017 05:33:10 -0700
References: <148847238435.285.7158100214182923369@0e2666bad730>
	<e58e0463-c12f-31ed-3944-a09735e7a7fc@de.ibm.com>
	<20170303095301.GE7097@lemon.lan>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 3 Mar 2017 13:33:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170303095301.GE7097@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <6d02fcc5-f5e0-4f33-fe77-1a6b6f167b4a@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 03/03/2017 10:53 AM, Fam Zheng wrote:
> On Fri, 03/03 09:12, Christian Borntraeger wrote:
>> On 03/02/2017 05:33 PM, no-reply@patchew.org wrote:
>>
>> Fam, this seems to happen sometimes. Can you have a look at that why the qtest 
>> thing fails on the s390 box?
> 
> I don't know, when I run the commands manually for a few times, it is not
> reproduced. :(

Just guessing, maybe you have two runs in parallel that use the same folder
for some reason?

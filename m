Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cjnAB-0000jT-AE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cjnA8-0003Xn-5L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:22:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cjnA7-0003Xd-Va
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:22:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v23DDcHn036237
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 08:22:23 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28xs8fftpd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:22:22 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 3 Mar 2017 06:22:22 -0700
References: <148847238435.285.7158100214182923369@0e2666bad730>
	<e58e0463-c12f-31ed-3944-a09735e7a7fc@de.ibm.com>
	<20170303095301.GE7097@lemon.lan>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 3 Mar 2017 14:22:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170303095301.GE7097@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <7010a04e-a8c0-16a9-c9bf-c22e32b521c3@de.ibm.com>
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org

On 03/03/2017 10:53 AM, Fam Zheng wrote:
> On Fri, 03/03 09:12, Christian Borntraeger wrote:
>> On 03/02/2017 05:33 PM, no-reply@patchew.org wrote:
>>
>> Fam, this seems to happen sometimes. Can you have a look at that why the qtest 
>> thing fails on the s390 box?
> 
> I don't know, when I run the commands manually for a few times, it is not
> reproduced. :(
> 
> Fam

Any chance to add V=1 to the make check, so that we get the full testcase output?

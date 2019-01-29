Received: from eggs.gnu.org ([209.51.188.92]:46628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goWRR-0006zR-3G
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goWRP-0005Um-5I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:40:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goWRN-0005T2-7X
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 11:40:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TGY4uq132667
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:40:45 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qat47shew-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 11:40:45 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 16:40:44 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 11:40:38 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <003bced3-a883-bf08-98a9-e3c105125643@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 00/15] s390: vfio-ccw dasd ipl
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 1/29/19 8:29 AM, Jason J. Herne wrote:
> This is to support booting from vfio-ccw dasd devices. We basically implement
> the real hardware ipl procedure. This allows for booting Linux guests on
> vfio-ccw devices.
> 
> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
> channel programs dynamically modify themselves. Details on the ipl process and
> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
> 
> This version brings better error handling, namely retrying I/O operations in the
> event of some transient failure conditions. I've also renamed the sense data
> structures and error output to indicate that they are for eckd dasd only. A few
> other fixups as well, see changelog for details.
> 

Forgot to add the 2 tag, this is v2.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

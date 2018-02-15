Received: from eggs.gnu.org ([2001:4830:134:3::10]:56726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1emKEh-0003DH-PV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1emKEd-0005Na-EC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:10:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37192
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1emKEd-0005LY-8A
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:10:03 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FE88FA005669
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:10:01 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5atnak4f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:10:00 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 09:09:59 -0500
References: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
	<1818f13c-0e9e-70da-8d39-9ff9f07c3982@redhat.com>
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 12:09:53 -0200
MIME-Version: 1.0
In-Reply-To: <1818f13c-0e9e-70da-8d39-9ff9f07c3982@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8e7db8ab-359e-8ee4-4a0b-1c6f9523f652@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/ssh: fix possible segmentation fault
 when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Richard W M Jones <rjones@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 01/05/2018 02:57 PM, Eric Blake wrote:
> On 01/05/2018 08:44 AM, Murilo Opsfelder Araujo wrote:
>> This patch prevents a possible segmentation fault when .desc members are checked
>> against NULL.
>>
>> The ssh_runtime_opts was added by commit
>> 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime
>> options").
>>
>> This fix was inspired by
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00883.html.
>>
>> Fixes: 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime options")
> 
> present since 2.7.0, so we've gotten lucky that no one has actually
> encountered a crash (but I didn't try hard to see if one was possible)
> 
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
>> ---
>>  block/ssh.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> CC: qemu-stable@nongnu.org
> Reviewed-by: Eric Blake <eblake@redhat.com>

Hi, Eric.

Was this supposed to land stable-2.11 branch?

Cheers
Murilo

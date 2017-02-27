Received: from eggs.gnu.org ([2001:4830:134:3::10]:58316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ciLsi-0001xu-2H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ciLse-0007Sb-VC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:02:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ciLse-0007SS-LS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:02:24 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RDxLgG005658
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:02:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u641byqe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:02:22 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 14:02:20 -0000
References: <20170222160119.52771-1-pasic@linux.vnet.ibm.com>
	<20170222160119.52771-4-pasic@linux.vnet.ibm.com>
	<20170224122954.GA8830@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 15:02:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170224122954.GA8830@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <fb8ac151-a375-9c2b-a241-fbff879c3492@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration/vmstate: fix array of ptr
 with nullptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>



On 02/24/2017 01:29 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Make VMS_ARRAY_OF_POINTER cope with null pointers. Previously the
>> reward for trying to migrate an array with some null pointers in it was
>> an illegal memory access, that is a swift and painless death of the
>> process.  Let's make vmstate cope with this scenario.
>>
>> The general approach is, when we encounter a null pointer (element),
>> instead of following the pointer to save/load the data behind it, we
>> save/load a placeholder. This way we can detect if we expected a null
>> pointer at the load side but not null data was saved instead.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

Thanks! Seems there are no further objections. Is the series going in
via your tree (softfreeze starting 28.02, me worried)?

Regards,
Halil

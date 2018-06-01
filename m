Received: from eggs.gnu.org ([2001:4830:134:3::10]:53421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fOqWm-0005I3-Ug
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fOqWh-0002sx-Sn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:20:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34844
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fOqWh-0002rM-Lz
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:19:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w51KJSpY143023
	for <qemu-devel@nongnu.org>; Fri, 1 Jun 2018 16:19:54 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jbaj25yf2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 16:19:54 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 1 Jun 2018 16:19:53 -0400
References: <1527671818-23809-1-git-send-email-thuth@redhat.com>
	<1527671818-23809-3-git-send-email-thuth@redhat.com>
	<9b84d9e4-f7b8-dd5b-3180-551047879eab@linux.ibm.com>
	<0eaa6943-57a8-3dec-18e5-5e498dd06e6a@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 1 Jun 2018 16:19:50 -0400
MIME-Version: 1.0
In-Reply-To: <0eaa6943-57a8-3dec-18e5-5e498dd06e6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2489ce83-a622-2f63-e9d1-50b3298596cb@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] pc-bios/s390-ccw/net: Add support for
 pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>



On 05/31/2018 11:21 PM, Thomas Huth wrote:
>> Just a question do we want to clear cfgbuf here, before calling
>> pxelinux_load_parse_cfg?
> That's theoretically not necessary. The buffer either gets populated
> with data, or the function errors out. The code also makes sure that
> there is a final NUL-character in the buffer:
> 
> https://github.com/aik/SLOF/blob/64c526a/lib/libnet/pxelinux.c#L169
> 
> ... but I think I've got to double check that there is also a
> NUL-character immediately at the end of the downloaded data ... so
> there's indeed a change required, but likely rather in the SLOF code
> than here.
> 
>   Thomas
> 
> 

Can't we do that in net_try_direct_tftp_load, or it is better to put 
that in SLOF code?

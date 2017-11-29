Received: from eggs.gnu.org ([2001:4830:134:3::10]:46194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eKAv6-00049W-8H
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eKAv2-0007ql-Ar
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:33:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eKAv1-0007p5-S2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:33:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vATMSxqw093636
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 17:33:24 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ej21p1mg3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 17:33:24 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 15:33:23 -0700
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
	<47adadbb-04a5-a91b-9e61-861c905a520b@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 29 Nov 2017 17:33:20 -0500
MIME-Version: 1.0
In-Reply-To: <47adadbb-04a5-a91b-9e61-861c905a520b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <8ff918de-c3e3-14da-db46-3b220b00cc7f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/5] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 11/29/2017 05:28 PM, David Hildenbrand wrote:
> On 27.11.2017 21:55, Collin L. Walling wrote:
>> Set boot menu options for an s390 guest and store them in
>> the iplb. These options are set via the QEMU command line
>> option:
>>
>>      -boot menu=on|off[,splash-time=X]
>>
>> or via the libvirt domain xml:
>>
>>      <os>
>>        <bootmenu enable='yes|no' timeout='X'/>
>>      </os>
>>
>> Where X represents some positive integer representing
>> milliseconds.
> Aren't this properties usually contained in the zIPL block? (e.g.
> written and configured by zipl)
>
I believe the timeout value is nestled in there somewhere, yes.
However it was requested that we control the boot menu timeout value
via the Qemu command line instead. :)

-- 
- Collin L Walling

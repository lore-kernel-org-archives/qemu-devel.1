Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOofK-00024C-4o
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOofH-0005nw-3X
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:48:26 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-4-git-send-email-walling@linux.vnet.ibm.com>
	<8f61fa61-9b27-ac88-e781-be2e8df3a6f4@redhat.com>
	<046eae0b-e094-8d94-3fea-3390942930b1@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8f374b1d-3bbd-e10d-128a-8b1fa1840530@redhat.com>
Date: Tue, 12 Dec 2017 18:48:19 +0100
MIME-Version: 1.0
In-Reply-To: <046eae0b-e094-8d94-3fea-3390942930b1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 3/5] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com, frankja@linux.vnet.ibm.com


>>> +
>>> +        /* Store timeout value as seconds */
>>> +        timeout /= 1000;
>> So we pass ms on the command line? Why?
> 
> 
> The QEMU user documentation specifies the splash-time as milliseconds.
> I figured it would be best to conform to that.

Makes sense then, maybe round up.


-- 

Thanks,

David / dhildenb

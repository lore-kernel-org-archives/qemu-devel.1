Received: from eggs.gnu.org ([2001:4830:134:3::10]:51153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKR8n-0001Fn-8e
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKR8i-0001mq-Dh
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:52:45 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
	<47adadbb-04a5-a91b-9e61-861c905a520b@redhat.com>
	<8ff918de-c3e3-14da-db46-3b220b00cc7f@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <69cba44d-5126-4711-4be6-362cc2ce10d7@redhat.com>
Date: Thu, 30 Nov 2017 16:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <8ff918de-c3e3-14da-db46-3b220b00cc7f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 29.11.2017 23:33, Collin L. Walling wrote:
> On 11/29/2017 05:28 PM, David Hildenbrand wrote:
>> On 27.11.2017 21:55, Collin L. Walling wrote:
>>> Set boot menu options for an s390 guest and store them in
>>> the iplb. These options are set via the QEMU command line
>>> option:
>>>
>>>      -boot menu=on|off[,splash-time=X]
>>>
>>> or via the libvirt domain xml:
>>>
>>>      <os>
>>>        <bootmenu enable='yes|no' timeout='X'/>
>>>      </os>
>>>
>>> Where X represents some positive integer representing
>>> milliseconds.
>> Aren't this properties usually contained in the zIPL block? (e.g.
>> written and configured by zipl)
>>
> I believe the timeout value is nestled in there somewhere, yes.
> However it was requested that we control the boot menu timeout value
> via the Qemu command line instead. :)
> 

Wonder if it makes sense to always act like the zIPL loader (display
menu/timeout) but allow to overwrite it via cmd line.

-- 

Thanks,

David / dhildenb

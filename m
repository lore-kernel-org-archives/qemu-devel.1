Received: from eggs.gnu.org ([209.51.188.92]:37144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmkSv-0007JO-HN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gmkSt-00063A-Af
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:15:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gmkSr-00061G-AD
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:15:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OJDlGx138252
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:14:56 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q7j0tmbj7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:14:56 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 24 Jan 2019 19:14:55 -0000
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190122193346.4e23e018@oc2783563651>
	<20190123112112.7822b237.cohuck@redhat.com>
	<42264dd9-86d7-8994-8c25-bc688067725d@linux.ibm.com>
	<20190124111934.72e7f0f1.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 24 Jan 2019 14:14:49 -0500
MIME-Version: 1.0
In-Reply-To: <20190124111934.72e7f0f1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f21fcc66-7874-295a-df3f-191c3a930c64@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 01/24/2019 05:19 AM, Cornelia Huck wrote:
> On Thu, 24 Jan 2019 11:08:02 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 23/01/2019 11:21, Cornelia Huck wrote:
>>> On Tue, 22 Jan 2019 19:33:46 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On Mon, 21 Jan 2019 12:03:51 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>   
>>>>> --- a/drivers/s390/cio/vfio_ccw_private.h
>>>>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>>>>> @@ -28,6 +28,7 @@
>>>>>     * @mdev: pointer to the mediated device
>>>>>     * @nb: notifier for vfio events
>>>>>     * @io_region: MMIO region to input/output I/O arguments/results
>>>>> + * @io_mutex: protect against concurrent update of I/O structures
>>>>
>>>> We could be a bit more specific about what does this mutex guard.
>>>> Is it only io_region, or cp, irb and the new regions a well? ->state does
>>>> not seem to be covered, but should need some sort of synchronisation
>>>> too, or?
>>>
>>> I'm not sure. IIRC Pierre had some ideas about locking in the fsm?
>>>    
>>
>> Yes I postponed this work to not collide with your patch series.
>>
>> Do you think I should provide a new version of the FSM reworking series
>> based on the last comment I got?
>>
>> I would take into account that the asynchronous commands will come with
>> your patch series and only provide the framework changes.
> 
> This was more an answer to Halil's concerns around state
> synchronization. I would prefer to first get this series (or a
> variation) into decent shape, and then address state machine handling
> on top of that (when we know more about the transitions involved), just
> to avoid confusion.
> 
> Does that sound reasonable?
> 

It does to me.

<Sorry for my silence; we teach our daughter to share, and she shares 
whatever bug is passed around daycare.  I'm catching up on my "todo" 
emails now!>

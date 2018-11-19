Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1gOqOQ-0002Wd-P8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1gOqOL-0000kJ-0p
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1gOqOJ-0000a5-4K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:43:31 -0500
References: <20181119104330.GA2367@work-vm>
	<16966.1542632079@dschgrazlin2.units.it>
	<20181119183343.GD2365@work-vm>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <0f9a622f-d3af-0bfb-36f0-c08447292523@redhat.com>
Date: Mon, 19 Nov 2018 15:43:25 -0500
MIME-Version: 1.0
In-Reply-To: <20181119183343.GD2365@work-vm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, balducci@units.it, pbonzini@redhat.com, ehabkost@redhat.com, robert.hu@linux.intel.com
Cc: qemu-devel@nongnu.org

On 11/19/2018 01:35 PM, Dr. David Alan Gilbert wrote:
> * balducci@units.it (balducci@units.it) wrote:
>> hi
>>
>> thanks for taking the time to reply
>>
>> Dr. David Alan Gilbert writes:
>>>> I suspect that this might be some problem on my side, as I couldn't
>>>> find any similar report (apart some old (qemu-2.8.50) threads, that
>>>> didn't help)
>>>
>>> Not necessarily; can you tell me:
>>>    a) At what point does it fail - immediately when booting the guest?
>>>       Some time during the boot? Later?
>>>    b) What guest does it happen on?
>>
>> a) the error happens almost immediately; I mean: when I run qemu from an
>>     xterm, it doesn't even popup its window: it just dumps the error
>>     message to the terminal and stops
>> b) the guest is an old windows XP OS; but, as I say above, all goes as
>>     if qemu doesn't even load the OS image (at least this is my
>>     impression)
>>
> A colleague has confirmed this on his FX-8320 on Fedora 29 with the
> virt-next repo;  so it's nothing that's special about your machine;
> it's 3.1 that really doesn't like the old AMDs.
> 

Also we received a similar report in Fedora bugzilla:

https://bugzilla.redhat.com/show_bug.cgi?id=1651021

Thanks,
Cole

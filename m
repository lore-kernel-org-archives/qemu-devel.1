Received: from eggs.gnu.org ([2001:4830:134:3::10]:57367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBJpe-0002N0-1M
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fBJpa-0007bP-42
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:47:34 -0400
References: <1524633715-21393-1-git-send-email-thuth@redhat.com>
	<11bfff34-f237-69e3-5491-a048809d84a4@redhat.com>
	<fae01c1a-1780-7bb6-2396-f21dd9b2c6b6@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6418edf4-e94c-02eb-0b6d-86fada5986fa@redhat.com>
Date: Wed, 25 Apr 2018 14:47:27 +0200
MIME-Version: 1.0
In-Reply-To: <fae01c1a-1780-7bb6-2396-f21dd9b2c6b6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

>>>      int ret;
>>> @@ -346,6 +355,14 @@ static void ccw_init(MachineState *machine)
>>>      /* Create VirtIO network adapters */
>>>      s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
>>>  
>>> +    /* init consoles */
>>> +    if (serial_hds[0]) {
>>> +        s390_create_sclpconsole("sclpconsole", serial_hds[0]);
>>> +    }
>>> +    if (serial_hds[1]) {
>>> +        s390_create_sclpconsole("sclplmconsole", serial_hds[1]);
>>> +    }
>>
>> What happens if more -serial are defined? An error? Silently ignored?
> 
> Silently ignored, since this is also what almost all other machines are
> doing (look for serial_hds in hw/ and you'll see what I mean).
> 
>> (e.g. do we have to redefine MAX_SERIAL_PORTS on s390x or add checking
>> code here?)
> 
> As all the other machines are also not redefining MAX_SERIAL_PORTS, I
> think we should also not do this on s390x now, should we?

Then I guess if we would introduce it, we should do it for all other
implementations. So I think we can just leave it as it is.

> 
>  Thomas
> 


-- 

Thanks,

David / dhildenb

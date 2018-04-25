Received: from eggs.gnu.org ([2001:4830:134:3::10]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBKym-00023Q-Eu
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBKye-0005Vf-Sp
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:01:04 -0400
References: <1524633715-21393-1-git-send-email-thuth@redhat.com>
	<11bfff34-f237-69e3-5491-a048809d84a4@redhat.com>
	<fae01c1a-1780-7bb6-2396-f21dd9b2c6b6@redhat.com>
	<CAFEAcA_chYr1Y00KJQJ+JJ2VDgkcxuh4DqYeP0o_+HbHdJXGFA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8d0fb991-12b8-5660-19c1-4d93299a5ba9@redhat.com>
Date: Wed, 25 Apr 2018 16:00:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_chYr1Y00KJQJ+JJ2VDgkcxuh4DqYeP0o_+HbHdJXGFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] hw/s390x: Allow to
 configure the consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 25.04.2018 14:31, Peter Maydell wrote:
> On 25 April 2018 at 11:17, Thomas Huth <thuth@redhat.com> wrote:
>> On 25.04.2018 11:50, David Hildenbrand wrote:
>>> On 25.04.2018 07:21, Thomas Huth wrote:
>>>> The consoles ("sclpconsole" and "sclplmconsole") can only be configured
>>>> with "-device" and "-chardev" so far. Other machines use the convenience
>>>> option "-serial" to configure the default consoles, even for virtual
>>>> consoles like spapr-vty on the pseries machine. So let's support this
>>>> option on s390x, too. This way we can easily enable the serial console
>>>> here again with "-nodefaults", for example:
> 
>>>> +    /* init consoles */
>>>> +    if (serial_hds[0]) {
>>>> +        s390_create_sclpconsole("sclpconsole", serial_hds[0]);
>>>> +    }
>>>> +    if (serial_hds[1]) {
>>>> +        s390_create_sclpconsole("sclplmconsole", serial_hds[1]);
>>>> +    }
>>>
>>> What happens if more -serial are defined? An error? Silently ignored?
>>
>> Silently ignored, since this is also what almost all other machines are
>> doing (look for serial_hds in hw/ and you'll see what I mean).
>>
>>> (e.g. do we have to redefine MAX_SERIAL_PORTS on s390x or add checking
>>> code here?)
>>
>> As all the other machines are also not redefining MAX_SERIAL_PORTS, I
>> think we should also not do this on s390x now, should we?
> 
> Note that I have a series on-list which removes the MAX_SERIAL_PORTS
> restriction, so you can have arbitrarily many serial ports.

Ah, great, good idea. Thanks for the hint, I was not aware of that patch
series yet.

> (If that gets into master before this there'll be a conflict,
> but it's easy to resolve: just change "serial_hds[n]" to "serial_hd(n)".)

Ok, that should be pretty easy to resolve, indeed.

 Thomas

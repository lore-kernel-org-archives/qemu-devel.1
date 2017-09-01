Received: from eggs.gnu.org ([2001:4830:134:3::10]:57817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1dnmXs-00078R-4R
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1dnmXk-0000qi-8G
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:03:40 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1dnmXk-0000qA-1p
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:03:32 -0400
Received: by mail-oi0-x243.google.com with SMTP id x184so245290oia.3
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 07:03:30 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAATJJ0+icNedEKO0HK54Wv=V7NQ67TYwJtNXfR+KBpHJ77m-Sg@mail.gmail.com>
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<e24316e0-3b6f-ef1c-7c4b-66e7b302e5b4@linux.vnet.ibm.com>
	<97b35c4d-e897-c18a-525f-1fa1a7560776@de.ibm.com>
	<20170825092008.12484e6a.cohuck@redhat.com>
	<d3e9d032-fd2e-6126-1774-cb8a86a219f4@de.ibm.com>
	<20170825102950.736647be.cohuck@redhat.com>
	<2fdd5a70-6339-c4ec-c13c-d6f96d7abfc9@de.ibm.com>
	<c79ab349-116d-10d5-9310-f3ff8a6b4b81@redhat.com>
	<150420147254.3063.2667079729715778036@loki>
	<CAATJJ0+icNedEKO0HK54Wv=V7NQ67TYwJtNXfR+KBpHJ77m-Sg@mail.gmail.com>
Message-ID: <150427459766.16876.8717337565160214215@loki>
Date: Fri, 01 Sep 2017 09:03:17 -0500
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On 09/01/2017 02:06 AM, Christian Ehrhardt wrote:
> On Thu, Aug 31, 2017 at 7:44 PM, Michael Roth
> <mdroth@linux.vnet.ibm.com>
> wrote:
> =

>> Quoting Thomas Huth (2017-08-29 04:35:22)
>>> On 28.08.2017 09:18, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 08/25/2017 10:29 AM, Cornelia Huck wrote:
>>>>> On Fri, 25 Aug 2017 10:21:58 +0200
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>
>>>>>> On 08/25/2017 09:20 AM, Cornelia Huck wrote:
>>>>>
>>>>>>> OK, to recap:
>>>>>>>
>>>>>>> - the current pre-built bios seems fine
>>>>>>> - rebuilding the bios may yield a version that fails on some
>>>>>>> systems
>>>>>>>    (different compiler?)
>>>>>>> - adding aligned(8) looks like the right thing to do
>>>>>>> - it seems to fix the problem, but on at least one system
>>>>>>> something
>>>>>>>    still seems off (under investigation)
>>>>>>
>>>>>> Yes. I am out of office today, so for any aligned(8) patch
>>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>> even for 2.10.
>>>>>
>>>>> I fear the 2.10 train has already left the station, but any
>>>>> aligned(8)
>>>>> patch should be cc:stable.
>>>>
>>>> I think this could be a topic for QEMU summit. Our process of not
>> allowing
>>>> fixes in rcx without requiring an rc(x+1) seems a bit odd. The
>>>> Linux
>> kernel
>>>> style (there are fixes between the last rc and release) seems more
>> balanced
>>>> as long as we establish some safety nets.
>>>
>>> This sounds like a good idea to me, yes. And maybe we could also
>>> ease
>>> the situation a little bit by providing the first stable .1 release
>>> already two or three weeks after the .0 release [*] ? Then these "we
>>> are
>>> not 100% sure whether this is a severe blocker or not" patches could
>>> simply be provided to the public with that .1 release instead of
>>> blocking the QEMU master branch in freeze state...
>>
>> I can give it a try for 2.10.1.
>>
>> At least initially, I would prefer to not have there be a set
>> expectation
>> that there will be a quick .1 release though, but rather anything
>> tagged
>> for-2.10, for instance, that doesn't make it in, will then fall into
>> the "expedited 2.10.1" bucket, and for that to be the *only* way to
>> get
>> into that bucket (we'd still do the normal round-up and pull in any
>> "Cc: qemu-stable@nongnu.org" patches at that point though).
>>
> =

> Hi Michael,
> To check if I got that correctly:
> - a 2.10.1 could happen rather soon (like end of september as
> suggested) as
> several things seem still up in the air?

Correct.

> - but to "get in" you'd still expect all changes that should be
> considered
> to hit "Cc: qemu-stable@nongnu.org" and be bugfix only?

Well, that's always the case. What I'm suggesting is that for, say,
2.11, we shouldn't plan to have an early 2.11.1, but rather target
everything for 2.11.0 as normal and only do an early 2.11.1 if we
decide to defer anything originally targetted for 2.11.0. Otherwise
2.11.1 would happen toward the end of 2.12 development cycle like we
usually do.

> =

> This would help ensure we don't steal focus from the .0 releases and
> allow
>> those "is this a blocker?" discussions to happen in the proper
>> context.
>>
>>>
>>>   Thomas
>>>
>>>
>>> [*] I know that means more additional work for Michael - sorry for
>>> that
>>> ... but at least we should talk about this, I think. Maybe someone
>>> else
>>> could also help with the releases if it's too much work for one
>>> person?
>>>
>>
>>
>>
>=20

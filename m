Received: from eggs.gnu.org ([2001:4830:134:3::10]:45637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dO6X9-0005ti-8P
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dO6X6-0001JT-1T
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:08:47 -0400
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
	<CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
	<20170622172555.GE2100@work-vm>
	<20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
	<20170622175012.GF2100@work-vm>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fb2c7124-2d3f-6684-e2f2-265bfb3eb6da@redhat.com>
Date: Thu, 22 Jun 2017 20:08:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170622175012.GF2100@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Separate function types from opaque types
 in include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 22.06.2017 19:50, Dr. David Alan Gilbert wrote:
> * Greg Kurz (groug@kaod.org) wrote:
>> On Thu, 22 Jun 2017 18:25:55 +0100
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>>
>>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>>> On 22 June 2017 at 18:03, Juan Quintela <quintela@redhat.com> wrote:  
>>>>> Greg Kurz <groug@kaod.org> wrote:  
>>>>>> On Thu, 22 Jun 2017 17:14:08 +0100
>>>>>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>  
>>>>>>> On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote:  
>>>>>>>> Function types cannot reside in the same sorted list as opaque types since
>>>>>>>> they may depend on a type which would be defined later.
>>>>>>>>
>>>>>>>> Of course, the same problem could arise if a function type depends on
>>>>>>>> another function type with greater alphabetical order. Hopefully we
>>>>>>>> don't have that at this time.  
>>>>>>>
>>>>>>> The other approach would be to put function types somewhere
>>>>>>> else and leave typedefs.h for the simple 'opaque types
>>>>>>> for structures' that it was started as.
>>>>>>>
>>>>>>> For instance we have include/qemu/fprintf-fn.h as a precedent.
>>>>>>>  
>>>>>>
>>>>>> Indeed, and I'm not quite sure why Juan decided to put these types into
>>>>>> typedefs.h instead of a dedicated header file in include/migration... is
>>>>>> it only because it was the quickest fix ?  
>>>>>
>>>>> All other typedefs were defined there.  I can create a different include
>>>>> file, but I think that is "overengineering", no?  They are typedefs,
>>>>> just not of structs.  But I agree that they are the only ones.  
>>>>
>>>> Well, the comment in the file says "opaque types so that device init
>>>> declarations don't have to pull in all the real definitions", whereas
>>>> the ones you've added aren't opaque types, they are the real
>>>> definitions. They're also only used by a very small subset of .c
>>>> files, whereas typedefs.h goes everywhere.  
>>>
>>> mv fprintf-fn.f   fn-typedefs.h
>>>
>>> move those two defs into that?
>>>
>>
>> Wouldn't it be more appropriate to put them in a dedicated
>> include/migration/handler-fn.h header included by both
>> vmstate.h and register.h ?
> 
> Could do; I'm just not finding tiny header files with one or
> two entries each that useful.

Do we really need these function typedefs at all? IMHO it's quite ugly
to hide such things in a typedef unless it is really necessary (and in
this case, it does not seem to be really necessary since it is only used
in a few places). So what about simply removing the typedefs in this case?

 Thomas

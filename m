Received: from eggs.gnu.org ([2001:4830:134:3::10]:40148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDnnw-0007Wd-F2
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDnns-0007Ec-Eh
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:12:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fDnns-0007E0-6j
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:12:00 -0400
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
	<87muxi8t2b.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c49e4ab-bb40-cf20-629a-2fc5c19d8585@redhat.com>
Date: Wed, 2 May 2018 11:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <87muxi8t2b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

On 02/05/2018 08:34, Markus Armbruster wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> On 30/4/18 7:39 pm, Paolo Bonzini wrote:
>>> On 30/04/2018 08:52, Alexey Kardashevskiy wrote:
>>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>>> index 5636f4a..399ec74 100644
>>>> --- a/qapi/misc.json
>>>> +++ b/qapi/misc.json
>>>> @@ -1491,6 +1491,10 @@
>>>>  #
>>>>  # List properties associated with a device.
>>>>  #
>>>> +# Note: the handler creates a device object, enumerates properties and destroys
>>>> +# the object so it only lists properties defined in DeviceClass::props or
>>>> +# created by DeviceClass::init()/TypeInfo::instance_init().
>>>> +#
>>>>  # @typename: the type name of a device
>>>>  #
>>>>  # Returns: a list of ObjectPropertyInfo describing a devices properties
>>>> @@ -1506,6 +1510,11 @@
>>>>  #
>>>>  # List properties associated with a QOM object.
>>>>  #
>>>> +# Note: the handler creates an object, enumerates properties and destroys
>>>> +# the object so it only lists properties created in TypeInfo::instance_init().
>>>> +# Since the instance_init() callback of the device object adds
>>>> +# DeviceClass::props as object properties, they will be listed as well.
>>>> +#
>>>
>>> This says what it does, but not why it is a problem.  Can you explain
>>> that to me as well?
>>
>> It probably is not unless someone adds properties in realize() callback,
> 
> Now work that into the doc comment, please :)

Are there any examples?  If not, that belongs in a comment in the code
rather than the QAPI doc comment.  If yes, then the doc comment should
include one.

Paolo

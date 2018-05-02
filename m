Received: from eggs.gnu.org ([2001:4830:134:3::10]:37433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDlL8-0001nJ-Hb
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDlL5-0005Fs-Gj
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:34:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDlL5-0005FN-Ba
	for qemu-devel@nongnu.org; Wed, 02 May 2018 02:34:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
Date: Wed, 02 May 2018 08:34:04 +0200
In-Reply-To: <d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru> (Alexey
	Kardashevskiy's message of "Wed, 2 May 2018 11:26:22 +1000")
Message-ID: <87muxi8t2b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 30/4/18 7:39 pm, Paolo Bonzini wrote:
>> On 30/04/2018 08:52, Alexey Kardashevskiy wrote:
>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>> index 5636f4a..399ec74 100644
>>> --- a/qapi/misc.json
>>> +++ b/qapi/misc.json
>>> @@ -1491,6 +1491,10 @@
>>>  #
>>>  # List properties associated with a device.
>>>  #
>>> +# Note: the handler creates a device object, enumerates properties and destroys
>>> +# the object so it only lists properties defined in DeviceClass::props or
>>> +# created by DeviceClass::init()/TypeInfo::instance_init().
>>> +#
>>>  # @typename: the type name of a device
>>>  #
>>>  # Returns: a list of ObjectPropertyInfo describing a devices properties
>>> @@ -1506,6 +1510,11 @@
>>>  #
>>>  # List properties associated with a QOM object.
>>>  #
>>> +# Note: the handler creates an object, enumerates properties and destroys
>>> +# the object so it only lists properties created in TypeInfo::instance_init().
>>> +# Since the instance_init() callback of the device object adds
>>> +# DeviceClass::props as object properties, they will be listed as well.
>>> +#
>> 
>> This says what it does, but not why it is a problem.  Can you explain
>> that to me as well?
>
>
> It probably is not unless someone adds properties in realize() callback, if
> this happens, the user would probably expect to see these in these commands
> but he/she won't.

Now work that into the doc comment, please :)

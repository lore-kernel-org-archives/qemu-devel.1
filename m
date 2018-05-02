Received: from eggs.gnu.org ([2001:4830:134:3::10]:45586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDgXS-00052z-1p
	for qemu-devel@nongnu.org; Tue, 01 May 2018 21:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDgXO-0003Sf-Sm
	for qemu-devel@nongnu.org; Tue, 01 May 2018 21:26:34 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:34570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fDgXO-0003S0-IM
	for qemu-devel@nongnu.org; Tue, 01 May 2018 21:26:30 -0400
Received: by mail-pf0-x229.google.com with SMTP id a14so10352543pfi.1
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 18:26:28 -0700 (PDT)
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
Date: Wed, 2 May 2018 11:26:22 +1000
MIME-Version: 1.0
In-Reply-To: <c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 30/4/18 7:39 pm, Paolo Bonzini wrote:
> On 30/04/2018 08:52, Alexey Kardashevskiy wrote:
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index 5636f4a..399ec74 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -1491,6 +1491,10 @@
>>  #
>>  # List properties associated with a device.
>>  #
>> +# Note: the handler creates a device object, enumerates properties and destroys
>> +# the object so it only lists properties defined in DeviceClass::props or
>> +# created by DeviceClass::init()/TypeInfo::instance_init().
>> +#
>>  # @typename: the type name of a device
>>  #
>>  # Returns: a list of ObjectPropertyInfo describing a devices properties
>> @@ -1506,6 +1510,11 @@
>>  #
>>  # List properties associated with a QOM object.
>>  #
>> +# Note: the handler creates an object, enumerates properties and destroys
>> +# the object so it only lists properties created in TypeInfo::instance_init().
>> +# Since the instance_init() callback of the device object adds
>> +# DeviceClass::props as object properties, they will be listed as well.
>> +#
> 
> This says what it does, but not why it is a problem.  Can you explain
> that to me as well?


It probably is not unless someone adds properties in realize() callback, if
this happens, the user would probably expect to see these in these commands
but he/she won't.



-- 
Alexey

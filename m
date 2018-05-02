Received: from eggs.gnu.org ([2001:4830:134:3::10]:49477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDoPV-0006Pj-Kd
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDoPU-0001XX-QU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:50:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fDoPU-0001Wx-JT
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:50:52 -0400
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
	<87muxi8t2b.fsf@dusky.pond.sub.org>
	<6c49e4ab-bb40-cf20-629a-2fc5c19d8585@redhat.com>
	<6a553611-7bbb-98dd-6dfb-0ef6f53e4dec@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1d40d88-1c80-2bbd-c28c-613b7fe8d45e@redhat.com>
Date: Wed, 2 May 2018 11:50:32 +0200
MIME-Version: 1.0
In-Reply-To: <6a553611-7bbb-98dd-6dfb-0ef6f53e4dec@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 02/05/2018 11:33, Alexey Kardashevskiy wrote:
>>>>>> +# Note: the handler creates an object, enumerates properties and destroys
>>>>>> +# the object so it only lists properties created in TypeInfo::instance_init().
>>>>>> +# Since the instance_init() callback of the device object adds
>>>>>> +# DeviceClass::props as object properties, they will be listed as well.
> 
> There are roughly 400 of realize(), this is will take a bit of time :)
> imho what it does belongs to .json, why it does exactly that belongs to the
> git commit log. I'll walk through the realize() hook though, educate
> myself, at least :)

Cheer up, there are only 300 callers of object_property_add_* (apart
from object_property_add_child which is generally not an issue).  You
could look at those instead. :)

Seriously, I think the problem with the comment is only that the reader
most likely doesn't care about instance_init() or props, as those are
QEMU implementation details.

Paolo

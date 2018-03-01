Received: from eggs.gnu.org ([2001:4830:134:3::10]:59639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUfM-0004qR-W5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUfI-0004Vu-AU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:19:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erUfI-0004U7-5t
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:18:56 -0500
References: <20180226082259.40293-1-aik@ozlabs.ru>
	<20180301035910.GC2264@umbus.fritz.box>
	<ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2dad9d81-c83f-d6fb-30a6-380a8cdb70bc@redhat.com>
Date: Thu, 1 Mar 2018 14:18:53 -0600
MIME-Version: 1.0
In-Reply-To: <ae263ebe-d0d2-3b1d-b2ac-200772eb9154@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 03/01/2018 05:47 AM, Alexey Kardashevskiy wrote:

>>> +##
>>> +{ 'struct': 'QOMPropertyInfo',
>>> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
>>
>> So, this has identical contents to DevicePropertyInfo, and is very
>> similar to ObjectPropertyInfo.  Is there any way we could consolidate
>> those types?
> 
> Sure, I can get rid of DevicePropertyInfo in favour of QOMPropertyInfo, I
> am just not sure if this typename is visible anywhere in the QMP protocol.

Introspection doesn't expose type names; you are free to change those at 
will (clients like libvirt that parse introspection merely get a list of 
members and types, regardless of what typename those members belonged to).


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

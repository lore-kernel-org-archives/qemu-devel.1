Received: from eggs.gnu.org ([2001:4830:134:3::10]:47697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoRD9-0007cj-Bm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoRD6-00073X-8Y
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:01:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoRD6-00072V-4G
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:01:12 -0500
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<cde2e179-820f-5afb-9d90-43862a50be51@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0575e414-09b6-af0d-a392-1eeb903f6c28@redhat.com>
Date: Wed, 21 Feb 2018 11:01:01 +0100
MIME-Version: 1.0
In-Reply-To: <cde2e179-820f-5afb-9d90-43862a50be51@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrea Bolognani <abologna@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 21/02/2018 04:36, Alexey Kardashevskiy wrote:
> On 19/01/18 16:09, Alexey Kardashevskiy wrote:
>> There is already 'device-list-properties' which does most of the job,
>> however it does not handle everything returned by qom-list-types such
>> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
>>
>> This adds a new qom-list-properties command which prints properties
>> of a specific class and its instance. It is pretty much a simplified copy
>> of the device-list-properties handler.
>>
>> Since it creates an object instance, device properties should appear
>> in the output as they are copied to QOM properties at the instance_init
>> hook.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> So is it ack or nack for the patch? Whose area is this? Thanks,

I think Markus, but I can queue it too because he's on leave.  Can you
please resubmit it?

Paolo

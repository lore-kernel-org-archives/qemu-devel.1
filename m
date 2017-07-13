Received: from eggs.gnu.org ([2001:4830:134:3::10]:58124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVcxm-0005zU-55
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVcxh-000838-2Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:11:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44977
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVcxg-00082y-Ss
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:11:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DC9ZNi124946
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:11:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3s5c7h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:11:15 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 13:11:13 +0100
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-4-ehabkost@redhat.com>
	<2cda5b0b-0169-d12e-114e-77fcb1a4bb07@linux.vnet.ibm.com>
	<20170712192055.GL6020@localhost.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 14:11:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170712192055.GL6020@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fc38afe1-ee3c-f2e2-9d21-31396d271829@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] Revert "machine: Convert abstract
 typename on compat_props to subclass names"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>



On 07/12/2017 09:20 PM, Eduardo Habkost wrote:
> On Wed, Jul 12, 2017 at 07:49:22PM +0200, Halil Pasic wrote:
>> On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
>>> This reverts commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2.
>>>
>>> The bug addressed by that commit is now fixed in a better way by the
>>> commit "qdev: fix the order compat and global properties are applied".
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>
>> Note: It is not like the effect of commit 0bcba41fe3 is canceled
>> out with your first patch in place. It depends on the client
>> code (the implementation of the individual devices) wether
>> this patch changes something or not. I did not check myself.
>> So the did you verify that nothing breaks with this change applies
>> here too.
> 
> I don't get this part.  I don't see how individual devices
> implementation will be able to affect the outcome after this
> patch is applied.
> 
> GlobalProperty::driver is not used as input for
> object_property_parse() at all (see qdev_prop_set_globals()).
> This means exactly the same property setter is invoked when
> registering "<superclass>.<property>" or "<subclass>.<property>".
> The only difference introduced by this series is in the ordering
> of the object_property_parse() calls.
> 
> And even the object_property_parse() call ordering is not
> affected by this patch at all, because of patch 1/3.  Patch 1/3
> will ensure the properties will be applied in exactly the same
> order they were registered, so this patch should introduce
> absolutely no behavior change on any device.
> 

Resolving this disagreement IMHO depends on resolving our disagreement
about patch 1. Let us postpone this until we have an agreement
there.

Cheers,
Halil

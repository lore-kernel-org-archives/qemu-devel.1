Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ddOLM-00044C-E8
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ddOLJ-0003vn-9t
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:11:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45722
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ddOLJ-0003tc-4Y
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:11:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v73MBd54002994
	for <qemu-devel@nongnu.org>; Thu, 3 Aug 2017 18:11:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c45nun0c9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 18:11:43 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 3 Aug 2017 23:11:41 +0100
References: <20170801230155.21083-1-ehabkost@redhat.com>
	<61e65941-a035-a1fd-4a09-3dc54aac7354@linux.vnet.ibm.com>
	<20170803144508.GI3108@localhost.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 4 Aug 2017 00:11:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170803144508.GI3108@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <74f5e1dd-73f0-9a43-0de0-93082f8a7273@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Mark virtio-device as
 non-user-creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 08/03/2017 04:45 PM, Eduardo Habkost wrote:
> On Wed, Aug 02, 2017 at 02:33:00PM +0200, Halil Pasic wrote:
>>
>>
>> On 08/02/2017 01:01 AM, Eduardo Habkost wrote:
>>> TYPE_VIRTIO_DEVICE devices are already not usable with -device
>>> and device_add, but they are reported as user-creatable on
>>> "-device help" and through monitor interfaces.
>>
>> I've tried -device virtio-rng on s390x and from what I see, it
>> seems we 'auto-magically' create the 'controlling' virtio-rng-ccw
>> device. So I have to ask what do you mean by 'already not usable'?
> 
> virtio-rng is just an alias for virtio-rng-<transport>, and it's
> not a TYPE_VIRTIO_DEVICE device.
> 
> virtio-rng-device is the TYPE_VIRTIO_DEVICE subclass, and you
> shouldn't be able to use "-device virtio-rng-device".  Except
> that it works with "qemu-system-arm -machine virt", as I noted on
> another message, and this patch breaks it.
> 

Sorry, I was in a hurry leaving for holiday (I'm in a holiday
for approx 2 weeks) and acted on assumptions -- obviously wrong
ones.

AFAIU you withdrew the patch because of this arm exception in
the other message.

Sorry for the noise.

Halil

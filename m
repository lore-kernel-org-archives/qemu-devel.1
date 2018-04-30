Received: from eggs.gnu.org ([2001:4830:134:3::10]:33583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD8mh-0002ct-K8
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD8me-0000e4-5Z
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:24:03 -0400
References: <1524570294-23058-1-git-send-email-thuth@redhat.com>
	<d2a9fc1a-9696-f2bd-d603-03b23de62004@de.ibm.com>
	<87f6ba73-2ded-06f2-c68f-d8ef4be50edf@redhat.com>
	<20180424160911.22a238bb.cohuck@redhat.com>
	<6d699426-3525-f62a-c4ec-37dd5589654f@redhat.com>
	<64848d8f-071d-e6c8-58a7-d1e74e93e4f0@redhat.com>
	<20180426235515.GL29865@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <324b16e4-4f14-b7ed-94b5-3010896d3a0b@redhat.com>
Date: Mon, 30 Apr 2018 15:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180426235515.GL29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 27/04/2018 01:55, Eduardo Habkost wrote:
>>>
>>> ... the sclpconsole now shows up under /unattached instead of
>>> /peripheral-anon ... does that matter? (I don't have a clue)
>> If the devices are created in the same order, before and after the
>> patch, it should be okay.
> Is there a way to find out if the devices are created in the same
> order using only QMP commands?  It would be very useful to
> automatically validate compatibility between QEMU versions.

We could add QOM properties for the migration "instance id" and all the
other bits that are placed in the migration stream.

Thanks,

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elzbX-0001zA-Rk
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elzbT-0006i3-RA
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:08:19 -0500
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180214111522.677d77bc.cohuck@redhat.com>
	<a0d9f591-8f6d-4c98-8b71-cb8585c1ef12@redhat.com>
	<20180214162715.54743e55.cohuck@redhat.com>
	<b1704559-ae69-8c1c-eae5-3e473e271364@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5c32795-424f-3dd9-85cf-2beb13696b83@redhat.com>
Date: Wed, 14 Feb 2018 10:07:57 -0600
MIME-Version: 1.0
In-Reply-To: <b1704559-ae69-8c1c-eae5-3e473e271364@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, berrange@redhat.com
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/14/2018 09:50 AM, Viktor Mihajlovski wrote:

>> I'd like to know first what libvirt plans to do -- no sense in starting
>> deprecation if we're still stuck with it for a while.
>>
> FWIW, I'm currently preparing libvirt patches to use query-cpus-fast if
> available. I wouldn't see why it would take more than one libvirt
> release to get them in.

And libvirt releases more frequently, so that's probably not a limiting 
factor for deprecating it now in qemu.

> 
> The question might rather be, which combinations of qemu and libvirt are
> considered useful. E.g., I didn't upgrade libvirt in a while on my test
> system but am using bleeding edge QEMU. But that doesn't necessarily
> resemble a valid setup.

In general, new libvirt and old qemu is supported (libvirt tries hard to 
make sure it can manage older images gracefully, for as long as older 
qemu is still supported by a distro), but old libvirt and new qemu is 
unsupported (you often get lucky where it works for a release or two, 
because qemu tries hard not to break back-compat without proper 
deprecation periods, but there may be features that you NEED a newer 
libvirt to properly drive, and this is one of those cases).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

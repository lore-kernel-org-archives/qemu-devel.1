Received: from eggs.gnu.org ([2001:4830:134:3::10]:35480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJd2J-0002Z4-Uf
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJd2F-0007Dr-VI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:22:43 -0500
Date: Tue, 28 Nov 2017 11:22:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128112233.0a1c8c04.cohuck@redhat.com>
In-Reply-To: <c49e91f1-0f8a-8f6c-9784-21aa4623e2cf@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
	<76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
	<20171124134650.46665791.cohuck@redhat.com>
	<7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
	<20171124142758.39d7726f.cohuck@redhat.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
	<39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
	<2933e058-0217-9696-2c52-613da8ba7a1c@linux.vnet.ibm.com>
	<20171127175607.75bd999e.cohuck@redhat.com>
	<c49e91f1-0f8a-8f6c-9784-21aa4623e2cf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On Tue, 28 Nov 2017 09:53:15 +0100
Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:

> On 11/27/2017 05:56 PM, Cornelia Huck wrote:
> > Proposal 2: Export the default cssid as a machine property. If this
> > property exists, it also implies that devices can be put into any css
> > image (although it makes the most sense to put them into the default
> > css image as indicated by the property). Can be made r/w later if it is
> > too much for 2.12.  
> Just as a side discussion:
> I know of qom command query-machines but that does not seem to provide 
> the information you suggest to use with proposal 2.
> What qom command do you suggest to use for the introspection of the 
> machine options access mode?
> 

Is qom-get what you are looking for?

virsh # qemu-monitor-command vm1 --pretty '{ "execute": "qom-get", "arguments": { "path": "/machine/", "property": "accel"} }'
{
  "return": "kvm",
  "id": "libvirt-18"
}

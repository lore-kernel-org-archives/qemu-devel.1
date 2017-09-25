Received: from eggs.gnu.org ([2001:4830:134:3::10]:34693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwRpY-0005pd-Qy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwRpV-00012X-9C
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwRpV-00012G-1s
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:45:41 -0400
Date: Mon, 25 Sep 2017 13:45:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170925134532.08e9e273.cohuck@redhat.com>
In-Reply-To: <20da1950-3aa5-c29f-3d54-4f82289f34f1@de.ibm.com>
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
	<5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
	<ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
	<eee7e600-a8b0-6e23-580b-803f3b4e9efa@linux.vnet.ibm.com>
	<4a31c53b-98aa-747a-1402-1a93e74c565b@de.ibm.com>
	<5cdfe359-2e78-7e2a-72c2-d3e69574288e@linux.vnet.ibm.com>
	<20170925120745.7326637e.cohuck@redhat.com>
	<20da1950-3aa5-c29f-3d54-4f82289f34f1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Mon, 25 Sep 2017 12:12:49 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/25/2017 12:07 PM, Cornelia Huck wrote:
> > On Fri, 22 Sep 2017 16:27:00 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> One thing I would find very helpful is what do we expect to work and not
> >> work for which version. Kind of a matrix. For instance should vfio pci
> >> work for versions prior 2.11. I think in the not so distant past we
> >> changed how SIC works (so it complains when we don't have ais).  
> > 
> > A matrix sounds like a good idea.  
> 
> I think we do not even need a matrix, a minimum level will suffice because...
> > 
> > I don't think we really ever had a setup that worked out of the box  
> 
> exactly: ...it never worked until 2.10 and we do not have libvirt support yet.
> Now with the fix 2.10 will also not work, so I think its fair to say
> 
> PCI passthrough via VFIO will be supported for 
> - KVM: host kernel >= 4.13
> - TCG: TBD
> - QEMU >= 2.11
> - libvirt TBD

Make that zpci-per-se, no?

with KVM: host kernel >= 4.13 && QEMU >= 2.11
with TCG: tbd, I don't think anybody has time to wire this up for 2.11

Apropos libvirt: How will it determine whether zpci should be
supported? There are some old QEMU + KVM combinations out there that
will have a phb (but not be usable by stock Linux guests as the feature
bits are missing). Version fence? Check for cpu feature support?

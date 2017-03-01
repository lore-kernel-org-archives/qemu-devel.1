Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj618-0007iZ-Id
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cj615-00018s-7V
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cj614-00018A-Vs
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:18:11 -0500
Date: Wed, 1 Mar 2017 15:18:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170301151803.GF10160@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <57FA3A002D66E049AA7792D931B894C7060F5494@MOKSCY3MSGUSRGB.ITServices.sbc.com>
	<945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com>
	<20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com>
	<20160616080520.GA2249@work-vm> <20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@us.ibm.com>
Cc: "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Wed, Mar 01, 2017 at 08:25:43AM -0500, Stefan Berger wrote:
> "Daniel P. Berrange" <berrange@redhat.com> wrote on 03/01/2017 07:54:14 
> AM:
> 
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> > To: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger/
> > Watson/IBM@IBMUS, "mst@redhat.com" <mst@redhat.com>, "qemu-
> > devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN, CRISTINA" 
> > <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, 
> > "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, 
> > "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C" 
> > <cs1815@att.com>
> > Date: 03/01/2017 08:03 AM
> > Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE 
> TPM
> > 
> > On Wed, Mar 01, 2017 at 07:25:28AM -0500, Stefan Berger wrote:
> > > On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
> > > > On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David Alan Gilbert 
> wrote:
> > > > > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > > > > On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
> > > > > <snip>
> > > > > 
> > > > > > > So what was the multi-instance vTPM proxy driver patch set 
> about?
> > > > > > That's for containers.
> > > > > Why have the two mechanisms? Can you explain how the 
> multi-instance
> > > > > proxy works; my brief reading when I saw your patch series seemed
> > > > > to suggest it could be used instead of CUSE for the non-container 
> case.
> > > > One of the key things that was/is not appealing about this CUSE 
> approach
> > > > is that it basically invents a new ioctl() mechanism for talking to
> > > > a TPM chardev. With in-kernel vTPM support, QEMU probably doesn't 
> need
> > > > to have any changes at all - its existing driver for talking to TPM
> > > 
> > > We still need the control channel with the vTPM to reset it upon VM 
> reset,
> > > for getting and setting the state of the vTPM upon 
> snapshot/suspend/resume,
> > > changing locality, etc.
> > 
> > You ultimately need the same mechanisms if using in-kernel vTPM with
> > containers as containers can support snapshot/suspend/resume/etc too.
> 
> The vTPM running on the backend side of the vTPM proxy driver is 
> essentially the same as the CUSE TPM used for QEMU. I has the same control 
> channel through sockets. So on that level we would have support for the 
> operations but not integrated with anything that would support container 
> migration.

This goes back to the question Dave mentions above ? Ignoring the control
channel aspect temporarily, can the CUSE TPM support the exact same ioctl
interface as the existing kernel TPM device ? It feels like this should
be possible, and if so, then this virtal TPM feature can be considered to
have two separate pieces.

First enabling basic CUSE TPM device support would not require QEMU changes,
as we could just use the existing tpm-passthrough driver against the CUSE
device, albeit with the limitations around migration, snapshot etc.

Second we could consider the question of supporting a control channel as
a separate topic. IIUC, QEMU essentially needs a way to trigger various
operations in the underlying TPM implementation, when certain lifecycle
operations are performed on the VM. I could see this being done as a
simple network protocol over a UNIX socket. So, you could then add a
new 'chardev' property to the tpm-passthrough device, which gives the
ID of a character device that provides the control channel.

This way QEMU does not need to have any special code to deal with CUSE
directly. QEMU could be used with a real TPM device, a vTPM device or
a CUSE TPM device, with the same driver. With both the vTPM and the
CUSE TPM device, QEMU would have the ability to use a out of band
control channel when migration/snapshot/etc take place.

This cleanly isolates QEMU from the particular design & implementation
that is currently used by the current swtpm code.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

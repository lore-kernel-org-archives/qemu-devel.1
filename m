Received: from eggs.gnu.org ([2001:4830:134:3::10]:37895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e88GF-0003Sb-5l
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 13:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e88GB-0000wq-Sn
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 13:17:35 -0400
Received: from cz-mail-1.axfone.eu ([80.79.25.77]:60520)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e88GB-0000vb-LH
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 13:17:31 -0400
Date: Fri, 27 Oct 2017 19:12:31 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20171027171231.GI4938@orkuz.home>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
	<b40f75d4-2280-fc66-b92f-34717b51ed47@linux.vnet.ibm.com>
	<d7a16f29-1420-d723-4a42-ac549e3f4f52@de.ibm.com>
	<03b0c516-7044-d71e-1b1f-c3bef84ac812@de.ibm.com>
	<108a9258-f245-f0bc-44cd-29f6528d34d4@linux.vnet.ibm.com>
	<277f202a-212b-2868-06e0-62c262909c03@de.ibm.com>
	<a98a959b-dc89-a75b-6479-9d8c2d9666b7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98a959b-dc89-a75b-6479-9d8c2d9666b7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH/QEMU] s390x/kvm: use
 cpu_model_available for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, jjherne@linux.vnet.ibm.com, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On Fri, Oct 27, 2017 at 17:18:44 +0200, Halil Pasic wrote:
> On 10/27/2017 04:06 PM, Christian Borntraeger wrote:
...
> > I talked to several people and it seems that on x86 the host model will also enable new features
> > that are not known by older QEMUs and its considered works as designed. (see also Jiris mail)
> 
> Yes, I've seen that. It would be nice though if this design was easier to
> find in written. Unfortunately I can read minds only to a very limited extent,
> and the written stuff I've read did not give me a full understanding of the
> design -- although the entity to blame for this could be my limited intellect.

I think it's more likely the documentation is just not perfect. I'll
look at it and try to make it better. I know about some parts which need
to be clarified thanks to this discussion.

Jirka

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMCpJ-0001U8-0i
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMCpF-0007b2-5n
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:59:57 -0500
Date: Tue, 5 Dec 2017 13:59:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205135948.10e2ae2b.cohuck@redhat.com>
In-Reply-To: <f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
	<f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 5 Dec 2017 13:05:11 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 12/05/2017 09:41 AM, Thomas Huth wrote:
> > On 01.12.2017 15:31, Halil Pasic wrote:  
> >> With the cssids unrestricted (commit <COMMIT HERE> "s390x/css: unrestrict
> >> cssids") the s390-squash-mcss machine property should not be used.
> >> Actually libvirt never supported this, so the expectation is that
> >> removing it should be pretty painless.  But let's play nice and deprecate
> >> it first.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---  
> > [...]  
> >> diff --git a/qemu-doc.texi b/qemu-doc.texi
> >> index db2351c746..874432d87c 100644
> >> --- a/qemu-doc.texi
> >> +++ b/qemu-doc.texi
> >> @@ -2501,6 +2501,14 @@ enabled via the ``-machine usb=on'' argument.
> >>  
> >>  The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
> >>  
> >> +@subsection -machine virtio-ccw,s390-squash-mcss=on|off (since 2.12.0)  
> > 
> > The machine is called "s390-ccw-virtio", not "virtio-ccw". Anyway, I
> > think you could also rather omit the machine name here (since it is the
> > default) and just write "-machine s390-squash-mcss=on|off".
> > 
> >  Thomas
> >   
> 
> Good catch! Regarding omitting the machine name, I was surprised that
> it works, but it does. Our documentation is a bit strange on this: we
> document the machine name as non-optional:
> "-machine [type=]name[,prop=value[,...]]"
> but then use -machine prop=value in the deprecation section (that's
> with no name).
> 
> Since the documentation doesn't make it clear that the property is
> existent only for the s390-ccw-virtio family of the machines I think
> being your suggestion has a lot of charm. @Connie: do you agree to
> removing the machine name (type)?

Let's drop the machine name.

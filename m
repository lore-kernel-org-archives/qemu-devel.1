Received: from eggs.gnu.org ([2001:4830:134:3::10]:44553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHuqT-0001KW-It
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHuqP-0002Be-9F
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:59:25 -0500
Date: Thu, 23 Nov 2017 17:59:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171123175915.14ec1639.cohuck@redhat.com>
In-Reply-To: <35aee93c-70e0-d9dd-b8e1-598c4e4c6a1c@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
	<35aee93c-70e0-d9dd-b8e1-598c4e4c6a1c@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On Thu, 23 Nov 2017 17:09:16 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

[I need time to process your other remarks.]

> On 11/22/2017 01:13 PM, Cornelia Huck wrote:

> >> Also I can't find anything about vfio-ccw in the upstream users
> >> manual for 2.10.91.   
> > 
> > We have an "upstream users manual"?
> >   
> This is what I mean:
> https://qemu.weilnetz.de/doc/qemu-doc.html

This is really hit-and-miss. Some things are documented in there, some
are not. I usually consider the output of the binary the canonical list
of supported devices (in combination with the x- notation.)

> 
> >> So I would argue using vfio-ccw is using an
> >> undocumented feature: if undocumented features changing in a non
> >> compatible way hits you, it's partly your own fault.  
> > 
> > If it's an x- interface, it is preliminary. If not, we should avoid
> > breaking it.
> >   
> 
> I don't see this documented in the users manual? Shouldn't the users
> know what is preliminary?
> 
> Where is this documented?

It is long standing practice, but I cannot point to documentation
(maybe someone else can?)

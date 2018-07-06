Received: from eggs.gnu.org ([2001:4830:134:3::10]:39487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbPou-0008Ub-3a
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbPop-0002Qa-5K
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:26:40 -0400
Date: Fri, 6 Jul 2018 14:26:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706142631.664474ec.cohuck@redhat.com>
In-Reply-To: <81699814-1e9a-7031-ca3f-4d4d5c58906a@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<20180706100346.3dda6b10.cohuck@redhat.com>
	<81699814-1e9a-7031-ca3f-4d4d5c58906a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, bjsdjshi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Fri, 6 Jul 2018 13:42:25 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 07/06/2018 10:03 AM, Cornelia Huck wrote:
> > On Thu,  5 Jul 2018 13:25:38 -0400
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >> +    rc = ssch(schid, &orb);
> >> +    if (rc) {
> >> +        print_int("ssch failed with rc=", rc);
> >> +        return rc;  
> > 
> > Are you doing anything like retrying on cc 1/2? It's probably fine to
> > give up on cc 3.
> >   
> 
> We are in IPL context. We should have exclusive access to the DASD
> we are IPL-ing from, or not? My understanding was that if the layers
> below us don't violate the rules, we should never observe cc 1 or 2
> here. Or am I wrong?

cc 2 probably not (nobody should be doing a halt or a clear), but cc 1
if there's some unsolicited status pending?

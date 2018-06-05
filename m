Received: from eggs.gnu.org ([2001:4830:134:3::10]:53638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQI6n-0000x7-Fy
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQI6m-0007Wp-Hr
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:59:09 -0400
Date: Tue, 5 Jun 2018 20:58:55 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180605195855.GC1455@redhat.com>
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
	<20180605223934-mutt-send-email-mst@kernel.org>
	<a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 05, 2018 at 02:54:07PM -0500, Eric Blake wrote:
> On 06/05/2018 02:47 PM, Michael S. Tsirkin wrote:
> 
> >>>Layer 1:
> >>>    The string shall always be a JSON 'object'; i.e. of the form
> >>>     { "something": ... , "more": ... }
> >>>
> >>>    The key strings shall be non-null and non-empty and shall
> >>>    be unique.
> 
> >>
> >>I think it would be simpler if layer 0 simply provided a list of
> >>names/value pairs, where names are ascii strings, and values are
> >>binary data[1].  It would make layer 1 unnecessary, and allow (3)
> >>and (4) to happen.
> >>
> >>[1] In other words, Rich's proposal of "named blobs":
> >>https://www.mail-archive.com/qemu-block@nongnu.org/msg37856.html
> >
> >I think simple is beautiful, too. But assuming they
> >really are binary how are blobs encoded?
> >Did binary really mean UTF-8 here?

By binary I actually meant binary.  The idea is you could
store things like PNG images in them (for icons).

> Binary blobs can always be base64 encoded for representation within
> a valid JSON UTF-8 string (and we already have several QMP
> interfaces that utilize base64 encoding to pass through what is
> otherwise invalid UTF-8).  It does inflate things slightly compared
> to a format that allows a raw length coupled with raw data, but that
> is not necessarily a problem.

Of course how we represent them externally and/or while
using QMP / qemu-img to store and retrieve them is up for grabs.
Doesn't JSON allow binary to be encoded?  (Knowing how poorly
done JSON is, I wouldn't be surprised if not)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

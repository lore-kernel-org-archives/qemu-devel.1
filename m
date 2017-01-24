Received: from eggs.gnu.org ([2001:4830:134:3::10]:56189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW0Mo-0005iQ-5K
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW0Mn-0002gt-5F
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:38:30 -0500
Date: Tue, 24 Jan 2017 12:38:17 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124123817.GM14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103160556.9895-1-berrange@redhat.com>
	<cfa039b5-d1df-079e-5a6e-f92e13870a2d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfa039b5-d1df-079e-5a6e-f92e13870a2d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: record separate timings per
 format, protocol pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Tue, Jan 03, 2017 at 11:08:39AM -0600, Eric Blake wrote:
> On 01/03/2017 10:05 AM, Daniel P. Berrange wrote:
> > The 'check' program records timings for each test that
> > is run. These timings are only valid, however, for a
> > particular format/protocol combination. So if frequently
> > running 'check' with a variety of different formats or
> > protocols, the times printed can be very misleading.
> > 
> > Instead of having a single 'check.time' file, maintain
> > multiple 'check.time-$IMGPROTO-$IMGFMT' files.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > Changed in v2:
> > 
> >  - Use a separate file per format/protocol, instead of
> >    throwing away data each time format/protocol changes
> >    between runs (Eric)
> > 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Ping, any block maintainers want to take this simple patch ?


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

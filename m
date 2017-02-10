Received: from eggs.gnu.org ([2001:4830:134:3::10]:46308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ccDuy-0001q6-Vu
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ccDux-0001Ft-R3
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:19:29 -0500
Date: Fri, 10 Feb 2017 16:19:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170210161914.GD12176@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-9-berrange@redhat.com>
	<w51d1eq496o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w51d1eq496o.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 08/18] qcow: make
 encrypt_sectors encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, Feb 10, 2017 at 11:44:15AM +0100, Alberto Garcia wrote:
> On Thu 26 Jan 2017 11:18:17 AM CET, Daniel P. Berrange wrote:
> > Instead of requiring separate input/output buffers for
> > encrypting data, change encrypt_sectors() to assume
> > use of a single buffer, encrypting in place. One current
> > caller uses the same buffer for input/output already
> > and the other two callers are easily converted to do so.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
> > @@ -469,13 +465,12 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
> >                      uint64_t start_sect;
> >                      assert(s->cipher);
> >                      start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
> > -                    memset(s->cluster_data + 512, 0x00, 512);
> 
> I haven't checked this thoroughly, but without this patch it seems that
> this would overflow if the cluster size is 512 bytes (the minimum
> allowed by qcow).

Heh, yeah, I think you are right :-)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

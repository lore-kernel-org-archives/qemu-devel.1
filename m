Received: from eggs.gnu.org ([209.51.188.92]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go9XA-0007N2-S1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go9X8-00081v-VN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:13:16 -0500
Date: Mon, 28 Jan 2019 16:12:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190128161257.GC3437@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190128151521.13875-1-antonkuchin@yandex-team.ru>
	<20190128153750.GE5756@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128153750.GE5756@localhost.localdomain>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qmp: Deprecate query-nodes
 option of query-blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, nsoffer@redhat.com, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

On Mon, Jan 28, 2019 at 04:37:50PM +0100, Kevin Wolf wrote:
> Am 28.01.2019 um 16:15 hat Anton Kuchin geschrieben:
> > This option is broken since a6baa60807 in v2.9 and returns mostly
> > zeroes instead of real stats because actual querring of BlockStats
> > that resides in blk is missing.
> > 
> > And it makes no sense because with this option BlockDriverState-s
> > are iterated but BlockAcctStats belong to BlockBackend and not BDS
> > since 7f0e9da6f13 in v2.5
> > 
> > Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> 
> Isn't query-nodes the only way to get wr_highest_offset for the protocol
> layer? oVirt depends on this, as far as I know.

Libvirt just invokes 'query-blockstats' with no arguments, so is not
relying on 'query-nodes' working. Given that libvirt doesn't use it,
it doesn't seem like this is relevant for oVirt unless they were
using QMP passthrough from libvirt. That this has been broken
since v2.9 though rather suggests oVirt doesn't use it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

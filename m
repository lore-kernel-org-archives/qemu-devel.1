Received: from eggs.gnu.org ([2001:4830:134:3::10]:50610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyGxe-0007Qc-AR
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyGxY-0001Cu-Hs
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:05:54 -0400
Date: Tue, 20 Mar 2018 15:05:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320145402-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521510562-529051-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: include generated files with <> and
 not ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Tue, Mar 20, 2018 at 03:54:36AM +0200, Michael S. Tsirkin wrote:
> QEMU coding style at the moment asks for all non-system
> include files to be used with #include "foo.h".
> However this rule actually does not make sense and
> creates issues for when the included file is generated.
> 
> In C, include "file" means look in current directory,
> then on include search path. Current directory here
> means the source file directory.
> By comparison include <file> means look on include search path.
> 
> As generated files are not in the search directory (unless the build
> directory happens to match the source directory), it does not make sense
> to include them with "" - doing so is merely more work for preprocessor
> and a source or errors if a stale file happens to exist in the source
> directory.
> 
> This changes include directives for all generated files, across the
> tree. The idea is to avoid sending a huge amount of email.  But when
> merging, the changes will be split with one commit per file, e.g. for
> ease of bisect in case of build failures, and to ease merging.
> 
> Note that should some generated files be missed by this tree-wide
> refactoring, it isn't a big deal - this merely maintains the status quo,
> and this can be addressed by a separate patch on top.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


For the record, the stated advantage is that one can
have a header file that happens to match the system
header.

To put it bluntly that does not work as designed.

For example, if a system header foo.h somewhere has #include <trace.h>
then the compiler will happily pull in our own version (since that is in
the -I path) and completely ignore the system one, breaking things in
the process.

When does it make sense to use include ""? When the header is
a directory-specific one, located with the source.
This approach would both be enforced by the compiler
and help people know where to find the header.

-- 
MST

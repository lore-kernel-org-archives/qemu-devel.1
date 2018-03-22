Received: from eggs.gnu.org ([2001:4830:134:3::10]:54734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez6S5-00006J-HX
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez6S4-0007lT-DA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:04:45 -0400
Date: Thu, 22 Mar 2018 22:04:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180322215555-mutt-send-email-mst@kernel.org>
References: <1521746188-496856-1-git-send-email-mst@redhat.com>
	<e149388d-eb17-ffd3-b54c-cbdf6a309882@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e149388d-eb17-ffd3-b54c-cbdf6a309882@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] make: move generated headers to
 qemu-build/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Mar 22, 2018 at 02:42:55PM -0500, Eric Blake wrote:
> On 03/22/2018 02:27 PM, Michael S. Tsirkin wrote:
> > Make sure all generated files go into qemu-build subdirectory.
> > We can then include them like this:
> >   #include "qemu-build/trace.h"
> > 
> > This serves two purposes:
> > - make it easy to detect which files are in the source
> >    directory (a bit more work for writers, easier for readers)
> > - reduce chances of conflicts with possible stale files in source
> >    directory (which could be left over from e.g. old patches, etc)
> > 
> > This patch needs to be merged with patch 2  of series updating all
> > files: sending it separately to avoid spamming the list.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> > +++ b/Makefile
> > @@ -89,102 +89,102 @@ endif
> >   include $(SRC_PATH)/rules.mak
> > -GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
> > -GENERATED_FILES += qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
> 
> Uggh - I really need to follow up on my threat to make smarter use of make
> variables and string manipulation to cut down on the boilerplate involved
> here.  Sadly, I'm not convinced that doing so is a 2.12 bugfix priority, so
> it isn't at the top of my work queue.
> 
> Overall, the patch is an interesting idea.  I'm still not 100% sold on it
> (as you say, it's now slightly more work for writers), but I'm not coming up
> with any solid reasons why it should not be applied (at least, for 2.13 -
> doing it during freeze for 2.12 is a bit harder to justify).

It's up to Peter really: it helps reduce conflicts if we apply patches
like this during freeze.  But with enough effort on Pater's part it's
not a huge deal.

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

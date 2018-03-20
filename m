Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyD9H-0000x1-Aw
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyD9B-0006W8-3F
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:01:39 -0400
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8f06e1e3-4823-d8e8-43bd-c092c523849e@vivier.eu>
Date: Tue, 20 Mar 2018 09:58:23 +0100
MIME-Version: 1.0
In-Reply-To: <1521510562-529051-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Michael Walle <michael@walle.cc>, Keith Busch <keith.busch@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Fabien Chouteau <chouteau@adacore.com>, Amit Shah <amit@kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <minyard@acm.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Peter Chubb <peter.chubb@nicta.com.au>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Yuval Shaia <yuval.shaia@oracle.com>, David Hildenbrand <david@redhat.com>, Hannes Reinecke <hare@suse.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andrzej Zaborowski <balrogg@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, kvm@vger.kernel.org, qemu-block@nongnu.org, sheepdog@lists.wpkg.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>

Le 20/03/2018 à 02:54, Michael S. Tsirkin a écrit :
> QEMU coding style at the moment asks for all non-system
> include files to be used with #include "foo.h".
> However this rule actually does not make sense and
> creates issues for when the included file is generated.

If you change that, we can have issue when a system include has the same
name as our local include. With "<FILE>", system header are taken first.

> In C, include "file" means look in current directory,
> then on include search path. Current directory here
> means the source file directory.
> By comparison include <file> means look on include search path.

Not exactly, there is the notion of "system header" too.

https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html

#include <file>
This variant is used for system header files. It searches for a file
named file in a standard list of system directories. You can prepend
directories to this list with the -I option (see Invocation).

#include "file"
This variant is used for header files of your own program. It searches
for a file named file first in the directory containing the current
file, then in the quote directories and then the same directories used
for <file>. You can prepend directories to the list of quote directories
with the -iquote option.

> As generated files are not in the search directory (unless the build
> directory happens to match the source directory), it does not make sense
> to include them with "" - doing so is merely more work for preprocessor
> and a source or errors if a stale file happens to exist in the source
> directory.

I agree there is a problem with stale files. But linux, for instance,
asks for a "make mrproper" to avoid this.

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

I think your idea conflicts with what Markus has started to do:

commit d8e39b70625d4ba1e998439d1a077b4b978930e7
Author: Markus Armbruster <armbru@redhat.com>
Date:   Thu Feb 1 12:18:28 2018 +0100

    Use #include "..." for our own headers, <...> for others

    System headers should be included with <...>, our own headers with
    "...".  Offenders tracked down with an ugly, brittle and probably
    buggy Perl script.  Previous iteration was commit a9c94277f0.

    Delete inclusions of "string.h" and "strings.h" instead of fixing them
    to <string.h> and <strings.h>, because we always include these via
    osdep.h.

    Put the cleaned up system header includes first.

    While there, separate #include from file comment with exactly one
    blank line.

commit a9c94277f07d19d3eb14f199c3e93491aa3eae0e
Author: Markus Armbruster <armbru@redhat.com>
Date:   Wed Jun 22 19:11:19 2016 +0200

    Use #include "..." for our own headers, <...> for others

    Tracked down with an ugly, brittle and probably buggy Perl script.

    Also move includes converted to <...> up so they get included before
    ours where that's obviously okay.

Thanks,
Laurent

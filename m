Received: from eggs.gnu.org ([2001:4830:134:3::10]:44165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKnN-0006Mi-AA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKnI-0006XW-TM
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:11:33 -0400
Date: Tue, 20 Mar 2018 19:10:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320185130-mutt-send-email-mst@kernel.org>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<b068cb91-b8ba-175c-40f5-a7c9c8163575@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b068cb91-b8ba-175c-40f5-a7c9c8163575@weilnetz.de>
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
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Mar 20, 2018 at 05:33:42PM +0100, Stefan Weil wrote:
> Using <> for system include files and "" for local include files is a
> convention, and as far as I know most projects adhere to that
> convention. So does QEMU currently. Such conventions are not only
> important for humans, but also for tools. There are more tools than the
> C preprocessor which handle <> and "" differently. For example the GNU
> compiler uses -MD or -MMD to automatically generate dependency rules for
> make. While -MD generates dependencies to all include files, -MMD does
> so only for user include files, but not for system include files. "user"
> and "system" means the different forms how include statements are
> written. QEMU still seems to use -MMD:
> 
> rules.mak:QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d

To my knowledge, and according to my limited testing,
system headers in this context means
the default ones not supplied with -I.

If I had to guess, that is the definition most other tools
are likely to use.


>
> Other tools like static code analysers could restrict their warning and
> error messages to user include files and ignore problems in system
> include files.

Could you give some exacmples of tools like that?

IMHO they would not work correctly if they did not treat
include directives the way compiler does.

C standard is pretty explicit that the only difference
is extra directories searched:

A preprocessing directive of the form
# include "q-char-sequence" new-line
causes the replacement of that directive by the entire contents of the source file identified
by the specified sequence between the " delimiters. The named source file is searched
for in an implementation-defined manner. If this search is not supported, or if the search
fails, the directive is reprocessed as if it read
# include <h-char-sequence> new-line
with the identical contained sequence (including > characters, if any) from the original
directive.



> Very large projects often split in sub projects, maybe one of them
> describing the API. Then that API headers are similar to system headers
> and can be included using <>, although they still belong to the same
> larger project. Do we have a stable QEMU API described in a (small)
> number of include files which typically do not change? If yes, then
> those include files could be included using <> because we don't need
> them in dependency lists or in static code analysis reports.
> 
> For all other QEMU include files, I'd stick to using "".
> 
> Regards
> Stefan

Most people know that system headers are the ones in /usr/include
The distinction that they are pulled in with include ""
is a QEMU construct.

If we want to be able to distinguish between internal and
external headers, the standard way to do it
in C is by prefixing the names with qemu/ qemu- or qemu_.

In fact we kind of already do this - if you see a name with
a slash in there you can be pretty sure it's internal
to qemu.

Exceptions are elf.h glib-compat.h and the generated trace.h.

Let's
	mv include/* include/qemu/ ?

-- 
MST

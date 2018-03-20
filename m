Received: from eggs.gnu.org ([2001:4830:134:3::10]:33755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eyKD3-0001rG-Ih
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eyKD2-0001pl-E3
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:34:01 -0400
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <b068cb91-b8ba-175c-40f5-a7c9c8163575@weilnetz.de>
Date: Tue, 20 Mar 2018 17:33:42 +0100
MIME-Version: 1.0
In-Reply-To: <1521510562-529051-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Am 20.03.2018 um 02:54 schrieb Michael S. Tsirkin:
> QEMU coding style at the moment asks for all non-system
> include files to be used with #include "foo.h".
> However this rule actually does not make sense and
> creates issues for when the included file is generated.
>=20
> In C, include "file" means look in current directory,
> then on include search path. Current directory here
> means the source file directory.
> By comparison include <file> means look on include search path.


Hello Michael,

the compiler (or to be more precise the preprocessor) works as you
describe it, so technically all include files which are only found by
searching the include paths would be found faster with <> than with "":
the unsuccessful search relative to the source file directory would be
omitted. Practically this will not save much build time because of
caching effects. So the suggested change is not required to get faster
build speed.

Using <> for system include files and "" for local include files is a
convention, and as far as I know most projects adhere to that
convention. So does QEMU currently. Such conventions are not only
important for humans, but also for tools. There are more tools than the
C preprocessor which handle <> and "" differently. For example the GNU
compiler uses -MD or -MMD to automatically generate dependency rules for
make. While -MD generates dependencies to all include files, -MMD does
so only for user include files, but not for system include files. "user"
and "system" means the different forms how include statements are
written. QEMU still seems to use -MMD:

rules.mak:QEMU_DGFLAGS +=3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d

Other tools like static code analysers could restrict their warning and
error messages to user include files and ignore problems in system
include files.

Very large projects often split in sub projects, maybe one of them
describing the API. Then that API headers are similar to system headers
and can be included using <>, although they still belong to the same
larger project. Do we have a stable QEMU API described in a (small)
number of include files which typically do not change? If yes, then
those include files could be included using <> because we don't need
them in dependency lists or in static code analysis reports.

For all other QEMU include files, I'd stick to using "".

Regards
Stefan

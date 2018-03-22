Received: from eggs.gnu.org ([2001:4830:134:3::10]:34549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ez6uz-0008Ha-JD
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ez6uy-0004nV-I7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:34:37 -0400
References: <1521642402-197739-1-git-send-email-mst@redhat.com>
	<20180321153439.GC3898@localhost.localdomain>
	<20180321175452-mutt-send-email-mst@kernel.org>
	<20180321162203.GE3898@localhost.localdomain>
	<20180322211902-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aba29cf7-637a-c967-9b2f-59060a1c1330@redhat.com>
Date: Thu, 22 Mar 2018 21:33:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180322211902-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu: replace "" with <> in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Zhang Chen <zhangckid@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Hannes Reinecke <hare@suse.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 22/03/2018 20:29, Michael S. Tsirkin wrote:
> On Wed, Mar 21, 2018 at 05:22:03PM +0100, Kevin Wolf wrote:
>>> It's all still very much a non-standard convention and so less robust
>>> than prefixing file name with a project-specifix prefix.
>> I've always had the impression that it's by far the most common
>> convention, to the point that I'd blindly assume it when joining a new
>> project.
>=20
> Any examples?

GCC - https://github.com/gcc-mirror/gcc/blob/master/gcc/reload.c
Libvirt - https://github.com/libvirt/libvirt/blob/master/src/util/virproc=
ess.c
SDL - https://github.com/SDL-mirror/SDL/blob/master/src/core/unix/SDL_pol=
l.c

Anything but Linux really.

I find <qemu/foo/bar.h> verbose and unnecessary.  The only advantage
of your proposal is that files included from the source directory would b=
e
clearly noticeable.  That said, it's easy to add a checkpatch.pl rule tha=
t
detects when ".../..." is used on a file not under include/.

Paolo

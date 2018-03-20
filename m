Received: from eggs.gnu.org ([2001:4830:134:3::10]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyLCN-0000mG-Oo
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyLCM-0000go-La
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:37:23 -0400
Date: Tue, 20 Mar 2018 17:36:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320173653.GH4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521510562-529051-1-git-send-email-mst@redhat.com>
	<b068cb91-b8ba-175c-40f5-a7c9c8163575@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, sheepdog@lists.wpkg.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Li Zhijian <lizhijian@cn.fujitsu.com>, David Hildenbrand <david@redhat.com>, Jeff Cody <jcody@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>, Hannes Reinecke <hare@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Ben Warren <ben@skyportsystems.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Richard W.M. Jones" <rjones@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Xie Changlong <xiechanglong.d@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Greg Kurz <groug@kaod.org>, Anthony Perard <anthony.perard@citrix.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Yuval Shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Wen Congyang <wencongyang2@huawei.com>, qemu-s390x@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Juan Quintela <quintela@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, Mar 20, 2018 at 05:33:42PM +0100, Stefan Weil wrote:
> 
> Very large projects often split in sub projects, maybe one of them
> describing the API. Then that API headers are similar to system headers
> and can be included using <>, although they still belong to the same
> larger project. Do we have a stable QEMU API described in a (small)
> number of include files which typically do not change? If yes, then
> those include files could be included using <> because we don't need
> them in dependency lists or in static code analysis reports.

QEMU doesn't have anything we'd call a stable API at the source level,
anything is subject to change at any time, and often does.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

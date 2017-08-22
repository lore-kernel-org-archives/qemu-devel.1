Received: from eggs.gnu.org ([2001:4830:134:3::10]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkDdo-0001k3-Ra
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dkDdo-0002qh-3f
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:11:04 -0400
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-7-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <25156151-964d-801c-a7ae-5a8a66fcb81f@redhat.com>
Date: Tue, 22 Aug 2017 14:10:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170822132255.23945-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/54] qapi: introduce qapi_enum_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Josh Durgin <jdurgin@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 08/22/2017 09:22 AM, Marc-Andr=C3=A9 Lureau wrote:
> This will help with the introduction of a new structure to handle
> enum lookup.
>=20

Procedurally for the sake of review, it's a little odd to introduce the
function, deploy it, and then change it and update all callers.

content-wise, I'm really glad to have a function like this that we can
use universally.

ACK (6, 12)

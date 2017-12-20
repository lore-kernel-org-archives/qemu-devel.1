Received: from eggs.gnu.org ([2001:4830:134:3::10]:36013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRf81-000221-8g
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRf7x-0007ce-JJ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:13:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRf7x-0007c4-DH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:13:45 -0500
Date: Wed, 20 Dec 2017 16:13:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220161328-mutt-send-email-mst@kernel.org>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
	<20171220135130.GA6408@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220135130.GA6408@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, minyard@acm.org, "Denis V. Lunev" <den@openvz.org>

On Wed, Dec 20, 2017 at 04:51:31PM +0300, Roman Kagan wrote:
> On Mon, Nov 27, 2017 at 04:05:16PM +0300, Roman Kagan wrote:
> > UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
> > property type becomes helpful.
> > 
> > In the existing code, vmgenid can immediately profit from it.
> > 
> > Roman Kagan (2):
> >   qdev-properties: add UUID property type
> >   vmgenid: use UUID property type
> > 
> > v1 -> v2:
> >  - make the property default to autogeneration if not specified
> >    explicitly
> >  - use the corresponding define for "guid" field name
> > 
> >  include/hw/qdev-properties.h |  9 +++++++
> >  hw/acpi/vmgenid.c            | 30 ++++++----------------
> >  hw/core/qdev-properties.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 78 insertions(+), 22 deletions(-)
> 
> Ping?

It's in my queue, will be in the next pull request.

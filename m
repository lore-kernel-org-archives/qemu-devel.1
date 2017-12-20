Received: from eggs.gnu.org ([2001:4830:134:3::10]:38176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eRemo-0001k1-5y
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eReml-0005Ks-HT
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:51:54 -0500
Received: from mail-ve1eur01hn0245.outbound.protection.outlook.com
	([104.47.1.245]:5414
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eRemk-0005Ig-Pa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:51:51 -0500
Date: Wed, 20 Dec 2017 16:51:31 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171220135130.GA6408@rkaganb.sw.ru>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127130518.26703-1-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, minyard@acm.org, "Denis V. Lunev" <den@openvz.org>

On Mon, Nov 27, 2017 at 04:05:16PM +0300, Roman Kagan wrote:
> UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
> property type becomes helpful.
> 
> In the existing code, vmgenid can immediately profit from it.
> 
> Roman Kagan (2):
>   qdev-properties: add UUID property type
>   vmgenid: use UUID property type
> 
> v1 -> v2:
>  - make the property default to autogeneration if not specified
>    explicitly
>  - use the corresponding define for "guid" field name
> 
>  include/hw/qdev-properties.h |  9 +++++++
>  hw/acpi/vmgenid.c            | 30 ++++++----------------
>  hw/core/qdev-properties.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 22 deletions(-)

Ping?

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gBy3l-0005lB-4D
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gBy3g-0005HB-Ah
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:17:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gBy3g-000598-1C
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:17:00 -0400
Date: Mon, 15 Oct 2018 10:16:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181015081641.q6r5wnhm7rq5tgfh@sirius.home.kraxel.org>
References: <20181013025435.25785-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013025435.25785-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Fri, Oct 12, 2018 at 11:54:35PM -0300, Eduardo Habkost wrote:
> The current virtio-*-pci device types actually represent 3
> different types of devices:
> * virtio 1.0 non-transitional devices
> * virtio 1.0 transitional devices

Ok.

> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)

Why?  Is there any reason to prefer 0.9 over transitional?

cheers,
  Gerd

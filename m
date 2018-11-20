Received: from eggs.gnu.org ([2001:4830:134:3::10]:40180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gP3Nc-0000i0-Fz
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gP3NZ-0006An-Ar
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:35:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gP3NZ-00067t-4E
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:35:37 -0500
Date: Tue, 20 Nov 2018 11:35:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181120113502.175c81ed.cohuck@redhat.com>
In-Reply-To: <20181119213232.GE3807@habkost.net>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
	<20181116034551.GK3807@habkost.net>
	<20181119114105.4da89f2c.cohuck@redhat.com>
	<20181119125519-mutt-send-email-mst@kernel.org>
	<20181119193238.117c2f4e.cohuck@redhat.com>
	<20181119133434-mutt-send-email-mst@kernel.org>
	<20181119195638.49a9c21e.cohuck@redhat.com>
	<20181119213232.GE3807@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Mon, 19 Nov 2018 19:32:32 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> However, I wish this kind of usability magic didn't automatically
> imposed us the burden of keeping guest ABI compatibility too.
> Keeping ABI compatibility on the machine-friendly device types and
> interfaces is already hard enough.

Hm, what are you thinking about here? We can fence off new features in
the hw compat section (and we already do so today), so the remaining
compat woe is what you are addressing with this patch set, isn't it?

> 
> We already have aliases that automatically select a virtio device
> type at qdev-monitor.c:qdev_alias_table[], and I don't know if
> they are supposed to keep a stable guest ABI.

As the comment there states, it was a bad idea... when you are using
the alias, you can't pass any properties that are unique to the
transport anyway. Hopefully the compat code dealt with the
disable-modern for old machine types correctly in this case; but I
don't think that helps for the bus dilemma.

I'm not sure we want to worry about the aliases too much; it might even
be a good idea to deprecate them.

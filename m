Received: from eggs.gnu.org ([2001:4830:134:3::10]:35621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCeid-0002F3-0k
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCeiZ-0007NH-Mb
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCeiZ-0007Lr-GK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:50:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181015081641.q6r5wnhm7rq5tgfh@sirius.home.kraxel.org>
	<20181015062543-mutt-send-email-mst@kernel.org>
	<20181015230342.GJ31060@habkost.net>
	<20181016064816.34ykasexdp5ikioz@sirius.home.kraxel.org>
	<20181016133921.GQ31060@habkost.net>
	<20181016184218.fhtmkfntj4xfg5oy@sirius.home.kraxel.org>
Date: Wed, 17 Oct 2018 07:49:46 +0200
In-Reply-To: <20181016184218.fhtmkfntj4xfg5oy@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Tue, 16 Oct 2018 20:42:18 +0200")
Message-ID: <87tvllf7gl.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] "no-user" for properties (was: [PATCH] virtio: Provide
 version-specific variants of virtio PCI devices)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> > See above.  We can't drop disable-modern.
>> 
>> Good point.  But this doesn't require it to be a supported device
>> option for users/management.  Maybe we should rename it to
>> "x-disable-modern" (but that's a separate discussion).
>
> I think it would be more useful to allow properties being tagged as
> "no-user", simliar to devices which we do not want be created via
> -device.

You mean user_creatable, which replaced
cannot_instantiate_with_device_add_yet, which used to be called no_user.

Yes, having something like that for properties would be a better user
interface than our current, lazy one "I'm showing you a bunch of stuff
you're supposed to ignore, and you're supposed to divine that from the
'x-' prefix".  Patches?

[...]

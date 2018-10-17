Received: from eggs.gnu.org ([2001:4830:134:3::10]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCeqB-00042Z-NR
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCeq8-00058F-JS
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCeq8-00056t-D5
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 01:57:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
Date: Wed, 17 Oct 2018 07:57:39 +0200
In-Reply-To: <d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com> (Laine Stump's
	message of "Tue, 16 Oct 2018 15:12:40 -0400")
Message-ID: <87murdf73g.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] No more chameleon devices (was: [PATCH] virtio:
 Provide version-specific variants of virtio PCI devices)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Laine Stump <laine@redhat.com> writes:

[...]
> In the end, having a device that changed PCI ID depending on what kind
> of slot it was plugged into was an idea "too clever for its own good",
> should be avoided when new devices are added in the future, and we
> should at least provide an alternative that doesn't do that for existing
> devices.

That means for each chameleon PCI/PCIe device:

* create a pair of devices that can only go into one kind of slot

* deprecate the chameleon

Yes, please!  Volunteers?

Do we have similar chameleons outside PCI?

[...]

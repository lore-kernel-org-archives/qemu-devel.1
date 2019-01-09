Received: from eggs.gnu.org ([209.51.188.92]:35344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gh9Ub-0002V6-60
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gh9Ua-0006Sn-GK
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gh9Ua-0006Rs-7n
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:45:40 -0500
Date: Wed, 9 Jan 2019 09:45:01 +0100
From: "Hoffmann, Gerd" <kraxel@redhat.com>
Message-ID: <20190109084501.bp6m3rzp6xrqzn2r@sirius.home.kraxel.org>
References: <20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
	<20181211135230-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKuoWWxLqZKQRU-g_144jX2bwsQJUzeW0W-QicNrbPfQw@mail.gmail.com>
	<20181218181803-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJmT5O3x84upBDhvvCPCK5x51RP0TxBMsodLzVeQgC-vw@mail.gmail.com>
	<20181219103112-mutt-send-email-mst@kernel.org>
	<CAJ+F1CLKftEt8g5WyW8NPOPNsKPXhNnS3BkdVqjrny4cjb+kWw@mail.gmail.com>
	<20181220113338-mutt-send-email-mst@kernel.org>
	<CAJ+F1CK1jeJgk07TXwHWpZLhO59Rrf7gSfpB6=J-NO+sYFfwpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK1jeJgk07TXwHWpZLhO59Rrf7gSfpB6=J-NO+sYFfwpA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

  Hi,

> Unfortunately, vdev is not set before vhost_dev_start().
> 
> We could add the migration blocker there somehow?

Sure.  Just use migrate_add_blocker() to do that at any time (see qxl.c
for an example).

HTH,
  Gerd

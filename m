Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHYj5-0004C8-UT
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHYj2-0006HK-0J
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cHYj1-0006Gb-Qo
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:17:43 -0500
Message-ID: <1481818660.21413.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Dec 2016 17:17:40 +0100
In-Reply-To: <20161215165406-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215165406-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

  Hi,

> BTW I note that on f23, build of 2.7 fails since it uses
> deprecated APIs from gtk. Easy to work around with --disable-werror,
> but I wonder whether we should add --disable-werror in release tarballs
> generally.

That is the case already.  configure checks you are building from a git
tree or not, and only for git tree builds werror is enabled by default.

cheers,
  Gerd

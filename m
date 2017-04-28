Received: from eggs.gnu.org ([2001:4830:134:3::10]:46010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d41q1-0005TL-PN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d41px-0004jn-OY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d41px-0004jb-II
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:05:13 -0400
Message-ID: <1493370309.23357.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Apr 2017 11:05:09 +0200
In-Reply-To: <20170428084906.GB23819@redhat.com>
References: <20170428084237.23960-1-kraxel@redhat.com>
	<20170428084906.GB23819@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] input: limit kbd queue depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Huawei PSIRT <PSIRT@huawei.com>, P J P <ppandit@redhat.com>

On Fr, 2017-04-28 at 09:49 +0100, Daniel P. Berrange wrote:
> On Fri, Apr 28, 2017 at 10:42:37AM +0200, Gerd Hoffmann wrote:
> > Apply a limit to the number of items we accept into the keyboard queue.
>=20
> Is there a need for similar protection fir mouse input events from VNC ?

No, there is no delay queue for mouse events.

> > Impact: Without this limit vnc clients can exhaust host memory by
> > sending keyboard events faster than qemu feeds them to the guest.
>=20
> Ability for a remote network client to crash a host by exhausting
> memory should be considered a security flaw & have a CVE allocated
> for it.

Sure, it's WIP, Prasit will get one.

cheers,
  Gerd

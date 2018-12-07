Received: from eggs.gnu.org ([2001:4830:134:3::10]:55956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gVKpO-0003Lq-7Z
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gVKpK-0002CB-8Z
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gVKpK-0002Bz-2c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:26:14 -0500
Date: Fri, 7 Dec 2018 13:26:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181207132044-mutt-send-email-mst@kernel.org>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
	<20181206100618.GF29540@redhat.com>
	<20181207163607.GD7395@habkost.net>
	<20181207164629.GP13784@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181207164629.GP13784@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] Attempt to implement the standby feature
 for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 07, 2018 at 04:46:29PM +0000, Daniel P. Berrang=E9 wrote:
> I'm not convinced it is useful enough to justify playing games in qdev
> with dynamically hiding devices. This adds complexity to the code which
> will make it harder to maintain and debug at runtime.

I actually think a hidden device is a useful concept to model.
E.g. you can have a powered off slot and a PCI device in
such a slot isn't visible but isn't gone either.

Right now we force-eject such devices.

But it sounds reasonable that e.g. a bunch of guests cooperate
and share an assigned device and then whoever wants to
use it, powers it up. These patches do not implement this
of course but it's a step in that direction.

--=20
MST

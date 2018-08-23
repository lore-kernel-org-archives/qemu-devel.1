Received: from eggs.gnu.org ([2001:4830:134:3::10]:41101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fst2P-0001nT-2N
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fst2L-0002Z6-1z
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fst2K-0002Xw-QL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:04:44 -0400
Date: Thu, 23 Aug 2018 14:04:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180823170435.GH3778@localhost.localdomain>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
	<87r2ipcbfs.fsf@dusky.pond.sub.org>
	<20180823162647.GQ23703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180823162647.GQ23703@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Laine Stump <laine@laine.org>, Andrea Bolognani <abologna@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Thu, Aug 23, 2018 at 05:26:47PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> There are countless mistakes in both QEMU & libvirt, but only some of
> them are worth the cost of changing. I'm not seeing a compelling reason
> why this change is worthwhile. The impact of the design mistake is narr=
ow
> and only raised because of downstream desire to change even legacy OS
> to use Q35 when there's no benefit to those OS of such a change.

I think you underestimate the impact of the design mistake.
Maintaining and working around badly designed interfaces have
costs.

The virtio device model was already an obstacle when designing
new bus/device introspection interfaces.  It will be an obstacle
for adding mechanisms to tell applications that legacy virtio
devices can't be plugged on PCI Express slots.

Anyway, if we want to fix the design mistake it wouldn't make
sense to do it only on the libvirt side and not on QEMU.  We can
address that on QEMU first, and then let libvirt decide how to
handle it.

--=20
Eduardo

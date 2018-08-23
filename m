Received: from eggs.gnu.org ([2001:4830:134:3::10]:36309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsv0J-0003M2-4g
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 15:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsv0E-0004aQ-TV
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 15:10:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsv09-0004Vl-HL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 15:10:39 -0400
From: Markus Armbruster <armbru@redhat.com>
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
	<20180823170435.GH3778@localhost.localdomain>
Date: Thu, 23 Aug 2018 21:10:30 +0200
In-Reply-To: <20180823170435.GH3778@localhost.localdomain> (Eduardo Habkost's
	message of "Thu, 23 Aug 2018 14:04:35 -0300")
Message-ID: <87in4099w9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>, Andrea Bolognani <abologna@redhat.com>, Laine Stump <laine@laine.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, Aug 23, 2018 at 05:26:47PM +0100, Daniel P. Berrang=C3=A9 wrote:
> [...]
>> There are countless mistakes in both QEMU & libvirt, but only some of
>> them are worth the cost of changing.

Agreed.

>>                                      I'm not seeing a compelling reason
>> why this change is worthwhile. The impact of the design mistake is narrow
>> and only raised because of downstream desire to change even legacy OS
>> to use Q35 when there's no benefit to those OS of such a change.
>
> I think you underestimate the impact of the design mistake.

And overstate the "this is just for a downstream need".

> Maintaining and working around badly designed interfaces have
> costs.
>
> The virtio device model was already an obstacle when designing
> new bus/device introspection interfaces.  It will be an obstacle
> for adding mechanisms to tell applications that legacy virtio
> devices can't be plugged on PCI Express slots.

Thus, there's a genuine upstream motivation to clean up this mess.
Whether it's worthwhile is of course a fair question.

The argument for "it is worthwhile" I like to see in general is patches.

> Anyway, if we want to fix the design mistake it wouldn't make
> sense to do it only on the libvirt side and not on QEMU.  We can
> address that on QEMU first, and then let libvirt decide how to
> handle it.

Yes.

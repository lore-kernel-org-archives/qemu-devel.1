Received: from eggs.gnu.org ([2001:4830:134:3::10]:51396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1edyi8-0004ms-8Q
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1edyi4-0005C6-EA
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1edyi4-0005Bu-8D
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:33:56 -0500
Message-ID: <1516714431.31897.6.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 23 Jan 2018 14:33:51 +0100
In-Reply-To: <20180123124922.GB14832@umbus>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
	<1516702111.31897.2.camel@redhat.com>
	<20180123112025.GI11419@umbus> <1516709019.31897.4.camel@redhat.com>
	<20180123124922.GB14832@umbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue, 2018-01-23 at 23:49 +1100, David Gibson wrote:
> It's also occurred to me that making a spapr specific approach to this
> might not be quite as horrible as I initially thought.  The
> capabilities table is global (and immutable) so coding up a
> "get-spapr-caps" qapi entry point which encodes the stuff there into
> json giving the names and allowed values of each cap would be fairly
> straightforward.

OTOH, qom-list-properties is a superset of device-list-properties
so it could be used instead of it if supported; plus it would
expose properties of machines which are not also capabilities and
properties of non-pSeries machine types. There could be value in
taking the more generic approach.

> Accurately retreiving default values would be trickier, not sure if
> that's important or not.

Not sure. I think it's okay not to expose that information, since
there are other areas where defaults are not exposed and so all
libvirt can do is document that not *explicitly* setting a feature
will result in the hypervisor default, whatever that might happen
to be, being enforced.

-- 
Andrea Bolognani / Red Hat / Virtualization

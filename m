Received: from eggs.gnu.org ([2001:4830:134:3::10]:36225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6YqT-0004zz-Ni
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6YqP-0004QU-OT
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6YqP-0004QJ-IO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:16:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DB1A37E75
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:16:24 +0000 (UTC)
Message-ID: <1508750176.16488.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 11:16:16 +0200
In-Reply-To: <083108b4-6300-6302-d8c8-108fc6ae07fb@redhat.com>
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
	<1508418225.18146.1.camel@redhat.com>
	<d231ac0a-bb7d-78aa-ddb4-8048cc7bdfd8@redhat.com>
	<1508482525.18146.6.camel@redhat.com>
	<f58bd55b-5a32-bbe1-90e6-79c5b1036355@redhat.com>
	<1508737557.16488.1.camel@redhat.com>
	<083108b4-6300-6302-d8c8-108fc6ae07fb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 2017-10-23 at 11:46 +0300, Marcel Apfelbaum wrote:
> On 23/10/2017 8:45, Gerd Hoffmann wrote:
> > =C2=A0=C2=A0=C2=A0Hi,
> >=20
> > > The guest will still run with 40 bits physical!
> > > (judging the code anyway, I hope I am wrong)
> > >=20
> > > Then, the stakes are not so big, the Guest kernel will disregard
> > > the 64bit hole since is not CPU addressable and go on.
> >=20
> > But then there is no working 64bit hole for hotplug ...
> >=20
>=20
> Hosts with old CPUs are not fit for modern PCIe devices
> having large BARs anyway, no 64bit hole in this case would
> be OK, I think.

Well, my workstation which has only 39 bits physical is kaby lake.
If you classify this as "old cpu", what is a new cpu then?

cheers,
  Gerd

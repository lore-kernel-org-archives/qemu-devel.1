Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5AUX-0005Cm-Mk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e5AUT-0003oD-PP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e5AUT-0003lZ-JK
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:04:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B22B8C04AC5A
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 13:03:59 +0000 (UTC)
Message-ID: <1508418225.18146.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Oct 2017 15:03:45 +0200
In-Reply-To: <9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
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

  Hi,

> =C2=A0 - commit 39848901818 pc: limit 64 bit hole to 2G by default
> =C2=A0 shows us QEMU had the 64bit PCI hole, so it is a regression.

commit message says:

<quote>
=C2=A0=C2=A0=C2=A0=C2=A0It turns out that some 32 bit windows guests cras=
h
=C2=A0=C2=A0=C2=A0=C2=A0if 64 bit PCI hole size is >2G.
</quote>

Why this suddenly isn't a problem any more?

Also: how about just using the existing pci_hole64_size property?

cheers,
  Gerd

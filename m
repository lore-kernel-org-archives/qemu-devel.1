Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dJ3QW-0001qV-Fp
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dJ3QT-0005Nh-Cu
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dJ3QT-0005NI-6n
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:49:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDB58C008B1B
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 19:48:59 +0000 (UTC)
Message-ID: <1496951333.29761.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 08 Jun 2017 21:48:53 +0200
In-Reply-To: <20170608204026-mutt-send-email-mst@kernel.org>
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> I really dislike negotiation being re-invented for each device.=C2=A0=C2=
=A0Do
> we
> need these tricks?=C2=A0=C2=A0Can we just do fw cfg with standard discove=
ry?
> This ties in with my proposal to generalize smi features to
> generic ones.

Device properties should be part of the device.
We should have done this with the smi too.

A more standard way to handle this would be to add a vendor-specific
pci capability and place the register there.  Not sure we have room for
that in the pci config space though.

cheers,
  Gerd

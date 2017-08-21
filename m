Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djl8A-0001gR-KE
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djl88-0007dD-2O
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djl87-0007co-Sc
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A95F4C047B7B
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 11:44:26 +0000 (UTC)
Message-ID: <1503315859.26016.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 13:44:19 +0200
In-Reply-To: <20170814215748.5158-13-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-13-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 12/13] usb: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

  Hi,

-ENOCONTEXT

What is the use case?

> +=C2=A0=C2=A0=C2=A0=C2=A0QTAILQ_FOREACH(port, l, next) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DeviceSlotInfo *slot =3D=
 make_slot(BUS(bus));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* TODO: should t=
he "bus" option be included, or is
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* "port" enough =
to identify the USB bus + port?
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/

Yes, bus must be included, port alone isn't enough in case multiple usb
host adapters are present.

cheers,
  Gerd

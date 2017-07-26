Received: from eggs.gnu.org ([2001:4830:134:3::10]:41042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daEsn-0000TT-81
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daEsi-0008Ep-CF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daEsi-0008DK-5p
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:29:12 -0400
Message-ID: <1501046944.29903.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 07:29:04 +0200
In-Reply-To: <4e3f9aad-3528-59b4-1fab-d109cf49632a@redhat.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-6-git-send-email-zuban32s@gmail.com>
	<20170723055006-mutt-send-email-mst@kernel.org>
	<b566a69d-a977-bf9f-d567-b742d400b288@redhat.com>
	<20170723173111-mutt-send-email-mst@kernel.org>
	<CAKSfGUBP8oH2YymDnCA+Q=ngmyyVRYTVujwfOLRgdBQ82qgivg@mail.gmail.com>
	<20170725165213-mutt-send-email-mst@kernel.org>
	<CAKSfGUDiJ9GVNepiX7nGHtPf5=OqUaZgyPwwwDUDWuwnAND-Ew@mail.gmail.com>
	<a16dcefb-8abd-cf24-762c-82e26a0f9ec4@redhat.com>
	<CAKSfGUDOC7vBG30+NmrTr+UO4=vb6phiDreTA=4mA1LOfLs3Tw@mail.gmail.com>
	<4e3f9aad-3528-59b4-1fab-d109cf49632a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/6] hw/pci: add bus_reserve
 property to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net, seabios@seabios.org

  Hi,

> > Gerd's suggestion was to set min(cap_value, children_found). From
> > such=C2=A0
> > point of view 0 can be a valid value.
> >=20
>=20
> I am lost now :)
> How can we use the capability to reserve "more" buses since
> children-found will be always the smaller value?
>=20
> I think you should use max(cap_value, children_found) to
> ensure you always reserve enough buses for existing children.

Was about to point out the same ;)

Yes, should be max(reserve-buses, child-buses-found).  And reserve-
buses is actually a minimum, because the result can't be smaller than
reserve-buses.

cheers,
  Gerd

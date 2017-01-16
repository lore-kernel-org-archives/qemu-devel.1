Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cTAQj-000457-84
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cTAQg-0004ji-4C
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cTAQf-0004jX-UR
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:46:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99964C056800
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:46:45 +0000 (UTC)
Message-ID: <1484585201.4091.12.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 16 Jan 2017 17:46:41 +0100
In-Reply-To: <1484137136-8021-1-git-send-email-marcel@redhat.com>
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On Wed, 2017-01-11 at 14:18 +0200, Marcel Apfelbaum wrote:
> v1 -> v2:
>=C2=A0=C2=A0- Rebased on master.
>=C2=A0
> The Generic Root Port behaves the same as the
> Intel's IOH device with id 3420, without having
> Intel specific attributes.
>=C2=A0
> The device has two purposes:
>=C2=A0=C2=A0(1) Can be used on both X86 and ARM machines.
>=C2=A0=C2=A0(2) It will allow us to tweak the behaviour
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(e.g add vendor-specific PCI capabilities)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- something that obviously cannot be=
 done
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0on a known device.
>=C2=A0
> Patch 1/3: Introduce a base class for Root Ports - most of the code
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
is migrated from IOH3420 implementation.
> Patch 2/3: Derives the IOH3420 from the new base class
> Patch 3/3: Introduces the generic Root Port.
>=C2=A0
> Tested with Linux and Windows guests only on x86 hosts.

I tested this both on x86/q35 (Debian guest) and on
aarch64/virt (Fedora guest) very briefly, eg. started
the guest, performed some network I/O and shut it down.

It seems to be working fine :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization

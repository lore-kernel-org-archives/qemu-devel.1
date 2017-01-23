Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVdmx-0003w3-99
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVdmw-0005tW-FS
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVdmw-0005tJ-9m
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:31:58 -0500
Message-ID: <1485174715.2149.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Jan 2017 13:31:55 +0100
In-Reply-To: <20170121014901.GA21645@foober.ini.cmu.edu>
References: <20170121014901.GA21645@foober.ini.cmu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] hw/usb/dev-hid: Make usb-tablet
 work with OS X/macOS guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gabriel L. Somlo" <somlo@cmu.edu>
Cc: qemu-devel@nongnu.org, phil@philjordan.eu

  Hi,

> works like a charm on Sierra (10.12.1). Also tried it with
> Fedora-Workstation-Live-x86_64-25-1.3.iso, where it behaves
> identically with or without the mac_compat option. All tests
> used qemu in SDL/X11-client mode.
>=20
> Tested-by: Gabriel Somlo <somlo@cmu.edu>

Cool.  Given that windows  guests are happy with the change too and
vmware doing the same I think we don't need a config option for this one
too.

cheers,
  Gerd

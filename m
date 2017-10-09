Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1Vqf-0003jy-KA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1Vqb-00049F-Kl
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1Vqb-000494-E2
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:03:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 493524A6E6
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 11:03:44 +0000 (UTC)
Date: Mon, 9 Oct 2017 12:03:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171009110336.GA17824@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170911165929.2791-1-marcandre.lureau@redhat.com>
	<20170911165929.2791-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170911165929.2791-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/7] hw/misc: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com, mst@redhat.com, anderson@redhat.com, lersek@redhat.com

On Mon, Sep 11, 2017 at 06:59:24PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> See docs/specs/vmcoreinfo.txt for details.
>=20
> "etc/vmcoreinfo" fw_cfg entry is added when using "-device vmcoreinfo".

I'm wondering if you considered just adding the entry to fw_cfg by
default, without requiring any -device arg ? Unless I'm misunderstanding,
this doesn't feel like a device to me - its just a well known bucket
in fw_cfg IIUC ?  Obviously its existance would need to be tied to
the latest machine type for ABI reasons though. The benefit of this
is that it would "just work" without us having to plumb it through to
all the downstream applications that use QEMU for mgmt guest (OpenStack,
oVirt, GNOME Boxes, virt-manager, and countless other mgmt apps).

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

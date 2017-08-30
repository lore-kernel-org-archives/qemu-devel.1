Received: from eggs.gnu.org ([2001:4830:134:3::10]:42129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn5Qy-0004LY-Kf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dn5Qt-0006ai-1M
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dn5Qs-0006aP-SF
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:01:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C9CA356C7
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 16:01:33 +0000 (UTC)
Date: Wed, 30 Aug 2017 17:01:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170830160126.GB31465@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-7-berrange@redhat.com>
	<1503323345.26016.23.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1503323345.26016.23.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/15] input: convert virtio-input-hid
 device to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Aug 21, 2017 at 03:49:05PM +0200, Gerd Hoffmann wrote:
> On Thu, 2017-08-10 at 16:55 +0100, Daniel P. Berrange wrote:
> > -=C2=A0=C2=A0=C2=A0 virtio_input_key_config(vinput, keymap_qcode,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(keymap_qcode));
> > +=C2=A0=C2=A0=C2=A0 virtio_input_key_config(vinput, qemu_input_map_qc=
ode2linux,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qemu_input_map_qcode2linux_len);
>=20
> That is a guest-visible change.

Huh, really ?!?!?

Are you saying the guest OS sees the raw qcode values ? IIUC these are
something we never wanted to expose outside QEMU, because nothing in
QAPI is gauranteeing enum values are stable - only the string
representation is stable in QAPI.

I thought this device was sending linux keycodes to the guest, not
qcodes ????

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dng69-0005Bh-G5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dng66-0001Z2-9h
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dng66-0001Xp-34
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:10:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73A8F80F79
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 07:10:32 +0000 (UTC)
Message-ID: <1504249831.10150.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 01 Sep 2017 09:10:31 +0200
In-Reply-To: <20170830160126.GB31465@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-7-berrange@redhat.com>
	<1503323345.26016.23.camel@redhat.com>
	<20170830160126.GB31465@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 2017-08-30 at 17:01 +0100, Daniel P. Berrange wrote:
> On Mon, Aug 21, 2017 at 03:49:05PM +0200, Gerd Hoffmann wrote:
> > On Thu, 2017-08-10 at 16:55 +0100, Daniel P. Berrange wrote:
> > > -=C2=A0=C2=A0=C2=A0 virtio_input_key_config(vinput, keymap_qcode,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(keymap_qcode));
> > > +=C2=A0=C2=A0=C2=A0 virtio_input_key_config(vinput, qemu_input_map_=
qcode2linux,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 qemu_input_map_qcode2linux_len);
> >=20
> > That is a guest-visible change.
>=20
> Huh, really ?!?!?
>=20
> Are you saying the guest OS sees the raw qcode values ?

No.  It'll see a bitmap of supported keys, and that will change.

I'd suggest to just drop that patch for now, and when the dust has
settled (qcode got all missing keys etc) flip it over, so we get away
with a single compat property.

cheers,
  Gerd

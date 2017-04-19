Received: from eggs.gnu.org ([2001:4830:134:3::10]:35095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d0me6-0003Ft-AA
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d0me0-000882-PD
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d0me0-00086o-Ih
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:15:28 -0400
Message-ID: <1492596922.6853.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Apr 2017 12:15:22 +0200
In-Reply-To: <7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<CAFEAcA_YVJKobjJ2WeEquxUdXVYeaCvA-K0+zumCc-Rm4Tk5nQ@mail.gmail.com>
	<20170403141912.GA3539@stefanha-x1.localdomain>
	<87fuhf9kcz.fsf@dusky.pond.sub.org>
	<20170418095103.GF21261@stefanha-x1.localdomain>
	<1492516675.27392.45.camel@redhat.com>
	<7ae1e13f-b6a0-a735-3952-4e3833e34ad8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > There is -global, which is actually used by libvirt to configure
> > built-in floppy devices.  But as the name suggests it sets properties
> > globally, i.e. for all instances.  Which works in this specific use
> > case, as there can be only one floppy controller per machine, but I
>=20
> Spec-wise, Can't you have two?

You can have two floppy drives, but they are hooked to the same
controller.  isa-fdc has two properties (driveA and driveB) for that
reason, so -global works even for two floppy drives.

cheers,
  Gerd

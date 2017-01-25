Received: from eggs.gnu.org ([2001:4830:134:3::10]:42112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWHy5-0008F1-SH
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWHy2-0006F4-OC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:26:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cWHy2-0006Ep-J1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:26:06 -0500
Message-ID: <1485329162.29826.19.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 25 Jan 2017 08:26:02 +0100
In-Reply-To: <4623f4c5-e075-38f4-897d-00002392f8b2@redhat.com>
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
	<237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
	<1485254930.32716.23.camel@redhat.com>
	<b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
	<1485260998.32716.45.camel@redhat.com> <20170124153143.GA29823@olga.wb>
	<dba0324f-e6c1-04e0-da0f-0e06a87d0375@redhat.com>
	<CAKXe6S+OK=pd5LZXhvJ4hAoeb7GgEJSBY-TJD9vGyLVM8Pr4Xw@mail.gmail.com>
	<4623f4c5-e075-38f4-897d-00002392f8b2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>, Li Qiang <liqiang6-s@360.cn>, ghoffman@redhat.com, qemu-devel@nongnu.org

  Hi,

> > I have read all the discuss, very long and useful, but I think I still
> > need some
> > time to get a full understand. So I think one of you can provide the
> > formal patch to=20
> > describe the issue in more detail.
>=20
> Your patch is almost correct.

New version out for review.

> Gerd, do you think you can raise this with the SRT? (I mean, if you
> agree that this is a security issue.)

Yes, it is.  Getting a CVE number for it is wip.

cheers,
  Gerd

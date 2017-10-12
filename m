Received: from eggs.gnu.org ([2001:4830:134:3::10]:53295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2Zp2-00035k-71
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2Zoz-000767-3v
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2Zoy-00075j-Uf
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:30:29 -0400
Message-ID: <1507800626.26812.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 12 Oct 2017 11:30:26 +0200
In-Reply-To: <20171012082456.GB16125@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
	<20171012082456.GB16125@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > $ ./scripts/git-submodule.sh update ui/keycodemapdb dtc
> > Cloning into 'ui/keycodemapdb'...
> > fatal: unable to access
> > 'https://gitlab.com/keycodemap/keycodemapdb.git/': Problem with the
> > SSL CA cert (path? access rights?)
> > fatal: clone of 'https://gitlab.com/keycodemap/keycodemapdb.git'
> > into
> > submodule path 'ui/keycodemapdb' failed
>=20
> I'm not sure what I can do about this one=20

does gitlab support git:// urls too?

> - if GIT can't checkout
> a normal git repo, this looks like a OS distro / setup bug on the
> build host.=C2=A0

Indeed.  Is this openbsd?  They are a bit paranoid, possibly the usual
ca bundle (from nss/mozilla IIRC) isn't installed by default.

cheers,
  Gerd

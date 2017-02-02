Received: from eggs.gnu.org ([2001:4830:134:3::10]:41731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIs4-0003wr-Eh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZIs0-0000Ta-Iq
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:00:24 -0500
Message-ID: <1486047612.20628.44.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 16:00:12 +0100
In-Reply-To: <43557bc0-30ba-fab8-2378-b7ab912e6c84@redhat.com>
References: <1486023789-28995-1-git-send-email-kraxel@redhat.com>
	<1486023789-28995-5-git-send-email-kraxel@redhat.com>
	<43557bc0-30ba-fab8-2378-b7ab912e6c84@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 4/4] cirrus: fix oob access issue
 (CVE-2017-2615)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org, P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>

> > Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Message-id: 1485938101-26602-1-git-send-email-kraxel@redhat.com
> > Message-id: 5887254f.863a240a.2c122.5500@mx.google.com
> >=20
> > { kraxel: with backward blits (negative pitch) addr is the topmost
> >           address, so check it as-is against vram size ]
> >=20
> > Cc: qemu-stable@nongnu.org
> > Cc: P J P <ppandit@redhat.com>
> > Cc: Laszlo Ersek <lersek@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> > Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

> My inner pedant wishes to observe that my review concerned the patch as
> modified by you, so for complete accuracy, my R-b should be at the
> bottom, under your S-o-b.
>=20
> Not sure if this merits a PULLv2, I just needed to "silence to voices".

Oops.  The message ids are kinda f*cked up too.  Guess I shouldn't trust
the patches tool too much when it comes to non-trivial patch flows.

I'll respin the pull request.

cheers,
  Gerd

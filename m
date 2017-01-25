Received: from eggs.gnu.org ([2001:4830:134:3::10]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWL3q-0003Vh-Is
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cWL3n-0006Jg-F1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:44:18 -0500
Message-ID: <1485341051.29826.105.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 25 Jan 2017 11:44:11 +0100
In-Reply-To: <1485328025-3783-1-git-send-email-kraxel@redhat.com>
References: <1485328025-3783-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
 (CVE-2017-TODO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>, Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org, P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Mi, 2017-01-25 at 08:07 +0100, Gerd Hoffmann wrote:
> From: Li Qiang <liqiang6-s@360.cn>
>=20
> When doing bitblt copy in backward mode, we should minus the
> blt width first just like the adding in the forward mode. This
> can avoid the oob access of the front of vga's vram.
>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> Message-id: 5887254f.863a240a.2c122.5500@mx.google.com
>=20
> { kraxel: with backward blits (negative pitch) addr is the topmost
>           address, so check it as-is against vram size ]
>=20
> Cc: qemu-stable@nongnu.org
> Cc: P J P <ppandit@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

For testers:  All pending cirrus fixes are now pushed to:

  git://git.kraxel.org/qemu queue/vga

Gerd Hoffmann (1):
      cirrus: fix blit address mask handling

Li Qiang (1):
      cirrus: fix oob access issue (CVE-2017-TODO)

Wolfgang Bumiller (1):
      cirrus: allow zero source pitch in pattern fill rops

cheers,
  Gerd

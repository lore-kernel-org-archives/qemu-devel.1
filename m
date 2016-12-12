Received: from eggs.gnu.org ([2001:4830:134:3::10]:56575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGH5f-0008Vj-Un
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGH5c-0005Fm-R3
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:15:47 -0500
Received: from [45.249.212.187] (port=2496 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cGH5Y-0005Ck-FS
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:15:44 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 12 Dec 2016 03:14:59 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA159EAB@DGGEMA505-MBX.china.huawei.com>
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
	<54e4918c-f686-d7d1-2c70-31ed344cd8a9@redhat.com>
	<20161211045034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161211045034-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Sunday, December 11, 2016 10:51 AM
> To: Eric Blake
> Cc: Gonglei (Arei); qemu-devel@nongnu.org; stefanha@redhat.com
> Subject: Re: [PATCH for-2.9 v2] virtio-crypto: zeroize the key material b=
efore
> free
>=20
> On Thu, Dec 08, 2016 at 09:20:07AM -0600, Eric Blake wrote:
> > On 12/07/2016 08:33 PM, Gonglei (Arei) wrote:
> >
> > >> Sensitive information is sometimes also held in mlocked pages to pre=
vent
> > >> it being swapped to disk, but qemu in general is not currently takin=
g
> > >> that level of precaution (see also commit 8813800b).
> > >>
> > >>>
> > >>> Let's zeroize the memory of CryptoDevBackendSymOpInfo structure
> pointed
> > >>> for key material security.
> > >>>
> > >>> [v2: Stefan perfects the commit message, thanks]
> > >>
> > >> The v2 blurb should appear after the --- line, as it is nice for
> > >> reviewers but a year from now when reading 'git log' we won't care h=
ow
> > >> many versions were on the list, only about the one version in git.
> > >>
> > > Yes, you are right. I just wanted to keep the Stefan's work because
> > > the most of commit message comes from him. :)
> >
> > Then I might have written:
> >
> > [Thanks to Stefan for help with crafting the commit message]
> >
> > >
> > >>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > >>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >>> ---
> > >>>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
> > >>>  1 file changed, 12 insertions(+), 1 deletion(-)
> > >>>
> > >>
> > >> The commit message may still need improvement, but the maintainer
> might
> > >> be willing to do that without needing a v3.  At any rate,
> > >> Reviewed-by: Eric Blake <eblake@redhat.com>
> > >>
> > > Thanks.
> >
> > We'll see what the maintainer thinks :)
> >
> > --
> > Eric Blake   eblake redhat com    +1-919-301-3266
> > Libvirt virtualization library http://libvirt.org
> >
>=20
> I'd suggest post v3 after 2.8 is out.
>=20
OK, will do.


Regards,
-Gonglei

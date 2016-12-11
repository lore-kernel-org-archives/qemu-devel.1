Received: from eggs.gnu.org ([2001:4830:134:3::10]:55658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cFuEb-00083l-Fx
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 21:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cFuEY-0005vY-Dv
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 21:51:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cFuEY-0005vP-7s
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 21:51:26 -0500
Date: Sun, 11 Dec 2016 04:51:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161211045034-mutt-send-email-mst@kernel.org>
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
	<54e4918c-f686-d7d1-2c70-31ed344cd8a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e4918c-f686-d7d1-2c70-31ed344cd8a9@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>

On Thu, Dec 08, 2016 at 09:20:07AM -0600, Eric Blake wrote:
> On 12/07/2016 08:33 PM, Gonglei (Arei) wrote:
> 
> >> Sensitive information is sometimes also held in mlocked pages to prevent
> >> it being swapped to disk, but qemu in general is not currently taking
> >> that level of precaution (see also commit 8813800b).
> >>
> >>>
> >>> Let's zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> >>> for key material security.
> >>>
> >>> [v2: Stefan perfects the commit message, thanks]
> >>
> >> The v2 blurb should appear after the --- line, as it is nice for
> >> reviewers but a year from now when reading 'git log' we won't care how
> >> many versions were on the list, only about the one version in git.
> >>
> > Yes, you are right. I just wanted to keep the Stefan's work because
> > the most of commit message comes from him. :)
> 
> Then I might have written:
> 
> [Thanks to Stefan for help with crafting the commit message]
> 
> > 
> >>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> >>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> ---
> >>>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
> >>>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>
> >> The commit message may still need improvement, but the maintainer might
> >> be willing to do that without needing a v3.  At any rate,
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>
> > Thanks.
> 
> We'll see what the maintainer thinks :)
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 

I'd suggest post v3 after 2.8 is out.

-- 
MST

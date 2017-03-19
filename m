Received: from eggs.gnu.org ([2001:4830:134:3::10]:49719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bd.aviv@gmail.com>) id 1cpcr8-0001jM-KS
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 11:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bd.aviv@gmail.com>) id 1cpcr7-0003YK-8h
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 11:34:54 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:33171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bd.aviv@gmail.com>) id 1cpcr6-0003Y7-W6
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 11:34:53 -0400
Received: by mail-pf0-x234.google.com with SMTP id e129so16899946pfh.0
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 08:34:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316040526.GJ5971@pxdev.xzpeter.org>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-18-git-send-email-peterx@redhat.com>
	<20170316040526.GJ5971@pxdev.xzpeter.org>
From: "Aviv B.D." <bd.aviv@gmail.com>
Date: Sun, 19 Mar 2017 17:34:31 +0200
Message-ID: <CAM3WwMiuSG3KGEg7WnN7fhxi-0Yswtsk1Wnh_uVSeuN1HZSLaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

Hi Peter,
Thanks, I think that I should receive credit for this patch.

Please attribute it under my technion mail: bdaviv@cs.technion.ac.il.

The signed-off line should be:

Signed-off-by: Aviv Ben-David <bdaviv@cs.technion.ac.il>

Thanks,
Aviv.

On Thu, Mar 16, 2017 at 6:05 AM, Peter Xu <peterx@redhat.com> wrote:

> On Tue, Feb 07, 2017 at 04:28:19PM +0800, Peter Xu wrote:
> > This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
> > upstream:
> >
> >   "IOMMU: enable intel_iommu map and unmap notifiers"
> >   https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
> >
> > However I removed/fixed some content, and added my own codes.
> >
> > Instead of translate() every page for iotlb invalidations (which is
> > slower), we walk the pages when needed and notify in a hook function.
> >
> > This patch enables vfio devices for VT-d emulation.
> >
> > And, since we already have vhost DMAR support via device-iotlb, a
> > natural benefit that this patch brings is that vt-d enabled vhost can
> > live even without ATS capability now. Though more tests are needed.
> >
>
> Hi, Michael,
>
> If there is any possiblility that this version be merged in the future
> at any point, would you please help add Aviv's sign-off into this
> patch as well right here (I think it should be before Jason's r-b):
>
> Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
>
> Since I think we should definitely give Aviv more credit since he's
> done a great work before (and devoted lots of time).
>
> (Aviv, please reply if you have other opinions, or I'll just make
>  myself bold)
>
> Thanks,
>
> > Reviewed-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
>
> [...]
>
> -- peterx
>

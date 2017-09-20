Received: from eggs.gnu.org ([2001:4830:134:3::10]:42153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dueni-0008Bc-Ri
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duenD-0007D1-0H
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duenC-0007Bg-O5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:11:54 -0400
Date: Wed, 20 Sep 2017 10:25:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920102537.6b329909.cohuck@redhat.com>
In-Reply-To: <20170920074751.GI11080@bjsdjshi@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-5-pasic@linux.vnet.ibm.com>
	<20170920074751.GI11080@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] 390x/css: introduce maximum data
 address checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 20 Sep 2017 15:47:51 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:44 +0200]:

> > @@ -828,7 +836,9 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> >      g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
> >      cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
> >                   (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
> > +                 (orb->ctrl0 & ORB_CTRL0_MASK_FMT ? CDS_F_FMT : 0) |  
> This reminds me one more question:
> Calling ccw_dsteram_init() after copy_ccw_from_guest() may lead to a
> fmt-1 @ccw with an @orb that designates fmt-0 ccw. This sounds insane.

That's just a consequence of us translating everything to format-1
ccws. A bit confusing, but no problem if we pay attention to the format
bit everywhere it makes a difference.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMpA-0003So-3x
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFMp4-0002LF-9I
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:15:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFMp4-0002KX-3C
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:15:26 -0500
Date: Thu, 16 Nov 2017 18:15:24 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171116181158-mutt-send-email-mst@kernel.org>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
	<CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
	<20171116173033-mutt-send-email-mst@kernel.org>
	<20171116154534.GR16461@redhat.com>
	<20171116175149-mutt-send-email-mst@kernel.org>
	<CAFEAcA_DqWVaZ-oK8S9j9Hqu_AJ5nE2g9waf7Gd5vmeyKGZLsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_DqWVaZ-oK8S9j9Hqu_AJ5nE2g9waf7Gd5vmeyKGZLsA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 16, 2017 at 04:10:22PM +0000, Peter Maydell wrote:
> On 16 November 2017 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Nov 16, 2017 at 03:45:34PM +0000, Daniel P. Berrange wrote:
> >> On Thu, Nov 16, 2017 at 05:38:18PM +0200, Michael S. Tsirkin wrote:
> >> > I think it's     test: fix detection of errors from iasl
> >> > I'll drop it for now.
> >>
> >> I think that patch is merely exposing a failure that has always
> >> happened, but which we've never noticed before. So dropping that
> >> patch just hides the error again, doesn't fix the error.
> 
> > We shouldn't fail test if system can't load expected files.
> > This just will trip up people trying to build qemu.
> 
> If there are known-buggy iasl versions in the wild we could
> consider a configure test and treat buggy-iasl like no-iasl.
> 
> thanks
> -- PMM

Right. All this is not 2.11 material though.

-- 
MST

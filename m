Received: from eggs.gnu.org ([2001:4830:134:3::10]:57750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcw1-0004j0-86
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVcw0-0006vI-AK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:09:33 -0400
Date: Thu, 13 Jul 2017 14:09:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170713120921.GD4139@noname.redhat.com>
References: <20170709170614.24967-1-peter.maydell@linaro.org>
	<20170710015824.GA7056@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710015824.GA7056@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] block/vmdk: Report failures in
 vmdk_read_cid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 10.07.2017 um 03:58 hat Fam Zheng geschrieben:
> On Sun, 07/09 18:06, Peter Maydell wrote:
> > The function vmdk_read_cid() can fail if the read on the underlying
> > block device fails, or if there's a format error in the VMDK file.
> > However its API doesn't provide a mechanism to report these errors,
> > and in some cases we were returning a CID of 0 and in some cases a
> > CID of 0xffffffff, either of which might potentially be valid values.
> > 
> > Change the function to return 0 on success or a negative errno, and
> > return the CID via a uint32_t* argument. Update the callsites to
> > handle and propagate the error appropriately.
> > 
> > This fixes in passing a Coverity-spotted issue (CID 1350038) where
> > we weren't checking the return value from sscanf().
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin

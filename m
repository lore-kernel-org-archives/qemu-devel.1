Received: from eggs.gnu.org ([2001:4830:134:3::10]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUNy7-0008Fa-3P
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 21:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUNy6-0002z8-Ar
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 21:58:35 -0400
Date: Mon, 10 Jul 2017 09:58:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170710015824.GA7056@lemon.lan>
References: <20170709170614.24967-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709170614.24967-1-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sun, 07/09 18:06, Peter Maydell wrote:
> The function vmdk_read_cid() can fail if the read on the underlying
> block device fails, or if there's a format error in the VMDK file.
> However its API doesn't provide a mechanism to report these errors,
> and in some cases we were returning a CID of 0 and in some cases a
> CID of 0xffffffff, either of which might potentially be valid values.
> 
> Change the function to return 0 on success or a negative errno, and
> return the CID via a uint32_t* argument. Update the callsites to
> handle and propagate the error appropriately.
> 
> This fixes in passing a Coverity-spotted issue (CID 1350038) where
> we weren't checking the return value from sscanf().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Fam Zheng <famz@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcsLN-0004ON-B6
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcsLM-0007X2-DF
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:06:13 -0400
Date: Tue, 10 Jul 2018 15:05:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180710130558.GG5852@localhost.localdomain>
References: <20180706130620.5647-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130620.5647-1-cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/4] block: revert removal of
 deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Am 06.07.2018 um 15:06 hat Cornelia Huck geschrieben:
> Several -drive options had been marked as deprecated for two releases
> and had therefore been removed; unfortunately, libvirt still used at
> least two of them (serial number and disk geometry) and the patch
> switching away from it is not yet in any released libvirt version.
> 
> As agreed, let's revert the removal patches for 3.0; with 3.1, the then
> released libvirt versions will be fine. While nobody complained about
> the 'addr' option, it is reinstated again as well, but purely to make
> all the reverts apply cleanly.

Thanks, applied to the block branch and queued corresponding patches in
block-next to reinstate the reverted patches for 3.1.

Kevin

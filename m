Received: from eggs.gnu.org ([2001:4830:134:3::10]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJMN-0007uk-Ec
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJMM-0003HM-Lf
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:53:51 -0400
Date: Thu, 31 Aug 2017 14:53:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831065344.GB14896@lemon.lan>
References: <20170811080939.22304-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811080939.22304-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] file-posix: Clear out first
 sector in hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 08/11 16:09, Fam Zheng wrote:
> People get surprised when, after "qemu-img create -f raw /dev/sdX", they
> still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
> header. While this is natural because raw doesn't need to write any
> magic bytes during creation, hdev_create is free to clear out the first
> sector to make sure the stale qcow2 header doesn't cause such confusion.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Gentle ping as a reminder for 2.11 as we have now released 2.10.

Fam

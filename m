Received: from eggs.gnu.org ([2001:4830:134:3::10]:45544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW2dW-00069I-FO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW2dS-0008Kv-OZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:03:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cW2dS-0008Ih-JF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:03:50 -0500
Date: Tue, 24 Jan 2017 17:03:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124165832-mutt-send-email-mst@kernel.org>
References: <20170119001744-mutt-send-email-mst@kernel.org>
	<5881E2C2.2060502@cn.fujitsu.com>
	<20170120185753-mutt-send-email-mst@kernel.org>
	<58874FD7.9080605@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58874FD7.9080605@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: alex.williamson@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Tue, Jan 24, 2017 at 09:00:07PM +0800, Cao jin wrote:
> It take me for a long while to find what I missed.  I missed much
> details in pci-error-recovery.txt, and I was not conscious of a
> multi-function device which could have different functions(driver) on it.
> 
> Thank you both.

Pls note the actual code isn't always in sync with the documentation.
You want to look at that too.

-- 
MST

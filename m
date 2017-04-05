Received: from eggs.gnu.org ([2001:4830:134:3::10]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvsud-0006GP-4Q
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvsua-0007x6-3o
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cvsuZ-0007x1-UE
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:56:20 -0400
Date: Thu, 6 Apr 2017 00:56:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170406005028-mutt-send-email-mst@kernel.org>
References: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161238.366ce6a7@t450s.home>
	<58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
	<20170328205513.21b97381@t450s.home>
	<20170330205823-mutt-send-email-mst@kernel.org>
	<20170330121652.2ac8fa62@t450s.home>
	<58E4B0C9.50109@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58E4B0C9.50109@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Wed, Apr 05, 2017 at 04:54:33PM +0800, Cao jin wrote:
> Apparently, I don't have experience to induce non-fatal error, device
> error is more of a chance related with the environment(temperature,
> humidity, etc) as I understand.

I'm not sure how to interpret this statement. I think what Alex is
saying is simply that patches should include some justification. They
make changes but what are they improving?
For example:

	I tested device ABC in conditions DEF. Without a patch VM
	stops. With the patches applied VM recovers and proceeds to
	use the device normally.

is one reasonable justification imho.

-- 
MST

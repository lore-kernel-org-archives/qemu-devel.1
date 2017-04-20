Received: from eggs.gnu.org ([2001:4830:134:3::10]:40203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Dca-0000ox-50
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1DcW-0007vu-UN
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1d1DcW-0007va-O2
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 11:03:44 -0400
Date: Thu, 20 Apr 2017 11:03:39 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170420150339.GH15762@localhost.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v11 0/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Rakesh.Ranjan@veritas.com, eblake@redhat.com, Abhijit.Dey@veritas.com

On Mon, Apr 03, 2017 at 08:48:07PM -0700, Ashish Mittal wrote:
> - Veritas HyperScale block driver in QEMU is designed to provide an accelerated
>   IO path from KVM virtual machines to Veritas HyperScale storage service.
> 
> - A network IO transfer library that translates block IO from HyperScale block
>   driver to a network IO format to send it to Veritas HyperScale storage
>   service. This library (libvxhs) has been open sourced and is available on
>   github here:  https://github.com/VeritasHyperScale/libqnio.git
> 
> Ashish Mittal (2):
>   block/vxhs.c: Add support for a new block device type called "vxhs"
>   block/vxhs.c: Add qemu-iotests for new block device type "vxhs"
> 
>  block/Makefile.objs              |   2 +
>  block/trace-events               |  17 ++
>  block/vxhs.c                     | 575 +++++++++++++++++++++++++++++++++++++++
>  configure                        |  39 +++
>  qapi/block-core.json             |  23 +-
>  tests/qemu-iotests/common        |   6 +
>  tests/qemu-iotests/common.config |  13 +
>  tests/qemu-iotests/common.filter |   1 +
>  tests/qemu-iotests/common.rc     |  19 ++
>  9 files changed, 693 insertions(+), 2 deletions(-)
>  create mode 100644 block/vxhs.c
> 
> -- 
> 2.5.5
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff

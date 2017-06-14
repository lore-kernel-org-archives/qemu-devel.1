Received: from eggs.gnu.org ([2001:4830:134:3::10]:47719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLG0X-0002a7-12
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 17:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLG0W-0000Ov-8K
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 17:39:21 -0400
Date: Wed, 14 Jun 2017 17:39:12 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170614213912.GE2767@localhost.localdomain>
References: <cover.1497444637.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1497444637.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Parse 'filename' option for
 RBD/iSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com

On Wed, Jun 14, 2017 at 08:53:18AM -0400, Jeff Cody wrote:
> Change from v2:
> Add warning message that this is an unsupported option that may
> be deprecated in the future.
> 
> We need to be able to parse the 'filename' option for rbd and iscsi, because
> there may exist images in the wild that have json backing files, that specify
> the filename argument.
> 
> Jeff Cody (2):
>   block/rbd: enable filename option and parsing
>   block/iscsi: enable filename option and parsing
> 
>  block/iscsi.c | 22 +++++++++++++++++++++-
>  block/rbd.c   | 22 +++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> -- 
> 2.9.3
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff

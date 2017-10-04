Received: from eggs.gnu.org ([2001:4830:134:3::10]:56854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzmVB-000247-9N
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzmVA-0004DQ-HW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:26:29 -0400
Date: Wed, 4 Oct 2017 18:26:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171004162620.GD9801@localhost.localdomain>
References: <20170912144459.11359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 12.09.2017 um 16:44 hat Paolo Bonzini geschrieben:
> The purpose of this series is to separate the "check" sources from
> the tests.  After these patches, common.config is reduced to simple
> shell initialization, and common.rc is only included by the tests.
> 
> Along the way, a lot of dead code is removed too.
> 
> In v2, the following patches:
> 
>   qemu-iotests: do not do useless search for QEMU_*_PROG
>   qemu-iotests: do not search for binaries in the current directory
>   qemu-iotests: include common.env and common.config early
> 
> have been replaced by "qemu-iotests: cleanup and fix search for programs",
> which also preserves the behavior of searching for programs as symlinks
> in the current directory.

Thanks, applied to the block branch.

Kevin

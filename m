Received: from eggs.gnu.org ([2001:4830:134:3::10]:38169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fj00O-0002Jn-BZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 06:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fj00N-0003NH-JD
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 06:29:52 -0400
Date: Fri, 27 Jul 2018 12:29:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180727102938.GD4355@localhost.localdomain>
References: <20180727033402.13513-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727033402.13513-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC for-3.0-rc3 0/3] qemu-img: Disable copy
 offloading by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 27.07.2018 um 05:33 hat Fam Zheng geschrieben:
> Kevin pointed out that both glibc and kernel provides a slow fallback of
> copy_file_range which hurts thin provisioning. This is particularly true for
> thin LVs, because host_device driver cannot get allocation info from the
> volume, and copy_file_range is called on every sectors, making the dst fully
> allocated.
> 
> NFS mount points also doesn't support SEEK_DATA well, so the allocation
> information is unknown to QEMU.
> 
> That leaves only iscsi:// which seems to do what we want so far, but it is a
> smaller use case.
> 
> Add an option to qemu-img convert, "-C", to enable (attempting) copy offloading
> explicitly. And mark it incompatible with "-S" and "-c".

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Not sure why you made this an RFC only, but I think we absolutely need
this. People are used to using 'qemu-img convert' to compact images and
this would regress with automatic copy offloading.

Do you think we need more discussion?

Kevin

Received: from eggs.gnu.org ([209.51.188.92]:36797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpYIG-0004Q3-J5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpYIF-0007Di-HF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:51:40 -0500
Date: Fri, 1 Feb 2019 13:51:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201125120.GF5730@localhost.localdomain>
References: <20190125174653.4604-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125174653.4604-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi-disk: Device Identification fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com, berrange@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org

Am 25.01.2019 um 18:46 hat Kevin Wolf geschrieben:
> The vendor specific designator in the Device Identification VPD page has
> two problems:
> 
> 1. It defaults to the BlockBackend name (-drive id=...), which everyone
>    expected to be a host detail that the guest never sees
> 
> 2. With -blockdev based setups it defaults to an empty string; if this
>    default is used with more than one disk, the guest OS will interpret
>    this as a single multipath disk.
> 
> We can address problem 2 immediately, and start running the deprecation
> clock for problem 1.
> 
> Related bug reports:
> https://bugzilla.redhat.com/show_bug.cgi?id=1669446
> https://bugzilla.redhat.com/show_bug.cgi?id=1668248

Applied patches 1 and 2 to the block branch so that the bug is fixed.
I'll try to rewrite patch 3 along the lines Dan suggested.

Kevin

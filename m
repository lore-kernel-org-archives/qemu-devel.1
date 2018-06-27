Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fYC1T-0007ii-F8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fYC1N-0005OZ-Jm
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:06:19 -0400
Date: Wed, 27 Jun 2018 17:06:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180627170609.0a99d353.cohuck@redhat.com>
In-Reply-To: <20180627134410.4901-1-david@redhat.com>
References: <20180627134410.4901-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] s390x: TOD refactoring + TCG CPU
 hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Wed, 27 Jun 2018 15:44:01 +0200
David Hildenbrand <david@redhat.com> wrote:

> The TOD in TCG is not handled correctly:
> - each CPU has its own TOD based on CPU creation time vs. a system TOD
> - TOD is not migrated
> - TOD timer is not restarted during migration
> - CKC interrupts/TOD timer is not cleared when resetting the CKC
> 
> This (and a cpu creation problem for single threaded TCG) currently made
> CPU hotplug under TCG not work. Now it's working
> 
> The third patch also refactors TOD handling for KVM (moved into a new
> TOD device). The second patch makes sure that we can use a const pointer
> for the new TOD clock struct.

Thanks, applied.

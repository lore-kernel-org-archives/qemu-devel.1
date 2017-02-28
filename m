Received: from eggs.gnu.org ([2001:4830:134:3::10]:51266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cieDQ-0007P5-IN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cieDN-0002rF-Dh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:37:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cieDN-0002rB-7q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:37:01 -0500
Date: Tue, 28 Feb 2017 09:36:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170228093656.GB2773@work-vm>
References: <20170222160119.52771-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170222160119.52771-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] vmstate: handle arrays with null
 ptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> The objective is supporting migration of arrays of pointers 
> holdig a mix of null and not null pointers.

Queued.

> v1 -> v2:
> * do not ignore return value (Dave)
> * change some asserts to report_error+rc (Dave)
> * factor out and reuse wire_sample in patches 4 and 5 (Dave)
> * minor reword of patch 2
> * add r-b's
> 
> 
> RFC v2 -> v1:
> * rebase
> * changed marker as suggested by Dave (incl. simplifications)
> * fixed issues pointed out by Dave
> * reworded some commit messages
> * added a test for array of ptr to primitive
> 
> 
> Halil Pasic (5):
>   migration/vmstate: renames in (load|save)_state
>   migration/vmstate: split up vmstate_base_addr
>   migration/vmstate: fix array of ptr with nullptrs
>   tests/test-vmstate.c: test array of ptr with null
>   tests/test-vmstate.c: test array of ptr to primitive
> 
>  include/migration/vmstate.h |   4 ++
>  migration/vmstate.c         |  97 +++++++++++++++++++++++------------
>  tests/test-vmstate.c        | 122 ++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 173 insertions(+), 50 deletions(-)
> 
> -- 
> 2.8.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elWMJ-0004fQ-Cw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elWMG-0002af-Bk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:54:39 -0500
Date: Tue, 13 Feb 2018 09:54:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180213095416.6d35c22c.cohuck@redhat.com>
In-Reply-To: <20180209122543.25755-1-borntraeger@de.ibm.com>
References: <20180209122543.25755-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On Fri,  9 Feb 2018 12:25:43 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This patch is the s390 implementation of guest crash information,
> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> property") and the related commits. We will detect several crash
> reasons, with the "disabled wait" being the most important one, since
> this is used by all s390 guests as a "panic like" notification.
(...)
> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  qapi/run-state.json   | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  target/s390x/cpu.c    | 45 +++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h    |  2 ++
>  target/s390x/helper.c |  5 ++++-
>  target/s390x/kvm.c    | 15 +++++++-------
>  vl.c                  | 11 +++++++++--
>  6 files changed, 120 insertions(+), 13 deletions(-)

Thanks, applied.

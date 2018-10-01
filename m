Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g6xJN-0003bV-11
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g6xJK-0008C0-DV
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:28:28 -0400
Date: Mon, 1 Oct 2018 14:28:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181001142817.327eac68.cohuck@redhat.com>
In-Reply-To: <1538036615-32542-1-git-send-email-thuth@redhat.com>
References: <1538036615-32542-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Fix migration problems of s390x
 guests on Sparc hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>

On Thu, 27 Sep 2018 10:23:32 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The new migration test uncovered some alignment problems in the s390x
> code:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03012.html
> 
> Here are some patches to fix these issues (only tested with
> clang and -fsanitize=undefined, since I do not have access to
> a Sparc machine, but I hope that covers the issues there, too).
> 
> v3:
>  - Fix description of the first patch
>  - Add a comment before copy_sense_id_to_guest() in the 2nd patch
> 
> v2:
>  - Use static assert with offsetof in the first patch instead of comments
>  - Use stw_be_p in the second patch and add a comment about SA22-7204
> 
> Thomas Huth (3):
>   hw/s390x/ipl: Fix alignment problems of S390IPLState members
>   hw/s390x/css: Remove QEMU_PACKED from struct SenseId
>   hw/s390x/ioinst: Fix alignment problem in struct SubchDev
> 
>  hw/s390x/css.c            | 38 ++++++++++++++++++++++----------------
>  hw/s390x/ipl.h            |  5 +++--
>  include/hw/s390x/css.h    |  6 +++---
>  include/hw/s390x/ioinst.h | 21 ++++++++++++++-------
>  4 files changed, 42 insertions(+), 28 deletions(-)
> 

Thanks, applied.

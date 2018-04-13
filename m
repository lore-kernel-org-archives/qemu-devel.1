Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6zqm-0004jn-M7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6zql-0006Mn-Qs
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:38:52 -0400
References: <cover.1523376013.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <109f56ea-b1b1-ac06-ae2e-7a055f85609a@redhat.com>
Date: Fri, 13 Apr 2018 16:38:44 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1523376013.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Minor fixes about compressed clusters
 with OFLAG_COPIED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 2018-04-10 18:05, Alberto Garcia wrote:
> Hi,
> 
> while reviewing one previous patch about data corruption and
> compressed clusters we discussed that the documentation doesn't
> clarify that L2 entries for compressed clusters are not supposed to
> have the OFLAG_COPIED bit set.
> 
> Here's a patch to update the documentation and another one to fix the
> error message that "qemu-img check" produces.
> 
> Regards,
> 
> Berto
> 
> Alberto Garcia (2):
>   Fix error message about compressed clusters with OFLAG_COPIED
>   specs/qcow2: Clarify that compressed clusters have the COPIED bit
>     reset
> 
>  block/qcow2-refcount.c | 4 ++--
>  docs/interop/qcow2.txt | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Thanks, applied to my block-next tree:

https://github.com/XanClic/qemu/commits/block-next

Max

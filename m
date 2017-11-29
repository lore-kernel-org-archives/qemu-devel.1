Received: from eggs.gnu.org ([2001:4830:134:3::10]:44360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK59C-0004LO-MX
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK59B-0003iw-Uo
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:23:42 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7158ca0-38fd-e032-6967-4ba04b6f459b@redhat.com>
Date: Wed, 29 Nov 2017 10:23:27 -0600
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/17] qcow2: No persistent dirty bitmaps
 for compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On 11/22/2017 08:08 PM, Max Reitz wrote:
> Persistent dirty bitmaps require a properly functioning
> autoclear_features field, or we cannot track when an unsupporting
> program might overwrite them.  Therefore, we cannot support them for
> compat=0.10 images.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-bitmap.c | 10 ++++++++++
>   block/qcow2.c        | 14 +++++++++++---
>   2 files changed, 21 insertions(+), 3 deletions(-)

Missed Kevin's latest -rc3 pull request; oh well.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

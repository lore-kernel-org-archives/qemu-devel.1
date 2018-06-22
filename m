Received: from eggs.gnu.org ([2001:4830:134:3::10]:36684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWKbg-0002nq-7h
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWKbf-0003Wq-HM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:52:00 -0400
References: <20180621171925.28925-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <106e90f3-da9f-a1a8-c804-126b4566ecd3@redhat.com>
Date: Fri, 22 Jun 2018 06:51:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180621171925.28925-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: Implement co versions of
 discard/flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 06/21/2018 12:19 PM, Kevin Wolf wrote:
> This simplifies file-posix by implementing the coroutine variants of
> the discard and flush BlockDriver callbacks. These were the last
> remaining users of paio_submit(), which can be removed now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/file-posix.c | 72 ++++++++++++++++++------------------------------------
>   1 file changed, 24 insertions(+), 48 deletions(-)

The patchew complaints about formatting are valid.  With those fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

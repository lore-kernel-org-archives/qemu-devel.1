Received: from eggs.gnu.org ([2001:4830:134:3::10]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGQsC-0000Fc-9I
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGQsB-0002jj-Ef
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:19:20 -0400
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-7-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2edf9594-0ea5-7326-35b7-66ef0dfff846@redhat.com>
Date: Wed, 9 May 2018 10:19:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180509145815.3330-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/9] iscsi: Create and use
 iscsi_co_wait_for_task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/09/2018 09:58 AM, Fam Zheng wrote:
> This loop is repeated a growing number times. Make a helper.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/iscsi.c | 54 +++++++++++++++++-------------------------------------
>   1 file changed, 17 insertions(+), 37 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

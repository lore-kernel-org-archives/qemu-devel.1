Received: from eggs.gnu.org ([2001:4830:134:3::10]:48802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIzbc-0003en-RB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIzbc-0002dg-6Q
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:48:48 -0400
References: <20180516160816.26259-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <531b87dd-74c4-06a2-024e-2585113ffa4f@redhat.com>
Date: Wed, 16 May 2018 11:48:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180516160816.26259-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nfs: Remove processed options from QDict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com

On 05/16/2018 11:08 AM, Kevin Wolf wrote:
> Commit c22a03454 QAPIfied option parsing in the NFS block driver, but
> forgot to remove all the options we processed. Therefore, we get an
> error in bdrv_open_inherit(), which thinks the remaining options are
> invalid. Trying to open an NFS image will result in an error like this:
> 
>      Block protocol 'nfs' doesn't support the option 'server.host'
> 
> Remove all options from the QDict to make the NFS driver work again.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/nfs.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

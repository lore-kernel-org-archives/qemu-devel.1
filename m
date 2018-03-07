Received: from eggs.gnu.org ([2001:4830:134:3::10]:33726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eteXf-0002MT-33
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eteXe-00048r-0w
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:15:59 -0500
References: <20180307185946.29366-1-kwolf@redhat.com>
	<20180307185946.29366-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d6938ac-305e-2555-c3d4-ecc5cae3dbcb@redhat.com>
Date: Wed, 7 Mar 2018 13:15:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180307185946.29366-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/37] qcow2: Rename qcow2_co_create2()
 to qcow2_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 03/07/2018 12:59 PM, Kevin Wolf wrote:
> The functions originally known as qcow2_create() and qcow2_create2()
> are now called qcow2_co_create_opts() and qcow2_co_create(), which
> matches the names of the BlockDriver callbacks that they will implement
> at the end of this patch series.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

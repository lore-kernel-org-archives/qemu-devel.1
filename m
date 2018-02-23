Received: from eggs.gnu.org ([2001:4830:134:3::10]:38166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epF4F-0006x4-Ka
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epF4E-00049N-Pr
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:15:23 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-19-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80aaebea-b192-333f-aa35-3cdf0e71aef3@redhat.com>
Date: Fri, 23 Feb 2018 09:15:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/36] rbd: Fix use after free in
 qemu_rbd_set_keypairs() error path
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

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> If we want to include the invalid option name in the error message, we
> can't free the string earlier than that.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/rbd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

D'oh.  Should this one be cc'd to qemu-stable?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

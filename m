Received: from eggs.gnu.org ([2001:4830:134:3::10]:44110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzmoQ-0005if-Ts
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzmoQ-0007Td-8a
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:50:54 -0400
References: <cover.1536642773.git.jcody@redhat.com>
	<78d2f47b07325fce34a03b115159830f662b7f90.1536642773.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed272342-31ce-0cf6-be8e-392b6525df63@redhat.com>
Date: Tue, 11 Sep 2018 12:50:45 -0500
MIME-Version: 1.0
In-Reply-To: <78d2f47b07325fce34a03b115159830f662b7f90.1536642773.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] block/rbd: pull out
 qemu_rbd_convert_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On 9/11/18 12:15 AM, Jeff Cody wrote:
> Code movement to pull the conversion from Qdict to BlockdevOptionsRbd
> into a helper function.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>   block/rbd.c | 36 ++++++++++++++++++++++++------------
>   1 file changed, 24 insertions(+), 12 deletions(-)
> 

> -
> +    r = qemu_rbd_convert_options(bs, options, &opts, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> -        r = -EINVAL;
>           goto out;
>       }

You could simplify this to:

r = qemu_rbd_convert_options(bs, options, &opts, errp);
if (r < 0) {
     goto out;
}

Either way, this refactoring looks correct.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

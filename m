Received: from eggs.gnu.org ([2001:4830:134:3::10]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjy9-0001zM-C8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjy8-0005IV-IN
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:38:45 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-6-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f4c0fa6-78f5-13a9-bdd7-d24da479fc72@redhat.com>
Date: Fri, 16 Feb 2018 11:38:38 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-6-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] nbd/client: fix error messages in
 nbd_handle_reply_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 1. NBD_REP_ERR_INVALID is not only about length, so, make message more
>     general
> 
> 2. hex format is not very good: it's hard to read something like
>     "option a (set meta context)", so switch to dec.

It would be okay as option 0xa; I also want to be sure we match the 
output in server traces with the output in client traces; for example, I 
found:

nbd/server.c-                error_setg(errp, "Unsupported option 0x%" 
PRIx32 " (%s)",
nbd/server.c:                           option, nbd_opt_lookup(option));

So we want consistency through all the call sites, before this patch is 
ready to go, although I agree we need it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

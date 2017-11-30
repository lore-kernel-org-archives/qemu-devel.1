Received: from eggs.gnu.org ([2001:4830:134:3::10]:52307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKPoX-00035h-8v
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKPoU-0007EU-4x
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:27:45 -0500
References: <20171130140536.31164-1-cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3a92f36-841a-a678-2c84-05b9e57a8dc9@redhat.com>
Date: Thu, 30 Nov 2017 08:27:36 -0600
MIME-Version: 1.0
In-Reply-To: <20171130140536.31164-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: nuke DPRINTF in helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On 11/30/2017 08:05 AM, Cornelia Huck wrote:
> It is not used anywhere.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/s390x/helper.c | 18 ------------------
>   1 file changed, 18 deletions(-)

Yay! One less spot for bit-rotten debug.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

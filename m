Received: from eggs.gnu.org ([2001:4830:134:3::10]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRjf6-0006PH-ID
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRjf2-00017C-72
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:04:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRjf1-00015a-Vu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:04:12 -0500
References: <151335612254.14991.13093029894103210710.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92bc11be-2300-fc7c-37c4-f6374399585a@redhat.com>
Date: Wed, 20 Dec 2017 13:04:09 -0600
MIME-Version: 1.0
In-Reply-To: <151335612254.14991.13093029894103210710.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix error path in pdu_submit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 12/15/2017 10:42 AM, Greg Kurz wrote:
> If we receive an unsupported request id, we first decide to
> return -ENOTSUPP to the client, but since the request id
> causes is_read_only_op() to return false, we change the
> error to be -EROFS if the fsdev is read-only. This doesn't
> make sense since we don't know what the client asked for.
> 
> This patch ensures that -EROFS can only be returned if the
> request id is supported.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/9pfs/9p.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

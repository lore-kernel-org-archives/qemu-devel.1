Received: from eggs.gnu.org ([2001:4830:134:3::10]:58450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7o0q-0001rI-83
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7o0p-00088l-6K
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:44:52 -0400
References: <20181003180426.602765-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <030effeb-344d-bf33-e4b9-93c2ee237d8a@redhat.com>
Date: Wed, 3 Oct 2018 15:44:24 -0500
MIME-Version: 1.0
In-Reply-To: <20181003180426.602765-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Document --tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 10/3/18 1:04 PM, Eric Blake wrote:
> Commit 145614a1 introduced --tls-creds, but forgot to document
> it in 'qemu-nbd --help'.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> Sadly, 'git grep -i "qemu.nbd.*tls"' has no hits, making me wonder
> if our iotests are even covering this.
> 
> Noticed while writing my other patches for defaulting to newstyle.
> ---
>   qemu-nbd.c | 1 +
>   1 file changed, 1 insertion(+)

Thanks; applied to my NBD queue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

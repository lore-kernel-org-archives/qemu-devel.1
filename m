Received: from eggs.gnu.org ([2001:4830:134:3::10]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYbIG-00022r-Pk
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYbIF-0008Ip-L7
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:05:20 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a32f921-7800-a4f3-12ac-195212cbe828@redhat.com>
Date: Thu, 28 Jun 2018 13:05:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180628180042.3881-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: allow blockdev-backup from
 any source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 06/28/2018 01:00 PM, John Snow wrote:
> In the case of image fleecing, the node we choose as the source
> for a blockdev-backup is going to be both a root node AND the
> backing node for the exported image. It does not qualify as a root
> image in this case.
> 
> Loosen the restriction.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

In v1, you mentioned that this used to work but then regressed, 
pinpointing that detail in the commit message might be nice, but not 
essential (since we didn't test it until now).  So,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

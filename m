Received: from eggs.gnu.org ([2001:4830:134:3::10]:44982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmaN-00048Y-9C
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvmaJ-0002rG-4P
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:47:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvmaI-0002r4-Vz
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:47:47 -0400
References: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
	<1535733414-6812-7-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0874d29e-26fc-c1fa-4299-bc8d133dcfa8@redhat.com>
Date: Fri, 31 Aug 2018 11:47:45 -0500
MIME-Version: 1.0
In-Reply-To: <1535733414-6812-7-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] block: dump_qlist() may dereference
 a Null pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

On 08/31/2018 11:36 AM, Liam Merwick wrote:
> A NULL 'list' passed into function dump_qlist() isn't correctly
> validated and can be passed to qlist_first() where it is dereferenced.
> 
> Given that  dump_qlist() is static, and callers already do the right

Double space looks odd.

> thing, just add an assert to catch future potential bugs.
> 
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>   block/qapi.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/qapi.c b/block/qapi.c
> index c66f949db839..e81be604217c 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -740,6 +740,8 @@ static void dump_qlist(fprintf_function func_fprintf, void *f, int indentation,
>       const QListEntry *entry;
>       int i = 0;
>   
> +    assert(list);
> +
>       for (entry = qlist_first(list); entry; entry = qlist_next(entry), i++) {
>           QType type = qobject_type(entry->value);
>           bool composite = (type == QTYPE_QDICT || type == QTYPE_QLIST);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

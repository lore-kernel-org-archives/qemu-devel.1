Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1figvV-0003aH-3z
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1figvS-0002sB-3B
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:07:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1figvR-0002rx-TQ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:07:30 -0400
References: <20180726061844.25992-1-armbru@redhat.com>
	<20180726061844.25992-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23467af9-5ded-ee63-5408-b95c00ac48f7@redhat.com>
Date: Thu, 26 Jul 2018 09:07:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180726061844.25992-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qstring: Move qstring_from_substr()'s
 @end one to the right
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: liujunjie23@huawei.com

On 07/26/2018 01:18 AM, Markus Armbruster wrote:
> qstring_from_substr() takes the index of the substring's first and
> last character.  qstring_from_substr(s, 0, SIZE_MAX) denotes an empty
> substring.  Awkward.
> 
> Shift the end index one to the right.  This simplifies both
> qstring_from_substr() and its callers.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Not strictly a bug fix, but found while fixing a bug, thus I'm okay if 
this makes it into 3.0 (your call as maintainer).

>   block/blkdebug.c      | 2 +-
>   block/blkverify.c     | 2 +-
>   block/nbd.c           | 2 +-
>   qobject/qstring.c     | 6 +++---
>   tests/check-qobject.c | 2 +-
>   tests/check-qstring.c | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)
> 

This does fix all users.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

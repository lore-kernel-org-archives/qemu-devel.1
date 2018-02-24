Received: from eggs.gnu.org ([2001:4830:134:3::10]:60442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epg82-0008Du-Jo
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epg81-0000JG-Om
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:09:06 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e93d569-8014-d226-f7c0-c35395d7a245@redhat.com>
Date: Sat, 24 Feb 2018 14:08:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] compiler: Add QEMU_BUILD_BUG_MSG()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> _Static_assert() allows us to specify messages, and that may come in
> handy.  Even without _Static_assert(), encouraging developers to put a
> helpful message next to the QEMU_BUILD_BUG_* may make debugging easier
> whenever it breaks.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/qemu/compiler.h | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

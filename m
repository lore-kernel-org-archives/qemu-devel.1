Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvs0q-0002Nt-20
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvs0m-00029d-SA
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:31 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75a7f793-3b44-7fab-42ef-1ee7706a02f8@redhat.com>
Date: Fri, 31 Aug 2018 17:34:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180831222907.16257-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/15] block/stream: add block job
 creation flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>

On 08/31/2018 05:28 PM, John Snow wrote:
> Add support for taking and passing forward job creaton flags.

s/creaton/creation/ (here and in 2/15 as well)

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/stream.c            | 5 +++--
>   blockdev.c                | 3 ++-
>   include/block/block_int.h | 5 ++++-
>   3 files changed, 9 insertions(+), 4 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

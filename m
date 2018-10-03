Received: from eggs.gnu.org ([2001:4830:134:3::10]:33139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7gBV-0004ch-6D
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7gBU-0005wm-Cv
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 08:23:21 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <137950f7-ad45-9cf6-919c-d2578afd8d2c@redhat.com>
Date: Wed, 3 Oct 2018 07:23:05 -0500
MIME-Version: 1.0
In-Reply-To: <20181002230218.13949-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/6] block/dirty-bitmaps: prohibit
 enable/disable on locked/frozen bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/2/18 6:02 PM, John Snow wrote:
> We're not being consistent about this. If it's in use by an operation,
> the user should not be able to change the behavior of that bitmap.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

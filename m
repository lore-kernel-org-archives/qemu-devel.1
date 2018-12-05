Received: from eggs.gnu.org ([2001:4830:134:3::10]:32993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUZCF-0003cw-28
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUZCD-0007vr-NI
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:34:42 -0500
References: <20181205084308.201356-1-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8aa64c4-4bfa-05e6-9a2f-6478330a6fd7@redhat.com>
Date: Wed, 5 Dec 2018 09:34:32 -0600
MIME-Version: 1.0
In-Reply-To: <20181205084308.201356-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] iotests: make 235 work on s390 (and
 others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 12/5/18 2:43 AM, Christian Borntraeger wrote:
> "-machine pc" will not work all architectures. Lets fall back to the
> default machine by not specifying it.
> 
> In addition we also need to specify -no-shutdown on s390 as qemu will
> exit otherwise.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

CC: qemu-stable

> ---
>   tests/qemu-iotests/235 | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Too late for 3.1; for that, we can just document that there are known 
iotests failures under some configurations

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

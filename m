Received: from eggs.gnu.org ([2001:4830:134:3::10]:39479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Gl-0001J0-3B
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Gj-0007vC-1v
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:30:34 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6bbb47e8-675f-5058-4138-fc99d77d6d85@redhat.com>
Date: Fri, 12 Oct 2018 12:30:14 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] curl: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/12/18 6:55 AM, Kevin Wolf wrote:
> If read-only=off, but auto-read-only=on is given, just degrade to
> read-only.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/curl.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

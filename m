Received: from eggs.gnu.org ([2001:4830:134:3::10]:54437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBqo-0005xv-QZ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDBqn-0003uM-IW
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:40:30 -0400
References: <20180428144123.30333-1-mreitz@redhat.com>
	<20180428144123.30333-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eea123af-ec17-beb5-74b6-0fd81d22e138@redhat.com>
Date: Mon, 30 Apr 2018 11:40:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180428144123.30333-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests.py: Add qemu_io_silent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/28/2018 09:41 AM, Max Reitz wrote:
> With qemu-io now returning a useful exit code, some tests may find it
> sufficient to just query that instead of logging (and filtering) the
> whole output.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

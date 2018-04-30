Received: from eggs.gnu.org ([2001:4830:134:3::10]:56315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDAFz-0002dS-3z
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDAFy-0006Cp-9s
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:58:23 -0400
References: <20180428144123.30333-1-mreitz@redhat.com>
	<20180428144123.30333-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <649f308e-9fde-33e2-aab1-a155a4bf3a0b@redhat.com>
Date: Mon, 30 Apr 2018 09:58:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180428144123.30333-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-io: Drop command functions'
 return values
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
> For qemu-io, a function returns an integer with two possible values: 0
> for "qemu-io may continue execution", or 1 for "qemu-io should exit".
> However, there is only a single command that returns 1, and that is
> "quit".
> 
> So let's turn this case into a global variable instead so we can make
> better use of the return value in a later patch.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/qemu-io.h |   6 +-
>   qemu-io-cmds.c    | 294 +++++++++++++++++++++++++-----------------------------
>   qemu-io.c         |  36 +++----
>   3 files changed, 157 insertions(+), 179 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

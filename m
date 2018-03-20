Received: from eggs.gnu.org ([2001:4830:134:3::10]:43875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyMFy-0003Tx-Fa
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyMFx-0003Gm-MI
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:45:10 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dcd4ff81-6f3d-b7ae-f334-70ae836e21aa@redhat.com>
Date: Tue, 20 Mar 2018 13:45:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 10/12] vhdx: Don't use
 error_setg_errno() with constant errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> error_setg_errno() is meant for cases where we got an errno from the OS
> that can add useful extra information to an error message. It's
> pointless if we pass a constant errno, these cases should use plain
> error_setg().

Well, it DOES let you get the libc-specific spelling of the strerror for 
that errno (not all libc report the same string) - but you're right that 
it didn't add much here.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vhdx.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

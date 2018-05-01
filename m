Received: from eggs.gnu.org ([2001:4830:134:3::10]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDZj4-0002Br-DW
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDZj3-0004U4-Bo
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:10:06 -0400
References: <20180501165750.19242-1-mreitz@redhat.com>
	<20180501165750.19242-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bd9c414-d62e-79d8-7c3d-32b4ce748469@redhat.com>
Date: Tue, 1 May 2018 13:09:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180501165750.19242-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: Special post-backing convert
 handling
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

On 05/01/2018 11:57 AM, Max Reitz wrote:
> Currently, qemu-img convert writes zeroes when it reads zeroes.
> Sometimes it does not because the target is initialized to zeroes
> anyway, so we do not need to overwrite (and thus potentially allocate)
> it.  This is never the case for targets with backing files, though.  But
> even them may have an area that is initialized to zeroes, and that is

s/them/they/

> the area past the end of the backing file (if that is shorter than the
> overlay).
> 
> So if the target format's unallocated blocks are zero and there is a gap
> between the target's backing file's end and the target's end, we do not
> have to explicitly write zeroes there.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1527898
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 

Some long variable names, but it aids legibility.  Nice fix.

Reviewed-by: Eric Blake <eblake@redhat.com>

(And here's hoping that Red Hat someday flips the switch so that new 
images avoid compat=0.10 in their downstream builds, as we've had quite 
a few corner cases where we already have optimized speed for compat=1.1 ...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

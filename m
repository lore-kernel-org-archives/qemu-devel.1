Received: from eggs.gnu.org ([209.51.188.92]:51265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpcU8-0001ye-IO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpcU7-0003MR-0z
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:20:12 -0500
Date: Fri, 1 Feb 2019 18:19:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201171936.GC31750@localhost.localdomain>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Am 31.01.2019 um 14:46 hat Andrey Shinkevich geschrieben:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
> 
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>     compat: 1.1
>     lazy refcounts: true
>     bitmaps:
>         [0]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up1
>             unknown flags: 4
>             granularity: 65536
>         [1]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up2
>             unknown flags: 8
>             granularity: 65536
>     refcount bits: 16
>     corrupt: false
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

I haven't reviewed the patch in detail, but I suggest that you change
the subject line to make clear this is a qcow2 patch, not a qemu-img
one. Maybe:

    "qcow2: Add list of bitmaps to ImageInfoSpecificQCow2"

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ddcQ7-0008LN-3G
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ddcOw-0001JU-1e
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:13:32 -0400
References: <8760e3mst2.fsf@dusky.pond.sub.org>
	<87pocbjyzs.fsf@dusky.pond.sub.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <6944ef8b-c3f0-6057-9433-544dedde9b59@openvz.org>
Date: Fri, 4 Aug 2017 16:10:40 +0300
MIME-Version: 1.0
In-Reply-To: <87pocbjyzs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Is the use of bdrv_getlength() in parallels.c
 kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 08/04/2017 03:31 PM, Markus Armbruster wrote:
> Same question for allocate_clusters() in parallels.c, commit 5a41e1f,
> modified in commit ddd2ef2:
>
>     if (s->data_end + space > bdrv_getlength(bs->file->bs) >> BDRV_SECTOR_BITS) {
>
> bdrv_getlength() can fail.  Does it do the right thing then?  For what
> it's worth, the comparison of its value is signed.
>
> There's another one in parallels_open():
>
>     if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs) ||
>             bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
>                           PREALLOC_MODE_OFF, NULL) != 0) {
>         s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
>     }
the same as in the previous letter. Saniti checks will not harm.
I'll make a patch.

Thank you for the suggestion.

Den

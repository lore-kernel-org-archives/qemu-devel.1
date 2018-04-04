Received: from eggs.gnu.org ([2001:4830:134:3::10]:43054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3fIQ-0002HM-Uu
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3fIQ-00022W-8H
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:05:38 -0400
Date: Wed, 4 Apr 2018 12:05:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180404100529.GF4482@localhost.localdomain>
References: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522422996-14235-1-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: blacklist bochs and cloop for
 205 and 208
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, stefanha@redhat.com, den@openvz.org

Am 30.03.2018 um 17:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Blacklist these formats, as they don't support image creation, as they
> say:
>     > ./qemu-img create -f bochs x 1m
>     qemu-img: x: Format driver 'bochs' does not support image creation
> 
>     > ./qemu-img create -f cloop x 1m
>     qemu-img: x: Format driver 'cloop' does not support image creation

Thanks, applied to the block branch. (But if you feel like implementing
the IMGFMT_GENERIC thing on top, I wouldn't mind. :-))

Kevin

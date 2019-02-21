Received: from eggs.gnu.org ([209.51.188.92]:42002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwslu-0005m9-DV
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwslm-0000Cm-Aw
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:08:29 -0500
References: <20190221173758.24672-1-slp@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <441b350a-6e01-6163-c2ff-29065a344ab0@redhat.com>
Date: Thu, 21 Feb 2019 12:08:12 -0600
MIME-Version: 1.0
In-Reply-To: <20190221173758.24672-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: implement copy offload (-C) for
 dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 2/21/19 11:37 AM, Sergio Lopez wrote:
> This parameter is analogous to convert's "-C", making use of
> bdrv_co_copy_range().

The last time I tried to patch 'qemu-img dd', it was pointed out that it
already has several bugs (where it is not on feature-parity with real
dd), and that we REALLY want to make it a syntactic sugar wrapper around
'qemu-img convert', rather than duplicating code (which means that
qemu-img convert needs to make it easier to do arbitrary offsets and
subsets - although to some extent you can already do that with
--image-opts and appropriate raw driver wrappers).

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02618.html

> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  qemu-img-cmds.hx |   4 +-
>  qemu-img.c       | 146 ++++++++++++++++++++++++++++++++++++-----------
>  qemu-img.texi    |   2 +-
>  3 files changed, 117 insertions(+), 35 deletions(-)

In other words, this feels like a lot of code compared to being able to
just forward on to an appropriate qemu-img convert command, and I think
our time would be better spent on that.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

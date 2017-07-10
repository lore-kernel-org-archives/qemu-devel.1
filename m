Received: from eggs.gnu.org ([2001:4830:134:3::10]:36777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUhyv-00045W-2b
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUhyu-0000MC-9c
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:20:45 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-10-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d0efc293-865e-320c-ca5e-6fd5f0ea73c4@redhat.com>
Date: Mon, 10 Jul 2017 19:20:34 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/17] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> Thanks to recent cleanups, most callers were scaling a return value
> of sectors into bytes (the exception, in qcow2-bitmap, will be
> converted to byte-based iteration later).  Update the interface to
> do the scaling internally instead.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-By: John Snow <jsnow@redhat.com>

I still think about getting Arby's when I write that line, and now I'm 
hungry.

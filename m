Received: from eggs.gnu.org ([2001:4830:134:3::10]:33564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUhhB-0000Un-8t
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUhhA-0001Mx-MG
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 19:02:25 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-9-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3828b973-930c-eb80-7f40-a2a86cafd646@redhat.com>
Date: Mon, 10 Jul 2017 19:02:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/17] dirty-bitmap: Set iterator start
 by offset, not sector
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
> All callers to bdrv_dirty_iter_new() passed 0 for their initial
> starting point, drop that parameter.
> 
> Most callers to bdrv_set_dirty_iter() were scaling a byte offset to
> a sector number; the exception qcow2-bitmap will be converted later
> to use byte rather than sector iteration.  Move the scaling to occur
> internally to dirty bitmap code instead, so that callers now pass
> in bytes.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

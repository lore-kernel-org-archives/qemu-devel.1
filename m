Received: from eggs.gnu.org ([2001:4830:134:3::10]:59467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dSuaO-0007At-45
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dSuaN-0002Fd-B2
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:00 -0400
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-21-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7cd4c11a-26df-6621-9b68-5cf00ff627fe@redhat.com>
Date: Wed, 5 Jul 2017 20:23:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170705210842.960-21-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 20/21] block: Minimize raw use of
 bds->total_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, jcody@redhat.com, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 07/05/2017 05:08 PM, Eric Blake wrote:
> bdrv_is_allocated_above() was relying on intermediate->total_sectors,
> which is a field that can have stale contents depending on the value
> of intermediate->has_variable_length.  An audit shows that we are safe
> (we were first calling through bdrv_co_get_block_status() which in
> turn calls bdrv_nb_sectors() and therefore just refreshed the current
> length), but it's nicer to favor our accessor functions to avoid having
> to repeat such an audit, even if it means refresh_total_sectors() is
> called more frequently.
> 
> Suggested-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

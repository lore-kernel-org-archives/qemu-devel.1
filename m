Received: from eggs.gnu.org ([2001:4830:134:3::10]:57746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dSuRH-0004tt-DT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dSuRG-0007Df-EX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:14:35 -0400
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-9-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <70c3b6b2-baa4-9b45-f76a-3446f063f1f1@redhat.com>
Date: Wed, 5 Jul 2017 20:14:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170705210842.960-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/21] mirror: Switch MirrorBlockJob to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/05/2017 05:08 PM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting an
> internal structure (no semantic change), and all references to the
> buffer size.
> 
> Add an assertion that our use of s->granularity >> BDRV_SECTOR_BITS
> (necessary for interaction with sector-based dirty bitmaps, until
> a later patch converts those to be byte-based) does not suffer from
> truncation problems.
> 
> [checkpatch has a false positive on use of MIN() in this patch]
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>

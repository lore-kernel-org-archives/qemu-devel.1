Received: from eggs.gnu.org ([2001:4830:134:3::10]:58968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVjMd-0002OK-Up
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVjMd-0001nc-DP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:01:28 -0400
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-19-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <86157028-cb3f-b2ee-d266-eaebae1ed9e1@redhat.com>
Date: Thu, 13 Jul 2017 15:01:16 -0400
MIME-Version: 1.0
In-Reply-To: <20170713010555.6769-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 18/18] dirty-bitmap: Convert internal
 hbitmap size/granularity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/12/2017 09:05 PM, Eric Blake wrote:
> Now that all callers are using byte-based interfaces, there's no
> reason for our internal hbitmap to remain with sector-based
> granularity.  It also simplifies our internal scaling, since we
> already know that hbitmap widens requests out to granularity
> boundaries.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v5: fix bdrv_dirty_bitmap_truncate [John]
> v4: rebase to earlier changes, include serialization, R-b dropped
> v3: no change
> v2: no change


Reviewed-by: John Snow <jsnow@redhat.com>

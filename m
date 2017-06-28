Received: from eggs.gnu.org ([2001:4830:134:3::10]:36924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQDQ2-0001Oh-8r
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQDPx-00070i-KA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:54:10 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:9342 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQDPx-0006zw-82
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:54:05 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<969a2b68-c6ec-dee7-15cb-2a2bd9bfc0fd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <354bbe28-4357-6f9f-801f-10bb02ee7e18@virtuozzo.com>
Date: Wed, 28 Jun 2017 16:53:49 +0300
MIME-Version: 1.0
In-Reply-To: <969a2b68-c6ec-dee7-15cb-2a2bd9bfc0fd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v22 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

28.06.2017 16:01, Paolo Bonzini wrote:
> 
> 
> On 28/06/2017 14:05, Vladimir Sementsov-Ogievskiy wrote:
>> Rebase on master, so changes, mostly related to new dirty bitmaps mutex:
>>
>> 10: - asserts now in bdrv_{re,}set_dirty_bitmap_locked functions.
>>      - also add assert into bdrv_undo_clear_dirty_bitmap (the only change, not related to rebase)
>>      - add mutex lock into bdrv_dirty_bitmap_set_readonly (as it changes bitmap list,
>>        so the lock should be taken)
>>      - return instead of go-to in qmp_block_dirty_bitmap_clear
>>      - in dirty-bitmaps.h, move bdrv_dirty_bitmap_set_readonly before block
>>        "Functions that require manual locking", move
>>        bdrv_dirty_bitmap_readonly and bdrv_has_readonly_bitmaps into this block
>> 15: - add mutex lock/unlock into bdrv_dirty_bitmap_set_autoload
>>      - in dirty-bitmaps.h, move bdrv_dirty_bitmap_set_autoload before block
>>        "Functions that require manual locking", move
>>        bdrv_dirty_bitmap_get_autoload into this block
>> 17: - add mutex lock/unlock into bdrv_dirty_bitmap_set_persistance
>>      - in dirty-bitmaps.h, move bdrv_dirty_bitmap_set_persistance before block
>>        "Functions that require manual locking", move
>>        bdrv_dirty_bitmap_get_persistance and
>>        bdrv_has_changed_persistent_bitmaps into this block
>> 18: in dirty-bitmaps.h, move bdrv_dirty_bitmap_next into block
>>      "Functions that require manual locking". (do not remove r-b, as it is
>>      just one empty line removed before function declaration)
>> 23: return instead of go-to in qmp_block_dirty_bitmap_add
>> 24: return instead of go-to in qmp_block_dirty_bitmap_add
>> 25: - return instead of go-to
>>      - remove aio_context_acquire/release calls
>>      - no aio_context parameter for block_dirty_bitmap_lookup
>>      - in dirty-bitmaps.h, move bdrv_dirty_bitmap_sha256 into block
>>          "Functions that require manual locking".
>> 29: - return instead of go-to in qmp_block_dirty_bitmap_remove
> 
> All looks good, thanks.  I'll rebase my own fixes on top of these
> patches, no need to have you respin them.
> 
> Paolo
> 

Thank you! And for thunderbird-work-around too!

-- 
Best regards,
Vladimir

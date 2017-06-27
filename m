Received: from eggs.gnu.org ([2001:4830:134:3::10]:52524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dPmTS-0008Ty-3Y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dPmTN-0004vF-33
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:07:54 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34790 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dPmTM-0004rw-Nc
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:07:49 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
	<e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
	<37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <eb056c7c-2bd7-e9b2-cebb-30f716386d00@virtuozzo.com>
Date: Tue, 27 Jun 2017 12:07:42 +0300
MIME-Version: 1.0
In-Reply-To: <37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 16/19] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

26.06.2017 19:54, Paolo Bonzini wrote:
>
> On 26/06/2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
>> HI!
>>
>> One question here, should not 'bdrv_undo_clear_dirty_bitmap' be under
>> lock too?
> Any call to dirty bitmap functions between bdrv_clear_dirty_bitmap and
> bdrv_undo_clear_dirty_bitmap is problematic anyway, so
> bdrv_clear_dirty_bitmap really only needs the lock in the !out case;
> bdrv_undo_clear_dirty_bitmap is only called when out != NULL.
>
> However, I agree it would be cleaner to add the lock there, too.
>
> Paolo


Also, you've added comment "Called with BQL taken" both to functions 
that calls bdrv_dirty_bitmaps_lock and that do not... What is BQL?


-- 
Best regards,
Vladimir

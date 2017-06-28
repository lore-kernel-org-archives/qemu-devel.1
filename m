Received: from eggs.gnu.org ([2001:4830:134:3::10]:59058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQD4f-0008OK-GW
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQD4e-0003hn-Ls
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:32:05 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-14-vsementsov@virtuozzo.com>
	<f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
	<da795837-2945-d3b1-bd92-e6ced22817bc@redhat.com>
	<6e99d1ce-a7e9-af1b-ec84-baae97f348df@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4191c73e-a7d5-2dc2-c359-88e0eb00465c@redhat.com>
Date: Wed, 28 Jun 2017 15:31:43 +0200
MIME-Version: 1.0
In-Reply-To: <6e99d1ce-a7e9-af1b-ec84-baae97f348df@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v22 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com



On 28/06/2017 15:02, Vladimir Sementsov-Ogievskiy wrote:
> It is interesting, but I see this problem only in your answers, in my
> letters I see this white-space on its place.

That's the good old Thunderbird "format=flowed" bug.

Vladimir, download
http://people.redhat.com/pbonzini/format-flawed.tar.gz and place it into
~/.thunderbird/<profile name>/extensions.  It works around the bug.

Paolo

> 28.06.2017 15:36, Eric Blake wrote:
>> [meta-comment]
>>
>> On 06/28/2017 07:10 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 28.06.2017 15:05, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add format driver handler, which should mark loaded read-only
>>>> bitmaps as 'IN_USE' in the image and unset read_only field in
>>>> corresponding BdrvDirtyBitmap's.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>>>> Reviewed-by: John Snow<jsnow@redhat.com>
>> Your original message had spaces before '<' in the email addresses, but
>> it got lost here...
>>

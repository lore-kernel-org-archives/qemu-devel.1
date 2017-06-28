Received: from eggs.gnu.org ([2001:4830:134:3::10]:54368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQCn8-0008Vc-QD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQCn5-0000OX-Lo
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:13:58 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32854 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQCn5-0000NK-97
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:13:55 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-14-vsementsov@virtuozzo.com>
	<f5957047-c69c-ebe6-6640-08bacc3244ea@virtuozzo.com>
	<da795837-2945-d3b1-bd92-e6ced22817bc@redhat.com>
	<6e99d1ce-a7e9-af1b-ec84-baae97f348df@virtuozzo.com>
Message-ID: <22469eec-5a74-ee90-e530-744fabc50c4f@virtuozzo.com>
Date: Wed, 28 Jun 2017 16:13:37 +0300
MIME-Version: 1.0
In-Reply-To: <6e99d1ce-a7e9-af1b-ec84-baae97f348df@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

28.06.2017 16:02, Vladimir Sementsov-Ogievskiy wrote:
> It is interesting, but I see this problem only in your answers, in my 
> letters I see this white-space on its place.

In outgoing letter I see this white-space, but in letter from 
mailing-list it is absent.

>
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
>>>
>>> Forgot to add:
>>>
>>> Reviewed-by: Max Reitz<mreitz@redhat.com>
>> ...this one also lacks the space.  I'm not sure if git cares, but it may
>> be worth investigating why your mailer eats the space when you reply
>> manually rather than sending via git; and for consistency, it is worth
>> keeping the space (for example, we like to grep 'git log' for learning
>> how active various contributors are, and having a consistent usage of
>> space before < in an email address can make the task easier).
>>
>

-- 
Best regards,
Vladimir

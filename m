Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fIy4h-0003QH-23
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fIy4g-0000oI-0C
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:10:43 -0400
References: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
	<20180514064139.GB16389@lemon.usersys.redhat.com>
	<9a59b786-2351-e8ae-f582-5e436ce0383c@virtuozzo.com>
	<20180516124755.GB4435@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <352a3b44-b7ac-7d62-2d4e-8e46a80366d8@virtuozzo.com>
Date: Wed, 16 May 2018 18:10:26 +0300
MIME-Version: 1.0
In-Reply-To: <20180516124755.GB4435@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Restoring bitmaps after failed/cancelled migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "gilbert >> Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

16.05.2018 15:47, Kevin Wolf wrote:
> Am 14.05.2018 um 12:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 14.05.2018 09:41, Fam Zheng wrote:
>>> On Wed, 04/18 17:00, Vladimir Sementsov-Ogievskiy wrote:
>>>> Is it possible, that target will change the disk, and then we return control
>>>> to the source? In this case bitmaps will be invalid. So, should not we drop
>>>> all the bitmaps on inactivate?
>>> Yes, dropping all live bitmaps upon inactivate sounds reasonable. If the dst
>>> fails to start, and we want to resume VM at src, we could (optionally?) reload
>>> the persistent bitmaps, I guess.
>> Reload from where? We didn't store them.
> Maybe this just means that it turns out that not storing them was a bad
> idea?
>
> What was the motivation for not storing the bitmap? The additional
> downtime? Is it really that bad, though? Bitmaps should be fairly small
> for the usual image sizes and writing them out should be quick.
>
> Kevin

What are usual ones? A bitmap of standard granularity of 64k for 16Tb 
disk is ~30mb. If we have several such bitmaps it may be significant 
downtime.



-- 
Best regards,
Vladimir

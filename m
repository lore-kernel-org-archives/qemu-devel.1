Received: from eggs.gnu.org ([2001:4830:134:3::10]:49574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dSgXl-0001wK-2H
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dSgXk-0007SO-AM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:24:21 -0400
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
	<1486979689-230770-13-git-send-email-vsementsov@virtuozzo.com>
	<20170216130409.GA28784@lemon.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d94f4e26-0979-f530-6a88-9ee655843d68@virtuozzo.com>
Date: Wed, 5 Jul 2017 12:24:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170216130409.GA28784@lemon.lan>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

16.02.2017 16:04, Fam Zheng wrote:
>> +            dbms->node_name = bdrv_get_node_name(bs);
>> +            if (!dbms->node_name || dbms->node_name[0] == '\0') {
>> +                dbms->node_name = bdrv_get_device_name(bs);
>> +            }
>> +            dbms->bitmap = bitmap;
> What protects the case that the bitmap is released before migration completes?
>
What is the source of such deletion? qmp command? Theoretically possible.

I see the following variants:

1. additional variable BdrvDirtyBItmap.migration, which forbids bitmap 
deletion

2. make bitmap anonymous (bdrv_dirty_bitmap_make_anon) - it will not be 
available through qmp

what do you think?

-- 
Best regards,
Vladimir

Received: from eggs.gnu.org ([209.51.188.92]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzoO3-0002YE-7X
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzoO0-0008RS-1y
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:04:02 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-4-jsnow@redhat.com>
	<66ebf636-43e1-f16a-bd05-e9a8a766d4bd@redhat.com>
	<4ee8a7b7-d110-8253-2caa-c8f6ec105bba@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a58f266-dca6-8208-a046-85b718ed72fc@redhat.com>
Date: Fri, 1 Mar 2019 14:03:41 -0600
MIME-Version: 1.0
In-Reply-To: <4ee8a7b7-d110-8253-2caa-c8f6ec105bba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 3/1/19 1:57 PM, John Snow wrote:

>>> +    if ((flags & BDRV_BITMAP_BUSY) && bdrv_dirty_bitmap_busy(bitmap)) {
>>> +        error_setg(errp, "Bitmap '%s' is currently in use by another"
>>> +                   " operation and cannot be used", bitmap->name);
>>
>> Split before space,
>>

>>> +        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used",
>>> +                   bitmap->name);
>>> +        error_append_hint(errp, "Try block-dirty-bitmap-remove to delete "
>>> +                          "this bitmap from disk");
>>
>> split after space.  Looks inconsistent within a single function (pardon
>> the pun :)
>>
> 
> Ah... I've never known how to split strings. In fact, does anyone?
> I'll address this either in staging or as a follow-up, as I assume
> Vladimir will have some comments for me.

I don't care which way you go. git says we have both styles with enough
frequency that I wouldn't rule out the other style in HACKING.  But it
also says split after space seems more common, if you trust my regex:

$ git grep '"[^"]* "$' | wc
  11597  120619 1261416
$ git grep '^[[:space:]]*" [^"]*"' | wc
   4070   19423  271036

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

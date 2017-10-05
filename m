Received: from eggs.gnu.org ([2001:4830:134:3::10]:57417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e05FO-0005uZ-2E
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e05FI-0002Ko-8E
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:27:26 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23840 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e05FH-0002I5-NV
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:27:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
	<c3c3bfdb-3e8f-5443-3d6c-52ab5a95bc63@virtuozzo.com>
Message-ID: <485ee47a-9217-d19f-f1c4-8bc10021459c@virtuozzo.com>
Date: Thu, 5 Oct 2017 15:27:05 +0300
MIME-Version: 1.0
In-Reply-To: <c3c3bfdb-3e8f-5443-3d6c-52ab5a95bc63@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] nbd structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, nbd@other.debian.org

fix cc to nbd@other.debian.org

05.10.2017 14:30, Vladimir Sementsov-Ogievskiy wrote:
> 21.09.2017 15:18, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> I'm about this:
>>
>> "A server SHOULD try to minimize the number of chunks sent in a 
>> reply, but MUST NOT mark a chunk as final if there is still a 
>> possibility of detecting an error before transmission of that chunk 
>> completes"
>>
>> What do we mean by "possibility"? Formally, such possibility exists 
>> always, so, we'll never mark a chunk as final.
>>
>
> One more question:
>
> for |NBD_REPLY_TYPE_ERROR and ||NBD_REPLY_TYPE_ERROR_OFFSET, why do we 
> need message_length field? why not to calc it as chunk.lenght - 4 for 
> ||NBD_REPLY_TYPE_ERROR and chunk.lenght - 12 for 
> ||NBD_REPLY_TYPE_ERROR_OFFSET?
>
> For example, with NBD_REPLY_TYPE_OFFSET_DATA variable data length is 
> calculated, not specified separately.
>
> What is the reason for server to send NBD_REPLY_TYPE_ERROR with 
> message_lenght < chunk.lenght - 4?
> |
>
> -- 
> Best regards,
> Vladimir


-- 
Best regards,
Vladimir

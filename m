Received: from eggs.gnu.org ([2001:4830:134:3::10]:48738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKgl-0002Ii-R2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKgk-0001vH-Nv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:18:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEKgk-0001ua-JR
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:18:50 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-6-git-send-email-mst@redhat.com>
	<5fbe4232-ca1a-5e0c-437c-8b63cf83c510@redhat.com>
	<20180503230505-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4f0bb7a-f5db-383b-60fd-683dd65de7f8@redhat.com>
Date: Thu, 3 May 2018 15:18:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180503230505-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/67] migration: drop an unused include,
 add a used one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05/03/2018 03:15 PM, Michael S. Tsirkin wrote:
> On Thu, May 03, 2018 at 03:02:59PM -0500, Eric Blake wrote:
>> On 05/03/2018 02:50 PM, Michael S. Tsirkin wrote:
>>> we just need a struct name, let's add a forward
>>> declaration instead of an include.
>>
>> Reasonable.
>>
>>>
>>> We also use size_t, so add stddef.h
>>
>> Why? osdep.h already does this, and ALL .c files that use include/ should be
>> including osdep.h prior to any other in-tree .h file.  So size_t should
>> already be in scope by the time this header is included.
> 
> It seemed cleaner to have the file self-contained.
> OK, I will drop this.
> There's a small number of files which do not include qemu/osdep.h.
> Might be worth fixing.

scripts/clean-includes is already supposed to fix these.

There are a few .c files exempt from including osdep.h, but in general, 
those files should probably also not be including anything from include/.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

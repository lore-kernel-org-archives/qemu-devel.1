Received: from eggs.gnu.org ([2001:4830:134:3::10]:35583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSm78-00084K-EW
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSm73-0007kT-Gt
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSm73-0007kN-AT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:21:09 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-3-vsementsov@virtuozzo.com>
	<695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com>
	<a0dae7c7-f0e8-2c6b-e35e-096f597c40cb@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0fec8f79-5d1e-307e-6f34-0f2152a6a4ca@redhat.com>
Date: Wed, 5 Jul 2017 17:21:02 +0200
MIME-Version: 1.0
In-Reply-To: <a0dae7c7-f0e8-2c6b-e35e-096f597c40cb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, den@openvz.org, Markus Armbruster <armbru@redhat.com>



On 05/07/2017 14:33, Vladimir Sementsov-Ogievskiy wrote:
> 
> 
>>> -static int GCC_FMT_ATTR(4, 5)
>>> +static int GCC_FMT_ATTR(5, 6)
>>>   nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
>>> -                           uint32_t opt, const char *fmt, ...)
>>> +                           uint32_t opt, Error **errp, const char
>>> *fmt, ...)
>>>   {
>> Markus, this violates our usual idiom of errp last in code that is not
>> directly operating on an Error (the actual Error implementation in
>> error.c being the main obvious exception that lists errp first), but I
>> don't see any better approach. Do you have any thoughts on it?

I think it's okay as it matches functions like vfprintf.

Paolo

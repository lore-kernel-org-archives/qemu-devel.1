Received: from eggs.gnu.org ([209.51.188.92]:34445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwWVx-0007Xs-Jc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwWVw-0008Pr-Uh
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:22:37 -0500
References: <20190220174843.8847-1-kwolf@redhat.com>
	<20190220174843.8847-6-kwolf@redhat.com>
	<bf7d55dc-e914-ad14-d542-175255dd0d1b@redhat.com>
	<20190220180724.GE6281@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46a57a6b-d4d6-62d1-20aa-64c9b5b9f91e@redhat.com>
Date: Wed, 20 Feb 2019 19:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190220180724.GE6281@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/13] io: Remove redundant
 read/write_coroutine assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On 20/02/19 19:07, Kevin Wolf wrote:
> Am 20.02.2019 um 19:01 hat Paolo Bonzini geschrieben:
>> aio_co_wake was also acquiring/releasing the AioContext, so
>> that needs to stay for now.
> 
> True. Maybe I should leave the aio_co_wake call alone() and just add the
> assertion to avoid complicating the code rather than simplifying it...

Yes, I agree.

Paolo

ps: where is alone() defined? :)

Paolo

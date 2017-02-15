Received: from eggs.gnu.org ([2001:4830:134:3::10]:43897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2os-00064e-Jk
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2oo-0006LA-AV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:52:39 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-7-vsementsov@virtuozzo.com>
	<f9ddd60b-532a-2009-c1cc-edab0ca64458@redhat.com>
	<950e5279-0d30-77a4-ca1c-f8543ae08248@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <751994f4-b3ef-c189-dde4-687d4e040871@redhat.com>
Date: Wed, 15 Feb 2017 17:52:32 +0100
MIME-Version: 1.0
In-Reply-To: <950e5279-0d30-77a4-ca1c-f8543ae08248@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/18] nbd/client: refactor drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com



On 08/02/2017 08:55, Vladimir Sementsov-Ogievskiy wrote:
> 07.02.2017 02:19, Eric Blake wrote:
>> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Return 0 on success to simplify success checking.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  nbd/client.c | 35 +++++++++++++++++++----------------
>>>  1 file changed, 19 insertions(+), 16 deletions(-)
>> I'm not sure that this simplifies anything.  You have a net addition in
>> lines of code, so unless some later patch is improved because of this,
>> I'm inclined to say this is needless churn.
>>
> 
> I just dislike duplicating information like "drop_sync(ioc, 124) !=
> 124". In the code there is no place where positive and not equal to size
> return value actually handled. But it is not so important, if you are
> against i'll drop this, no problem.

I think I agree with Vladimir.

> One note: I don't have good understanding of the following: actually
> read can return positive value < queried size, which means that we
> should read again. But it is not handled in the code (handled, but just
> as an error), except drop_sync.. (With drop_sync it is side effect of
> using limited buffer size, yes?). Is it all ok?

It is handled in nbd_wr_syncv.

Paolo

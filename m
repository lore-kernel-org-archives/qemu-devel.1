Received: from eggs.gnu.org ([2001:4830:134:3::10]:51308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXOms-0000Ps-5R
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXOmo-0001l2-6s
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:59:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXOmo-0001hl-13
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:59:38 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com> (Eric Blake's
	message of "Thu, 4 Jan 2018 18:30:32 -0600")
References: <20180103093834.20879-1-quintela@redhat.com>
	<ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 05 Jan 2018 10:59:30 +0100
Message-ID: <87zi5soccd.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Alexey <a.perevalov@samsung.com>, Markus Armbruster <armbru@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> On 01/03/2018 03:38 AM, Juan Quintela wrote:
>> Hi
>> 
>> This are the changes for migration that are already reviewed.
>> 
>> Please, apply.
>> 
>
>> Alexey Perevalov (6):
>>       migration: introduce postcopy-blocktime capability
>>       migration: add postcopy blocktime ctx into MigrationIncomingState
>>       migration: calculate vCPU blocktime on dst side
>>       migration: postcopy_blocktime documentation
>>       migration: add blocktime calculation into migration-test
>>       migration: add postcopy total blocktime into query-migrate
>
> I had unanswered questions about these patches in the v12 series, where
> I'm not sure if the interface is still quite right.

To be fair, I had alroady integrated the patches before I saw your questions.

> We're still early
> enough that we could adjust the interface after the fact depending on
> how the questions are answered;

I think this is the best approach, so far I can see two questions:

- do we want to make it conditional?  it requires some locking, but I
  haven't meassured it to see how slow/fast is it.

- the other was documentation.

I will like Alexey to answer.  Depending of how slow it is, I can agree
to make it non-optional.

> but we're also early enough that it may
> be smarter to get the interface right before including it in a pull
> request.  I'll leave it to Peter and Juan to sort out whether this means
> an updated pull request is needed, or to take this as-is.

Thanks, Juan.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eZ8TL-0000R5-Em
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1eZ8TH-0000KF-IC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:58:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1eZ8TH-0000Ih-4a
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:58:39 -0500
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <3c76de45-8e41-07a0-cd78-d1fd14dc43c4@samsung.com>
Date: Wed, 10 Jan 2018 07:58:29 +0300
MIME-version: 1.0
In-reply-to: <87zi5soccd.fsf@secure.laptop>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <20180103093834.20879-1-quintela@redhat.com>
	<ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
	<CGME20180105095938epcas4p2c88624f9ece19386ebe91994ed87849b@epcas4p2.samsung.com>
	<87zi5soccd.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>

On 01/05/2018 12:59 PM, Juan Quintela wrote:
> Eric Blake <eblake@redhat.com> wrote:
>> On 01/03/2018 03:38 AM, Juan Quintela wrote:
>>> Hi
>>>
>>> This are the changes for migration that are already reviewed.
>>>
>>> Please, apply.
>>>
>>> Alexey Perevalov (6):
>>>        migration: introduce postcopy-blocktime capability
>>>        migration: add postcopy blocktime ctx into MigrationIncomingState
>>>        migration: calculate vCPU blocktime on dst side
>>>        migration: postcopy_blocktime documentation
>>>        migration: add blocktime calculation into migration-test
>>>        migration: add postcopy total blocktime into query-migrate
>> I had unanswered questions about these patches in the v12 series, where
>> I'm not sure if the interface is still quite right.
> To be fair, I had alroady integrated the patches before I saw your questions.
>
>> We're still early
>> enough that we could adjust the interface after the fact depending on
>> how the questions are answered;
> I think this is the best approach, so far I can see two questions:
>
> - do we want to make it conditional?  it requires some locking, but I
>    haven't meassured it to see how slow/fast is it.
>
> - the other was documentation.
>
> I will like Alexey to answer.  Depending of how slow it is, I can agree
> to make it non-optional.
Ok, I'll give a logs with traces, maybe gprof result, today
or tomorrow.
>
>> but we're also early enough that it may
>> be smarter to get the interface right before including it in a pull
>> request.  I'll leave it to Peter and Juan to sort out whether this means
>> an updated pull request is needed, or to take this as-is.
> Thanks, Juan.
>
>
>

-- 
Best regards,
Alexey Perevalov

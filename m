Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYydo-0003FN-AG
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYydl-000469-4k
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:28:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eYydk-00043h-VR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:28:49 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA_q9SLzsazfYkRukw+ijOHQTunHqVKqqLhUR_=mqPMPQQ@mail.gmail.com>
	(Peter Maydell's message of "Tue, 9 Jan 2018 18:24:00 +0000")
References: <20180103093834.20879-1-quintela@redhat.com>
	<ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
	<87zi5soccd.fsf@secure.laptop>
	<CAFEAcA_q9SLzsazfYkRukw+ijOHQTunHqVKqqLhUR_=mqPMPQQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 09 Jan 2018 19:28:34 +0100
Message-ID: <87vagazy25.fsf@secure.laptop>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Alexey <a.perevalov@samsung.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 January 2018 at 09:59, Juan Quintela <quintela@redhat.com> wrote:
>> Eric Blake <eblake@redhat.com> wrote:
>>> On 01/03/2018 03:38 AM, Juan Quintela wrote:
>>>> Hi
>>>>
>>>> This are the changes for migration that are already reviewed.
>>>>
>>>> Please, apply.
>>>>
>>>
>>>> Alexey Perevalov (6):
>>>>       migration: introduce postcopy-blocktime capability
>>>>       migration: add postcopy blocktime ctx into MigrationIncomingState
>>>>       migration: calculate vCPU blocktime on dst side
>>>>       migration: postcopy_blocktime documentation
>>>>       migration: add blocktime calculation into migration-test
>>>>       migration: add postcopy total blocktime into query-migrate
>>>
>>> I had unanswered questions about these patches in the v12 series, where
>>> I'm not sure if the interface is still quite right.
>>
>> To be fair, I had alroady integrated the patches before I saw your questions.
>>
>>> We're still early
>>> enough that we could adjust the interface after the fact depending on
>>> how the questions are answered;
>>
>> I think this is the best approach, so far I can see two questions:
>>
>> - do we want to make it conditional?  it requires some locking, but I
>>   haven't meassured it to see how slow/fast is it.
>>
>> - the other was documentation.
>>
>> I will like Alexey to answer.  Depending of how slow it is, I can agree
>> to make it non-optional.
>
> So have you come to a consensus on whether you'd like me to apply
> this pull request or not ?

My understanding is that you should apply it.  We will add a
documentation patch later.

Later, Juan.

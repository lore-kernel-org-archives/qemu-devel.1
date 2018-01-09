Received: from eggs.gnu.org ([2001:4830:134:3::10]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYyZS-00011A-Rj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYyZR-0000nu-Rw
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:24:22 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:40351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYyZR-0000nY-NC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:24:21 -0500
Received: by mail-ot0-x22d.google.com with SMTP id d10so12112408oti.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 10:24:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi5soccd.fsf@secure.laptop>
References: <20180103093834.20879-1-quintela@redhat.com>
	<ce168bf2-8e61-1f62-8042-7e7df2decd8c@redhat.com>
	<87zi5soccd.fsf@secure.laptop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 18:24:00 +0000
Message-ID: <CAFEAcA_q9SLzsazfYkRukw+ijOHQTunHqVKqqLhUR_=mqPMPQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Alexey <a.perevalov@samsung.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 5 January 2018 at 09:59, Juan Quintela <quintela@redhat.com> wrote:
> Eric Blake <eblake@redhat.com> wrote:
>> On 01/03/2018 03:38 AM, Juan Quintela wrote:
>>> Hi
>>>
>>> This are the changes for migration that are already reviewed.
>>>
>>> Please, apply.
>>>
>>
>>> Alexey Perevalov (6):
>>>       migration: introduce postcopy-blocktime capability
>>>       migration: add postcopy blocktime ctx into MigrationIncomingState
>>>       migration: calculate vCPU blocktime on dst side
>>>       migration: postcopy_blocktime documentation
>>>       migration: add blocktime calculation into migration-test
>>>       migration: add postcopy total blocktime into query-migrate
>>
>> I had unanswered questions about these patches in the v12 series, where
>> I'm not sure if the interface is still quite right.
>
> To be fair, I had alroady integrated the patches before I saw your questions.
>
>> We're still early
>> enough that we could adjust the interface after the fact depending on
>> how the questions are answered;
>
> I think this is the best approach, so far I can see two questions:
>
> - do we want to make it conditional?  it requires some locking, but I
>   haven't meassured it to see how slow/fast is it.
>
> - the other was documentation.
>
> I will like Alexey to answer.  Depending of how slow it is, I can agree
> to make it non-optional.

So have you come to a consensus on whether you'd like me to apply
this pull request or not ?

thanks
-- PMM

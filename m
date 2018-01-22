Received: from eggs.gnu.org ([2001:4830:134:3::10]:53402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edcJ0-0007hC-RG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edcJ0-0004WB-0u
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:38:34 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:42497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edcIz-0004Vs-S3
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:38:33 -0500
Received: by mail-ot0-x235.google.com with SMTP id s3so7441295otc.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 05:38:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122123810.GA2628@work-vm>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA8AMejrf1P26QX1xne2+JvYziBvT1Q-HjcC2Pa=40gB6A@mail.gmail.com>
	<20180122123810.GA2628@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 13:38:12 +0000
Message-ID: <CAFEAcA960L3EX6cYFjw6BWueowa-ASn+N-Hwb4QOCisou802EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On 22 January 2018 at 12:38, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 15 January 2018 at 11:52, Juan Quintela <quintela@redhat.com> wrote:
>> > Alexey Perevalov (6):
>> >       migration: introduce postcopy-blocktime capability
>> >       migration: add postcopy blocktime ctx into MigrationIncomingState
>> >       migration: calculate vCPU blocktime on dst side
>> >       migration: postcopy_blocktime documentation
>> >       migration: add blocktime calculation into migration-test
>> >       migration: add postcopy total blocktime into query-migrate
>>
>> I suggest that we should for the moment revert
>> 3be98be4e9f5  migration: calculate vCPU blocktime on dst side
>> 5f32dc8ee073  migration: add blocktime calculation into migration-test
>> ca6011c23291  migration: add postcopy total blocktime into query-migrate
>>
>> unless there is an imminent fix for the ppc32 issues (which seems
>> unlikely since the code is fundamentally assuming it can atomically
>> do operations which can't be done atomically on all hosts).
>>
>> I haven't yet tested that combination of reverts, I'm guessing
>> at which subsequent commits depend on 3be98be4e9f5. Let me know
>> if you have suggestions for additions/removals from the revert list.
>
> It's probably better to remove the whole set of 6, then we can come
> back to it later rather than leaving something half-implemented in
> there.

OK. I'm currently running a commit with
 git revert --no-commit 31bf06a9d6844d^..ca6011c232912
through my build tests, though I'll hold off on actually pushing it
for a bit to give people time to comment.

thanks
-- PMM

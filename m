Received: from eggs.gnu.org ([2001:4830:134:3::10]:39849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1deewb-0002Yv-Uk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1deewY-0000pM-PT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:07:29 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:32999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1deewY-0000oT-Fh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:07:26 -0400
Received: by mail-wr0-x231.google.com with SMTP id v105so18711wrb.0
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 03:07:24 -0700 (PDT)
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
	<1501604245-33460-3-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8ArjNALptSYkR4T-SaejWPQxpazYjm-b_aCkGDFFXgnw@mail.gmail.com>
	<20170801180408.GC2471@work-vm>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170801180408.GC2471@work-vm>
Date: Mon, 07 Aug 2017 11:07:21 +0100
Message-ID: <87y3qvvgh2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 02/17]
 cpu_physical_memory_sync_dirty_bitmap: Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 1 August 2017 at 17:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >
>> > This code has an optimised, word aligned version, and a boring
>> > unaligned version.  Recently 084140bd498909 fixed a missing offset
>> > addition from the core of both versions.  However, the offset isn't
>> > necessarily aligned and thus the choice between the two versions
>> > needs fixing up to also include the offset.
>> >
>> > Symptom:
>> >   A few stuck unsent pages during migration; not normally noticed
>> > unless under very low bandwidth in which case the migration may get
>> > stuck never ending and never performing a 2nd sync; noticed by
>> > a hanging postcopy-test on a very heavily loaded system.
>> >
>> > Fixes: 084140bd498909
>> >
>> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > Reported-by: Alex BenneÃ© <alex.benee@linaro.org>
>> > Tested-by: Alex BenneÃ© <alex.benee@linaro.org>
>> >
>> > --
>> > v2
>> >   Move 'page' inside the if (Comment from Paolo)
>> > Message-Id: <20170724165125.29887-1-dgilbert@redhat.com>
>> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Something somewhere along the line seems to have mangled the
>> unicode characters in Alex's name :-(
>> Also, Alex's email address is typoed, and what should be the
>> '---' marker has been written as '--' so the below-the-fold waffle
>> is still hanging around in the commit.
>>
>> This doesn't seem worth rejecting the pull request on the
>> eve of rc1 for, but it's still a bit sad :-(
>
> Hmm yes, I think some of that's mine - the missing 'n' is certainly
> my fault; and I may have got his two 'e's in the wrong order,
> but I don't know what changed the encoding, that seems right on:
>   https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07417.html

Hmm also the acute accent should be on the second (not third) e ;-)

--
Alex Bennée
(breaking UTF-8 workflow since before it was cool)

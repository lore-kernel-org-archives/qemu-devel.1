Received: from eggs.gnu.org ([2001:4830:134:3::10]:57669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEW11-0002Mk-Ps
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEW0x-0006UM-Sy
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:24:31 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:40112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEW0x-0006UC-Ns
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:24:27 -0400
Received: by mail-ot0-x22b.google.com with SMTP id n1-v6so23621104otf.7
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 01:24:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504081628.GC18897@stefanha-x1.localdomain>
References: <d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
	<222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
	<20180503180240.GC13789@stefanha-x1.localdomain>
	<87in84c7kf.fsf@dusky.pond.sub.org>
	<20180504081628.GC18897@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 09:24:06 +0100
Message-ID: <CAFEAcA-OFC1kHGm5T9wPx-gncs2+zP3bkLTR_tf--ap_6b=8Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 May 2018 at 09:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, May 04, 2018 at 07:29:20AM +0200, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> > So to clarify, three separate steps:
>> >
>> > 1. Get rid of target-specific #ifdefs
>>
>> 1. can be incremental.  Something for
>> <https://wiki.qemu.org/Contribute/BiteSizedTasks>?
>
> Some conversions are trivial, others are not.  I think asking newcomers
> to figure out how to untangle the #ifdefs without a plan would not
> produce good results.

Yes; we have a bad track record of putting "general unfinished
conversions" into the bite-sized-tasks list and then finding
that new contributors try to tackle things that are more
subtle than the brief description makes them seem (especially
since often the unfinished parts of a conversion are the hard
parts!)

thanks
-- PMM

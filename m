Received: from eggs.gnu.org ([2001:4830:134:3::10]:48915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e2GfX-0001mI-TK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e2GfQ-0007XU-4d
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:03:27 -0400
MIME-Version: 1.0
In-Reply-To: <20171010080201.GB4177@dhcp-200-186.str.redhat.com>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
	<20171006140137.GH26575@redhat.com>
	<CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
	<e46a6b2d-83e2-d558-028c-94ad41af8fa2@redhat.com>
	<CAEfK_44_43d5_KaGUf-FH7bHxre5BP1wCQu96p38bhskUqU+Ug@mail.gmail.com>
	<87h8v7lcan.fsf@dusky.pond.sub.org>
	<20171010080201.GB4177@dhcp-200-186.str.redhat.com>
From: Doug Gale <doug16k@gmail.com>
Date: Wed, 11 Oct 2017 09:03:11 -0400
Message-ID: <CAEfK_47PVc7wZpt1KJscXb+UBHg-vFJMsSGQPi0pe+XenKrjTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, mreitz@redhat.com, keith.busch@intel.com

On Tue, Oct 10, 2017 at 4:02 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 10.10.2017 um 08:58 hat Markus Armbruster geschrieben:
>> Doug Gale <doug16k@gmail.com> writes:
>>
>> > I used exclamations as a concise way of indicating that the driver did
>> > something nonsensical, or horribly invalid, like something likely to
>> > cause a memory corruption, trying to start the controller with a
>> > nonsense configuration, providing invalid PRDs or writing to
>> > unrecognized MMIO offsets that might hang or do something extremely
>> > bad on a poorly implemented controller. Exclaiming is not shouting, I
>> > thought shouting was when it was all uppercase.
>> >
>> > If a driver might trash memory or hang a controller, maybe it should
>> > shout at the driver author or person investigating an unstable VM.
>> > None of those messages with exclamations should ever happen. If any of
>> > them are possible when the driver is correct, then I have made a
>> > mistake.
>>
>> Please do not top-quote on this mailing list.
>>
>> Existing tracepoints do not use exclamation marks to signal severity.
>>
>> Consider using assertions for "if this happens, either the program's
>> state is shot (and continuing is unsafe), or the author's mental state
>> was shot (and continuing is probably unsafe, too)" conditions.
>> Tracepoints are for tracing.
>
> Assertions are for checking that assumptions in qemu code hold true.
> Here it's about bad guest code, and you can't let qemu abort for that.
>
> Tracing is the right tool to detect bad guest code, and I think it makes
> sense to mark conditions that shouldn't happen with a correctly
> operating guest driver. I'm not sure if an exclamation mark is the best
> syntax for this, because I wouldn't have intuitively understood what
> it's supposed to tell me.
>
> If we do use the exclamation mark, we should document it somewhere
> (docs/devel/tracing.txt?) and make it a qemu-wide pattern. If not, we
> should choose something else and still document it and use it
> consistently.
>
> Kevin
>

Should I give up on indicating severity for now (removing the
exclamations) and just group together the severe ones with a comment
heading in the trace-events file?
I added "" at the end of some traces to help possibly-incorrect
parsing code find the end of the string reliably. Was that a good idea
or is it okay and expected to end them with something like PRIx64 and
drop the extra ""?
I found a few cases of missing 0x that I will fix in the next version
of this patch. Policy is to have 0x before every hex value, right?

Also, so I'm clear, when I submit the patch I should put the patch
first and put my message after the -- at the end?
And use "nvme: Add tracing" for the commit message,
And put nvme: Add tracing v3 in my subject line in a completely new
email thread?

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnPQZ-0000VC-5z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnPQW-0001Ra-1E
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:50:19 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnPQV-0001Qk-R2
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:50:15 -0400
Received: by mail-wr0-x231.google.com with SMTP id g10so102917071wrg.2
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:50:15 -0700 (PDT)
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
Date: Mon, 13 Mar 2017 12:50:29 +0000
Message-ID: <877f3tqr1m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, KVM devel mailing list <kvm@vger.kernel.org>, QEMU Developer <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 March 2017 at 21:45, Juan Quintela <quintela@redhat.com> wrote:
>>
>>
>> Hi
>>
>> Please, send any topic that you are interested in covering.
>>
>> So far the agenda is:
>>
>> - Direction of QEMU and toolstack in light of Google Cloud blog:
>>   https://cloudplatform.googleblog.com/2017/01/7-ways-we-harden-our-KVM-hypervisor-at-Google-Cloud-security-in-plaintext.html
>
>
> Ah, I'd forgotten that this was on the call agenda. I actually
> had an interesting conversation with Alex Graf last week about
> some similar topics, which I guess you could generally summarize
> as "what are the issues we need to address as a project in order
> to not become irrelevant in five years time". Since I wrote them
> up for an internal "what I did on my holi^Wconference trip" report
> I might as well repost them here:
>
>   - on the "VM support" side, QEMU is more used because it's the only
>     production-quality option in this space, rather than because its
>     users love it. (cf the Google choice to replace it.) It's also got
>     a pretty poor security record. It wouldn't be too surprising if
>     some time in the next five years somebody writes a replacement in
>     a safer language (perhaps also targeting only the VM support role)
>     and it got enough mindshare and takeup to eclipse QEMU.
>     [Is it too early/daft to think about prototyping being able to
>      write QEMU device emulation in Rust ?]

I think rust has the potential to be very interesting. I've been
watching to remacs project with interest:

  https://github.com/Wilfred/remacs

They are attempting to port Emacs to rust in a piecemeal way. Whether
this works remains to be seen but it is certainly an interesting
approach compared to other "re-write it all" approaches.

>     If the "VM support" usecase moves to another project then QEMU
>     will become a very quiet backwater...
>   - on the "emulation" side, nobody is clearly articulating a purpose
>     for QEMU, a reason why you should use it rather than other modelling
>     technologies (or rather than using real hardware). As a result the
>     efforts applied to QEMU are somewhat unfocused. Are we trying to be:
>     . a dev platform before easy h/w availability?
>       [not easy for QEMU for several reasons]
>     . a dev tool that provides better introspection into guest
>       behaviour than running on h/w?
>       [if so we should put more work into improving our introspection
>        and guest tracing capabilities!]

For example now we support atomics in the TCG it would be fairly easy* to
port something like the ThreadSanitizer (which has fairly hefty memory
requirements) as a tool for debugging system code.

>     . primarily a tool for doing automated CI testing and one-off
>       developer smoke-testing that's easier to set up and scale than
>       trying to test on real h/w?
>     . something else?
>       [your idea goes here!]
>   - in all areas our legacy code and back-compatibility requirements
>     are threatening to choke forward progress if we don't make serious
>     efforts to get on top of them
>   - there's no easy way for people to use parts of QEMU like the CPU
>     emulation, or to add their own devices without having to write lots
>     of C code (we're firmly in a "one monolithic blob of code" setup
>     right now and disentangling and setting clear API dividing lines
>     will be a lot of work)

I spoke to Edgar about posting his rports patch set as a catalyst for
discussion. Certainly for modelling hobby projects or new hardware QEMU
could do with support for rapid prototyping. Others have mentioned maybe
including a scripting language integration for device modelling -
although I still hold the view that what ever language you choose will
be the "wrong one" according to the majority of developers.

>     [Making QEMU more modular would help with defeating the legacy
>     and back-compat dragons, though]
>
> thanks
> -- PMM


--
Alex Bennée

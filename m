Received: from eggs.gnu.org ([2001:4830:134:3::10]:45992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnMo8-00085y-0t
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnMo3-0000x9-KM
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:02:28 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnMo3-0000wa-D5
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:02:23 -0400
Received: by mail-wm0-x236.google.com with SMTP id t189so35624838wmt.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:02:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tw6y8bs8.fsf@secure.mitica>
References: <87tw6y8bs8.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 11:02:01 +0100
Message-ID: <CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: KVM devel mailing list <kvm@vger.kernel.org>, QEMU Developer <qemu-devel@nongnu.org>

On 12 March 2017 at 21:45, Juan Quintela <quintela@redhat.com> wrote:
>
>
> Hi
>
> Please, send any topic that you are interested in covering.
>
> So far the agenda is:
>
> - Direction of QEMU and toolstack in light of Google Cloud blog:
>   https://cloudplatform.googleblog.com/2017/01/7-ways-we-harden-our-KVM-hypervisor-at-Google-Cloud-security-in-plaintext.html


Ah, I'd forgotten that this was on the call agenda. I actually
had an interesting conversation with Alex Graf last week about
some similar topics, which I guess you could generally summarize
as "what are the issues we need to address as a project in order
to not become irrelevant in five years time". Since I wrote them
up for an internal "what I did on my holi^Wconference trip" report
I might as well repost them here:

  - on the "VM support" side, QEMU is more used because it's the only
    production-quality option in this space, rather than because its
    users love it. (cf the Google choice to replace it.) It's also got
    a pretty poor security record. It wouldn't be too surprising if
    some time in the next five years somebody writes a replacement in
    a safer language (perhaps also targeting only the VM support role)
    and it got enough mindshare and takeup to eclipse QEMU.
    [Is it too early/daft to think about prototyping being able to
     write QEMU device emulation in Rust ?]
    If the "VM support" usecase moves to another project then QEMU
    will become a very quiet backwater...
  - on the "emulation" side, nobody is clearly articulating a purpose
    for QEMU, a reason why you should use it rather than other modelling
    technologies (or rather than using real hardware). As a result the
    efforts applied to QEMU are somewhat unfocused. Are we trying to be:
    . a dev platform before easy h/w availability?
      [not easy for QEMU for several reasons]
    . a dev tool that provides better introspection into guest
      behaviour than running on h/w?
      [if so we should put more work into improving our introspection
       and guest tracing capabilities!]
    . primarily a tool for doing automated CI testing and one-off
      developer smoke-testing that's easier to set up and scale than
      trying to test on real h/w?
    . something else?
      [your idea goes here!]
  - in all areas our legacy code and back-compatibility requirements
    are threatening to choke forward progress if we don't make serious
    efforts to get on top of them
  - there's no easy way for people to use parts of QEMU like the CPU
    emulation, or to add their own devices without having to write lots
    of C code (we're firmly in a "one monolithic blob of code" setup
    right now and disentangling and setting clear API dividing lines
    will be a lot of work)
    [Making QEMU more modular would help with defeating the legacy
    and back-compat dragons, though]

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cnihQ-0004pX-PX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cnihM-0001ku-Pr
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cnihM-0001kX-H2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:24:56 -0400
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6559d50e-b8d5-eaa2-4a14-48608644ad29@redhat.com>
Date: Tue, 14 Mar 2017 10:24:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>
Cc: QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

On 13.03.2017 11:02, Peter Maydell wrote:
> On 12 March 2017 at 21:45, Juan Quintela <quintela@redhat.com> wrote:
>>
>> Hi
>>
>> Please, send any topic that you are interested in covering.
>>
>> So far the agenda is:
>>
>> - Direction of QEMU and toolstack in light of Google Cloud blog:
>>   https://cloudplatform.googleblog.com/2017/01/7-ways-we-harden-our-KV=
M-hypervisor-at-Google-Cloud-security-in-plaintext.html
>=20
>=20
> Ah, I'd forgotten that this was on the call agenda. I actually
> had an interesting conversation with Alex Graf last week about
> some similar topics, which I guess you could generally summarize
> as "what are the issues we need to address as a project in order
> to not become irrelevant in five years time". Since I wrote them
> up for an internal "what I did on my holi^Wconference trip" report
> I might as well repost them here:
>=20
>   - on the "VM support" side, QEMU is more used because it's the only
>     production-quality option in this space, rather than because its
>     users love it. (cf the Google choice to replace it.) It's also got
>     a pretty poor security record. It wouldn't be too surprising if
>     some time in the next five years somebody writes a replacement in
>     a safer language (perhaps also targeting only the VM support role)
>     and it got enough mindshare and takeup to eclipse QEMU.
>     [Is it too early/daft to think about prototyping being able to
>      write QEMU device emulation in Rust ?]
>     If the "VM support" usecase moves to another project then QEMU
>     will become a very quiet backwater...
>   - on the "emulation" side, nobody is clearly articulating a purpose
>     for QEMU, a reason why you should use it rather than other modellin=
g
>     technologies (or rather than using real hardware). As a result the
>     efforts applied to QEMU are somewhat unfocused. Are we trying to be=
:
>     . a dev platform before easy h/w availability?
>       [not easy for QEMU for several reasons]

What reasons exactly do you mean here?
I think that this would be very useful feature, since AFAIK there is no
real good open source emulator "Lego" set available yet. We'd "just"
need a possibility to build machines on the fly instead of hard-wiring
them in the C source code...

>   - in all areas our legacy code and back-compatibility requirements
>     are threatening to choke forward progress if we don't make serious
>     efforts to get on top of them

... and don't forget all the code that is in "orphan" state since many
years... it's often hard to get patches accepted that primarily touches
files that nobody feels responsible for...

Maybe it's really time for a "spring-cleaning", break with some
compatibility cruft and do a 3.0 release afterwards ;-)

 Thomas

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXq3q-0006kP-N6
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXq3m-0006x0-7P
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:11:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXq3l-0006Yg-EA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:11:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
	<CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
	<860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com>
	<871s6kfwoo.fsf@dusky.pond.sub.org>
	<CAFEAcA_KP532BBsESjO1NuKSeefSKH7RdpCdSDLfgMCtc6D5nw@mail.gmail.com>
	<87tvjgp9wp.fsf@dusky.pond.sub.org>
	<CAFEAcA_iCUoJJdVZYsw8yhviCgp-qFPfaJP6UYZGYP_WyMzp-g@mail.gmail.com>
Date: Fri, 14 Dec 2018 17:11:03 +0100
In-Reply-To: <CAFEAcA_iCUoJJdVZYsw8yhviCgp-qFPfaJP6UYZGYP_WyMzp-g@mail.gmail.com>
	(Peter Maydell's message of "Fri, 14 Dec 2018 12:57:52 +0000")
Message-ID: <8736r0f5rc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 14 Dec 2018 at 12:31, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > On Fri, 14 Dec 2018 at 06:29, Markus Armbruster <armbru@redhat.com> wrote:
>> > I have to admit I never really understood what tweak
>> > you wanted making to the commit message. I'm happy
>> > to make it clearer: do you want to suggest a rewording?
>>
>> The commit message claims "(The only changes needed are that Linux's
>> checkpatch.pl WARN() function takes an extra argument that ours does
>> not.)"  This isn't the case.  You also dropped the kernel's "Networking
>> with an initial /*" special case.
>
> The bit of the commit message you didn't quote says
> "by backporting the relevant
> parts of the Linux kernel's checkpatch.pl. (The only changes
> needed are that Linux's checkpatch.pl WARN() function takes
> an extra argument that ours does not.)"
>
> The networking special case is not a "relevant part", which
> is why it's not in the patch. The bracketed statement applies
> to the code in the patch, not any lumps of code in the
> kernel's checkpatch that are not in the patch.

I understand you logic now.

> Anyway, I've adjusted the commit message as you suggest.
>
> Since we seem to now have consensus on the checkpatch patch,
> I'm going to put it into the "misc" pull request I'm putting
> together.

Thanks!

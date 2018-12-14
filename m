Received: from eggs.gnu.org ([2001:4830:134:3::10]:58147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXn2c-00009V-QR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXn2b-0007nK-Rx
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:58:06 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXn2b-0007kM-EU
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:58:05 -0500
Received: by mail-ot1-x342.google.com with SMTP id a11so5251196otr.10
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 04:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
	<CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
	<860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com>
	<871s6kfwoo.fsf@dusky.pond.sub.org>
	<CAFEAcA_KP532BBsESjO1NuKSeefSKH7RdpCdSDLfgMCtc6D5nw@mail.gmail.com>
	<87tvjgp9wp.fsf@dusky.pond.sub.org>
In-Reply-To: <87tvjgp9wp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 12:57:52 +0000
Message-ID: <CAFEAcA_iCUoJJdVZYsw8yhviCgp-qFPfaJP6UYZGYP_WyMzp-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 14 Dec 2018 at 12:31, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > On Fri, 14 Dec 2018 at 06:29, Markus Armbruster <armbru@redhat.com> wrote:
> > I have to admit I never really understood what tweak
> > you wanted making to the commit message. I'm happy
> > to make it clearer: do you want to suggest a rewording?
>
> The commit message claims "(The only changes needed are that Linux's
> checkpatch.pl WARN() function takes an extra argument that ours does
> not.)"  This isn't the case.  You also dropped the kernel's "Networking
> with an initial /*" special case.

The bit of the commit message you didn't quote says
"by backporting the relevant
parts of the Linux kernel's checkpatch.pl. (The only changes
needed are that Linux's checkpatch.pl WARN() function takes
an extra argument that ours does not.)"

The networking special case is not a "relevant part", which
is why it's not in the patch. The bracketed statement applies
to the code in the patch, not any lumps of code in the
kernel's checkpatch that are not in the patch.
Anyway, I've adjusted the commit message as you suggest.

Since we seem to now have consensus on the checkpatch patch,
I'm going to put it into the "misc" pull request I'm putting
together.

thanks
-- PMM

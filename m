Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKLzf-0000Kd-2H
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKLza-0007sZ-Mf
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:18:27 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:40810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cKLza-0007sS-Ct
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:18:22 -0500
Date: Fri, 23 Dec 2016 04:18:19 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <739597410.5141134.1482484699401.JavaMail.zimbra@redhat.com>
In-Reply-To: <8737hfm312.fsf@dusky.pond.sub.org>
References: <20161222155915.7232-1-pbonzini@redhat.com>
	<CAFEAcA_gQ4pMcfVevAEiY6LfoW_HzR8DARHb2QpGFEA2hTAMHw@mail.gmail.com>
	<cfe1e535-a28c-ebfa-b60f-f411a5e6cdd0@redhat.com>
	<20161222174202.GM3808@thinpad.lan.raisama.net>
	<b33af478-d0af-e450-ac89-e25ab2a5c4f9@redhat.com>
	<8737hfm312.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



----- Original Message -----
> From: "Markus Armbruster" <armbru@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Eduardo Habkost" <ehabkost@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, "Fam Zheng"
> <famz@redhat.com>, "QEMU Developers" <qemu-devel@nongnu.org>
> Sent: Friday, December 23, 2016 10:02:33 AM
> Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 22/12/2016 18:42, Eduardo Habkost wrote:
> >> On Thu, Dec 22, 2016 at 06:32:24PM +0100, Paolo Bonzini wrote:
> >>>
> >>>
> >>> On 22/12/2016 18:30, Peter Maydell wrote:
> >>>> On 22 December 2016 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>>>> This moves out of libqemustub.a those functions which can be handled
> >>>>> simply by $(call lnot), like we already do for pci-stub.c or
> >>>>> kvm-stub.c.
> >>>>> libqemustub.a keep the more complex cases where a small part of the
> >>>>> executables we build needs an implementation of a small subset of an
> >>>>> API.
> >>>>
> >>>> So why is doing it this way round better? (I don't have a strong
> >>>> opinion here, but you don't really give a rationale for this change.)
> >>>
> >>> I don't really have a strong opinion here either, hence the RFC.
> >>> However, one advantage is that it keeps things visible to the right
> >>> maintainer.
> >> 
> >> Can't we just move the files to subdirectories where they are
> >> visible to the maintainers, but keep using stub-obj-y/libqemustub
> >> to build/link them?
> >> 
> >> I find libqemustub/stub-obj-y much easier to use than manually
> >> setting obj-$(call lnot ...).
> >
> > Yes, that would work too.  It's a pity that we cannot just use weak
> > symbols, as that would work fine with obj-y.
> 
> Can you explain again why we can't use weak symbols?

Because Windows and OS X don't have full support for weak symbols.
At least as I understand it, OS X only supports "weak import" of
a symbol from a library, where if a symbol is missing _in the library_
it resolves to NULL in the program.  It doesn't support replacing a
weak definition of a function with a strong definition of the same,
and that's why we use a static library.

Paolo

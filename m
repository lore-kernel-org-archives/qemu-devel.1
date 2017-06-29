Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQZKr-0005cF-Eh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQZKo-0005DA-Nh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQZKo-0005Cq-HN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:18:14 -0400
Date: Thu, 29 Jun 2017 14:18:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629131807.GD32167@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Khem Raj <raj.khem@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Thu, Jun 29, 2017 at 10:05:13AM +0100, Peter Maydell wrote:
> On 28 June 2017 at 21:44, Khem Raj <raj.khem@gmail.com> wrote:
> > The ucontext_t type had a tag struct ucontext until now
> > but newer glibc will drop it so we need to adjust and use
> > the exposed type instead
> 
> If true this seems like a bug in glibc to break
> existing working programs, and it should be fixed there...

The glib commit message indicates it is intentional change, in order
to get POSIX compliance:

  https://sourceware.org/git/?p=glibc.git;a=commit;h=251287734e89a52da3db682a8241eb6bccc050c9

NB, other parts of QEMU like the coroutine code are already
using the 'ucontext_t' typedef, so attaining consistency across
files is good regardless of the glibc change.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

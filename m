Received: from eggs.gnu.org ([2001:4830:134:3::10]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnpBS-0005A1-16
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnpBQ-0007fp-Oh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnpBQ-0007ev-G0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:20:24 -0400
Date: Tue, 14 Mar 2017 16:20:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314162020.GT2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170314160113.GM2445@work-vm>
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Tue, Mar 14, 2017 at 04:01:14PM +0000, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > On 14 March 2017 at 09:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >> On Mon, Mar 13, 2017 at 11:02:01AM +0100, Peter Maydell wrote:
> > >> The minimum requirements for the new language:
> > >> 1. Does it support the host operating systems that QEMU runs on?
> > >> 2. Does it support the host architectures that QEMU runs on?
> > >
> > > Speaking of this, I was thinking that we should introduce
> > > a rule that for any host OS/arch we support we must have
> > > a build machine so we can at least do a compile test.
> > > For instance if you believe configure we support Solaris
> > > and AIX, but I bet they're bit-rotting. The ia64 backend
> > > has to be a strong candidate for being dumped too.
> > > Demanding "system we can test on or we drop support"
> > > would let us more clearly see what we're actually running
> > > on and avoid unnecessarily ruling things out because they
> > > don't support Itanium or AIX...
> > 
> > YES, YES and YES.
> > 
> > I demand an osX build machine NOW!!!!  Remote access is ok.
> > 
> > Now more seriously, I can (relatively easy) compile test my pull
> > requests with:
> > - linux x86 (latest fedora, but I can get an older one if needed)
> > - linux x86_64 (latest fedor,, but the same)
> > - mingw64 32bit (latest fedora, but here I have the problem that Peter
> >   uses a different crosscompiler than me)
> > - mingw64 32bit (the same)
> > 
> > But for the rest, I need to wait that somebody told me that it breaks
> > the build.  Normally it is things like size_t is 32bit instead of 64bit
> > or some stupid things like that, that are trivial to fix if I can
> > compile there before doing the pull submission.
> 
> I also do a FreeBSD VM, and grab an aarch64 and/or PPC bigendian host
> to test on.
> 
> (I could grab an ia64 host, but I don't think I could find anything
> to install on it that would be new enough for the rest of our build
> requirements).

Indeed, ia64 is a fully dead as a host architecture at this point, only
interesting as a historical curiosity. Paolo already killed ia64 KVM
host support in Linux git back in 2014.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

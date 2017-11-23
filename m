Received: from eggs.gnu.org ([2001:4830:134:3::10]:35528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHr6n-0004H7-P8
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHr6j-0008E8-P5
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:00:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eHr6j-0008Dc-H0
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:59:57 -0500
Date: Thu, 23 Nov 2017 12:59:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171123125949.GN8166@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
	<20171123130908.6ab004d3.cohuck@redhat.com>
	<b3b9837e-c6b0-d718-faaf-1ef198256634@redhat.com>
	<20171123133924.60e9f616.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171123133924.60e9f616.cohuck@redhat.com>
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, sergio.g.delreal@gmail.com, alex@alex.org.uk

On Thu, Nov 23, 2017 at 01:39:24PM +0100, Cornelia Huck wrote:
> On Thu, 23 Nov 2017 13:26:14 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 23/11/2017 13:09, Cornelia Huck wrote:
> > > On Thu, 23 Nov 2017 13:05:33 +0100
> > > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >   
> > >> On 23/11/2017 12:57, Thomas Huth wrote:  
> > >>> On 23.11.2017 12:17, Paolo Bonzini wrote:    
> > >>>> On 23/11/2017 11:57, Thomas Huth wrote:    
> > >>> [...]    
> > >>>>> I've put "--accel kvm:hax:tcg" also on the doable list since I don't
> > >>>>> remember any objections to that idea so far -- feel free to move it to
> > >>>>> the controversial list instead if you think it needs more discussion.    
> > >>>>
> > >>>> "hax" is very far from feature parity with TCG, it doesn't even support
> > >>>> CPUID (-cpu).  "-accel kvm:hvf:tcg" could be a possibility, but only if
> > >>>> we have resources to test it.  As far as I know the only active x86
> > >>>> developer who owns a Mac is Igor?    
> > >>>
> > >>> hvf hasn't been merged yet ... do you expect it to hit master after 2.11
> > >>> has been released?    
> > >>
> > >> Yes, more or less.
> > >>  
> > >>> Otherwise, we should maybe rather simply go with
> > >>> "--accel kvm:tcg"?    
> > >>
> > >> Yes, HVF can come later.  
> > > 
> > > This switch sounds like something we can easily do for the next
> > > release; I'd hope that anyone explicitly requiring tcg already
> > > specifies it.  
> > 
> > I seriously doubt that.  Most people are probably using a
> > distro-provided qemu-kvm script for KVM, and qemu-system-x86_64 for TCG.
> >  In fact, that is probably the best of both worlds for anybody who
> > doesn't compile its own QEMU; and since KVM is Linux-only, there are
> > very few non-developers in the intersection of "compile its own QEMU"
> > and "use KVM".
> 
> I'm wondering how many people want to run e.g. x86_64-on-x86_64
> _without_ using an available kvm (and I expect those people to
> explicitly specify tcg).

Libvirt at least always explicitly gives an --accel option, so the
question is only for people who directly run qemu.


> > And in fact that is the main reason why have never bothered switching
> > the default... only RHEL does it, because it ships the QEMU binary as
> > qemu-kvm rather than qemu-system-xxx plus a wrapper script.
> > 
> > Perhaps we could:
> > 
> > 1) look for "qemu-{kvm,hvf,hax}" in argv[0] and change the "-accel" default?
> > 
> > 2) change "make install" to install one or more of qemu-kvm/hvf/hax
> > based on target architecture and OS.
> > 
> > Then distros can do away with the script and Windows/Mac users can learn
> > to use qemu-hvf and qemu-hax.
> 
> I'm not sure I like that. For me, qemu-kvm comes with the connotation
> of "there used to be a fork of qemu for kvm usage, and we stuck with
> the name because it is likely scattered through scripts".

Yes, qemu-kvm is a historical artifact in Fedora solely because of the
previous fork. We can't easily get rid of it because the path is encoded
in libvirt XML files and countless end user scripts/configs.

In RHEL it exists for similar historical reasons, but we explicitly want
to keep it, since RHEL only ships KVM, this allows people to optionally
install a full QEMU for TCG usage in parallel.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

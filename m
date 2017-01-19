Received: from eggs.gnu.org ([2001:4830:134:3::10]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUHbi-0001J2-VH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUHbf-0005Gg-6s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:38:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cUHbf-0005GL-0t
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:38:43 -0500
Date: Thu, 19 Jan 2017 18:38:36 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170119183836.GK16641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<20170119175003.GJ16641@redhat.com>
	<CAFEAcA9HEp+-JvtA49NRUWpA2LsOOLw+SaA-knS5x9=bn89UjQ@mail.gmail.com>
	<20170119183145.GP3491@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170119183145.GP3491@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 19, 2017 at 04:31:45PM -0200, Eduardo Habkost wrote:
> On Thu, Jan 19, 2017 at 06:22:40PM +0000, Peter Maydell wrote:
> > On 19 January 2017 at 17:50, Daniel P. Berrange <berrange@redhat.com> wrote:
> > > On Mon, Jan 16, 2017 at 05:54:52PM -0200, Eduardo Habkost wrote:
> > >> Change the meaning of "-cpu host" to "enable all features
> > >> supported by the accelerator in the current host", so that it can
> > >> be used to enable/query all features supported by TCG.
> > >>
> > >> To make sure "host" is still at the end of the list in "-cpu
> > >> help", add a "ordering" field that will be used when sorting the
> > >> CPU model list.
> > >
> > > To be clear, "-cpu host" for TCG is not talking about the actual
> > > host OS feature support, right ? x86_64 TCG can be run on a ppc host,
> > > so presumably "-cpu host" just means "all features that this TCG binary
> > > is able to emulate" ?
> > >
> > > This feels like it is introducing scope for confusion vs KVM -cpu host,
> > > so I wonder if different naming is better for this.
> > 
> > The idea is that you do want an option that works whatever the
> > accelerator is, though, so as a user you don't need to worry
> > about messing with the command line for KVM vs TCG vs "try
> > KVM and fall back to TCG". (I think "-cpu best" has been thrown about
> > as a suggestion for this before.)
> 
> "-cpu best" has been proposed with different semantics before:
> one meant "select the the best CPU model from the builtin table",
> and another that's equivalent to the meaning of "host" in this
> patch.
> 
> s390x uses "max CPU model" internally to represent a CPU model
> that has all supported features enabled.
> 
> If "-cpu host" is not a good name, I suggest "-cpu max".

Yeah, I think "-cpu max" better describes the intended semantics for this
with TCG. I guess for KVM  -cpu host & -cpu max would be equivalent.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fj2ZT-0003kg-NB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fj2ZP-0007aJ-TG
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:14:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fj2ZP-0007ZG-MV
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:14:11 -0400
Date: Fri, 27 Jul 2018 14:14:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180727131406.GH17836@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717195028.GA6691@localhost.localdomain>
	<CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
	<87a7qnk9qa.fsf@dusky.pond.sub.org>
	<20180727130317.GE28555@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727130317.GE28555@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Jul 27, 2018 at 02:03:17PM +0100, Stefan Hajnoczi wrote:
> On Thu, Jul 19, 2018 at 08:42:05AM +0200, Markus Armbruster wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > 
> > > On 17 July 2018 at 20:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Instead, we've repeatedly wasted time on debating which kind of ugly we
> > hate less, and all we can show for our troubles is CODING_STYLE.  Which
> > leaves a whole lot more questions open than it answers, so we can keep
> > enjoying style debates.
> > 
> > That the code shows anything resembling consistency at all is a
> > testament to humanity's yearning for order within a chaotic world.
> 
> Going back to something concrete after this nice philosophical musing:
> 
> The coding style checker (checkpatch.pl) seems like a huge success to
> me.  Without it, achieving consistency is futile.
> 
> checkpatch.pl defines the true coding style of QEMU - the subset that
> can be automatically checked by patchew.  If we want to follow a coding
> style, implementing the rules in checkpatch.pl is important.

Sadly that is not enough and arguably making life worse in some ways.

The core problem is that we never change any existing code to follow
the coding style rules we add. We only require new code to use it. We
have plenty of code that goes years between being touched by a patch,
so we've got countless different coding styles present across the
source tree. What's worse is that when submitting new patches, you have
to merge unrelated style cleanup changes into your functional changes,
just so the patch can pass checkpatch.pl, or go back & clean up enough
of the existing code in a separate patch, so that your patch doesn't
trigger a checkpatch.pl violation :-(

I wish we'd do a blanket cleanup to get the entire codebase passing
checkpatch. Despite the downside that it'd create a conflict point
in the history for people cherry-picking to older branches in the short
term, I think it would be a net win over the long term (3+ years) to
actually have a real coding style that is consistently followed.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

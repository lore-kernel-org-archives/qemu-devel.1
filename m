Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSJH5-0003Au-BY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSJH2-0004Dm-6Q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:38:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSJH2-0004Di-1A
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:38:04 -0400
Date: Mon, 11 Jun 2018 10:38:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180611093800.GH11636@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
	<CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Keno Fischer <keno@juliacomputing.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>

On Mon, Jun 11, 2018 at 09:52:55AM +0100, Peter Maydell wrote:
> On 11 June 2018 at 08:56, Markus Armbruster <armbru@redhat.com> wrote:
> > You're not printing $strchrnul like we print other configuration
> > results.  Hmm, we're not printing several of them.  Question for
> > maintainers (MAINTAINERS doesn't have any, so I'm cc'ing the top three
> > coughed up by get_maintainer.pl): bug or feature?  If feature, how do we
> > decide what to print?
> 
> If we printed everything that we tested for then the output would
> be unhelpfully enormous. My view is that we should print the
> "interesting" things for the user, ie the higher-level things
> that the user could potentially turn on by installing more
> libraries or has turned off explicitly or whatever. Reporting
> whether the host OS has strchrnul or whether we've had to
> provide our own implementation is doubly uninteresting:
>  * there's nothing the user could do to change this
>  * there is no visible effect (missing features, worse performance)
> 
> There's an argument that we should also log every config check
> result somehow (I think autoconf configures do this), but I
> don't think that our 'print stuff to stdout' is the right place
> for that.

If you look at most non-trivial apps using autoconf, they have soo many
checks printed out, that they end up having to manually print out a
summary of the "important stuff" at the end so users can actually see
something they have a chance of reading.   QEMU's configure output
is essentially equivalent to this summary data, which is good.

It is sometimes useful to know the answer of individual checks, but
if we really wanted todo that, we should just create a logfile for
that info, or just write more into our existing config.log file.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

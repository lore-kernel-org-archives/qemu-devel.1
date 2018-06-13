Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSygE-0007wD-4B
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSygA-000280-W4
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:50:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSygA-00027c-RX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:50:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
	<CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
Date: Wed, 13 Jun 2018 07:50:44 +0200
In-Reply-To: <CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 11 Jun 2018 09:52:55 +0100")
Message-ID: <87tvq7kzez.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On 11 June 2018 at 08:56, Markus Armbruster <armbru@redhat.com> wrote:
>> You're not printing $strchrnul like we print other configuration
>> results.  Hmm, we're not printing several of them.  Question for
>> maintainers (MAINTAINERS doesn't have any, so I'm cc'ing the top three
>> coughed up by get_maintainer.pl): bug or feature?  If feature, how do we
>> decide what to print?
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

Care to clean out out existing "uninteresting" prints?

> There's an argument that we should also log every config check
> result somehow (I think autoconf configures do this), but I
> don't think that our 'print stuff to stdout' is the right place
> for that.

Makes sense.  Volunteers?

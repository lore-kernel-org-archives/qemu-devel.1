Received: from eggs.gnu.org ([2001:4830:134:3::10]:33759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSIZi-0003hy-2M
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSIZh-0004Tu-DE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:53:18 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSIZh-0004Tg-7Y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 04:53:17 -0400
Received: by mail-oi0-x243.google.com with SMTP id c6-v6so16074660oiy.0
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 01:53:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvq9lps3.fsf@dusky.pond.sub.org>
References: <1528653731-4920-1-git-send-email-keno@juliacomputing.com>
	<87tvq9lps3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 09:52:55 +0100
Message-ID: <CAFEAcA9XiuToz7pCEOysL-Hz1HvVyaMyeXV-yJi1xpHgdycLiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Keno Fischer <keno@juliacomputing.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11 June 2018 at 08:56, Markus Armbruster <armbru@redhat.com> wrote:
> You're not printing $strchrnul like we print other configuration
> results.  Hmm, we're not printing several of them.  Question for
> maintainers (MAINTAINERS doesn't have any, so I'm cc'ing the top three
> coughed up by get_maintainer.pl): bug or feature?  If feature, how do we
> decide what to print?

If we printed everything that we tested for then the output would
be unhelpfully enormous. My view is that we should print the
"interesting" things for the user, ie the higher-level things
that the user could potentially turn on by installing more
libraries or has turned off explicitly or whatever. Reporting
whether the host OS has strchrnul or whether we've had to
provide our own implementation is doubly uninteresting:
 * there's nothing the user could do to change this
 * there is no visible effect (missing features, worse performance)

There's an argument that we should also log every config check
result somehow (I think autoconf configures do this), but I
don't think that our 'print stuff to stdout' is the right place
for that.

thanks
-- PMM

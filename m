Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dXqg7-0002Lz-SI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dXqg7-0002Au-1s
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:14:19 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dXqg6-00029d-SH
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:14:18 -0400
Date: Wed, 19 Jul 2017 17:14:16 +0200 (CEST)
From: Stefan Fritsch <sf@sfritsch.de>
In-Reply-To: <4267b3f1-02d2-0342-f964-956ed8fe1f63@redhat.com>
Message-ID: <alpine.DEB.2.11.1707191711180.10642@manul.sfritsch.de>
References: <20170611074817.13621-1-sf@sfritsch.de>
	<4267b3f1-02d2-0342-f964-956ed8fe1f63@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 19 Jul 2017, Thomas Huth wrote:
> On 11.06.2017 09:48, Stefan Fritsch wrote:
> > Sending a break on a serial console can be useful for debugging the
> > guest. But not all chardev backends support sending breaks (only telnet
> > and mux do). The chardev-send-break command allows to send a break even
> > if using other backends.
> > 
> > Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> > Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> > v2: added tests and Acked-by line
> [...]
> > diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> > index 99e35ec15a..6dfa0c36e2 100644
> > --- a/tests/test-hmp.c
> > +++ b/tests/test-hmp.c
> > @@ -22,6 +22,7 @@ static int verbose;
> >  static const char *hmp_cmds[] = {
> >      "boot_set ndc",
> >      "chardev-add null,id=testchardev1",
> > +    "chardev-send-break testchardev2",
> >      "chardev-remove testchardev1",
> >      "commit all",
> >      "cpu-add 1",
> 
> Did you use "testchardev2" here on purpose, or should that have been a
> "testchardev1" instead? "testchardev2" is not a valid identifier in the
> HMP test, so this might not exercise the code path that you might have
> intended?

You are right, this should have been "testchardev1". Actually, one could 
do both, which would then exercise two different code paths.

Cheers,
Stefan

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7eFP-0003im-3j
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7eFK-00054o-9N
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:42:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d7eFK-00054M-3H
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:42:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493726062-31743-1-git-send-email-thuth@redhat.com>
	<20170505144837.GB14316@stefanha-x1.localdomain>
	<20170505145049.GM12773@redhat.com>
Date: Mon, 08 May 2017 10:42:18 +0200
In-Reply-To: <20170505145049.GM12773@redhat.com> (Daniel P. Berrange's message
	of "Fri, 5 May 2017 15:50:49 +0100")
Message-ID: <871srz7n9x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Mark legacy option '-no-kvm' as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Fri, May 05, 2017 at 03:48:37PM +0100, Stefan Hajnoczi wrote:
>> On Tue, May 02, 2017 at 01:54:22PM +0200, Thomas Huth wrote:
>> > '-no-kvm' was just a legacy convenience option for the users of
>> > qemu-kvm, it never made sense in the normal QEMU tree since TCG is
>> > the default here anyway. The option has also never been specified
>> > in the QEMU docs and in the '--help' list, so likely hardly anybody
>> > knows about this option at all. I think we could get rid of this
>> > without bothering anybody nowadays, but just in case, let's print
>> > out a warning for a couple of releases first.
>> > 
>> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>> > ---
>> >  vl.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/vl.c b/vl.c
>> > index d5ec87e..2d44621 100644
>> > --- a/vl.c
>> > +++ b/vl.c
>> > @@ -3709,7 +3709,9 @@ int main(int argc, char **argv, char **envp)
>> >                      exit(1);
>> >                  }
>> >                  break;
>> > -             case QEMU_OPTION_no_kvm:
>> > +            case QEMU_OPTION_no_kvm:
>> > +                error_report("'-no-kvm' is depreacted, please use "
>> 
>> s/depreacted/deprecated/
>
> Should we have an dedicated  'error_deprecated(oldfeat, newfeat)' method
> that prints a standardized message, as well as a -no-deprecated flag that

I hate flags starting with "no".  What about something like
--suppress-deprecation-warnings?

> turns off all the deprecation warnings. There's nothing more annoying than
> an application that insists on spewing warnings to stdout that you know
> about, but aren't in a position to address any time soon.

If we do that, we should consider having the warnings tell users how to
suppress them, say "You can suppress this warning with
--suppress-deprecation-warnings".

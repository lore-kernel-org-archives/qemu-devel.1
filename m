Received: from eggs.gnu.org ([2001:4830:134:3::10]:37085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu04V-0004vy-Qe
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu04U-0006GW-JJ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:10:47 -0400
Date: Fri, 31 Mar 2017 14:10:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170331171039.GB3709@thinpad.lan.raisama.net>
References: <1490965980-513-1-git-send-email-peter.maydell@linaro.org>
	<5979a675-6077-50f8-0714-7e509a9bc492@amsat.org>
	<20170331134033.GY3709@thinpad.lan.raisama.net>
	<20170331161839.GA18974@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170331161839.GA18974@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/parallels.c: avoid integer overflow
 in allocate_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Fri, Mar 31, 2017 at 05:18:39PM +0100, Stefan Hajnoczi wrote:
> On Fri, Mar 31, 2017 at 10:40:33AM -0300, Eduardo Habkost wrote:
> > On Fri, Mar 31, 2017 at 10:27:44AM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Hi,
> > >=20
> > > Eduardo you seem skilled regarding Coccinelle scripts, is it possib=
le to
> > > write one to find those overflows?
> >=20
> > Probably not. AFAIK, Coccinelle rules are based on local code
> > syntax only. This means it doesn't know the data type of
> > expressions like (s->tracks).
>=20
> I'm surprised by that statement.  Coccinelle isn't a text matcher, it's
> a proper C compiler frontend that parses the all code in the compilatio=
n
> unit.  Therefore it must have the type information even for s->tracks.

You are probably not wrong about it not being just a text
matcher. But I'm not sure about it being able to have type
information for s->tracks. The documentation isn't clear about
that.

The 'idexpression' declarations seems to accept some kind of C
type annotations (I didn't know that!), but the documentation
also says: "A more complex description of a location, such as
a->b is considered to be an expression, not an idexpression".
And 'expression' metavariables don't seem to support type
annotations.

My impression is that Coccinelle has limited support to
understand simple variable declarations, but not the full set of
C type declarations and type system rules that would allow it to
figure out the type of an expression like s->tracks.

But I really hope to be wrong, because that would be very useful. :)

> Disclaimer: This should in no way be considered a volunteer offer to
> write cocci scripts now or at any time in the future :).  I'm not fluen=
t
> in the semantic patch syntax.

I don't believe there's anybody in the world fluent in the SmPL
syntax. Maybe its authors are, but I wouldn't be so sure. :)

--=20
Eduardo

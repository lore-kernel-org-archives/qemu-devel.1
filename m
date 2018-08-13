Received: from eggs.gnu.org ([2001:4830:134:3::10]:44003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1H2-0005yq-Qn
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1Gy-0008So-Rj
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:03:56 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fp1Gy-0008SZ-Kb
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:03:52 -0400
Date: Mon, 13 Aug 2018 02:03:40 +0100
From: Julian Brown <julian@codesourcery.com>
Message-ID: <20180813020340.77c80175@squid.athome>
In-Reply-To: <93a94aa5-2143-8079-3e0c-02364d0fab22@codesourcery.com>
References: <cover.1526671191.git.julian@codesourcery.com>
	<845fc301f4a7725c239708c58876e3ae4d858fd9.1526671191.git.julian@codesourcery.com>
	<805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de>
	<20180518211928.488214aa@octopus>
	<08f92788-6380-35fe-e237-aa80f075519e@codesourcery.com>
	<93a94aa5-2143-8079-3e0c-02364d0fab22@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>, Andrew Jenner <Andrew_Jenner@mentor.com>

On Thu, 2 Aug 2018 15:56:47 -0600
Sandra Loosemore <sandra@codesourcery.com> wrote:

> On 05/18/2018 03:35 PM, Sandra Loosemore wrote:
> > On 05/18/2018 02:19 PM, Julian Brown wrote: =20
> >> On Fri, 18 May 2018 21:52:04 +0200
> >> Marek Vasut <marex@denx.de> wrote:
> >> =20
> >>> On 05/18/2018 09:23 PM, Julian Brown wrote: =20
> >>>> This patch (by Sandra Loosemore, mildly rebased) adds support for
> >>>> semihosting for Nios II bare-metal emulation.
> >>>>
> >>>> Signed-off-by: Julian Brown <julian@codesourcery.com>
> >>>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com> =20
> >>>
> >>> Is there some documentation for this stuff ? It looks
> >>> interesting, but how can I try it here ? =20
> >>
> >> There's no documentation AFAIK apart from that the entry points are
> >> the same as m68k, semihosting is invoked with "break 1", and r4/r5
> >> are used for passing arguments. I'm not actually sure how you can
> >> try this stuff without our startup code or other infrastructure
> >> (that I'm pretty sure we can't divulge). Sandra, any ideas? =20
> >=20
> > I don't see any reason why we couldn't contribute libgloss support,=20
> > except that I don't have time to write such a BSP right now.=C2=A0 :-(
> > I recently did this for C-SKY, though, and the semihosting parts
> > were just a straightforward copy from the m68k port. =20
>=20
> I've posted a patch with libgloss semihosting support for nios2 here:
>=20
> https://sourceware.org/ml/newlib/2018/msg00610.html
>=20
> I hope this is enough to unblock consideration of the corresponding
> QEMU patch set now.  Here's a link to the original patch posting:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04571.html

For completeness I've re-tested with a rebased QEMU and posted
again (with a couple of checkpatch.pl nits fixed, but otherwise
identical):

http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg01987.html

Thank you,

Julian

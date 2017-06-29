Received: from eggs.gnu.org ([2001:4830:134:3::10]:32970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQhKd-000470-3n
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQhKa-0005yh-2j
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:50:35 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQhKZ-0005wv-M7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:50:31 -0400
Date: Thu, 29 Jun 2017 17:50:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629215028.GA9797@flamenco>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838167780.6497.10644158789800844637.stgit@frigg.lan>
	<20170626181451.GH17935@flamenco> <87vangcq5g.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vangcq5g.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v9 06/26] target: [tcg,
 i386] Port to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 28, 2017 at 14:23:07 +0300, Lluís Vilanova wrote:
> Emilio G Cota writes:
> 
> > On Sun, Jun 25, 2017 at 12:07:57 +0300, Lluís Vilanova wrote:
> >> Incrementally paves the way towards using the generic instruction translation
> >> loop.
> >> 
> >> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> > Just a minor nit: the commit titles are a little strange to me.
> > I'd rather do: "target/arch: foo" than "target: [tcg, arch]: foo" --
> > it's less characters ("tcg" is redundant) and seems more in line with
> > qemu's idioms.
> 
> Is tcg redundant? I thought it was necessary for differentiating it from the kvm
> target-specific parts.

In most cases it is redundant -- anyway my point is that "targer/foo"
will be enough to get the right eyes on the patch.

Cheers,

		E.

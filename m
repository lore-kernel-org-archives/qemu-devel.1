Received: from eggs.gnu.org ([2001:4830:134:3::10]:47967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPYO8-0004Pe-75
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPYO7-0000YJ-5w
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:05:28 -0400
Date: Mon, 26 Jun 2017 14:05:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170626180518.GE17935@flamenco>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838143590.6497.11184953059640962891.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149838143590.6497.11184953059640962891.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v9 05/26] target: [tcg] Redefine DISAS_*
 onto the generic translation framework (DJ_*)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alexander Graf <agraf@suse.de>, "open list:ARM" <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Sun, Jun 25, 2017 at 12:03:56 +0300, Lluís Vilanova wrote:
> Temporarily redefine DISAS_* values based on DJ_TARGET. They should
> disappear as targets get ported to the generic framework.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc)
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com> (i386)
> Acked-by: Laurent Vivier <laurent@vivier.eu> (m68k)
> Reviewed-by: Alex Benée <alex.benee@linaro.org> (arm)

Why don't we just keep DISAS_* instead? That will simplify diffs (i.e.
no need to eventually convert anything to DJ_*), and really DISAS_NEXT
makes more sense than DJ_NEXT. You can define a few generic DISAS_foo's,
plus DISAS_TARGET that the existing DISAS_* can build from.

Also, IMO DJ is a poor choice for an acronym. Am I the only one
immediately thinking of 'disc jockey'? =)

		E.

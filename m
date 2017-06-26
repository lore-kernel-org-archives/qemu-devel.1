Received: from eggs.gnu.org ([2001:4830:134:3::10]:48786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPYRJ-00068x-G7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPYRI-0002n0-HP
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:08:45 -0400
Date: Mon, 26 Jun 2017 14:08:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170626180839.GF17935@flamenco>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838409778.6497.16277162983730521098.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149838409778.6497.16277162983730521098.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v9 16/26] target: [tcg,
 arm] Replace DISAS_* with DJ_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Sun, Jun 25, 2017 at 12:48:17 +0300, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/arm/translate-a64.c |   58 ++++++++++++++--------------
>  target/arm/translate.c     |   90 ++++++++++++++++++++++----------------------
>  target/arm/translate.h     |   24 ++++++------
>  3 files changed, 87 insertions(+), 85 deletions(-)

I'd do arm and a64 patches separately; much better for bisectability.

The DisasContextBase patch cannot be split up, obviously.

		E.

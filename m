Received: from eggs.gnu.org ([2001:4830:134:3::10]:56349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dTVyS-0004hk-M4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dTVyS-0000Gf-0N
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:19:20 -0400
Date: Fri, 7 Jul 2017 12:19:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170707161913.GA16183@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865801156.17063.15618379976159104550.stgit@frigg.lan>
	<244b5aab-8863-3139-f252-09cc02333eda@twiddle.net>
	<87inj4ebqn.fsf@frigg.lan>
	<c35a41d9-4c9d-3daf-2759-17a784b8711b@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35a41d9-4c9d-3daf-2759-17a784b8711b@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v11 24/29] target/arm: [tcg,
 a64] Port to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, Jul 07, 2017 at 05:46:19 -1000, Richard Henderson wrote:
> I do wonder if we should provide a generic empty hook, so that a target that
> does not need a particular hook need not define an empty function.  It could
> just put e.g. "translator_noop" into the structure.  Ok, maybe a better name
> than that...

NULL would serve that purpose well. The subsequent "if (hook)" branch
would be essentially free because it'd be trivially predicted.

		E.

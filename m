Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e1dfj-0007Ze-By
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e1dfe-0001Th-Q9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:25:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e1dfe-0001SQ-JB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:24:58 -0400
Date: Mon, 9 Oct 2017 15:24:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171009192455.GA27135@flamenco>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
	<20170829211649.GA9108@flamenco>
	<CAJhHMCAwpMHAiOeBZ+F2c0yKFPQxU3nU7+FGf75wOqFnYEc43w@mail.gmail.com>
	<20170922204018.GA23631@flamenco>
	<00656f91-760f-c46f-86dc-6c0d29192b3b@linaro.org>
	<20171005232416.GA23670@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005232416.GA23670@flamenco>
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani+qemu@gmail.com>

On Thu, Oct 05, 2017 at 19:24:16 -0400, Emilio G. Cota wrote:
> I'm including the fixups below.

Just pushed v5 of this series. I rebased the series on top of the current master,
and added the already mentioned fixes plus a new one (see below).

Grab the patches from:
  https://github.com/cota/qemu/tree/multi-tcg-v5

Changes since v4:
- Rebase to current master. (fixed a few conflicts, mostly due to some targets
  having been converted to the generic translation loop.)
- Add the removal of CF_COUNT_MASK as a separate "FIXUP" commit to signal
  that this still requires attention.
- Fix tb TC comparison function to support deletions (otherwise -icount breaks)
- [new fix] TCG regions: Rely on max_cpus instead of smp_cpus. Otherwise we'd
  break CPU hotplug on targets that support it. (max_cpus and smp_cpus are
  set from the command line with -smp foo,maxcpus=bar; max_cpus is always
  >= smp_cpus.)

Thanks,

		Emilio

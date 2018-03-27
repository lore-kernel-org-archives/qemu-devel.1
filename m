Received: from eggs.gnu.org ([2001:4830:134:3::10]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0ljs-0005ye-VM
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0ljp-00012F-7O
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:22:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f0ljp-00011C-3C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:21:57 -0400
Date: Tue, 27 Mar 2018 11:21:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180327102148.GI4005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
	<CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
	<CAHNT7NsWALp1eehZ7YNX3eGFemh94YCNKBwxjqUOjEAheBV5iA@mail.gmail.com>
	<CAHNT7NuzZY8MgAtDjokbN8MMtHV=oFnrSnXj2xAzDF_uXd=4jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHNT7NuzZY8MgAtDjokbN8MMtHV=oFnrSnXj2xAzDF_uXd=4jg@mail.gmail.com>
Subject: Re: [Qemu-devel] [patches] Re: [PATCH v6 00/26] RISC-V: Fixes and
 cleanups for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Mar 26, 2018 at 04:45:34PM -0700, Michael Clark wrote:
> I've made a tag for the series including the fixes from my own review
> during the weekend (one logic fix and 2 comment of commit log typos, and a
> patch hunk in the wrong commit):
> 
> - https://github.com/riscv/riscv-qemu/releases/tag/riscv-qemu-2.12-fixes-v7
> 
> That said, if you want important or critical fixes only, then i'd suggest
> these at least these 3:
> 
> I R [PATCH v6 22/26] RISC-V: Convert cpu definition towards future model
> I - [PATCH v6 25/26] RISC-V: Fix incorrect disassembly for addiw
> X - [PATCH v6 26/26] RISC-V: Workaround for critical mstatus.FS MTTCG bug
> 
> The other patches are the 23 patches which were accidentially included in
> the initial pull on March 8, now with Signed-off-by, less the one that
> Paolo asked me to drop.
> 
> Most of the bugs are relatively innocuous except for the mstatus.FS fix.
> Linux boots on upstream QEMU but has FPU register file corruption when SMP
> is enabled.

Even innocuous bug fixes are still welcome before rc2 is released.

> I need advice as to which fixes you want to have included in QEMU 2.12. I'm
> not sure if the reviewed set is the right set as it excludes 25/26 and more
> importantly 26/26.

We've got rc1 now, but you can still send pull requests for pretty much
any kind of bug fix to get into the rc2 release, assuming the patches have
a Reviewed-by, and are not excessively complicated or likely to cause
regressions.

After rc2 is out you want to only be sending important bug fixes, that
users cannot wait for.

After rc3 is out, ideally we won't find any more important bugs that
need fixing. A bug would have to be really severe to justify including
at that stage.

Based on your description, patches 22/25/26 definitely still welcome
in a pull request before rc2 or rc3. The more innocuous patches can
also still be sent if you can do send a pull request for them pretty
much straightaway before rc2. You'll obviously need to chase reviews
for the few that miss them still.

We're slightly unlucky in this release that the time between rc1 and
rc2 falls over Easter weekend and Peter is on holiday, so has pretty
limited time for dealing with pull requests. So you want to do what
you can to minimize the work that Peter has to do, and minimize risk
that a patch will fail build or automated testing, as that risks
having the PR rejected. This is why it is worth sending patches in
smaller groups. If you sent 20 patches at once and the last one
fails, all 20 patches get rejected. If you send two batches of 10
you would at least get some of them off your plate, even if they
are innocuous fixes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

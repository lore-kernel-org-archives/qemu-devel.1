Received: from eggs.gnu.org ([2001:4830:134:3::10]:49896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEVim-0005az-3b
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEVii-0002AM-8t
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fEVii-00029n-1u
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:36 -0400
Date: Fri, 4 May 2018 10:05:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180504100533.3d0de9e5@redhat.com>
In-Reply-To: <CAFEAcA8TOLjW7aEniG4EhBPF-_mCWWzdJL58SjC915Ket2PfZw@mail.gmail.com>
References: <1525176522-200354-5-git-send-email-imammedo@redhat.com>
	<1525182297-205763-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA8TOLjW7aEniG4EhBPF-_mCWWzdJL58SjC915Ket2PfZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/5] arm: boot: set boot_info starting
 from first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 3 May 2018 16:03:09 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 1 May 2018 at 14:44, Igor Mammedov <imammedo@redhat.com> wrote:
> > Even though nothing is currently broken (since all boards
> > use first_cpu as boot cpu), make sure that boot_info is set
> > on all CPUs.
> > If some board would like support heterogenuos setup (i.e.
> > init boot_info on subset of CPUs) in future, it should add
> > a reasonable API to do it, instead of starting assigning
> > boot_info from some CPU and till the end of present CPUs
> > list.  
> 
> It's a bit confusing to only send one patch rather than the
> whole set -- our automated patch application and testing
> tooling gets confused. I noticed this one by chance because
> I was skimming the commit log for v3 and noticed that it was
> missing this text. If the change had been in code rather than
> in the commit message I would probably not have picked it up...
I wanted to not to spam too much list with respin of whole series
for commit message fixup, sending fixed up vX as reply is usually
ok for x86 trees but it's up to a maintainer preference.
Next time for fixups, I'll respin whole series if it's intended
to go via ARM tree.

> thanks
> -- PMM

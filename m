Received: from eggs.gnu.org ([2001:4830:134:3::10]:36952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewv2H-0003cD-9C
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewv2E-00075v-IZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewv2E-00074j-DL
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:29:02 -0400
Date: Fri, 16 Mar 2018 16:28:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180316192854.GM3417@localhost.localdomain>
References: <20180315181420.8694-1-ehabkost@redhat.com>
	<CAFEAcA9itE11dUF-Z22M13XT2_sgr0vgDPAsJ_QhUvdT07L5nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9itE11dUF-Z22M13XT2_sgr0vgDPAsJ_QhUvdT07L5nQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 0/7] Machine queue, 2018-03-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Fri, Mar 16, 2018 at 07:05:29PM +0000, Peter Maydell wrote:
> On 15 March 2018 at 18:14, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Changes in v2 (v1 was 2018-03-12):
> > * Fix bsd-user build error
> >
> > The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f24b:
> >
> >   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-130318-1' into staging (2018-03-15 14:48:09 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to 7cbb6fd8926b9b590c0725b9b7d0a11db6aefd08:
> >
> >   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-15 14:52:40 -0300)
> >
> > ----------------------------------------------------------------
> > Machine queue, 2018-03-15
> >
> 
> Hi. This produces several warning messages running make check:
> 
> WARNING: cpu name for target 'riscv32' isn't defined, add it to cpus_map
> WARNING: cpu name for target 'riscv64' isn't defined, add it to cpus_map

Ouch, another conflict with the commits that added target/riscv
after the original series was submitted.  :(

I will drop all the patches in this pull request except for the
only bug fix there ("pc: correct misspelled CPU model-id for pc
2.2").

Igor, can you resubmit the cpu_model/cpu_type series fixing the
warnings so I can queue it for v2.13?

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6ywy-0004AC-Ev
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6ywx-0003S7-O9
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:41:12 -0400
Date: Fri, 13 Apr 2018 15:41:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180413154100.1731a448@redhat.com>
In-Reply-To: <CAFEAcA9LVUfmHGor=OmnXf0Dhj5zP_e++WELKwtx0Ru7VcRA-g@mail.gmail.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
	<1523551221-11612-2-git-send-email-imammedo@redhat.com>
	<CAFEAcA9LVUfmHGor=OmnXf0Dhj5zP_e++WELKwtx0Ru7VcRA-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 1/4] arm: reuse
 arm_boot_address_space() in armv7m_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On Thu, 12 Apr 2018 19:22:13 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 April 2018 at 17:40, Igor Mammedov <imammedo@redhat.com> wrote:
> > reduce code duplication by resusing arm_boot_address_space()
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/arm/arm.h |  2 ++
> >  hw/arm/armv7m.c      | 10 +---------
> >  hw/arm/boot.c        | 16 ++++++++--------
> >  3 files changed, 11 insertions(+), 17 deletions(-)  
> 
> This minor duplication was deliberate, because hw/arm/armv7m.c
> is for M profile cores only, and hw/arm/boot.c is for
> A/R profile cores only. I don't think that saving a
> single if/else in armv7m.c really justifies blurring
> that dividing line.
I'll drop patch on respin

> thanks
> -- PMM

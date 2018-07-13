Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidsa.openu@gmail.com>) id 1fdsgZ-0005NI-8t
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidsa.openu@gmail.com>) id 1fdsgX-0001Ts-Te
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 03:40:15 -0400
MIME-Version: 1.0
Reply-To: davidsa@openu.ac.il
Sender: davidsa.openu@gmail.com
In-Reply-To: <20180712114733.GE4541@localhost.localdomain>
References: <20180622112237.2131-1-gersner@gmail.com>
	<20180712114733.GE4541@localhost.localdomain>
From: David Sariel <davidsa@openu.ac.il>
Date: Fri, 13 Jul 2018 10:40:06 +0300
Message-ID: <CAKhp91ERm-Hc7fUwi4V-BB2o5GCJKDWZyNssS-HfHARZkGX2hQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] nvme: PCI/e configuration from
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Shimi Gersner <gersner@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>

Our bad. Change-Id tag snuck into those from gerrit
(https://review.gerrithub.io/c/davidsaOpenu/qemu/+/415434).

Took a note to replace this line with "[PATCH v2]" but, I guess, it makes
sense
if additional comments will follow, right?

Thanks for taking a look.

On 12 July 2018 at 14:47, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 22.06.2018 um 13:22 hat Shimi Gersner geschrieben:
> > PCI/e configuration currently does not meets specifications.
> >
> > Patch includes various configuration changes to support specifications
> > - BAR2 to return zero when read and CMD.IOSE is not set.
> > - Expose NVME configuration through IO space (Optional).
> > - PCI Power Management v1.2.
> > - PCIe Function Level Reset.
> > - Disable QEMUs default use of PCIe Link Status (DLLLA).
> > - PCIe missing AOC compliance flag.
> > - Mask PCIe End-to-End TLP as RO (Unspecified by specification).
> >
> > Change-Id: I9057f56266db16b013fa194730c998d4779cede3
>
> What is the meaning of this Change-Id tag?
>
> > Signed-off-by: Shimi Gersner <gersner@gmail.com>
>
> Keith, can you have a look at this series?
>
> Kevin
>



--=20

=D7=9E=D7=93=D7=A2=D7=99 =D7=94=D7=9E=D7=97=D7=A9=D7=91, =D7=94=D7=90=D7=95=
=D7=A0=D7=99=D7=91=D7=A8=D7=A1=D7=99=D7=98=D7=94 =D7=94=D7=A4=D7=AA=D7=95=
=D7=97=D7=94
CS Dept, Open University of Israel

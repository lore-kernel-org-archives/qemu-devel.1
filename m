Received: from eggs.gnu.org ([2001:4830:134:3::10]:40334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erleS-0000f6-Es
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erleR-0007s6-8Y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:27:12 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erleR-0007rw-28
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:27:11 -0500
Received: by mail-ot0-x241.google.com with SMTP id w38so8851685ota.8
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 06:27:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 14:26:49 +0000
Message-ID: <CAFEAcA9ZRSX9FBwaiA8Th3mrO4KSOaDPqnH5F==5xNESOf+Dwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/24] ppc-for-2.12 queue 20180302
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 2 March 2018 at 06:03, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c=
67:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' in=
to staging (2018-03-01 17:08:16 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180302
>
> for you to fetch changes up to 57ae75b2e401f1d04f37a8cd26212eb3134c51a6:
>
>   hw/ppc/spapr,e500: Use new property "stdout-path" for boot console (201=
8-03-02 12:24:44 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-03-02
>
> Here's the next batch of accumulated spapr and ppc patches.
> Highlights are:
>     * New Sam460ex machine type
>     * Yet more fixes related to vcpu id allocation for spapr
>     * Numerous macio cleanupsr
>     * Some enhancements to the Spectre/Meltdown fixes for pseries,
>       allowing use of a better mitigation for indirect branch based
>       exploits
>     * New pseries machine types with Spectre/Meltdown mitigations
>       enabled (stop gap until libvirt and management understands the
>       machine options)
>     * A handful of other fixes
>

Hi. This generates a compile error from some compilers in my test set
(I think just the older gccs):

/home/petmay01/linaro/qemu-for-merges/hw/ppc/ppc440_uc.c: In function
=E2=80=98ppc460ex_pcie_realize=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/ppc/ppc440_uc.c:1054:5:
error: =E2=80=98id=E2=80=99 may be used uninitialized in this function
[-Werror=3Dmaybe-uninitialized]
     snprintf(buf, sizeof(buf), "pcie%d-io", id);
     ^
cc1: all warnings being treated as errors

Looks like a valid complaint to me -- the realize function
should check that dcrn_base was set to a valid value, fail
realize if it wasn't, and have a 'default:' case in the
switch with g_assert_not_reached().

thanks
-- PMM

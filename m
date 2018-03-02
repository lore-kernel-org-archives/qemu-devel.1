Received: from eggs.gnu.org ([2001:4830:134:3::10]:33091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ersai-000654-72
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ersaf-00029s-4a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:51:48 -0500
Date: Fri, 2 Mar 2018 22:51:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1803021853180.78982@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1803022248360.37366@zero.eik.bme.hu>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
	<CAFEAcA9ZRSX9FBwaiA8Th3mrO4KSOaDPqnH5F==5xNESOf+Dwg@mail.gmail.com>
	<alpine.BSF.2.21.1803021853180.78982@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/24] ppc-for-2.12 queue 20180302
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 2 Mar 2018, BALATON Zoltan wrote:
> On Fri, 2 Mar 2018, Peter Maydell wrote:
>> On 2 March 2018 at 06:03, David Gibson <david@gibson.dropbear.id.au> w=
rote:
>>> The following changes since commit=20
>>> 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c67:
>>>
>>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2=
'=20
>>> into staging (2018-03-01 17:08:16 +0000)
>>>=20
>>> are available in the Git repository at:
>>>
>>>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180302
>>>=20
>>> for you to fetch changes up to 57ae75b2e401f1d04f37a8cd26212eb3134c51=
a6:
>>>
>>>   hw/ppc/spapr,e500: Use new property "stdout-path" for boot console=20
>>> (2018-03-02 12:24:44 +1100)
>>>=20
>>> ----------------------------------------------------------------
>>> ppc patch queue 2018-03-02
>>>=20
>>> Here's the next batch of accumulated spapr and ppc patches.
>>> Highlights are:
>>>     * New Sam460ex machine type
>>>     * Yet more fixes related to vcpu id allocation for spapr
>>>     * Numerous macio cleanupsr
>>>     * Some enhancements to the Spectre/Meltdown fixes for pseries,
>>>       allowing use of a better mitigation for indirect branch based
>>>       exploits
>>>     * New pseries machine types with Spectre/Meltdown mitigations
>>>       enabled (stop gap until libvirt and management understands the
>>>       machine options)
>>>     * A handful of other fixes
>>>=20
>>=20
>> Hi. This generates a compile error from some compilers in my test set
>> (I think just the older gccs):
>>=20
>> /home/petmay01/linaro/qemu-for-merges/hw/ppc/ppc440_uc.c: In function
>> =E2=80=98ppc460ex_pcie_realize=E2=80=99:
>> /home/petmay01/linaro/qemu-for-merges/hw/ppc/ppc440_uc.c:1054:5:
>> error: =E2=80=98id=E2=80=99 may be used uninitialized in this function
>> [-Werror=3Dmaybe-uninitialized]
>>     snprintf(buf, sizeof(buf), "pcie%d-io", id);
>>     ^
>> cc1: all warnings being treated as errors
>>=20
>> Looks like a valid complaint to me -- the realize function
>> should check that dcrn_base was set to a valid value, fail
>> realize if it wasn't, and have a 'default:' case in the
>> switch with g_assert_not_reached().
>
> I've sent an updated patch (v3) that should fix this.

Wait, I've just realised this is not even in this pull request but alread=
y=20
in master but it was not compiled before the machine that uses it was=20
added now. So a v3 of the original patch is not appropriate. Instead, I'v=
e=20
sent a fixup patch now that should be applied before this pull request to=
=20
hopefully fix the problem. Sorry for the inconvenience this caused.

Thank you,
BALATON Zoltan

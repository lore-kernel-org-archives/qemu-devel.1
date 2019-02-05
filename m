Received: from eggs.gnu.org ([209.51.188.92]:54439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gqzBs-0000Dw-9t
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gqzBq-0007nc-TR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:46:59 -0500
Date: Tue, 5 Feb 2019 12:46:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8nSy=gi+CDSi0GoJbdzgM-b=hOv6BdSFj67eb3yijUsA@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1902051245130.33901@zero.eik.bme.hu>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
	<CAFEAcA8nSy=gi+CDSi0GoJbdzgM-b=hOv6BdSFj67eb3yijUsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/37] ppc-for-4.0 queue 20190204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>, =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>

On Mon, 4 Feb 2019, Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 09:01, David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>> The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:
>>
>>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-01 17:58:27 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190204
>>
>> for you to fetch changes up to 53adb9d43e1abba187387a51f238e878e934c647:
>>
>>   mmap-alloc: fix hugetlbfs misaligned length in ppc64 (2019-02-04 18:44:20 +1100)
>>
>> ----------------------------------------------------------------
>> ppc patch queue 2019-02-04
>>
>> Here's the next batch of ppc target and spapr related changes.
>> Highlights are:
>>  * A number of endianness handling cleanups from Mark Cave-Ayland
>>  * Updated Mac VGA driver
>>  * Updated SLOF image
>>  * Some XIVE cleanups and small fixes
>>  * ppc4xx cleanups and fixes from BALATON Zoltan
>>
>> There are a few chances not technically in the ppc target code:
>>  * Several MAINTAINERS updates
>>  * Fixes for unmapping of hugepages on power hosts
>>
>> The latter is included because it's primarily of interest for ppc KVM setups.
>>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.

Can someone with a wiki account please add:

"sam460ex can now have 2GB memory"

Thank you,
BALATON Zoltan

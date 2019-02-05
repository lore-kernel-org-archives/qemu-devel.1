Received: from eggs.gnu.org ([209.51.188.92]:34723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzmY-0002UB-Rf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqzmX-00075N-1R
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:24:54 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqzmV-00071f-6x
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:24:52 -0500
Received: by mail-wm1-f46.google.com with SMTP id p6so3429082wmc.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 04:24:48 -0800 (PST)
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
	<CAFEAcA8nSy=gi+CDSi0GoJbdzgM-b=hOv6BdSFj67eb3yijUsA@mail.gmail.com>
	<alpine.BSF.2.21.9999.1902051245130.33901@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a02916ee-06a1-f444-3960-a62d413d6619@redhat.com>
Date: Tue, 5 Feb 2019 13:24:45 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1902051245130.33901@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/37] ppc-for-4.0 queue 20190204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 2/5/19 12:46 PM, BALATON Zoltan wrote:
> On Mon, 4 Feb 2019, Peter Maydell wrote:
>> On Mon, 4 Feb 2019 at 09:01, David Gibson
>> <david@gibson.dropbear.id.au> wrote:
>>>
>>> The following changes since commit
>>> b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:
>>>
>>>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into
>>> staging (2019-02-01 17:58:27 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190204
>>>
>>> for you to fetch changes up to 53adb9d43e1abba187387a51f238e878e934c647:
>>>
>>>   mmap-alloc: fix hugetlbfs misaligned length in ppc64 (2019-02-04
>>> 18:44:20 +1100)
>>>
>>> ----------------------------------------------------------------
>>> ppc patch queue 2019-02-04
>>>
>>> Here's the next batch of ppc target and spapr related changes.
>>> Highlights are:
>>>  * A number of endianness handling cleanups from Mark Cave-Ayland
>>>  * Updated Mac VGA driver
>>>  * Updated SLOF image
>>>  * Some XIVE cleanups and small fixes
>>>  * ppc4xx cleanups and fixes from BALATON Zoltan
>>>
>>> There are a few chances not technically in the ppc target code:
>>>  * Several MAINTAINERS updates
>>>  * Fixes for unmapping of hugepages on power hosts
>>>
>>> The latter is included because it's primarily of interest for ppc KVM
>>> setups.
>>>
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
>> for any user-visible changes.
> 
> Can someone with a wiki account please add:
> 
> "sam460ex can now have 2GB memory"

Done.

> 
> Thank you,
> BALATON Zoltan

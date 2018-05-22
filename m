Received: from eggs.gnu.org ([2001:4830:134:3::10]:33714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL6Kq-0006Tb-3B
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL6Km-0005qe-Az
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:24:12 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-19-peter.maydell@linaro.org>
	<5c004b51-6d28-58e8-2674-0df659c51e65@redhat.com>
	<CAFEAcA_NWGczOhpRqRaZfdeeifubEiLqjZXytuYx+vRrv7rPTA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <40a90e77-cc48-bfdd-db74-f1938325a644@redhat.com>
Date: Tue, 22 May 2018 14:23:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NWGczOhpRqRaZfdeeifubEiLqjZXytuYx+vRrv7rPTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/27] hw/misc/tz-mpc.c: Implement the Arm
 TrustZone Memory Protection Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,

On 05/22/2018 01:56 PM, Peter Maydell wrote:
> On 22 May 2018 at 12:30, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 05/21/2018 04:03 PM, Peter Maydell wrote:
>>> Implement the Arm TrustZone Memory Protection Controller, which sits
>>> in front of RAM and allows secure software to configure it to either
>>> pass through or reject transactions.
>>>
>>> We implement the MPC as a QEMU IOMMU, which will direct transactions
>>> either through to the devices and memory behind it or to a special
>>> "never works" AddressSpace if they are blocked.
>>>
>>> This initial commit implements the skeleton of the device:
>>>  * it always permits accesses
>>>  * it doesn't implement most of the registers
>>>  * it doesn't implement the interrupt or other behaviour
>>>    for blocked transactions
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> this patch does not seem to apply on master.
> 
> Clash in the MAINTAINERS file? There's a dependency on another
> MAINTAINERS patch, see the Based-on: line in the cover letter.

Ah OK.

Thanks

Eric
> 
> thanks
> -- PMM
> 

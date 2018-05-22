Received: from eggs.gnu.org ([2001:4830:134:3::10]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL5uJ-0001o4-Cb
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL5uI-0003Bc-9u
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:56:47 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL5uI-0003B4-4l
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:56:46 -0400
Received: by mail-oi0-x242.google.com with SMTP id 11-v6so15914124ois.8
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 04:56:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5c004b51-6d28-58e8-2674-0df659c51e65@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-19-peter.maydell@linaro.org>
	<5c004b51-6d28-58e8-2674-0df659c51e65@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 12:56:24 +0100
Message-ID: <CAFEAcA_NWGczOhpRqRaZfdeeifubEiLqjZXytuYx+vRrv7rPTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 22 May 2018 at 12:30, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 05/21/2018 04:03 PM, Peter Maydell wrote:
>> Implement the Arm TrustZone Memory Protection Controller, which sits
>> in front of RAM and allows secure software to configure it to either
>> pass through or reject transactions.
>>
>> We implement the MPC as a QEMU IOMMU, which will direct transactions
>> either through to the devices and memory behind it or to a special
>> "never works" AddressSpace if they are blocked.
>>
>> This initial commit implements the skeleton of the device:
>>  * it always permits accesses
>>  * it doesn't implement most of the registers
>>  * it doesn't implement the interrupt or other behaviour
>>    for blocked transactions
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> this patch does not seem to apply on master.

Clash in the MAINTAINERS file? There's a dependency on another
MAINTAINERS patch, see the Based-on: line in the cover letter.

thanks
-- PMM

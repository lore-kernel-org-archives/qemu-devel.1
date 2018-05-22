Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL8Bl-0003i3-Uf
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fL8Bl-0007Kk-2j
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:22:57 -0400
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<47281818-f0cf-0ed1-c479-fbcaca5c5167@redhat.com>
	<CAFEAcA-R9t4K488viYM9ipmfArA=ijMMJn+FD1wekPdAbNOHvQ@mail.gmail.com>
	<595dcb89-3856-3755-e8db-7791c1374284@redhat.com>
	<CAFEAcA8Eq+EvtL1JuqtHePWMLPdkHG9zzAh7Wkrw7sNYw8jzUQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <baee90f4-2006-ed78-c052-b735145527d3@redhat.com>
Date: Tue, 22 May 2018 16:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Eq+EvtL1JuqtHePWMLPdkHG9zzAh7Wkrw7sNYw8jzUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
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



On 05/22/2018 04:19 PM, Peter Maydell wrote:
> On 22 May 2018 at 15:11, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 05/22/2018 03:22 PM, Peter Maydell wrote:
>>> How many substream IDs do we expect to see in practice?
>>
>> Spec says max 20 bits, matching the max size of the PASID
> 
> Right, but do we actually expect to see transactions from
> devices that use the whole 2^20 possible values, or will
> they in practice mostly use 1..5, or somethnig else?

An example given in the spec mentions 8.

"An example would be a compute accelerator with 8 contexts that might
each map to a different user process, but where the single device has
common configuration meaning it must be assigned to a VM whole."

Thanks

Eric
> 
> thanks
> -- PMM
> 

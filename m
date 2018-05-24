Received: from eggs.gnu.org ([2001:4830:134:3::10]:46198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLq1J-0005Ed-Ln
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLq1E-0004sq-PO
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:11:05 -0400
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
	<bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
	<22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
	<CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
	<550464ac-5155-6311-d0f7-92c7c0813f82@redhat.com>
	<CAFEAcA-hobu_=VKhYQ+UZ1WX_JFfwCarkPKQhiBtXc3fre57rg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8a2e04d2-68a8-5ea6-b0a6-6df4b6c029e2@redhat.com>
Date: Thu, 24 May 2018 15:10:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hobu_=VKhYQ+UZ1WX_JFfwCarkPKQhiBtXc3fre57rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>

Hi Peter, Laszlo,

On 05/24/2018 03:07 PM, Peter Maydell wrote:
> On 24 May 2018 at 13:59, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 05/24/18 11:11, Peter Maydell wrote:
>>> Won't it also break a guest which is just Linux loaded not via
>>> firmware which is an aarch32 kernel without LPAE support?
>>
>> Does such a thing exist? (I honestly have no clue.)
> 
> Yes, it does; LPAE isn't a mandatory kernel config option.
> This is why we have the machine 'highmem' option, so that
> we can run on those kernels by not putting anything above
> the 4G boundary. Looking back at the history on that, we
> opted at the time for "default to highmem on, and if you're
> running an non-lpae kernel you need to turn it off manually".
> So we can handle those kernels by just not putting ECAM
> above 4G if highmem is false.

Actually that's what my series does. If highmem=off then we use the
legacy ECAM.

Thanks

Eric
> 
> thanks
> -- PMM
> 

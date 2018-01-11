Received: from eggs.gnu.org ([2001:4830:134:3::10]:37135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZaBX-0000KY-GR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZaBT-0004vh-OA
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:34:11 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-RC6hUMR5jPrgOB7nkWjXaPxo6dYEXO=kgC=59k7EVrw@mail.gmail.com>
	<558dc576-6d05-50d4-9f7c-73738e28ad26@huawei.com>
	<CAFEAcA-cAgB5TigMWUsnF74YrzWGToDht61HhOnGrSD1QBDNhg@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <b44234f4-c63b-21bd-0584-bf7f134a2317@huawei.com>
Date: Thu, 11 Jan 2018 18:33:11 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-cAgB5TigMWUsnF74YrzWGToDht61HhOnGrSD1QBDNhg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v14 5/9] target-arm: kvm64:
 inject synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>, qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>, Huangshaoyu <huangshaoyu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@linaro.org>, Richard Henderson <rth@twiddle.net>

On 2018/1/11 17:53, Peter Maydell wrote:
>> we only support AArch64 kernel, not support AArch32
>>  kernel or AArch32 user space.
> Nope, you must handle AArch32 EL1 correctly in some way, even if that
> is only "this guest CPU doesn't support RAS notification and we
> will not notify it". And you must absolutely support AArch32 EL0,
> that's a requirement for getting this merged. It's not difficult.
sure, it needed. I absolutely follow your suggestion and handle AArch32
EL1 correctly in some way. it is not difficult.

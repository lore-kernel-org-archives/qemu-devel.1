Received: from eggs.gnu.org ([2001:4830:134:3::10]:43629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cXwJ3-0007Qc-Fi
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cXwJ2-00035o-RA
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:42:37 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:32826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cXwJ2-000351-NN
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:42:36 -0500
Received: by mail-vk0-x231.google.com with SMTP id k127so204846562vke.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 12:42:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170129115306.iuhvofl3y65x7sjw@hawk.localdomain>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
	<1484558821-15512-4-git-send-email-zhaoshenglong@huawei.com>
	<20170129115306.iuhvofl3y65x7sjw@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Jan 2017 20:42:14 +0000
Message-ID: <CAFEAcA-nB7uQAGcZWUYeiAis2tY33U6yeiig+kwd2-KRD=KSuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] arm: kvm64: Check if kvm supports
 cross type vCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, Christoffer Dall <christoffer.dall@linaro.org>

On 29 January 2017 at 11:53, Andrew Jones <drjones@redhat.com> wrote:
> On Mon, Jan 16, 2017 at 05:26:58PM +0800, Shannon Zhao wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>> +    memset(id_regitsers, 0, ARM_CPU_ID_MAX * sizeof(struct kvm_one_reg));
>> +
>> +    id_regitsers[0].id = ARM64_SYS_REG(ARM_CPU_ID_MIDR);
>> +    id_regitsers[0].addr = (uintptr_t)&cpu->midr;
>> +
>> +    id_regitsers[1].id = ARM64_SYS_REG(ARM_CPU_ID_REVIDR);
>> +    id_regitsers[1].addr = (uintptr_t)&cpu->revidr;
>> +
>
> We can condense this nicely with list initialization
>
>  struct kvm_one_reg id_regitsers[] = {
>    { ARM64_SYS_REG(ARM_CPU_ID_MIDR), (uintptr_t)&cpu->midr },
>    { ARM64_SYS_REG(ARM_CPU_ID_REVIDR), (uintptr_t)&cpu->revidr },
>    ...
>    { 0, 0 }

"registers", please :-)

thanks
-- PMM

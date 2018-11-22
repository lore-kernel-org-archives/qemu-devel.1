Received: from eggs.gnu.org ([2001:4830:134:3::10]:40058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPmFs-0007MP-1Q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPmFq-000258-8D
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:30:40 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPmFq-00024S-3o
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:30:38 -0500
Received: by mail-ot1-x344.google.com with SMTP id e12so3344086otl.5
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 02:30:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_P9d=hOH6sAfdqdBEAwF_am6+Qq9XgAafxbzGfWLEhHg@mail.gmail.com>
References: <1541672989-15967-1-git-send-email-gengdongjiu@huawei.com>
	<1541672989-15967-11-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-6UKk-WF+M+z0=AN-X7q0XRFLo2RG_yBadDeCas4A5wQ@mail.gmail.com>
	<0184EA26B2509940AA629AE1405DD7F201F7D7EB@DGGEMA503-MBX.china.huawei.com>
	<CAFEAcA_P9d=hOH6sAfdqdBEAwF_am6+Qq9XgAafxbzGfWLEhHg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 10:30:17 +0000
Message-ID: <CAFEAcA_M_Lmv=zouad3FfL6o2DnOeH49xt4J3C6WyGZZ=BsQpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel]
	=?utf-8?b?562U5aSNOiBbUEFUQ0ggUkVTRU5EIHYxNSAxMC8x?=
	=?utf-8?q?0=5D_target-arm=3A_kvm64=3A_handle_SIGBUS_signal_from_ke?=
	=?utf-8?q?rnel_or_KVM?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, "zhengxiang (A)" <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 22 November 2018 at 10:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 November 2018 at 03:05, gengdongjiu <gengdongjiu@huawei.com> wrote:
>>> >
>>> Shouldn't there be something in here to say "only report this error to the guest if we are actually reporting RAS errors to the guest" ?
>>
>> Yes, We can say something that such as "report this error to the guest", because this error is indeed triggered by guest, which is guest error.
>
> I'm afraid I don't really understand what you mean. Could you
> try rephrasing it?
>
> My understanding was:
>  * we get this signal if there is a RAS error in the host memory
>  * if we are exposing RAS errors to the guest (ie we have
>    told it that in the ACPI table we passed it at startup)
>    then we should pass on this error to the guest
>
> but that these are two different conditions.
>
> If the host hardware detects a RAS error in memory used
> by the guest but the guest is not being told about RAS
> errors, then we cannot report the error: we have no mechanism
> to do so, and the guest is not expecting it.

If you look at the x86 version of this function you can see that
it tests (env->mcg_cap & MCG_SER_P), which I think is the
equivalent x86 "is the guest CPU/config one we can report
these errors to" test.

thanks
-- PMM

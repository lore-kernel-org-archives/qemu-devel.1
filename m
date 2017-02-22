Received: from eggs.gnu.org ([2001:4830:134:3::10]:33215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgVgW-0001TG-1Z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgVgU-0001AE-Tq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:06:16 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgVgU-00019W-Oc
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:06:14 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v77so418717wmv.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:06:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALicx6uiFYXsOMaiCH9HYW_jxbMSg+QSCrbVr0D-UKWwtf+TwA@mail.gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
	<1487313115-9510-3-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA8618+LGejFq6SpBEwGrNpfamBBX3MFWjss-ZxJ7Xk8mg@mail.gmail.com>
	<CALicx6tqxXZxBTxYvF55ydBg5CB1to3MsEkhaohucx4EAZcEJA@mail.gmail.com>
	<CAFEAcA_NbQNzrUUCAS2e5Xso0rg6H3+nzDjTc9i8Tc+GLpXvLw@mail.gmail.com>
	<CALicx6uiFYXsOMaiCH9HYW_jxbMSg+QSCrbVr0D-UKWwtf+TwA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Feb 2017 12:05:51 +0000
Message-ID: <CAFEAcA8sTEtJGpvrL3qCQ7OfUaQ5Ym0siQfGMnTpaUQw+Uzh_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v8 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 22 February 2017 at 11:56, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> On Mon, Feb 20, 2017 at 3:21 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> My expectation was that the KVM GICv3 emulation would
>> make these bits RAO/WI like the TCG implementation.
>> Is there maybe a bug in the kernel side where it
>> doesn't implement bypass but has made these bits be
>> RAZ/WI rather than RAO/WI ?
>
> Do you have any inputs on this?

I talked to Marc Z who agreed this is a KVM bug -- the kernel
should have these bits be RAO/WI like TCG. I think Marc
was going to write a patch...

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1u65-00044C-W0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1u61-0005wz-Jz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:57:22 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:47258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1u61-0005wT-Dn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:57:17 -0400
Received: by mail-wm0-x233.google.com with SMTP id t69so4918226wmt.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 05:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010125231.GD4015@localhost.localdomain>
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
	<CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
	<4479e30f-801d-0d8e-712d-06f2dd987528@cn.fujitsu.com>
	<20171010125231.GD4015@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 13:56:55 +0100
Message-ID: <CAFEAcA_M-6yb1Vx0dT77zg8wUO+vNzawTNnubmd=OO_CB6t9vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>

On 10 October 2017 at 13:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
> This shouldn't happen if CONFIG_IASL is not defined.  Did you run
> configure again after removing iasl?

I've neither added nor removed iasl from the build systems
in question. Pull request tests just apply the pull and
run make/make check.

thanks
-- PMM

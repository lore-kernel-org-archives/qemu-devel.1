Received: from eggs.gnu.org ([2001:4830:134:3::10]:54639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDXBy-0004wz-LB
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDXBs-00035r-25
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:00:02 -0400
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
	<CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
	<a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
	<CAFEAcA9Pb5Dw9zu5_esYwor+MEmUJ=f4ZZqifui9qyJdKWbTiQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98df614b-e432-5a18-34f3-b2275ba9af93@redhat.com>
Date: Fri, 19 Oct 2018 17:59:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Pb5Dw9zu5_esYwor+MEmUJ=f4ZZqifui9qyJdKWbTiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 19/10/2018 16:43, Peter Maydell wrote:
> I think if we want to support this for downstreams we need
> to look at something better than the default-configs/
> mechanism for it. (Perhaps the kconfig-alike Paolo mentioned
> in a previous thread?)

True, but having more CONFIG_* symbols does not complicate the switch to
a system like that one.

> My dividing line for "should something go in a specific
> architecture's default-configs/ list" is "is this an SoC
> or real piece of hardware that is naturally limited to
> one or a few SoCs".

I tend to agree, but I'd rather have a separate CONFIG_* symbol as soon
as two different *targets* (aka default-configs/*.mak files) use a
device.  So the SPARC change that you mention would actually be a good
reason to introduce CONFIG_UNIMP, for example.

Paolo

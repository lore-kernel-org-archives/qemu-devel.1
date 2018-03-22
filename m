Received: from eggs.gnu.org ([2001:4830:134:3::10]:58509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyxr9-0006lW-38
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyxr8-0000fv-Cg
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:54:03 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:46585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyxr8-0000fX-7g
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:54:02 -0400
Received: by mail-oi0-x22c.google.com with SMTP id e123-v6so4713866oih.13
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 03:54:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322080156.x2q7w6wtdrvc3wk3@hawk.localdomain>
References: <20180322031216.14569-1-wei@redhat.com>
	<20180322080156.x2q7w6wtdrvc3wk3@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 10:53:39 +0000
Message-ID: <CAFEAcA_Sb6iz-8cg00JXhNF5pMS3z2=QxhoEhwSgG6PG04nKqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->desc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 22 March 2018 at 08:01, Andrew Jones <drjones@redhat.com> wrote:
> I agree we should change the useless 1.0, but shouldn't we use
> mc->name instead of mc->desc? mc->name would make it consistent
> with pc-piix and q35 and also be a less verbose "version". We'd
> get e.g.
>
>  System Information
>         Manufacturer: QEMU
>         Product Name: KVM Virtual Machine
>         Version: virt-2.12
>         Serial Number: Not Specified

I would vote for consistency with x86, I think.

thanks
-- PMM

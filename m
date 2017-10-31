Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9a3q-0007Hi-SI
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9a3p-0007mJ-P1
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:10:46 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:51768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9a3p-0007kp-8e
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:10:45 -0400
Received: by mail-wm0-x22d.google.com with SMTP id b9so256232wmh.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 10:10:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710310959490.13766@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710171708130.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA9zXAmNPL8TsLKSPbm8Er_KLK8Ubwth6=nL6WD87OmBQw@mail.gmail.com>
	<CAFEAcA8jwN81ZBCLA8HW=q5GAWKmZ=kAZAP9vGNN8RYkzYe=Pw@mail.gmail.com>
	<alpine.DEB.2.10.1710310959490.13766@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 17:10:23 +0000
Message-ID: <CAFEAcA_8cimWtic=2OdvCmAN-mJ5MGGnVzDGYA5VgXGJG-fKhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] aarch64: advertise the GIC system register
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, julien.grall@arm.com, qemu-arm <qemu-arm@nongnu.org>

On 31 October 2017 at 17:01, Stefano Stabellini <sstabellini@kernel.org> wrote:
> Fixing QEMU is harder than I expected. Would it be possible to update
> id_aa64pfr0 at CPU reset time? Like cpu->id_aa64pfr0 |= 0x01000000; ?

At that point we've already called register_cp_regs_for_features(),
which is where we read cpu->id_aa64pfr0 when we're creating the
cpreg. So if you change it after that it's too late. But that
function is called at CPU realize time, which is before we've
created the GIC object...

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daeq6-0007U1-Ap
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daeq5-0005f7-Fb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:12:14 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:38350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daeq5-0005d0-9R
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:12:13 -0400
Received: by mail-wr0-x22e.google.com with SMTP id f21so84583999wrf.5
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 02:12:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 10:11:48 +0100
Message-ID: <CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>

On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> quiesced by vfio-pci's finalize() routine until up to 6s after the
> DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
> much always crashing the host.

My initial naive thought is that if the host kernel can crash then
this is a host kernel bug... shouldn't the host kernel refuse
the subsequent libvirt rebind if it would cause a crash ?

thanks
-- PMM

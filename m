Received: from eggs.gnu.org ([2001:4830:134:3::10]:36403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96ti-0000Bm-T8
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96ti-0005ik-4i
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:02:22 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:55895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e96th-0005hY-T3
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 06:02:22 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l8so11892779wre.12
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 03:02:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508776211-22175-1-git-send-email-eric.auger@redhat.com>
References: <1508776211-22175-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 10:02:00 +0000
Message-ID: <CAFEAcA-5uwj+VBp1qvojyMpgDyM5=HenNzdO4TWeRv+knUruEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host/gpex: Improve INTX to gsi
 routing error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>

On 23 October 2017 at 17:30, Eric Auger <eric.auger@redhat.com> wrote:
> We exposed gpex_set_irq_num() for machines to set the INTx to
> GSI routing. However if the machine forgets to call that
> function we currently do not check the association was properly
> done. Let's initialize gsi values to -1 and if this value is
> found in gpex_route_intx_pin_to_irq, set the routing mode as
> disabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

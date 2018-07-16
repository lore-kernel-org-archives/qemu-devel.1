Received: from eggs.gnu.org ([2001:4830:134:3::10]:59709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff3wF-000694-04
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff3wE-0003DC-0j
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:53:19 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff3wD-0003Ct-SQ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:53:17 -0400
Received: by mail-oi0-x244.google.com with SMTP id i12-v6so74923857oik.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:53:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-16-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-16-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:52:56 +0100
Message-ID: <CAFEAcA_c+sHPzyDzmh=Np-FYeGQiHcQTX8UeGVrO=DGhAeWskg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/17] hw/arm/stm32f205_soc: Fix
 introspection problem with 'stm32f205-soc' device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On 16 July 2018 at 13:59, Thomas Huth <thuth@redhat.com> wrote:
> Valgrind complains:
>
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'stm32f205-soc'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
> [...]
> ==28531== Invalid read of size 8
> ==28531==    at 0x6185BA: qdev_print (qdev-monitor.c:686)
> ==28531==    by 0x6185BA: qbus_print (qdev-monitor.c:719)
> ==28531==    by 0x452B38: handle_hmp_command (monitor.c:3446)
> [...]
>
> Fix it with the new sysbus_init_child_obj() function.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f837r-0000ML-SH
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f837q-0005mw-St
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:20:51 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f837q-0005ma-KV
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 08:20:50 -0400
Received: by mail-ot0-x242.google.com with SMTP id v64-v6so17089929otb.13
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 05:20:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523541337-23919-1-git-send-email-geert+renesas@glider.be>
References: <1523541337-23919-1-git-send-email-geert+renesas@glider.be>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 13:20:29 +0100
Message-ID: <CAFEAcA-8yd9oKu1_FTxRHs1w_q7O5c1K7+n9s-BO3_WW8+Piog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH qemu v3] device_tree: Increase FDT_MAX_SIZE
 to 1 MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, qemu-stable <qemu-stable@nongnu.org>

On 12 April 2018 at 14:55, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> It is not uncommon for a contemporary FDT to be larger than 64 KiB,
> leading to failures loading the device tree from sysfs:
>
>     qemu-system-aarch64: qemu_fdt_setprop: Couldn't set ...: FDT_ERR_NOSPACE
>
> Hence increase the limit to 1 MiB, like on PPC.
>
> For reference, the largest arm64 DTB created from the Linux sources is
> ca. 75 KiB large (100 KiB when built with symbols/fixup support).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - Update example size figures,
>
> v2:
>   - Enlarge from 128 KiB to 1 MiB, as suggested by Peter Maydell.
> ---
>  device_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks; applied to target-arm.next for 2.13. I'll add cc:qemu-stable too.

-- PMM

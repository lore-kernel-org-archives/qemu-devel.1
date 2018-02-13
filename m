Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elgW9-0002IS-Hd
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elgW8-0002ce-IT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:45:29 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:40278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elgW8-0002c9-Br
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:45:28 -0500
Received: by mail-ot0-x244.google.com with SMTP id s4so18317940oth.7
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:45:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518540077-14481-1-git-send-email-geert+renesas@glider.be>
References: <1518540077-14481-1-git-send-email-geert+renesas@glider.be>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 19:45:07 +0000
Message-ID: <CAFEAcA-8xMm8+ta_z-g2L9ynrSd+Bn_GUueV=4n6gb2nxpWc-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] device_tree: Increase FDT_MAX_SIZE to 128
 KiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 February 2018 at 16:41, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> It is not uncommon for a contemporary FDT to be larger than 64 KiB,
> leading to failures loading the device tree from sysfs:
>
>     qemu-system-aarch64: qemu_fdt_setprop: Couldn't set ...: FDT_ERR_NOSPACE
>
> For reference, the largest arm64 DTB created from the Linux sources is
> 70 KiB large (93 KiB when built with symbols/fixup support).

I think we should probably give ourselves a bit more headroom,
then -- at least 256K.

The ppc boards actually define their own version of this constant:

#define FDT_MAX_SIZE            0x00100000

so I think we might as well just go with that in device_tree.c for
consistency.

thanks
-- PMM
